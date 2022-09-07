//
//  Copyright © 2022 James Boo. All rights reserved.
//

import SwiftUI

class DotScreenFX: FilterX {
       
    @Published var center:CIVector = CIVector(x:150,y:150)
    @Published var centerX:Float = 150
    @Published var centerY:Float = 150
    
    @Published var angle:Float = 0.0
    @Published var width:Float = 6.0
    @Published var sharpness:Float = 0.7
    
    let description = "Simulates the dot patterns of a halftone screen. The larger the Sharpness, the sharper the pattern. Width is the distance between dots in the pattern."

    override init()
    {
        let name="CIDotScreen"
        super.init(name)
        desc=description
        
        print(CIFilter.localizedName(forFilterName: name))
        print(CIFilter.localizedDescription(forFilterName: name))
        print(CIFilter.localizedReferenceDocumentation(forFilterName: name))
        print("inputAngle")
        if let attribute = CIFilter.dotScreen().attributes["inputAngle"] as? [String: AnyObject]
        {
           let minimum = attribute[kCIAttributeSliderMin] as? Float
           let maximum = attribute[kCIAttributeSliderMax] as? Float
           let defaultValue = attribute[kCIAttributeDefault] as? Float
            
            print(minimum)
            print(maximum)
            print(defaultValue)
            
        }
        print("inputWidth")
        if let attribute = CIFilter.dotScreen().attributes["inputWidth"] as? [String: AnyObject]
        {
           let minimum = attribute[kCIAttributeSliderMin] as? Float
           let maximum = attribute[kCIAttributeSliderMax] as? Float
           let defaultValue = attribute[kCIAttributeDefault] as? Float
            
            print(minimum)
            print(maximum)
            print(defaultValue)
            
        }
        
        print("inputSharpness")

        if let attribute = CIFilter.dotScreen().attributes["inputSharpness"] as? [String: AnyObject]
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
        case angle
        case width
        case sharpness
    }

    required init(from decoder: Decoder) throws {
        try super.init(from: decoder)
        let values = try decoder.container(keyedBy: CodingKeys.self)
        desc=description
        
        /*
        var container = try decoder.unkeyedContainer()
         var floats: [Float] = []
         while !container.isAtEnd {
             floats.append(try container.decode(Float.self))
         }
         */
        centerX = try values.decodeIfPresent(Float.self, forKey: .centerX) ?? 0.0
        centerY = try values.decodeIfPresent(Float.self, forKey: .centerY) ?? 0.0

        angle = try values.decodeIfPresent(Float.self, forKey: .angle) ?? 0.0
        width = try values.decodeIfPresent(Float.self, forKey: .width) ?? 0.0
        sharpness = try values.decodeIfPresent(Float.self, forKey: .sharpness) ?? 0.0

    }
    
    override func encode(to encoder: Encoder) throws {
        try super.encode(to: encoder)
  
        var container = encoder.container(keyedBy: CodingKeys.self)
        /*
        var ucontainer = encoder.unkeyedContainer()
                for i in 0..<center.count {
                    try ucontainer.encode(center.value(at: i))
                }
         */
        try container.encode(centerX, forKey: .centerX)
        try container.encode(centerY, forKey: .centerY)
        try container.encode(angle, forKey: .angle)
        try container.encode(width, forKey: .width)
        try container.encode(sharpness, forKey: .sharpness)
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
    override func getCIFilter(_ ciImage: CIImage)->CIFilter
    {
        let currentCIFilter = CIFilter(name: type)!
        currentCIFilter.setValue(ciImage, forKey: kCIInputImageKey)
        let tcenter=CIVector(x:CGFloat(centerX),y:CGFloat(centerY))
        currentCIFilter.setValue(tcenter, forKey: kCIInputCenterKey)
        currentCIFilter.setValue(angle, forKey: kCIInputAngleKey)
        currentCIFilter.setValue(width, forKey: kCIInputWidthKey)
        currentCIFilter.setValue(sharpness, forKey: kCIInputSharpnessKey)
        ciFilter=currentCIFilter

        return currentCIFilter
    }

}
