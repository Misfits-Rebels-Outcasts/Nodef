//
//  Copyright © 2022 James Boo. All rights reserved.
//

import SwiftUI

class ColorPosterizeFX: FilterX {
       
    @Published var levels:Float = 6.0


    let description = "Remaps red, green, and blue color components to the number of brightness values you specify for each color component. This filter flattens colors to achieve a look similar to that of a silk-screened poster. Levels is the number of brightness levels to use for each color component. Lower values result in a more extreme poster effect."
    
    override init()
    {
        let name = "CIColorPosterize"
        super.init(name)
        desc=description
        /*
        print(CIFilter.localizedName(forFilterName: name))
        print(CIFilter.localizedDescription(forFilterName: name))
        print(CIFilter.localizedReferenceDocumentation(forFilterName: name))
        
        
       
        if let attribute = CIFilter.colorPosterize().attributes["inputLevels"] as? [String: AnyObject]
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
        case levels

    }

    required init(from decoder: Decoder) throws {
        try super.init(from: decoder)
        let values = try decoder.container(keyedBy: CodingKeys.self)
        desc=description
        levels = try values.decodeIfPresent(Float.self, forKey: .levels) ?? 0.0


    }
    
    override func encode(to encoder: Encoder) throws {
        try super.encode(to: encoder)
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(levels, forKey: .levels)

    }
    
    override func getCIFilter(_ ciImage: CIImage)->CIFilter
    {
        let currentCIFilter = CIFilter(name: type)!
        currentCIFilter.setValue(ciImage, forKey: kCIInputImageKey)
        currentCIFilter.setValue(levels, forKey: "inputLevels")
        ciFilter=currentCIFilter
        return currentCIFilter

    }

}
