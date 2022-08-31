//
//  Copyright © 2022 James Boo. All rights reserved.
//

import SwiftUI

class BaseBlendFX: FilterX {
          
    //@Published var inputImageAlias : String=""
    //@Published var backgroundImageAlias : String=""
    
    override init()
    {
        super.init()
    }
    
    override init(_ type:String) {
        super.init(type)
    }
    
    enum CodingKeys : String, CodingKey {
        case None
        //case inputImageAlias
        //case backgroundImageAlias
    }

    required init(from decoder: Decoder) throws {
 
        try super.init(from: decoder)
        //let values = try decoder.container(keyedBy: CodingKeys.self)
        //inputImageAlias = try values.decodeIfPresent(String.self, forKey: .inputImageAlias) ?? ""
        //backgroundImageAlias = try values.decodeIfPresent(String.self, forKey: .backgroundImageAlias) ?? ""
    }
    
    override func encode(to encoder: Encoder) throws {
        try super.encode(to: encoder)
        //var container = encoder.container(keyedBy: CodingKeys.self)
        //try container.encode(inputImageAlias, forKey: .inputImageAlias)
        //try container.encode(backgroundImageAlias, forKey: .backgroundImageAlias)
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
        
        print("base blend getFilter type",type)

        currentCIFilter.setValue(inputImage, forKey: kCIInputImageKey)
        currentCIFilter.setValue(backgroundImage, forKey: kCIInputBackgroundImageKey)
        return ciFilter!

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
   
        //return fxStr+aliasStr
    }
    
}
