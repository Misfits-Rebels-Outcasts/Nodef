//
//  Copyright © 2022 James Boo. All rights reserved.
//

import SwiftUI

class NoiseReductionFX: FilterX {
       
    @Published var noiseLevel:Float = 0.02
    @Published var sharpness:Float = 0.4
    let description = "Reduces noise using a threshold value to define what is considered noise. The larger the Noise Level, the more noise reduction. The larger the sharpness, the sharper the result."

    override init()
    {
        let name = "CINoiseReduction"
        super.init(name)
        desc=description
        /*
        print(CIFilter.localizedName(forFilterName: name))
        print(CIFilter.localizedDescription(forFilterName: name))
        print(CIFilter.localizedReferenceDocumentation(forFilterName: name))
                    
        print("noiseLevel")
        if let attribute = CIFilter.noiseReduction().attributes["inputNoiseLevel"] as? [String: AnyObject]
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
        print("inputSharpness")
        if let attribute = CIFilter.noiseReduction().attributes["inputSharpness"] as? [String: AnyObject]
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
        case noiseLevel
        case sharpness
    }

    required init(from decoder: Decoder) throws {
        try super.init(from: decoder)
        let values = try decoder.container(keyedBy: CodingKeys.self)
        desc=description
        noiseLevel = try values.decodeIfPresent(Float.self, forKey: .noiseLevel) ?? 0.0
        sharpness = try values.decodeIfPresent(Float.self, forKey: .sharpness) ?? 0.0

    }
    
    override func encode(to encoder: Encoder) throws {
        try super.encode(to: encoder)
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(noiseLevel, forKey: .noiseLevel)
        try container.encode(sharpness, forKey: .sharpness)
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
        currentCIFilter.setValue(noiseLevel, forKey: "inputNoiseLevel")
        currentCIFilter.setValue(sharpness, forKey: kCIInputSharpnessKey)
        return currentCIFilter
        
    }

}
