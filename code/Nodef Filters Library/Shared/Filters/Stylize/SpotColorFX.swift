//
//  Copyright © 2022 James Boo. All rights reserved.
//

import SwiftUI

class SpotColorFX: FilterX {
           
    @Published var centerColor1:CIColor = .yellow
    @Published var centerColorx1:Color = .yellow
    @Published var replacementColor1:CIColor = .black
    @Published var replacementColorx1:Color = .black
    @Published var closeness1:Float = 0.5//0.22
    @Published var contrast1:Float = 1.0//0.98

    @Published var centerColor2:CIColor = .white
    @Published var centerColorx2:Color = .white
    @Published var replacementColor2:CIColor = .black
    @Published var replacementColorx2:Color = .black
    @Published var closeness2:Float = 0.0//0.15
    @Published var contrast2:Float = 0.0//0.98
    
    @Published var centerColor3:CIColor = .white
    @Published var centerColorx3:Color = .white
    @Published var replacementColor3:CIColor = .black
    @Published var replacementColorx3:Color = .black
    @Published var closeness3:Float = 0.0//0.5
    @Published var contrast3:Float = 0.0//0.99
    
    let description = "Replaces one or more color ranges with spot colors. Color is the center value of the color range to replace. Replacement Color is the replacement color for the  color range. Closeness is a value that indicates how close the color must match before it is replaced. Contrast is the contrast of the replacement color."

    override init()
    {
        let name="CISpotColor"
        super.init(name)
        desc=description
        
        print(CIFilter.localizedName(forFilterName: name))
        print(CIFilter.localizedDescription(forFilterName: name))
        print(CIFilter.localizedReferenceDocumentation(forFilterName: name))
        
        print("inputCloseness1")
        if let attribute = CIFilter.spotColor().attributes["inputCloseness1"] as? [String: AnyObject]
        {
           let minimum = attribute[kCIAttributeSliderMin] as? Float
           let maximum = attribute[kCIAttributeSliderMax] as? Float
           let defaultValue = attribute[kCIAttributeDefault] as? Float
            
            print(minimum)
            print(maximum)
            print(defaultValue)
            
        }
        
        print("inputContrast1")
        if let attribute = CIFilter.spotColor().attributes["inputContrast1"] as? [String: AnyObject]
        {
           let minimum = attribute[kCIAttributeSliderMin] as? Float
           let maximum = attribute[kCIAttributeSliderMax] as? Float
           let defaultValue = attribute[kCIAttributeDefault] as? Float
            
            print(minimum)
            print(maximum)
            print(defaultValue)
            
        }
    }

    enum CodingKeys : String, CodingKey {
        case centerColor1
        case replacementColor1
        case closeness1
        case contrast1
        
        case centerColor2
        case replacementColor2
        case closeness2
        case contrast2
        
        case centerColor3
        case replacementColor3
        case closeness3
        case contrast3
    }

    required init(from decoder: Decoder) throws {
        try super.init(from: decoder)
        let values = try decoder.container(keyedBy: CodingKeys.self)
        desc=description
        
        var colorData = try values.decodeIfPresent(Data.self, forKey: .centerColor1) ?? nil
        if colorData != nil
        {
            let uicolor=try NSKeyedUnarchiver.unarchivedObject(ofClass: UIColor.self, from: colorData!)!
            centerColor1 = CIColor(color:uicolor)
            centerColorx1 = Color(uicolor)
        }
        colorData = try values.decodeIfPresent(Data.self, forKey: .replacementColor1) ?? nil
        if colorData != nil
        {
            let uicolor=try NSKeyedUnarchiver.unarchivedObject(ofClass: UIColor.self, from: colorData!)!
            replacementColor1 = CIColor(color:uicolor)
            replacementColorx1 = Color(uicolor)
        }
        closeness1 = try values.decodeIfPresent(Float.self, forKey: .closeness1) ?? 0.0
        
        contrast1 = try values.decodeIfPresent(Float.self, forKey: .contrast1) ?? 0.0
        
        colorData = try values.decodeIfPresent(Data.self, forKey: .centerColor2) ?? nil
        if colorData != nil
        {
            let uicolor=try NSKeyedUnarchiver.unarchivedObject(ofClass: UIColor.self, from: colorData!)!
            centerColor2 = CIColor(color:uicolor)
            centerColorx2 = Color(uicolor)
        }
        colorData = try values.decodeIfPresent(Data.self, forKey: .replacementColor2) ?? nil
        if colorData != nil
        {
            let uicolor=try NSKeyedUnarchiver.unarchivedObject(ofClass: UIColor.self, from: colorData!)!
            replacementColor2 = CIColor(color:uicolor)
            replacementColorx2 = Color(uicolor)
        }
        closeness2 = try values.decodeIfPresent(Float.self, forKey: .closeness2) ?? 0.0
        
        contrast2 = try values.decodeIfPresent(Float.self, forKey: .contrast2) ?? 0.0
        
        colorData = try values.decodeIfPresent(Data.self, forKey: .centerColor3) ?? nil
        if colorData != nil
        {
            let uicolor=try NSKeyedUnarchiver.unarchivedObject(ofClass: UIColor.self, from: colorData!)!
            centerColor3 = CIColor(color:uicolor)
            centerColorx3 = Color(uicolor)
        }
        colorData = try values.decodeIfPresent(Data.self, forKey: .replacementColor3) ?? nil
        if colorData != nil
        {
            let uicolor=try NSKeyedUnarchiver.unarchivedObject(ofClass: UIColor.self, from: colorData!)!
            replacementColor3 = CIColor(color:uicolor)
            replacementColorx3 = Color(uicolor)
        }
        closeness3 = try values.decodeIfPresent(Float.self, forKey: .closeness3) ?? 0.0
        
        contrast3 = try values.decodeIfPresent(Float.self, forKey: .contrast3) ?? 0.0
    }
    
    override func encode(to encoder: Encoder) throws {
        try super.encode(to: encoder)
  
        var container = encoder.container(keyedBy: CodingKeys.self)

        try container.encode(try NSKeyedArchiver.archivedData(withRootObject: UIColor(ciColor: centerColor1), requiringSecureCoding: false), forKey: .centerColor1)
        try container.encode(try NSKeyedArchiver.archivedData(withRootObject: UIColor(ciColor: replacementColor1), requiringSecureCoding: false), forKey: .replacementColor1)
        try container.encode(closeness1, forKey: .closeness1)
        try container.encode(contrast1, forKey: .contrast1)
        
        try container.encode(try NSKeyedArchiver.archivedData(withRootObject: UIColor(ciColor: centerColor2), requiringSecureCoding: false), forKey: .centerColor2)
        try container.encode(try NSKeyedArchiver.archivedData(withRootObject: UIColor(ciColor: replacementColor2), requiringSecureCoding: false), forKey: .replacementColor2)
        try container.encode(closeness2, forKey: .closeness2)
        try container.encode(contrast2, forKey: .contrast2)

        try container.encode(try NSKeyedArchiver.archivedData(withRootObject: UIColor(ciColor: centerColor3), requiringSecureCoding: false), forKey: .centerColor3)
        try container.encode(try NSKeyedArchiver.archivedData(withRootObject: UIColor(ciColor: replacementColor3), requiringSecureCoding: false), forKey: .replacementColor3)
        try container.encode(closeness3, forKey: .closeness3)
        try container.encode(contrast3, forKey: .contrast3)


    }
    
    override func getCIFilter(_ ciImage: CIImage)->CIFilter
    {
        
        var currentCIFilter: CIFilter
        if ciFilter != nil {
            print("current Spot Color")
            currentCIFilter = ciFilter!
        } else {
            print("new Spot Color")
            currentCIFilter = CIFilter(name: type)!
            ciFilter=currentCIFilter
        }
        currentCIFilter.setValue(ciImage, forKey: kCIInputImageKey)
        currentCIFilter.setValue(centerColor1, forKey: "inputCenterColor1")
        currentCIFilter.setValue(replacementColor1, forKey: "inputReplacementColor1")
        currentCIFilter.setValue(closeness1, forKey: "inputCloseness1")
        currentCIFilter.setValue(contrast1, forKey: "inputContrast1")
        
        currentCIFilter.setValue(centerColor2, forKey: "inputCenterColor2")
        currentCIFilter.setValue(replacementColor2, forKey: "inputReplacementColor2")
        currentCIFilter.setValue(closeness2, forKey: "inputCloseness2")
        currentCIFilter.setValue(contrast2, forKey: "inputContrast2")

        currentCIFilter.setValue(centerColor3, forKey: "inputCenterColor3")
        currentCIFilter.setValue(replacementColor3, forKey: "inputReplacementColor3")
        currentCIFilter.setValue(closeness3, forKey: "inputCloseness3")
        currentCIFilter.setValue(contrast3, forKey: "inputContrast3")
        
        return currentCIFilter
        
    }

}
