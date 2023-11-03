//
//  Copyright © 2022 James Boo. All rights reserved.
//

import SwiftUI
//ANCHISES-from FilterX
class MaskedVariableBlurFX: BaseBlendFX {
    
    @Published var radius:Float = 10.0
    @Published var inputMaskImageAlias : String=""
    @Published var inputMaskImageAliasId : String=""

    let description = "Blurs the source image according to the brightness levels in a mask image. Radius is the distance from the center of the effect."

    override init()
    {
        let name = "CIMaskedVariableBlur"
        super.init(name)
        desc=description
        /*
        print(CIFilter.localizedName(forFilterName: name))
        print(CIFilter.localizedDescription(forFilterName: name))
        print(CIFilter.localizedReferenceDocumentation(forFilterName: name))
                    
        if let attribute = CIFilter.maskedVariableBlur().attributes["inputRadius"] as? [String: AnyObject]
        {
           let minimum = attribute[kCIAttributeSliderMin] as? Float
           let maximum = attribute[kCIAttributeSliderMax] as? Float
           let defaultValue = attribute[kCIAttributeDefault] as? Float
            
            print(minimum)
            print(maximum)
            print(defaultValue)
            
            //Optional(-1.0)
            //Optional(1.0)
            //Optional(0.0)
            
        }
        print("inputRadius")

        if let attribute = CIFilter.maskedVariableBlur().attributes["inputRadius"] as? [String: AnyObject]
        {
           let minimum = attribute[kCIAttributeSliderMin] as? Float
           let maximum = attribute[kCIAttributeSliderMax] as? Float
           let defaultValue = attribute[kCIAttributeDefault] as? Float
            
            print(minimum)
            print(maximum)
            print(defaultValue)
            
            //Optional(-1.0)
            //Optional(1.0)
            //Optional(0.0)
            
        }
         */
         
    }

    enum CodingKeys : String, CodingKey {
        case radius
        case inputMaskImageAlias

    }

    required init(from decoder: Decoder) throws {
        try super.init(from: decoder)
        let values = try decoder.container(keyedBy: CodingKeys.self)
        desc=description

        inputMaskImageAlias = try values.decodeIfPresent(String.self, forKey: .inputMaskImageAlias) ?? ""
        radius = try values.decodeIfPresent(Float.self, forKey: .radius) ?? 0.0
    }
    
    override func encode(to encoder: Encoder) throws {
        try super.encode(to: encoder)
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(inputMaskImageAlias, forKey: .inputMaskImageAlias)
        try container.encode(radius, forKey: .radius)
    }
    
    //deprecate
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
        
        let maskImage=handleAlias(alias: inputMaskImageAlias,
                                      inputImage: currentImage,
                                      beginImage: beginImage)
        
        currentCIFilter.setValue(inputImage, forKey: kCIInputImageKey)
        
        currentCIFilter.setValue(maskImage, forKey: "inputMask")
        currentCIFilter.setValue(radius, forKey: kCIInputRadiusKey)
        return currentCIFilter
        
    }
    
    override func getDisplayNameFX_Old() -> String
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
        
        var maskImageAliasStr = previousStr
        if inputMaskImageAlias != ""{
            maskImageAliasStr = "\""+inputMaskImageAlias+"\""
        }
                
        fxStr = "input - " + inputImageAliasStr + ", mask - " + maskImageAliasStr

        return fxStr
   
    }
    
    //ANCHISES
    override func getCIFilter(firstImage: CIImage, secondImage: CIImage) -> CIFilter? {
    
        var currentCIFilter: CIFilter
        if ciFilter != nil {
            currentCIFilter = ciFilter!
        } else {
            currentCIFilter = CIFilter(name: type)!
            ciFilter=currentCIFilter

        }
        
        currentCIFilter.setValue(firstImage, forKey: kCIInputImageKey)
        
        currentCIFilter.setValue(secondImage, forKey: "inputMask")
        currentCIFilter.setValue(radius, forKey: kCIInputRadiusKey)
        return currentCIFilter
        
    }
}
