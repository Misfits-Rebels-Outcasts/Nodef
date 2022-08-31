//
//  Copyright © 2022 James Boo. All rights reserved.
//

import SwiftUI

class BlendWithMaskFX: FilterX {
       
    @Published var inputMaskImageAlias : String=""
    @Published var inputMaskImageAliasId : String=""
    
    let description = "Uses values from a grayscale mask to interpolate between an image and the background."

    override init()
    {
        let name="CIBlendWithMask"
        super.init(name)
        desc=description
        
        print(CIFilter.localizedName(forFilterName: name))
        print(CIFilter.localizedDescription(forFilterName: name))
        print(CIFilter.localizedReferenceDocumentation(forFilterName: name))
        
    }

    enum CodingKeys : String, CodingKey {
        case inputMaskImageAlias

    }

    required init(from decoder: Decoder) throws {
        try super.init(from: decoder)
        let values = try decoder.container(keyedBy: CodingKeys.self)
        desc=description
        
        inputMaskImageAlias = try values.decodeIfPresent(String.self, forKey: .inputMaskImageAlias) ?? ""
    }
    
    override func encode(to encoder: Encoder) throws {
        try super.encode(to: encoder)
  
        var container = encoder.container(keyedBy: CodingKeys.self)

        try container.encode(inputMaskImageAlias, forKey: .inputMaskImageAlias)

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
        
        let backgroundImage=handleAlias(alias: backgroundImageAlias,
                                      inputImage: currentImage,
                                      beginImage: beginImage)
        
        let maskImage=handleAlias(alias: inputMaskImageAlias,
                                      inputImage: currentImage,
                                      beginImage: beginImage)
        
        currentCIFilter.setValue(inputImage, forKey: kCIInputImageKey)
        currentCIFilter.setValue(backgroundImage, forKey: kCIInputBackgroundImageKey)
        currentCIFilter.setValue(maskImage, forKey: kCIInputMaskImageKey)

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
        
        var backgroundImageAliasStr = previousStr
        if backgroundImageAlias != ""{
            backgroundImageAliasStr = "\""+backgroundImageAlias+"\""
        }

        var maskImageAliasStr = previousStr
        if inputMaskImageAlias != ""{
            maskImageAliasStr = "\""+inputMaskImageAlias+"\""
        }
        
        fxStr = "input - " + inputImageAliasStr + ", background - " + backgroundImageAliasStr + ", mask - " + maskImageAliasStr

        return fxStr
   
    }
    
}
