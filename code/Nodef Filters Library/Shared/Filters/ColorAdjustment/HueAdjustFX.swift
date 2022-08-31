//
//  Copyright © 2022 James Boo. All rights reserved.
//

import SwiftUI

class HueAdjustFX: FilterX {
       
    @Published var angle:Float = 0.0

    let description = "Changes the overall hue, or tint, of the source pixels. An angle is used to correct the hue of an image."

    override init()
    {
        let name = "CIHueAdjust"
        super.init(name)
        desc=description
      
        print(CIFilter.localizedName(forFilterName: name))
        print(CIFilter.localizedDescription(forFilterName: name))
        print(CIFilter.localizedReferenceDocumentation(forFilterName: name))
        print("inputAngle")
        if let attribute = CIFilter.hueAdjust().attributes["inputAngle"] as? [String: AnyObject]
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
        case angle


    }

    required init(from decoder: Decoder) throws {
        try super.init(from: decoder)
        let values = try decoder.container(keyedBy: CodingKeys.self)
        desc=description
        angle = try values.decodeIfPresent(Float.self, forKey: .angle) ?? 0.0

        
    }
    
    override func encode(to encoder: Encoder) throws {
        try super.encode(to: encoder)
        var container = encoder.container(keyedBy: CodingKeys.self)
        
        try container.encode(angle, forKey: .angle)

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
        currentCIFilter.setValue(angle, forKey: kCIInputAngleKey)

        return currentCIFilter
    }

}
