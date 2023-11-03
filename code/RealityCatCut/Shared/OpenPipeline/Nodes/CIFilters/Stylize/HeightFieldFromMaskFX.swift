//
//  Copyright © 2022 James Boo. All rights reserved.
//

import SwiftUI

class HeightFieldFromMaskFX: FilterX {
       
    @Published var radius:Float = 10.0

    
    //let description = "Produces a continuous three-dimensional, loft-shaped height field from a grayscale mask."

    let description = "The white values of the mask define those pixels that are inside the height field while the black values define those pixels that are outside. The field varies smoothly and continuously inside the mask, reaching the value 0 at the edge of the mask. You can use this filter with the Shaded Material filter node to produce extremely realistic shaded objects. Radius is the distance from the edge of the mask for the smooth transition is proportional to the input radius. Larger values make the transition smoother and more pronounced. Smaller values make the transition approximate a fillet radius."
    
    //The white values of the mask define those pixels that are inside the height field while the black values define those pixels that are outside. The field varies smoothly and continuously inside the mask, reaching the value 0 at the edge of the mask. You can use this filter with the Shaded Material filter node to produce extremely realistic shaded objects.
    
    override init()
    {
        let name="CIHeightFieldFromMask"
        super.init(name)
        desc=description
        /*
        print(CIFilter.localizedName(forFilterName: name))
        print(CIFilter.localizedDescription(forFilterName: name))
        print(CIFilter.localizedReferenceDocumentation(forFilterName: name))
        print("inputRadius")
        if let attribute = CIFilter.heightFieldFromMask().attributes["inputRadius"] as? [String: AnyObject]
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
        currentCIFilter.setValue(radius, forKey: "inputRadius")
        
        return currentCIFilter
        
    }

}
