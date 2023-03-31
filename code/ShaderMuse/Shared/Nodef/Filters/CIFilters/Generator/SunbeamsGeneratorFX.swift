//
//  Copyright © 2022 James Boo. All rights reserved.
//

import SwiftUI

class SunbeamsGeneratorFX: BaseGeneratorFX {
       
    @Published var centerX:Float = 150
    @Published var centerY:Float = 150
    @Published var colorx:Color = .yellow
    @Published var color:CIColor = .yellow
    
    @Published var sunRadius:Float = 40.00
    @Published var maxStriationRadius:Float = 2.58
    @Published var striationStrength:Float = 0.50
    @Published var striationContrast:Float = 1.38
    @Published var time:Float = 0.5
    
    let description = "Generates a sun effect. You typically use the output of the sunbeams filter as input to a composite filter. Color refers to the color of the sun. Maximum Striation Radius is the radius of the sunbeams."

    override init()
    {
        let name="CISunbeamsGenerator"
        super.init(name)
        desc=description
        
        print(CIFilter.localizedName(forFilterName: name))
        print(CIFilter.localizedDescription(forFilterName: name))
        print(CIFilter.localizedReferenceDocumentation(forFilterName: name))
             
        print("inputSunRadius")
        if let attribute = CIFilter.sunbeamsGenerator().attributes["inputSunRadius"] as? [String: AnyObject]
        {
           let minimum = attribute[kCIAttributeSliderMin] as? Float
           let maximum = attribute[kCIAttributeSliderMax] as? Float
           let defaultValue = attribute[kCIAttributeDefault] as? Float
            
            print(minimum)
            print(maximum)
            print(defaultValue)
            
        }
        
        print("inputMaxStriationRadius")
        if let attribute = CIFilter.sunbeamsGenerator().attributes["inputMaxStriationRadius"] as? [String: AnyObject]
        {
           let minimum = attribute[kCIAttributeSliderMin] as? Float
           let maximum = attribute[kCIAttributeSliderMax] as? Float
           let defaultValue = attribute[kCIAttributeDefault] as? Float
            
            print(minimum)
            print(maximum)
            print(defaultValue)
            
        }
        
        print("inputStriationStrength")
        if let attribute = CIFilter.sunbeamsGenerator().attributes["inputStriationStrength"] as? [String: AnyObject]
        {
           let minimum = attribute[kCIAttributeSliderMin] as? Float
           let maximum = attribute[kCIAttributeSliderMax] as? Float
           let defaultValue = attribute[kCIAttributeDefault] as? Float
            
            print(minimum)
            print(maximum)
            print(defaultValue)
            
        }
        
        print("inputStriationContrast")
        if let attribute = CIFilter.sunbeamsGenerator().attributes["inputStriationContrast"] as? [String: AnyObject]
        {
           let minimum = attribute[kCIAttributeSliderMin] as? Float
           let maximum = attribute[kCIAttributeSliderMax] as? Float
           let defaultValue = attribute[kCIAttributeDefault] as? Float
            
            print(minimum)
            print(maximum)
            print(defaultValue)
            
        }
        
        print("inputTime")
        if let attribute = CIFilter.sunbeamsGenerator().attributes["inputTime"] as? [String: AnyObject]
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
        case centerX
        case centerY
        case colorx
        case color
        
        case sunRadius
        case maxStriationRadius
        case striationStrength
        case striationContrast
        case time
    }

    required init(from decoder: Decoder) throws {
        try super.init(from: decoder)
        let values = try decoder.container(keyedBy: CodingKeys.self)
        desc=description
        
        centerX = try values.decodeIfPresent(Float.self, forKey: .centerX) ?? 0.0
        centerY = try values.decodeIfPresent(Float.self, forKey: .centerY) ?? 0.0
        let colorData = try values.decodeIfPresent(Data.self, forKey: .color) ?? nil
        if colorData != nil
        {
            let uicolor=try NSKeyedUnarchiver.unarchivedObject(ofClass: UIColor.self, from: colorData!)!
            color = CIColor(color:uicolor)
            colorx = Color(uicolor)
        }
        sunRadius = try values.decodeIfPresent(Float.self, forKey: .sunRadius) ?? 0.0
        maxStriationRadius = try values.decodeIfPresent(Float.self, forKey: .maxStriationRadius) ?? 0.0
        striationStrength = try values.decodeIfPresent(Float.self, forKey: .striationStrength) ?? 0.0
        striationContrast = try values.decodeIfPresent(Float.self, forKey: .striationContrast) ?? 0.0
        time = try values.decodeIfPresent(Float.self, forKey: .time) ?? 0.0

    }
    
    override func encode(to encoder: Encoder) throws {
        try super.encode(to: encoder)
  
        var container = encoder.container(keyedBy: CodingKeys.self)

        try container.encode(centerX, forKey: .centerX)
        try container.encode(centerY, forKey: .centerY)
        try container.encode(try NSKeyedArchiver.archivedData(withRootObject: UIColor(ciColor: color), requiringSecureCoding: false), forKey: .color)
        
        try container.encode(sunRadius, forKey: .sunRadius)
        try container.encode(maxStriationRadius, forKey: .maxStriationRadius)
        try container.encode(striationStrength, forKey: .striationStrength)
        try container.encode(striationContrast, forKey: .striationContrast)
        try container.encode(time, forKey: .time)
    }
    override func setupProperties(_ parent: FiltersX?)
    {
        super.setupProperties(parent)
        
        if parent != nil{
            centerX=Float(size.width/2.0)
            centerY=Float(size.height/2.0)
        }
        
    }
    
    override func adjustPropertiesToBounds(_ parent: FiltersX?)
    {
        super.adjustPropertiesToBounds(parent)
        
        centerX = centerX > Float(size.width) ? Float(size.width) : centerX
        centerY = centerY > Float(size.height) ? Float(size.height) : centerY
        
    }
    override func getCIFilter(currentImage: CIImage, beginImage: CIImage) -> CIFilter? {
        
        var currentCIFilter: CIFilter
        if ciFilter != nil {
            print("current Constant Color")
            currentCIFilter = ciFilter!
        } else {
            print("new Constant Color")
            currentCIFilter = CIFilter(name: type)!
            ciFilter=currentCIFilter
        }
        
        let tcenter=CIVector(x:CGFloat(centerX),y:CGFloat(centerY))
        currentCIFilter.setValue(tcenter, forKey: kCIInputCenterKey)
        currentCIFilter.setValue(color, forKey: kCIInputColorKey)
                
        currentCIFilter.setValue(sunRadius, forKey: "inputSunRadius")
        currentCIFilter.setValue(maxStriationRadius, forKey: "inputMaxStriationRadius")
        currentCIFilter.setValue(striationStrength, forKey: "inputStriationStrength")
        currentCIFilter.setValue(striationContrast, forKey: "inputStriationContrast")
        currentCIFilter.setValue(time, forKey: kCIInputTimeKey)

        return currentCIFilter
    }

}
