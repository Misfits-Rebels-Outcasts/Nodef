//
//  Copyright © 2022 James Boo. All rights reserved.
//

import SwiftUI

class DiscBlurFX: FilterX {
       
    @Published var radius:Float = 8.0
    let description = "Smooths an image using a disc-shaped convolution kernel. Radius determines how many pixels are used to create the blur. The larger the radius, the blurrier the result."

    override init()
    {
        let name = "CIDiscBlur"
        super.init(name)
        desc=description
        
        print(CIFilter.localizedName(forFilterName: name))
        print(CIFilter.localizedDescription(forFilterName: name))
        print(CIFilter.localizedReferenceDocumentation(forFilterName: name))
                    
        if let attribute = CIFilter.discBlur().attributes["inputRadius"] as? [String: AnyObject]
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
        case radius
    }

    required init(from decoder: Decoder) throws {
        try super.init(from: decoder)
        let values = try decoder.container(keyedBy: CodingKeys.self)
        desc=description
        radius = try values.decodeIfPresent(Float.self, forKey: .radius) ?? 0.0
      
    }
    
    override func encode(to encoder: Encoder) throws {
        try super.encode(to: encoder)
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(radius, forKey: .radius)
    }
    
    override func getCIFilter(_ ciImage: CIImage)->CIFilter
    {
        let currentCIFilter = CIFilter(name: type)!
        print("extent blur:",ciImage.extent)
        currentCIFilter.setValue(ciImage, forKey: kCIInputImageKey)
        currentCIFilter.setValue(radius, forKey: kCIInputRadiusKey)
        ciFilter=currentCIFilter

        return currentCIFilter
    }

}
