//
//  Copyright © 2022 James Boo. All rights reserved.
//

import SwiftUI

class StarShineGeneratorFX: BaseGeneratorFX {
       
    @Published var centerX:Float = 150
    @Published var centerY:Float = 150
    @Published var colorx:Color = .black
    @Published var color:CIColor = .black
    
    @Published var radius:Float = 50.0 //15.0 attributes
    @Published var crossScale:Float = 15.0
    @Published var crossAngle:Float = 0.6
    @Published var crossOpacity:Float = -2.00
    @Published var crossWidth:Float = 2.5
    @Published var epsilon:Float = -2.00
    
    let description = "Generates a starburst pattern. The output image is typically used as input to another filter. Color refers to the color to use for the outer shell of the circular star. Epsilon is the length of the cross spikes."

    override init()
    {
        let name="CIStarShineGenerator"
        super.init(name)
        desc=description
        
        print(CIFilter.localizedName(forFilterName: name))
        print(CIFilter.localizedDescription(forFilterName: name))
        print(CIFilter.localizedReferenceDocumentation(forFilterName: name))
  
        print("inputRadius")
        if let attribute = CIFilter.starShineGenerator().attributes["inputCrossScale"] as? [String: AnyObject]
        {
           let minimum = attribute[kCIAttributeSliderMin] as? Float
           let maximum = attribute[kCIAttributeSliderMax] as? Float
           let defaultValue = attribute[kCIAttributeDefault] as? Float
            
            print(minimum)
            print(maximum)
            print(defaultValue)
            
        }
        
        print("inputCrossScale")
        if let attribute = CIFilter.starShineGenerator().attributes["inputCrossScale"] as? [String: AnyObject]
        {
           let minimum = attribute[kCIAttributeSliderMin] as? Float
           let maximum = attribute[kCIAttributeSliderMax] as? Float
           let defaultValue = attribute[kCIAttributeDefault] as? Float
            
            print(minimum)
            print(maximum)
            print(defaultValue)
            
        }
        print("inputCrossAngle")
        if let attribute = CIFilter.starShineGenerator().attributes["inputCrossAngle"] as? [String: AnyObject]
        {
           let minimum = attribute[kCIAttributeSliderMin] as? Float
           let maximum = attribute[kCIAttributeSliderMax] as? Float
           let defaultValue = attribute[kCIAttributeDefault] as? Float
            
            print(minimum)
            print(maximum)
            print(defaultValue)
            
        }
        
        print("inputCrossOpacity")
        if let attribute = CIFilter.starShineGenerator().attributes["inputCrossOpacity"] as? [String: AnyObject]
        {
           let minimum = attribute[kCIAttributeSliderMin] as? Float
           let maximum = attribute[kCIAttributeSliderMax] as? Float
           let defaultValue = attribute[kCIAttributeDefault] as? Float
            
            print(minimum)
            print(maximum)
            print(defaultValue)
            
        }
        
        print("inputCrossWidth")
        if let attribute = CIFilter.starShineGenerator().attributes["inputCrossWidth"] as? [String: AnyObject]
        {
           let minimum = attribute[kCIAttributeSliderMin] as? Float
           let maximum = attribute[kCIAttributeSliderMax] as? Float
           let defaultValue = attribute[kCIAttributeDefault] as? Float
            
            print(minimum)
            print(maximum)
            print(defaultValue)
            
        }
        
        print("inputEpsilon")
        if let attribute = CIFilter.starShineGenerator().attributes["inputEpsilon"] as? [String: AnyObject]
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
        case color
        
        case radius
        case crossScale
        case crossAngle
        case crossOpacity
        case crossWidth
        case epsilon
        
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
        
        radius = try values.decodeIfPresent(Float.self, forKey: .radius) ?? 0.0
        crossScale = try values.decodeIfPresent(Float.self, forKey: .crossScale) ?? 0.0
        crossAngle = try values.decodeIfPresent(Float.self, forKey: .crossAngle) ?? 0.0
        crossOpacity = try values.decodeIfPresent(Float.self, forKey: .crossOpacity) ?? 0.0
        crossWidth = try values.decodeIfPresent(Float.self, forKey: .crossWidth) ?? 0.0
        epsilon = try values.decodeIfPresent(Float.self, forKey: .epsilon) ?? 0.0
    }
    
    override func encode(to encoder: Encoder) throws {
        try super.encode(to: encoder)
  
        var container = encoder.container(keyedBy: CodingKeys.self)

        try container.encode(centerX, forKey: .centerX)
        try container.encode(centerY, forKey: .centerY)
        try container.encode(try NSKeyedArchiver.archivedData(withRootObject: UIColor(ciColor: color), requiringSecureCoding: false), forKey: .color)

        try container.encode(radius, forKey: .radius)
        try container.encode(crossScale, forKey: .crossScale)
        try container.encode(crossAngle, forKey: .crossAngle)
        try container.encode(crossOpacity, forKey: .crossOpacity)
        try container.encode(crossWidth, forKey: .crossWidth)
        try container.encode(epsilon, forKey: .epsilon)
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
            print("current StarShine")
            currentCIFilter = ciFilter!
        } else {
            print("new StarShine")
            currentCIFilter = CIFilter(name: type)!
            ciFilter=currentCIFilter
        }
        
        let tcenter=CIVector(x:CGFloat(centerX),y:CGFloat(centerY))
        currentCIFilter.setValue(tcenter, forKey: kCIInputCenterKey)
        currentCIFilter.setValue(color, forKey: kCIInputColorKey)
        
        currentCIFilter.setValue(radius, forKey: "inputRadius")
        currentCIFilter.setValue(crossScale, forKey: "inputCrossScale")
        currentCIFilter.setValue(crossAngle, forKey: "inputCrossAngle")
        currentCIFilter.setValue(crossOpacity, forKey: "inputCrossOpacity")
        currentCIFilter.setValue(crossWidth, forKey: "inputCrossWidth")
        currentCIFilter.setValue(epsilon, forKey: "inputEpsilon")

        return currentCIFilter
    }

}
