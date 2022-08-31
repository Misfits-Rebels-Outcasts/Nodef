//
//  Copyright © 2022 James Boo. All rights reserved.
//

import SwiftUI

class ColorControlsFX: FilterX {
       
    @Published var brightness:Float = 0.0
    @Published var contrast:Float = 1.0
    @Published var saturation:Float = 1.0

    let description = "Adjusts saturation, brightness, and contrast values."
    override init()
    {
        super.init("CIColorControls")
        desc=description
        /*
        print(CIFilter.localizedName(forFilterName: "CIColorControls"))
        if let attribute = CIFilter.colorControls().attributes["inputBrightness"] as? [String: AnyObject]
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
        if let attribute = CIFilter.colorControls().attributes["inputSaturation"] as? [String: AnyObject]
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
        case brightness
        case contrast
        case saturation
    }

    required init(from decoder: Decoder) throws {
        try super.init(from: decoder)
        let values = try decoder.container(keyedBy: CodingKeys.self)
        desc=description
        brightness = try values.decodeIfPresent(Float.self, forKey: .brightness) ?? 0.0
        contrast = try values.decodeIfPresent(Float.self, forKey: .contrast) ?? 1.0
        saturation = try values.decodeIfPresent(Float.self, forKey: .saturation) ?? 1.0

    }
    
    override func encode(to encoder: Encoder) throws {
        try super.encode(to: encoder)
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(brightness, forKey: .brightness)
        try container.encode(contrast, forKey: .contrast)
        try container.encode(saturation, forKey: .saturation)
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
        currentCIFilter.setValue(brightness, forKey: kCIInputBrightnessKey)
        currentCIFilter.setValue(contrast, forKey: kCIInputContrastKey)
        currentCIFilter.setValue(saturation, forKey: kCIInputSaturationKey)
        return currentCIFilter

    }

}
