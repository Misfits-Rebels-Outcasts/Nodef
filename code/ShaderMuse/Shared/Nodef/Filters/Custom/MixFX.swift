//
//  Copyright © 2022 James Boo. All rights reserved.
//

import SwiftUI

class MixFX: FilterX {
       
    @Published var amount:Float = 0.5

    let description = "Mix an input image and a background image with a amount parameter. When value is 0.0 or less, the result is the background image. When the value is 1.0 or more, the result is the image."

    override init()
    {
        let name = "CIMix"
        super.init(name)
        desc=description
      
        print(CIFilter.localizedName(forFilterName: name))
        print(CIFilter.localizedDescription(forFilterName: name))
        print(CIFilter.localizedReferenceDocumentation(forFilterName: name))
                
         
    }

    enum CodingKeys : String, CodingKey {
        case amount

    }

    required init(from decoder: Decoder) throws {
        try super.init(from: decoder)
        let values = try decoder.container(keyedBy: CodingKeys.self)
        desc=description
        amount = try values.decodeIfPresent(Float.self, forKey: .amount) ?? 0.0
    }
    
    override func encode(to encoder: Encoder) throws {
        try super.encode(to: encoder)
        var container = encoder.container(keyedBy: CodingKeys.self)

        try container.encode(amount, forKey: .amount)
    }
    
    override func getCIFilter(currentImage: CIImage, beginImage: CIImage) -> CIFilter?
    {
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
        
        currentCIFilter.setValue(inputImage, forKey: kCIInputImageKey)
        currentCIFilter.setValue(backgroundImage, forKey: kCIInputBackgroundImageKey)

        currentCIFilter.setValue(amount, forKey: kCIInputAmountKey)

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
            
        if inputImageAlias == "" && backgroundImageAlias == ""
        {
            fxStr="input - "+previousStr+", background - "+previousStr
        }
        else if inputImageAlias != "" && backgroundImageAlias == ""
        {
            let inputImageAliasStr = "\""+inputImageAlias+"\""
            fxStr = "input - "+inputImageAliasStr + ", background - "+previousStr
        }
        else if inputImageAlias == "" && backgroundImageAlias != ""
        {
            let backgroundImageAliasStr = "\""+backgroundImageAlias+"\""
            fxStr = "input - "+previousStr+", background - "+backgroundImageAliasStr
        }
        else if inputImageAlias != "" && backgroundImageAlias != ""
        {
            let inputImageAliasStr = "\""+inputImageAlias+"\""
            let backgroundImageAliasStr = "\""+backgroundImageAlias+"\""
            fxStr = "input - " + inputImageAliasStr + ", background - " + backgroundImageAliasStr
        }

        return fxStr
   
    }
}
