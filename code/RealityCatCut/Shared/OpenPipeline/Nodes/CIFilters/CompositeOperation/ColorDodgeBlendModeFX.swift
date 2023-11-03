//
//  Copyright © 2022 James Boo. All rights reserved.
//

import SwiftUI

class ColorDodgeBlendModeFX: BaseBlendFX {
       
    let description = "Brightens the background image (B) samples to reflect the source image (A) samples."
    override init()
    {
        let name = "CIColorDodgeBlendMode"
        super.init(name)
        desc=description
        /*
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
        */
    }

    enum CodingKeys : String, CodingKey {
        case None
    }

    required init(from decoder: Decoder) throws {
        try super.init(from: decoder)
        //let values = try decoder.container(keyedBy: CodingKeys.self)
        desc=description

    }
    
    override func encode(to encoder: Encoder) throws {
        try super.encode(to: encoder)
        //var container = encoder.container(keyedBy: CodingKeys.self)
    }
    /*
    override func getCIFilter(_ ciImage: CIImage)->CIFilter
    {
        let currentCIFilter = CIFilter(name: type)!
        currentCIFilter.setValue(ciImage, forKey: kCIInputImageKey)
        currentCIFilter.setValue(radius, forKey: kCIInputRadiusKey)
        currentCIFilter.setValue(sharpness, forKey: kCIInputSharpnessKey)
        return currentCIFilter

    }
    */
}
