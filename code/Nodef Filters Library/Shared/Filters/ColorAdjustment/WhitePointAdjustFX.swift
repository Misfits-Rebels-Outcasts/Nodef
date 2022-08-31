//
//  Copyright © 2022 James Boo. All rights reserved.
//
import SwiftUI

class WhitePointAdjustFX: FilterX {
       
    @Published var color:CIColor = .white
    @Published var colorx:Color = .white

    let description = "Adjusts the reference white point for an image and maps all colors in the source using the new reference. Color is the color to use as the white point."

    override init()
    {
        let name = "CIWhitePointAdjust"
        super.init(name)
        desc=description
      
        print(CIFilter.localizedName(forFilterName: name))
        print(CIFilter.localizedDescription(forFilterName: name))
        print(CIFilter.localizedReferenceDocumentation(forFilterName: name))
         
    }

    enum CodingKeys : String, CodingKey {
        case color


    }

    required init(from decoder: Decoder) throws {
        try super.init(from: decoder)
        let values = try decoder.container(keyedBy: CodingKeys.self)
        desc=description
        var colorData = try values.decodeIfPresent(Data.self, forKey: .color) ?? nil
        if colorData != nil
        {
            let uicolor=try NSKeyedUnarchiver.unarchivedObject(ofClass: UIColor.self, from: colorData!)!
            color = CIColor(color:uicolor)
            colorx = Color(uicolor)
        }

        
    }
    
    override func encode(to encoder: Encoder) throws {
        try super.encode(to: encoder)
        var container = encoder.container(keyedBy: CodingKeys.self)
        
        try container.encode(try NSKeyedArchiver.archivedData(withRootObject: UIColor(ciColor: color), requiringSecureCoding: false), forKey: .color)

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
        
        currentCIFilter.setValue(color, forKey: kCIInputColorKey)

        return currentCIFilter
    }

}
