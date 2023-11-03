//
//  Copyright © 2022 James Boo. All rights reserved.
//

import SwiftUI

class BloomFX: FilterX {
       
    @Published var radius:Float = 10.0
    @Published var intensity:Float = 0.5
    
    let description = "Softens edges and applies a pleasant glow to an image. An Intensity of 0.0 has no effect while a value of 1.0 has the maximum effect."

    override init()
    {
        let name="CIBloom"
        super.init(name)
        desc=description
        /*
        print(CIFilter.localizedName(forFilterName: name))
        print(CIFilter.localizedDescription(forFilterName: name))
        print(CIFilter.localizedReferenceDocumentation(forFilterName: name))

        print("inputRadius")
        if let attribute = CIFilter.bloom().attributes["inputRadius"] as? [String: AnyObject]
        {
           let minimum = attribute[kCIAttributeSliderMin] as? Float
           let maximum = attribute[kCIAttributeSliderMax] as? Float
           let defaultValue = attribute[kCIAttributeDefault] as? Float
            
            print(minimum)
            print(maximum)
            print(defaultValue)
            
        }
        print("inputIntensity")
        if let attribute = CIFilter.bloom().attributes["inputIntensity"] as? [String: AnyObject]
        {
           let minimum = attribute[kCIAttributeSliderMin] as? Float
           let maximum = attribute[kCIAttributeSliderMax] as? Float
           let defaultValue = attribute[kCIAttributeDefault] as? Float
            
            print(minimum)
            print(maximum)
            print(defaultValue)
            
        }
         */
    }

    enum CodingKeys : String, CodingKey {
        case radius
        case intensity

    }

    required init(from decoder: Decoder) throws {
        try super.init(from: decoder)
        let values = try decoder.container(keyedBy: CodingKeys.self)
        desc=description
        
        radius = try values.decodeIfPresent(Float.self, forKey: .radius) ?? 0
        intensity = try values.decodeIfPresent(Float.self, forKey: .intensity) ?? 0

    }
    
    override func encode(to encoder: Encoder) throws {
        try super.encode(to: encoder)
  
        var container = encoder.container(keyedBy: CodingKeys.self)

        try container.encode(radius, forKey: .radius)
        try container.encode(intensity, forKey: .intensity)


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
        currentCIFilter.setValue(radius, forKey: kCIInputRadiusKey)
        currentCIFilter.setValue(intensity, forKey: kCIInputIntensityKey)

        return currentCIFilter
        
    }

}
