//
//  Copyright © 2022 James Boo. All rights reserved.
//

import SwiftUI

class ConstantColorGeneratorFX: BaseGeneratorFX {
       
    @Published var color:CIColor = .blue
    @Published var colorx:Color = .blue
    @Published var colorStr:String = "blue"
    
    let description = "Generates a solid color. You typically use the output of this filter as the input to another filter."

    override init()
    {
        let name="CIConstantColorGenerator"
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
        
        let colorData = try values.decodeIfPresent(Data.self, forKey: .color) ?? nil
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
    
    
    var constantColorCIFilter:CIFilter?
    override func getCIFilter(currentImage: CIImage, beginImage: CIImage) -> CIFilter? {
        
        var constantColorFilter: CIFilter

        constantColorFilter = constantColorCIFilter != nil ? constantColorCIFilter! : CIFilter(name: type)!
        
        constantColorFilter.setValue(color, forKey: kCIInputColorKey)

        if cropToFormat{
            super.setCIFilterAndCropImage(inputImage: constantColorFilter.outputImage!)
            return ciFilter!
        }
        else{
            ciFilter=constantColorFilter
            return ciFilter!

        }
    }

}
