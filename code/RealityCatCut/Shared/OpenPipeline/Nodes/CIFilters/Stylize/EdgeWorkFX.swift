//
//  Copyright © 2022 James Boo. All rights reserved.
//


import SwiftUI

class EdgeWorkFX: FilterX {
       
    @Published var radius:Float = 3.0

    //revisit - needs a background black to see the effects
    //otherwise need contant color with sourve over blend
    
    let description = "Produces a stylized black-and-white rendition of an image that looks similar to a woodblock cutout. This requires a background image to visualize. Please refer to the Stylize EWAI Preset on how to use this filter node."
   
    override init()
    {
        let name="CIEdgeWork"
        super.init(name)
        desc=description
        /*
        print(CIFilter.localizedName(forFilterName: name))
        print(CIFilter.localizedDescription(forFilterName: name))
        print(CIFilter.localizedReferenceDocumentation(forFilterName: name))
        
        print("inputRadius")
        if let attribute = CIFilter.edgeWork().attributes["inputRadius"] as? [String: AnyObject]
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
        case radius

    }

    required init(from decoder: Decoder) throws {
        try super.init(from: decoder)
        let values = try decoder.container(keyedBy: CodingKeys.self)
        desc=description
        
        radius = try values.decodeIfPresent(Float.self, forKey: .radius) ?? 0

    }
    
    override func encode(to encoder: Encoder) throws {
        try super.encode(to: encoder)
  
        var container = encoder.container(keyedBy: CodingKeys.self)

        try container.encode(radius, forKey: .radius)


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
        currentCIFilter.setValue(radius, forKey: kCIInputRadiusKey)

        return currentCIFilter
        
    }

}
