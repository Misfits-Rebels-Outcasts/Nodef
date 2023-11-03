//
//  Copyright © 2022 James Boo. All rights reserved.
//

import SwiftUI

class MedianFilterFX: FilterX {
       
    let description = "Computes the median value for a group of neighboring pixels and replaces each pixel value with the median."

    override init()
    {
        let name = "CIMedianFilter"
        super.init(name)
        desc=description
        /*
        print(CIFilter.localizedName(forFilterName: name))
        print(CIFilter.localizedDescription(forFilterName: name))
        print(CIFilter.localizedReferenceDocumentation(forFilterName: name))
         */
                 /*
        if let attribute = CIFilter.boxBlur().attributes["inputRadius"] as? [String: AnyObject]
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
        return currentCIFilter
        
    }
     
}
