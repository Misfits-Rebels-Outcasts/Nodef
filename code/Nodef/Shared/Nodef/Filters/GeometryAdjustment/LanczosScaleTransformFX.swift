//
//  Copyright © 2022 James Boo. All rights reserved.
//


import SwiftUI

class LanczosScaleTransformFX: FilterX {
       
    @Published var scale:Float = 1.0
    @Published var aspectRatio:Float = 1.0

    
    let description = "Produces a high-quality, scaled version of a source image. Aspect Ratio is the additional horizontal scaling factor to use on the image. Scaling values less than 1.0 scale down the images. Scaling values greater than 1.0 scale up the image."

    override init()
    {
        let name="CILanczosScaleTransform"
        super.init(name)
        desc=description
        
        print(CIFilter.localizedName(forFilterName: name))
        print(CIFilter.localizedDescription(forFilterName: name))
        print(CIFilter.localizedReferenceDocumentation(forFilterName: name))
        print("inputScale")
        if let attribute = CIFilter.lanczosScaleTransform().attributes["inputScale"] as? [String: AnyObject]
        {
           let minimum = attribute[kCIAttributeSliderMin] as? Float
           let maximum = attribute[kCIAttributeSliderMax] as? Float
           let defaultValue = attribute[kCIAttributeDefault] as? Float
            
            print(minimum)
            print(maximum)
            print(defaultValue)
            
        }
        print("inputAspectRatio")
        if let attribute = CIFilter.lanczosScaleTransform().attributes["inputAspectRatio"] as? [String: AnyObject]
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
        case scale
        case aspectRatio

    }

    required init(from decoder: Decoder) throws {
        try super.init(from: decoder)
        let values = try decoder.container(keyedBy: CodingKeys.self)
        desc=description
        
        scale = try values.decodeIfPresent(Float.self, forKey: .scale) ?? 0
        aspectRatio = try values.decodeIfPresent(Float.self, forKey: .aspectRatio) ?? 0

    }
    
    override func encode(to encoder: Encoder) throws {
        try super.encode(to: encoder)
  
        var container = encoder.container(keyedBy: CodingKeys.self)

        try container.encode(scale, forKey: .scale)
        try container.encode(aspectRatio, forKey: .aspectRatio)


    }
    
    override func getCIFilter(_ ciImage: CIImage)->CIFilter
    {
        
        var currentCIFilter: CIFilter
        if ciFilter != nil {
            currentCIFilter = ciFilter!
        } else {
            currentCIFilter = CIFilter(name: type)!
            ciFilter=currentCIFilter
        }
        currentCIFilter.setValue(ciImage, forKey: kCIInputImageKey)
        currentCIFilter.setValue(scale, forKey: kCIInputScaleKey)
        currentCIFilter.setValue(aspectRatio, forKey: kCIInputAspectRatioKey)


        return currentCIFilter
        
    }

}
