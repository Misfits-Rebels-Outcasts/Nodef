//
//  Copyright © 2022 James Boo. All rights reserved.
//

import SwiftUI

class ColorCubeWithColorSpaceFX: FilterX {
       
    @Published var brightness:Float = 0.0


    let description = "Modifies the pixel values in an image by applying a set of polynomial cross-products."
    override init()
    {
        let name = "CIColorEffect"
        super.init(name)
        desc=description
        /*
        print(CIFilter.localizedName(forFilterName: name))
        print(CIFilter.localizedDescription(forFilterName: name))
        print(CIFilter.localizedReferenceDocumentation(forFilterName: name))
        */
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

         */
    }

    enum CodingKeys : String, CodingKey {
        case brightness

    }

    required init(from decoder: Decoder) throws {
        try super.init(from: decoder)
        let values = try decoder.container(keyedBy: CodingKeys.self)
        desc=description
        brightness = try values.decodeIfPresent(Float.self, forKey: .brightness) ?? 0.0


    }
    
    override func encode(to encoder: Encoder) throws {
        try super.encode(to: encoder)
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(brightness, forKey: .brightness)

    }
    
    override func getCIFilter(_ ciImage: CIImage)->CIFilter
    {
        let currentCIFilter = CIFilter(name: type)!
        currentCIFilter.setValue(ciImage, forKey: kCIInputImageKey)
        currentCIFilter.setValue(brightness, forKey: kCIInputBrightnessKey)
        ciFilter=currentCIFilter
        return currentCIFilter

    }

}
