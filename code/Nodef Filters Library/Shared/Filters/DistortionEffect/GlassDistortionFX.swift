//
//  Copyright © 2022 James Boo. All rights reserved.
//

import SwiftUI

class GlassDistortionFX: FilterX {
       
    @Published var inputTextureAlias : String=""
    @Published var inputTextureAliasId : String=""
    @Published var centerX:Float = 150
    @Published var centerY:Float = 150
    @Published var scale:Float = 200.0
    let description = "Distorts an image by applying a glass-like texture. This filter works better with smaller images such as those less than 1024 x 1024 pixels."

    override init()
    {
        let name="CIGlassDistortion"
        super.init(name)
        desc=description
        
        print(CIFilter.localizedName(forFilterName: name))
        print(CIFilter.localizedDescription(forFilterName: name))
        print(CIFilter.localizedReferenceDocumentation(forFilterName: name))
                    
        print("inputScale")
        if let attribute = CIFilter.glassDistortion().attributes["inputScale"] as? [String: AnyObject]
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
        case centerX
        case centerY
        case inputTextureAlias
        case scale
    }

    required init(from decoder: Decoder) throws {
        try super.init(from: decoder)
        let values = try decoder.container(keyedBy: CodingKeys.self)
        desc=description
        inputTextureAlias = try values.decodeIfPresent(String.self, forKey: .inputTextureAlias) ?? ""
        centerX = try values.decodeIfPresent(Float.self, forKey: .centerX) ?? 0.0
        centerY = try values.decodeIfPresent(Float.self, forKey: .centerY) ?? 0.0
        scale = try values.decodeIfPresent(Float.self, forKey: .scale) ?? 0.0
    }
    
    override func encode(to encoder: Encoder) throws {
        try super.encode(to: encoder)
  
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(inputTextureAlias, forKey: .inputTextureAlias)
        try container.encode(centerX, forKey: .centerX)
        try container.encode(centerY, forKey: .centerY)
        try container.encode(scale, forKey: .scale)

    }
    
    override func setupProperties(_ parent: FiltersX?)
    {
        super.setupProperties(parent)
        
        if parent != nil{
            centerX=Float(size.width/2.0)
            centerY=Float(size.height/2.0)
        }
        
    }
    
    override func adjustPropertiesToBounds(_ parent: FiltersX?)
    {
        super.adjustPropertiesToBounds(parent)
        
        centerX = centerX > Float(size.width) ? Float(size.width) : centerX
        centerY = centerY > Float(size.height) ? Float(size.height) : centerY
        
    }
    
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
        
        let textureImage=handleAlias(alias: inputTextureAlias,
                                      inputImage: currentImage,
                                      beginImage: beginImage)
        
        currentCIFilter.setValue(inputImage, forKey: kCIInputImageKey)
        currentCIFilter.setValue(textureImage, forKey: "inputTexture")
        let tcenter=CIVector(x:CGFloat(centerX),y:CGFloat(centerY))
        currentCIFilter.setValue(tcenter, forKey: kCIInputCenterKey)
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
        
        var textureImageAliasStr = previousStr
        if inputTextureAlias != ""{
            textureImageAliasStr = "\""+inputTextureAlias+"\""
        }
                
        fxStr = "input - " + inputImageAliasStr + ", texture - " + textureImageAliasStr

        return fxStr
   
    }
}
