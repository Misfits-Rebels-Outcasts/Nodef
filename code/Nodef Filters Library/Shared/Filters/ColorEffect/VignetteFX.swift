//
//  Copyright © 2022 James Boo. All rights reserved.
//

import SwiftUI

class VignetteFX: FilterX {
       
    @Published var intensity:Float = 0.0
    @Published var radius:Float = 1.0

    let description = "Applies a vignette shading to the corners of an image. This reduces the brightness of an image at the periphery. Radius is the distance from the center of the effect."
    override init()
    {
        let name = "CIVignette"
        super.init(name)
        desc=description
        
        print(CIFilter.localizedName(forFilterName: name))
        print(CIFilter.localizedDescription(forFilterName: name))
        print(CIFilter.localizedReferenceDocumentation(forFilterName: name))
        
        
        print(CIFilter.localizedName(forFilterName: name))
        if let attribute = CIFilter.vignette().attributes["inputIntensity"] as? [String: AnyObject]
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
        if let attribute = CIFilter.vignette().attributes["inputRadius"] as? [String: AnyObject]
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
         
    }

    enum CodingKeys : String, CodingKey {
        case intensity
        case radius

    }

    required init(from decoder: Decoder) throws {
        try super.init(from: decoder)
        let values = try decoder.container(keyedBy: CodingKeys.self)
        desc=description
        intensity = try values.decodeIfPresent(Float.self, forKey: .intensity) ?? 0.0
        radius = try values.decodeIfPresent(Float.self, forKey: .radius) ?? 0.0


    }
    
    override func encode(to encoder: Encoder) throws {
        try super.encode(to: encoder)
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(intensity, forKey: .intensity)
        try container.encode(radius, forKey: .radius)

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
        currentCIFilter.setValue(intensity, forKey: kCIInputIntensityKey)
        currentCIFilter.setValue(radius, forKey: kCIInputRadiusKey)
        return currentCIFilter

    }

}
