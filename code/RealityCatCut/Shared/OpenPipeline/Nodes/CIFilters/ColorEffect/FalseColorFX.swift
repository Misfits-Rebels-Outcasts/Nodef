//
//  Copyright © 2022 James Boo. All rights reserved.
//

import SwiftUI

class FalseColorFX: FilterX {
       
    @Published var color0:CIColor = .blue
    @Published var colorx0:Color = .blue
    
    @Published var color1:CIColor = .red
    @Published var colorx1:Color = .red

    let description = "Maps luminance to a color ramp of two colors. False color is often used to process astronomical and other scientific data, such as ultraviolet and x-ray images."
    
    override init()
    {
        let name = "CIFalseColor"
        super.init(name)
        desc=description
        /*
        print(CIFilter.localizedName(forFilterName: name))
        print(CIFilter.localizedDescription(forFilterName: name))
        print(CIFilter.localizedReferenceDocumentation(forFilterName: name))
        */
    }

    enum CodingKeys : String, CodingKey {
        case color0
        case color1

    }

    required init(from decoder: Decoder) throws {
        try super.init(from: decoder)
        let values = try decoder.container(keyedBy: CodingKeys.self)
        desc=description
        var colorData = try values.decodeIfPresent(Data.self, forKey: .color0) ?? nil
        if colorData != nil
        {
            let uicolor=try NSKeyedUnarchiver.unarchivedObject(ofClass: UIColor.self, from: colorData!)!
            color0 = CIColor(color:uicolor)
            colorx0 = Color(uicolor)
        }
        colorData = try values.decodeIfPresent(Data.self, forKey: .color1) ?? nil
        if colorData != nil
        {
            let uicolor=try NSKeyedUnarchiver.unarchivedObject(ofClass: UIColor.self, from: colorData!)!
            color1 = CIColor(color:uicolor)
            colorx1 = Color(uicolor)
        }


    }
    
    override func encode(to encoder: Encoder) throws {
        try super.encode(to: encoder)
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(try NSKeyedArchiver.archivedData(withRootObject: UIColor(ciColor: color0), requiringSecureCoding: false), forKey: .color0)
        try container.encode(try NSKeyedArchiver.archivedData(withRootObject: UIColor(ciColor: color1), requiringSecureCoding: false), forKey: .color1)

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
        currentCIFilter.setValue(color0, forKey: "inputColor0")
        currentCIFilter.setValue(color1, forKey: "inputColor1")

        return currentCIFilter

    }

}
