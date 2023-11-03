//
//  Copyright © 2022 James Boo. All rights reserved.
//
import SwiftUI

class SepiaToneFX: FilterX {
       
    @Published var intensity:Float = 1.0


    let description = "Maps the colors of an image to various shades of brown to give a warmer tone or nostalgic look. Instensity is the intensity of the sepia effect. A value of 1.0 creates a monochrome sepia image. A value of 0.0 has no effect on the image."
    
    override init()
    {
        let name = "CISepiaTone"
        super.init(name)
        desc=description
        /*
        print(CIFilter.localizedName(forFilterName: name))
        print(CIFilter.localizedDescription(forFilterName: name))
        print(CIFilter.localizedReferenceDocumentation(forFilterName: name))
        
        
        print(CIFilter.localizedName(forFilterName: name))
        if let attribute = CIFilter.sepiaTone().attributes["inputIntensity"] as? [String: AnyObject]
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
        case intensity

    }

    required init(from decoder: Decoder) throws {
        try super.init(from: decoder)
        let values = try decoder.container(keyedBy: CodingKeys.self)
        desc=description
        intensity = try values.decodeIfPresent(Float.self, forKey: .intensity) ?? 0.0


    }
    
    override func encode(to encoder: Encoder) throws {
        try super.encode(to: encoder)
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(intensity, forKey: .intensity)

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
        currentCIFilter.setValue(intensity, forKey: kCIInputIntensityKey)
        return currentCIFilter
        

    }

}
