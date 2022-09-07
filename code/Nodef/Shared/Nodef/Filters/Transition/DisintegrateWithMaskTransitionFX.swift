//
//  Copyright © 2022 James Boo. All rights reserved.
//

import SwiftUI
import Accelerate

class DisintegrateWithMaskTransitionFX: BaseTransitionFX {
       
    @Published var inputMaskImageAlias : String=""
    @Published var inputMaskImageAliasId : String=""

    //@Published var time:Float = 0.5
    @Published var shadowRadius:Float = 8.0
    @Published var shadowDensity:Float = 0.65
    @Published var shadowOffsetX:Float = 0.0
    @Published var shadowOffsetY:Float = -10.0

    let description = "Transitions from one image to another using the shape defined by a mask. Shadow Density is the density of the shadow created by the mask. Shadow Offset is the offset of the shadow created by the mask. Shadow Radisu is the radius of the shadow created by the mask."

    override init()
    {
        let name="CIDisintegrateWithMaskTransition"
        super.init(name)
        desc=description
        time=0.5
        print(CIFilter.localizedName(forFilterName: name))
        print(CIFilter.localizedDescription(forFilterName: name))
        print(CIFilter.localizedReferenceDocumentation(forFilterName: name))
        /*
        print("inputTime")
        if let attribute = CIFilter.disintegrateWithMaskTransition().attributes["inputTime"] as? [String: AnyObject]
        {
           let minimum = attribute[kCIAttributeSliderMin] as? Float
           let maximum = attribute[kCIAttributeSliderMax] as? Float
           let defaultValue = attribute[kCIAttributeDefault] as? Float
            
            print(minimum)
            print(maximum)
            print(defaultValue)
            
        }*/
        print("inputShadowRadius")
        if let attribute = CIFilter.disintegrateWithMaskTransition().attributes["inputShadowRadius"] as? [String: AnyObject]
        {
           let minimum = attribute[kCIAttributeSliderMin] as? Float
           let maximum = attribute[kCIAttributeSliderMax] as? Float
           let defaultValue = attribute[kCIAttributeDefault] as? Float
            
            print(minimum)
            print(maximum)
            print(defaultValue)
            
        }
        print("inputShadowDensity")
        if let attribute = CIFilter.disintegrateWithMaskTransition().attributes["inputShadowDensity"] as? [String: AnyObject]
        {
           let minimum = attribute[kCIAttributeSliderMin] as? Float
           let maximum = attribute[kCIAttributeSliderMax] as? Float
           let defaultValue = attribute[kCIAttributeDefault] as? Float
            
            print(minimum)
            print(maximum)
            print(defaultValue)
            
        }
        print("inputShadowOffset")
        if let attribute = CIFilter.disintegrateWithMaskTransition().attributes["inputShadowOffset"] as? [String: AnyObject]
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
        case inputMaskImageAlias
        //case time
        case shadowRadius
        case shadowDensity
        case shadowOffsetX
        case shadowOffsetY
    }

    required init(from decoder: Decoder) throws {
        try super.init(from: decoder)
        let values = try decoder.container(keyedBy: CodingKeys.self)
        desc=description
        
        inputMaskImageAlias = try values.decodeIfPresent(String.self, forKey: .inputMaskImageAlias) ?? ""

        //time = try values.decodeIfPresent(Float.self, forKey: .time) ?? 0
        shadowRadius = try values.decodeIfPresent(Float.self, forKey: .shadowRadius) ?? 0
        shadowDensity = try values.decodeIfPresent(Float.self, forKey: .shadowDensity) ?? 0
        shadowOffsetX = try values.decodeIfPresent(Float.self, forKey: .shadowOffsetX) ?? 0
        shadowOffsetY = try values.decodeIfPresent(Float.self, forKey: .shadowOffsetY) ?? 0
    }
    
    override func encode(to encoder: Encoder) throws {
        try super.encode(to: encoder)
  
        var container = encoder.container(keyedBy: CodingKeys.self)

        try container.encode(inputMaskImageAlias, forKey: .inputMaskImageAlias)
        
        //try container.encode(time, forKey: .time)
        try container.encode(shadowRadius, forKey: .shadowRadius)
        try container.encode(shadowDensity, forKey: .shadowDensity)
        try container.encode(shadowOffsetX, forKey: .shadowOffsetX)
        try container.encode(shadowOffsetY, forKey: .shadowOffsetY)

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
        
        let maskImage=handleAlias(alias: inputMaskImageAlias,
                                      inputImage: currentImage,
                                      beginImage: beginImage)
      
        currentCIFilter.setValue(inputImage, forKey: kCIInputImageKey)
        currentCIFilter.setValue(targetImage, forKey: kCIInputTargetImageKey)
        currentCIFilter.setValue(maskImage, forKey: kCIInputMaskImageKey)
        
        currentCIFilter.setValue(time, forKey: kCIInputTimeKey)
        currentCIFilter.setValue(shadowRadius, forKey: "inputShadowRadius")
        currentCIFilter.setValue(shadowDensity, forKey: "inputShadowDensity")
        
        let shadowOffsetVector = CIVector(x: CGFloat(shadowOffsetX), y: CGFloat(shadowOffsetY))
        currentCIFilter.setValue(shadowOffsetVector, forKey: "inputShadowOffset")
        
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
        
        var targetImageAliasStr = previousStr
        if targetImageAlias != ""{
            targetImageAliasStr = "\""+targetImageAlias+"\""
        }
        
        var inputMaskImageAliasStr = previousStr
        if inputMaskImageAlias != ""{
            inputMaskImageAliasStr = "\""+inputMaskImageAlias+"\""
        }
        

        
        fxStr = "input - " + inputImageAliasStr + ", target - " + targetImageAliasStr + ", mask - " + inputMaskImageAliasStr

        return fxStr
   
    }
}
