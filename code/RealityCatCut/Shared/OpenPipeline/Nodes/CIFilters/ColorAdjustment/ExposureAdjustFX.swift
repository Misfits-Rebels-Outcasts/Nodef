//
//  Copyright © 2022 James Boo. All rights reserved.
//

import SwiftUI

class ExposureAdjustFX: FilterX {
       
    @Published var ev:Float = 0.0
    let description = "Adjusts the exposure setting for an image similar to the way you control exposure for a camera when you change the F-stop."

    override init()
    {
        let name = "CIExposureAdjust"
        super.init(name)
        desc=description
        /*
        print(CIFilter.localizedName(forFilterName: name))
        print(CIFilter.localizedDescription(forFilterName: name))
        print(CIFilter.localizedReferenceDocumentation(forFilterName: name))
                    
        if let attribute = CIFilter.exposureAdjust().attributes["inputEV"] as? [String: AnyObject]
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

        print("completed")
         */
    }

    enum CodingKeys : String, CodingKey {
        case ev
    }

    required init(from decoder: Decoder) throws {
        try super.init(from: decoder)
        let values = try decoder.container(keyedBy: CodingKeys.self)
        desc=description
        ev = try values.decodeIfPresent(Float.self, forKey: .ev) ?? 0.0
      
    }
    
    override func encode(to encoder: Encoder) throws {
        try super.encode(to: encoder)
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(ev, forKey: .ev)
    }
    
    override func getCIFilter(_ ciImage: CIImage)->CIFilter
    {
        let currentCIFilter = CIFilter(name: type)!
        currentCIFilter.setValue(ciImage, forKey: kCIInputImageKey)
        currentCIFilter.setValue(ev, forKey: kCIInputEVKey)
        ciFilter=currentCIFilter

        return currentCIFilter
    }

}
