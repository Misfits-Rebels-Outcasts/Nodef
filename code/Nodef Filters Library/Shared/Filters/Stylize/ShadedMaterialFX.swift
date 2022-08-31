//
//  Copyright © 2022 James Boo. All rights reserved.
//

import SwiftUI

class ShadedMaterialFX: FilterX {
       
    @Published var inputShadingImageAlias : String=""
    @Published var inputShadingImageAliasId : String=""
    @Published var scale:Float = 10.0

    let description = "Produces a shaded image from a height field. The height field is defined to have greater heights with lighter shades, and lesser heights (lower areas) with darker shades. You can combine this filter node with the Height Field From Mask filter node to produce quick shadings of masks. This filter works better with smaller images such as those with less than 1024x1024 pixels."

    override init()
    {
        let name="CIShadedMaterial"
        super.init(name)
        desc=description
        
        print(CIFilter.localizedName(forFilterName: name))
        print(CIFilter.localizedDescription(forFilterName: name))
        print(CIFilter.localizedReferenceDocumentation(forFilterName: name))
        
        print("inputScale")
        if let attribute = CIFilter.shadedMaterial().attributes["inputScale"] as? [String: AnyObject]
        {
           let minimum = attribute[kCIAttributeSliderMin] as? Float
           let maximum = attribute[kCIAttributeSliderMax] as? Float
           let defaultValue = attribute[kCIAttributeDefault] as? Float
            
            print(minimum)
            print(maximum)
            print(defaultValue)
            
        }
    }

    enum CodingKeys : String, CodingKey {
        case inputShadingImageAlias
        case scale

    }

    required init(from decoder: Decoder) throws {
        try super.init(from: decoder)
        let values = try decoder.container(keyedBy: CodingKeys.self)
        desc=description
        
        inputShadingImageAlias = try values.decodeIfPresent(String.self, forKey: .inputShadingImageAlias) ?? ""
        scale = try values.decodeIfPresent(Float.self, forKey: .scale) ?? 0.0

    }
    
    override func encode(to encoder: Encoder) throws {
        try super.encode(to: encoder)
  
        var container = encoder.container(keyedBy: CodingKeys.self)

        try container.encode(inputShadingImageAlias, forKey: .inputShadingImageAlias)
        try container.encode(scale, forKey: .scale)
    }
    //revisit
    /*if using a gradient as a shaded image.
     
    //Failed to render 4891824 pixels because a CIKernel's ROI function did not allow tiling.
    2022-08-01 08:03:00.147197+0800 SketchEffects[45820:2596384] [api] -[CIContext(CIRenderDestination) _startTaskToRender:toDestination:forPrepareRender:forClear:error:] Failed to render part of the image because memory requirement of -1 too big
     */
    override func getCIFilter(currentImage: CIImage, beginImage: CIImage) -> CIFilter? {
            
        var currentCIFilter: CIFilter
        if ciFilter != nil {
            currentCIFilter = ciFilter!
        } else {
            currentCIFilter = CIFilter(name: type)!
            ciFilter=currentCIFilter
        }
        
        let inputImage=handleAlias(alias: inputImageAlias,
                                      inputImage: currentImage,
                                      beginImage: beginImage)
        
        let inputShadingImage=handleAlias(alias: inputShadingImageAlias,
                                      inputImage: currentImage,
                                      beginImage: beginImage)
        
        currentCIFilter.setValue(inputImage, forKey: kCIInputImageKey)
        currentCIFilter.setValue(inputShadingImage, forKey: "inputShadingImage")
        currentCIFilter.setValue(scale, forKey: kCIInputScaleKey)
        return currentCIFilter
    }
    
    override func getDisplayNameFX() -> String
    {

        var fxStr = "" //retName
        var previousStr="previous"
        if nodeIndex == 1 {
            previousStr="0"//"0 (original image)"
        }
        else {
            previousStr="" + String(nodeIndex-1)
        }
            
        var inputImageAliasStr = previousStr
        if inputImageAlias != ""{
            inputImageAliasStr = "\""+inputImageAlias+"\""
        }
        
        var shadingImageAliasStr = previousStr
        if inputShadingImageAlias != ""{
            shadingImageAliasStr = "\""+inputShadingImageAlias+"\""
        }
                
        fxStr = "input - " + inputImageAliasStr + ", shading - " + shadingImageAliasStr

        return fxStr
   
    }

}
