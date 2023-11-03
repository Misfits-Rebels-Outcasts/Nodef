//
//  Copyright © 2022 James Boo. All rights reserved.
//


import SwiftUI

class UnsharpMaskFX: FilterX {
       
    @Published var radius:Float = 2.5
    @Published var intensity:Float = 0.5

    let description = "Increases the contrast of the edges between pixels of different colors in an image."
    
    override init()
    {
        let name = "CIUnsharpMask"
        super.init(name)
        desc=description
        /*
        print(CIFilter.localizedName(forFilterName: name))
        print(CIFilter.localizedName(forFilterName: name))
        print(CIFilter.localizedDescription(forFilterName: name))
        print(CIFilter.localizedReferenceDocumentation(forFilterName: name))
                    
        print("inputRadius")
        if let attribute = CIFilter.unsharpMask().attributes["inputRadius"] as? [String: AnyObject]
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
        print("inputIntensity")

        if let attribute = CIFilter.unsharpMask().attributes["inputIntensity"] as? [String: AnyObject]
        {
           let minimum = attribute[kCIAttributeSliderMin] as? Float
           let maximum = attribute[kCIAttributeSliderMax] as? Float
           let defaultValue = attribute[kCIAttributeDefault] as? Float
            
            print(minimum)
            print(maximum)
            print(defaultValue)
            
            //Optional(0.0)
            //Optional(2.0)
            //Optional(1.0)
             

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
        radius = try values.decodeIfPresent(Float.self, forKey: .radius) ?? 10.0
        intensity = try values.decodeIfPresent(Float.self, forKey: .intensity) ?? 1.0

    }
    
    override func encode(to encoder: Encoder) throws {
        try super.encode(to: encoder)
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(radius, forKey: .radius)
        try container.encode(intensity, forKey: .intensity)
    }
    
    override func getCIFilter(_ ciImage: CIImage)->CIFilter
    {
        let currentCIFilter = CIFilter(name: type)!
        currentCIFilter.setValue(ciImage, forKey: kCIInputImageKey)
        currentCIFilter.setValue(radius, forKey: kCIInputRadiusKey)
        currentCIFilter.setValue(intensity, forKey: kCIInputIntensityKey)
        ciFilter=currentCIFilter
        return currentCIFilter

    }

}
