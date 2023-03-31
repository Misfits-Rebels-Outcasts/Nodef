//
//  Copyright © 2022 James Boo. All rights reserved.
//

import SwiftUI

class SharpenLuminanceFX: FilterX {
       
    @Published var radius:Float = 10.0
    @Published var sharpness:Float = 1.0

    let description = "Increases image detail by sharpening. It operates on the luminance of the image; the chrominance of the pixels remains unaffected. Sharpness refers to the amount of sharpening to apply. Rqadisu is the distance from the center of the effect."
    override init()
    {
        let name = "CISharpenLuminance"
        super.init(name)
        desc=description
        
        print(CIFilter.localizedName(forFilterName: name))
        print(CIFilter.localizedName(forFilterName: name))
        print(CIFilter.localizedDescription(forFilterName: name))
        print(CIFilter.localizedReferenceDocumentation(forFilterName: name))
                    
        if let attribute = CIFilter.sharpenLuminance().attributes["inputRadius"] as? [String: AnyObject]
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
        if let attribute = CIFilter.sharpenLuminance().attributes["inputSharpness"] as? [String: AnyObject]
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
        /*
        if let attribute = CIFilter.colorControls().attributes["inputContrast"] as? [String: AnyObject]
        {
           let minimum = attribute[kCIAttributeSliderMin] as? Float
           let maximum = attribute[kCIAttributeSliderMax] as? Float
           let defaultValue = attribute[kCIAttributeDefault] as? Float
            
            print(minimum)
            print(maximum)
            print(defaultValue)
            
            //Optional(0.25)
            //Optional(4.0)
            //Optional(1.0)
             

        }
         */
    }

    enum CodingKeys : String, CodingKey {
        case radius
        case sharpness
    }

    required init(from decoder: Decoder) throws {
        try super.init(from: decoder)
        let values = try decoder.container(keyedBy: CodingKeys.self)
        desc=description
        radius = try values.decodeIfPresent(Float.self, forKey: .radius) ?? 10.0
        sharpness = try values.decodeIfPresent(Float.self, forKey: .sharpness) ?? 1.0

    }
    
    override func encode(to encoder: Encoder) throws {
        try super.encode(to: encoder)
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(radius, forKey: .radius)
        try container.encode(sharpness, forKey: .sharpness)
    }
    
    override func getCIFilter(_ ciImage: CIImage)->CIFilter
    {
        let currentCIFilter = CIFilter(name: type)!
        currentCIFilter.setValue(ciImage, forKey: kCIInputImageKey)
        currentCIFilter.setValue(radius, forKey: kCIInputRadiusKey)
        currentCIFilter.setValue(sharpness, forKey: kCIInputSharpnessKey)
        ciFilter=currentCIFilter
        return currentCIFilter

    }

}
