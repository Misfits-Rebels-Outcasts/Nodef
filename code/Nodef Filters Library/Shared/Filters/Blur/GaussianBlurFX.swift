//
//  Copyright © 2022 James Boo. All rights reserved.
//

import SwiftUI

class GaussianBlurFX: FilterX {
       
    @Published var radius:Float = 10.0
    let description = "Spreads source pixels by an amount specified by a Gaussian distribution. Radius determines how many pixels are used to create the blur. The larger the radius, the blurrier the result."

    override init()
    {
        super.init("CIGaussianBlur")
        desc=description
        
        print(CIFilter.localizedName(forFilterName: "CIGaussianBlur"))
        print(CIFilter.localizedDescription(forFilterName: "CIGaussianBlur"))
        print(CIFilter.localizedReferenceDocumentation(forFilterName: "CIGaussianBlur"))
                    
        if let attribute = CIFilter.gaussianBlur().attributes["inputRadius"] as? [String: AnyObject]
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
        currentCIFilter.setValue(ciImage, forKey: kCIInputImageKey)
        currentCIFilter.setValue(radius, forKey: kCIInputRadiusKey)
        ciFilter=currentCIFilter

        return currentCIFilter
    }

}
