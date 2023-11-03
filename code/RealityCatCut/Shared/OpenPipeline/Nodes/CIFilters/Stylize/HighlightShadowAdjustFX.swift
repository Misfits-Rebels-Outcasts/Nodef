//
//  Copyright © 2022 James Boo. All rights reserved.
//

import SwiftUI

class HighlightShadowAdjustFX: FilterX {
       
    @Published var highlightAmount:Float = 1.0
    @Published var shadowAmount:Float = 1.0
    
    @Published var radius:Float = 0.0
    
    let description = "Adjust the tonal mapping of an image while preserving spatial detail. Highlight Amount is the amount of adjustment to the highlights of the image. Shadow Amount is the amount of adjustment to the shadows of the image."

    override init()
    {
        let name="CIHighlightShadowAdjust"
        super.init(name)
        desc=description
        /*
        print(CIFilter.localizedName(forFilterName: name))
        print(CIFilter.localizedDescription(forFilterName: name))
        print(CIFilter.localizedReferenceDocumentation(forFilterName: name))
        print("inputHighlightAmount")
        if let attribute = CIFilter.highlightShadowAdjust().attributes["inputHighlightAmount"] as? [String: AnyObject]
        {
           let minimum = attribute[kCIAttributeSliderMin] as? Float
           let maximum = attribute[kCIAttributeSliderMax] as? Float
           let defaultValue = attribute[kCIAttributeDefault] as? Float
            
            print(minimum)
            print(maximum)
            print(defaultValue)
            
        }
        print("inputShadowAmount")
        if let attribute = CIFilter.highlightShadowAdjust().attributes["inputShadowAmount"] as? [String: AnyObject]
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
        case highlightAmount
        case shadowAmount
        case radius
    }

    required init(from decoder: Decoder) throws {
        try super.init(from: decoder)
        let values = try decoder.container(keyedBy: CodingKeys.self)
        desc=description
        
        highlightAmount = try values.decodeIfPresent(Float.self, forKey: .highlightAmount) ?? 0
        shadowAmount = try values.decodeIfPresent(Float.self, forKey: .shadowAmount) ?? 0
        radius = try values.decodeIfPresent(Float.self, forKey: .radius) ?? 0

    }
    
    override func encode(to encoder: Encoder) throws {
        try super.encode(to: encoder)
  
        var container = encoder.container(keyedBy: CodingKeys.self)

        try container.encode(highlightAmount, forKey: .highlightAmount)
        try container.encode(shadowAmount, forKey: .shadowAmount)
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
        currentCIFilter.setValue(highlightAmount, forKey: "inputHighlightAmount")
   
        currentCIFilter.setValue(shadowAmount, forKey: "inputShadowAmount")
        
        currentCIFilter.setValue(radius, forKey: "inputRadius")
        
        return currentCIFilter
        
    }

}
