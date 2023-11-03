//
//  Copyright © 2022 James Boo. All rights reserved.
//


import SwiftUI

class CMYKHalftoneFX: FilterX {
       
    @Published var center:CIVector = CIVector(x:150,y:150)
    @Published var centerX:Float = 150
    @Published var centerY:Float = 150
    
    @Published var width:Float = 6.0
    @Published var angle:Float = 0.0
    @Published var sharpness:Float = 0.7
    @Published var GCR:Float = 1.0
    @Published var UCR:Float = 0.5
    
    let description = "Creates a color, halftoned rendition of the source image, using cyan, magenta, yellow, and black inks over a white page. GCR changes the Gray Component Replacement and UCR changes the Under Color Removal. The larger the Sharpness, the sharper the pattern. Width is the distance between the  dots in the pattern."

    override init()
    {
        let name="CICMYKHalftone"
        super.init(name)
        desc=description
        /*
        print(CIFilter.localizedName(forFilterName: name))
        print(CIFilter.localizedDescription(forFilterName: name))
        print(CIFilter.localizedReferenceDocumentation(forFilterName: name))
                    
        print("inputWidth")
        if let attribute = CIFilter.cmykHalftone().attributes["inputWidth"] as? [String: AnyObject]
        {
           let minimum = attribute[kCIAttributeSliderMin] as? Float
           let maximum = attribute[kCIAttributeSliderMax] as? Float
           let defaultValue = attribute[kCIAttributeDefault] as? Float
            
            print(minimum)
            print(maximum)
            print(defaultValue)
            
        }
        print("inputAngle")
        if let attribute = CIFilter.cmykHalftone().attributes["inputAngle"] as? [String: AnyObject]
        {
           let minimum = attribute[kCIAttributeSliderMin] as? Float
           let maximum = attribute[kCIAttributeSliderMax] as? Float
           let defaultValue = attribute[kCIAttributeDefault] as? Float
            
            print(minimum)
            print(maximum)
            print(defaultValue)
            
        }
        print("inputSharpness")

        if let attribute = CIFilter.cmykHalftone().attributes["inputSharpness"] as? [String: AnyObject]
        {
           let minimum = attribute[kCIAttributeSliderMin] as? Float
           let maximum = attribute[kCIAttributeSliderMax] as? Float
           let defaultValue = attribute[kCIAttributeDefault] as? Float
            
            print(minimum)
            print(maximum)
            print(defaultValue)
            
        }
        print("inputGCR")

        if let attribute = CIFilter.cmykHalftone().attributes["inputGCR"] as? [String: AnyObject]
        {
           let minimum = attribute[kCIAttributeSliderMin] as? Float
           let maximum = attribute[kCIAttributeSliderMax] as? Float
           let defaultValue = attribute[kCIAttributeDefault] as? Float
            
            print(minimum)
            print(maximum)
            print(defaultValue)
            
        }
        print("inputUCR")

        if let attribute = CIFilter.cmykHalftone().attributes["inputUCR"] as? [String: AnyObject]
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
        case centerX
        case centerY
        case width
        case angle
        case sharpness
        case GCR
        case UCR
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

        width = try values.decodeIfPresent(Float.self, forKey: .width) ?? 0.0
        angle = try values.decodeIfPresent(Float.self, forKey: .angle) ?? 0.0
        sharpness = try values.decodeIfPresent(Float.self, forKey: .sharpness) ?? 0.0
        GCR = try values.decodeIfPresent(Float.self, forKey: .GCR) ?? 0.0
        UCR = try values.decodeIfPresent(Float.self, forKey: .UCR) ?? 0.0

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
        try container.encode(width, forKey: .width)
        try container.encode(angle, forKey: .angle)
        try container.encode(sharpness, forKey: .sharpness)
        try container.encode(GCR, forKey: .GCR)
        try container.encode(UCR, forKey: .UCR)
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
        currentCIFilter.setValue(width, forKey: kCIInputWidthKey)
        currentCIFilter.setValue(angle, forKey: kCIInputAngleKey)
        currentCIFilter.setValue(sharpness, forKey: kCIInputSharpnessKey)
        currentCIFilter.setValue(GCR, forKey: "inputGCR")
        currentCIFilter.setValue(UCR, forKey: "inputUCR")
        ciFilter=currentCIFilter

        return currentCIFilter
    }

}
