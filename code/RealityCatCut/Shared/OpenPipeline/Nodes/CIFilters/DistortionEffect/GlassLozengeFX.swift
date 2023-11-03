//
//  Copyright © 2022 James Boo. All rights reserved.
//


import SwiftUI

class GlassLozengeFX: FilterX {
       
    @Published var pointX0:Float = 0
    @Published var pointY0:Float = 0
    
    @Published var pointX1:Float = 350
    @Published var pointY1:Float = 150
    
    @Published var radius:Float = 100.0
    @Published var refraction:Float = 1.7
    
    let description = "Creates a lozenge-shaped lens and distorts the portion of the image over which the lens is placed. Refraction is the refraction of the glass. The larger the radius, the wider the extent of the lozenge distortion. "

    override init()
    {
        let name="CIGlassLozenge"
        super.init(name)
        desc=description
        /*
        print(CIFilter.localizedName(forFilterName: name))
        print(CIFilter.localizedDescription(forFilterName: name))
        print(CIFilter.localizedReferenceDocumentation(forFilterName: name))
                    
        print("inputRadius")
        if let attribute = CIFilter.glassLozenge().attributes["inputRadius"] as? [String: AnyObject]
        {
           let minimum = attribute[kCIAttributeSliderMin] as? Float
           let maximum = attribute[kCIAttributeSliderMax] as? Float
           let defaultValue = attribute[kCIAttributeDefault] as? Float
            
            print(minimum)
            print(maximum)
            print(defaultValue)
            
        }
        print("inputRefraction")
        if let attribute = CIFilter.glassLozenge().attributes["inputRefraction"] as? [String: AnyObject]
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
        case pointX0
        case pointY0
        case pointX1
        case pointY1
        case radius
        case refraction
    }

    required init(from decoder: Decoder) throws {
        try super.init(from: decoder)
        let values = try decoder.container(keyedBy: CodingKeys.self)
        desc=description
        
        pointX0 = try values.decodeIfPresent(Float.self, forKey: .pointX0) ?? 0.0
        pointY0 = try values.decodeIfPresent(Float.self, forKey: .pointY0) ?? 0.0

        pointX1 = try values.decodeIfPresent(Float.self, forKey: .pointX1) ?? 0.0
        pointY1 = try values.decodeIfPresent(Float.self, forKey: .pointY1) ?? 0.0
        
        radius = try values.decodeIfPresent(Float.self, forKey: .radius) ?? 0.0
        refraction = try values.decodeIfPresent(Float.self, forKey: .refraction) ?? 0.0

    }
    
    override func encode(to encoder: Encoder) throws {
        try super.encode(to: encoder)
  
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(pointX0, forKey: .pointX0)
        try container.encode(pointY0, forKey: .pointY0)
        try container.encode(pointX1, forKey: .pointX1)
        try container.encode(pointY1, forKey: .pointY1)
        try container.encode(radius, forKey: .radius)
        try container.encode(refraction, forKey: .refraction)
    }
    
    override func setupProperties(_ parent: FiltersX?)
    {
        super.setupProperties(parent)
        
        if parent != nil{
            pointX0=Float(size.width/3)
            pointY0=Float(size.height/3)

            pointX1=Float(2*size.width/3)
            pointY1=Float(2*size.height/3)
            
        }
        
    }
    
    override func adjustPropertiesToBounds(_ parent: FiltersX?)
    {
        super.adjustPropertiesToBounds(parent)
        
        pointX0 = pointX0 > Float(size.width) ? Float(size.width) : pointX0
        pointY0 = pointY0 > Float(size.height) ? Float(size.height) : pointY0

        pointX1 = pointX1 > Float(size.width) ? Float(size.width) : pointX1
        pointY1 = pointY1 > Float(size.height) ? Float(size.height) : pointY1
    }
    
    override func getCIFilter(_ ciImage: CIImage)->CIFilter
    {
        var currentCIFilter: CIFilter
        if ciFilter != nil {
            print("current Glass Logenze")
            currentCIFilter = ciFilter!
        } else {
            print("new Glass Logenze")
            currentCIFilter = CIFilter(name: type)!
            ciFilter=currentCIFilter
        }
        currentCIFilter.setValue(ciImage, forKey: kCIInputImageKey)
        let center0=CIVector(x:CGFloat(pointX0),y:CGFloat(pointY0))
        currentCIFilter.setValue(center0, forKey: "inputPoint0")
        let center1=CIVector(x:CGFloat(pointX1),y:CGFloat(pointY1))
        currentCIFilter.setValue(center1, forKey: "inputPoint1")
        currentCIFilter.setValue(radius, forKey: kCIInputRadiusKey)
        currentCIFilter.setValue(refraction, forKey: kCIInputRefractionKey)

        return currentCIFilter
    }

}
