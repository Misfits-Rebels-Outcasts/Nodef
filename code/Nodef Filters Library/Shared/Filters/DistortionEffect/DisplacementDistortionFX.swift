//
//  Copyright © 2022 James Boo. All rights reserved.
//

import SwiftUI

class DisplacementDistortionFX: FilterX {
    

 @Published var inputDisplacementImageAlias : String=""
 @Published var inputDisplacementImageAliasId : String=""
 @Published var scale:Float = 50.0
 let description = "Distorts an image by applying a glass-like texture. This filter works better with smaller images such as those less than 1024 x 1024 pixels."

 override init()
 {
     let name="CIDisplacementDistortion"
     super.init(name)
     desc=description
     
     print(CIFilter.localizedName(forFilterName: name))
     print(CIFilter.localizedDescription(forFilterName: name))
     print(CIFilter.localizedReferenceDocumentation(forFilterName: name))
                 
     print("inputScale")
     if let attribute = CIFilter.displacementDistortion().attributes["inputScale"] as? [String: AnyObject]
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

     case inputDisplacementImageAlias
     case scale
 }

 required init(from decoder: Decoder) throws {
     try super.init(from: decoder)
     let values = try decoder.container(keyedBy: CodingKeys.self)
     desc=description
     
     inputDisplacementImageAlias = try values.decodeIfPresent(String.self, forKey: .inputDisplacementImageAlias) ?? ""
     scale = try values.decodeIfPresent(Float.self, forKey: .scale) ?? 0.0

 }
 
 override func encode(to encoder: Encoder) throws {
     try super.encode(to: encoder)

     var container = encoder.container(keyedBy: CodingKeys.self)
     try container.encode(inputDisplacementImageAlias, forKey: .inputDisplacementImageAlias)
     try container.encode(scale, forKey: .scale)

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
        
        let displacementImage=handleAlias(alias: inputDisplacementImageAlias,
                                      inputImage: currentImage,
                                      beginImage: beginImage)
        
        currentCIFilter.setValue(inputImage, forKey: kCIInputImageKey)
        currentCIFilter.setValue(displacementImage, forKey: "inputDisplacementImage")
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
        
        var displacementImageAliasStr = previousStr
        if inputDisplacementImageAlias != ""{
            displacementImageAliasStr = "\""+inputDisplacementImageAlias+"\""
        }
                
        fxStr = "input - " + inputImageAliasStr + ", displacement - " + displacementImageAliasStr

        return fxStr
   
    }
}
