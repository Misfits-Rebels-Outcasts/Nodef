//
//  Copyright © 2022 James Boo. All rights reserved.
//


import SwiftUI

class BaseTransitionFX: FilterX {

    @Published var targetImageAlias : String=""
    @Published var targetImageAliasId : String=""
    @Published var time:Float = 0.0
    
    override init()
    {
        super.init()
    }
    
    override init(_ type:String) {
        super.init(type)
    }
    
    enum CodingKeys : String, CodingKey {
        case targetImageAlias
        case time
    }

    required init(from decoder: Decoder) throws {
 
        try super.init(from: decoder)
        let values = try decoder.container(keyedBy: CodingKeys.self)
        targetImageAlias = try values.decodeIfPresent(String.self, forKey: .targetImageAlias) ?? ""
        time = try values.decodeIfPresent(Float.self, forKey: .time) ?? 0.0
    }
    
    override func encode(to encoder: Encoder) throws {
        try super.encode(to: encoder)
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(targetImageAlias, forKey: .targetImageAlias)
        try container.encode(time, forKey: .time)
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
        
        let targetImage=handleAlias(alias: targetImageAlias,
                                      inputImage: currentImage,
                                      beginImage: beginImage)
        
        currentCIFilter.setValue(inputImage, forKey: kCIInputImageKey)
        currentCIFilter.setValue(targetImage, forKey: kCIInputTargetImageKey)
        currentCIFilter.setValue(time, forKey: kCIInputTimeKey)

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
 
        if inputImageAlias == "" && targetImageAlias == ""
        {
            fxStr="input - "+previousStr+", target - "+previousStr
        }
        else if inputImageAlias != "" && targetImageAlias == ""
        {
            let inputImageAliasStr = "\""+inputImageAlias+"\""
            fxStr = "input - "+inputImageAliasStr + ", target - "+previousStr
        }
        else if inputImageAlias == "" && targetImageAlias != ""
        {
            let targetImageAliasStr = "\""+targetImageAlias+"\""
            fxStr = "input - "+previousStr+", target - "+targetImageAliasStr
        }
        else if inputImageAlias != "" && targetImageAlias != ""
        {
            let inputImageAliasStr = "\""+inputImageAlias+"\""
            let targetImageAliasStr = "\""+targetImageAlias+"\""
            fxStr = "input - " + inputImageAliasStr + ", target - " + targetImageAliasStr
        }

        return fxStr
   
    }
 
}
