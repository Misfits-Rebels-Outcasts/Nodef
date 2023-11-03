//
//  Copyright © 2022 James Boo. All rights reserved.
//

import SwiftUI

class VibranceFX: FilterX {
       
    @Published var amount:Float = 0.0

    let description = "Adjusts the saturation of an image while keeping pleasing skin tones."

    override init()
    {
        let name = "CIVibrance"
        super.init(name)
        desc=description
      /*
        print(CIFilter.localizedName(forFilterName: name))
        print(CIFilter.localizedDescription(forFilterName: name))
        print(CIFilter.localizedReferenceDocumentation(forFilterName: name))
         
        print("inputAmount")
        if let attribute = CIFilter.vibrance().attributes["inputAmount"] as? [String: AnyObject]
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
        case amount
    }

    required init(from decoder: Decoder) throws {
        try super.init(from: decoder)
        let values = try decoder.container(keyedBy: CodingKeys.self)
        desc=description
        amount = try values.decodeIfPresent(Float.self, forKey: .amount) ?? 0.0


        
    }
    
    override func encode(to encoder: Encoder) throws {
        try super.encode(to: encoder)
        var container = encoder.container(keyedBy: CodingKeys.self)
        
        try container.encode(amount, forKey: .amount)

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
        
        currentCIFilter.setValue(amount, forKey: kCIInputAmountKey)

        return currentCIFilter
    }

}
