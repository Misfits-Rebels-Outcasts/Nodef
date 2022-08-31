//
//  Copyright © 2022 James Boo. All rights reserved.
//

import SwiftUI

class DepthOfFieldFX: FilterX {
       
    @Published var pointX0:Float = 0
    @Published var pointY0:Float = 0
    
    @Published var pointX1:Float = 200
    @Published var pointY1:Float = 200

    @Published var saturation:Float = 1.5
    @Published var unsharpMaskRadius:Float = 2.5
    @Published var unsharpMaskIntensity:Float = 0.5
    @Published var radius:Float = 6.0
    
    let description = "Simulates a depth of field effect. Radius is the distance from the center of the effect."

    override init()
    {
        let name="CIDepthOfField"
        super.init(name)
        desc=description
        
        print(CIFilter.localizedName(forFilterName: name))
        print(CIFilter.localizedDescription(forFilterName: name))
        print(CIFilter.localizedReferenceDocumentation(forFilterName: name))
        
        print("inputSaturation")
        if let attribute = CIFilter.depthOfField().attributes["inputSaturation"] as? [String: AnyObject]
        {
           let minimum = attribute[kCIAttributeSliderMin] as? Float
           let maximum = attribute[kCIAttributeSliderMax] as? Float
           let defaultValue = attribute[kCIAttributeDefault] as? Float
            
            print(minimum)
            print(maximum)
            print(defaultValue)
            
        }
        
        print("inputUnsharpMaskRadius")
        if let attribute = CIFilter.depthOfField().attributes["inputUnsharpMaskRadius"] as? [String: AnyObject]
        {
           let minimum = attribute[kCIAttributeSliderMin] as? Float
           let maximum = attribute[kCIAttributeSliderMax] as? Float
           let defaultValue = attribute[kCIAttributeDefault] as? Float
            
            print(minimum)
            print(maximum)
            print(defaultValue)
            
        }
        
        print("inputUnsharpMaskIntensity")
        if let attribute = CIFilter.depthOfField().attributes["inputUnsharpMaskIntensity"] as? [String: AnyObject]
        {
           let minimum = attribute[kCIAttributeSliderMin] as? Float
           let maximum = attribute[kCIAttributeSliderMax] as? Float
           let defaultValue = attribute[kCIAttributeDefault] as? Float
            
            print(minimum)
            print(maximum)
            print(defaultValue)
            
        }
        
        print("inputRadius")
        if let attribute = CIFilter.depthOfField().attributes["inputRadius"] as? [String: AnyObject]
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
        case pointX0
        case pointY0
        case pointX1
        case pointY1
        case saturation
        case unsharpMaskRadius
        case unsharpMaskIntensity
        case radius
    }

    required init(from decoder: Decoder) throws {
        try super.init(from: decoder)
        let values = try decoder.container(keyedBy: CodingKeys.self)
        desc=description
        
        pointX0 = try values.decodeIfPresent(Float.self, forKey: .pointX0) ?? 0.0
        pointY0 = try values.decodeIfPresent(Float.self, forKey: .pointY0) ?? 0.0
        pointX1 = try values.decodeIfPresent(Float.self, forKey: .pointX1) ?? 0.0
        pointY1 = try values.decodeIfPresent(Float.self, forKey: .pointY1) ?? 0.0

        saturation = try values.decodeIfPresent(Float.self, forKey: .saturation) ?? 0.0
        unsharpMaskRadius = try values.decodeIfPresent(Float.self, forKey: .unsharpMaskRadius) ?? 0.0
        unsharpMaskIntensity = try values.decodeIfPresent(Float.self, forKey: .unsharpMaskIntensity) ?? 0.0
        radius = try values.decodeIfPresent(Float.self, forKey: .radius) ?? 0.0

    }
    
    override func encode(to encoder: Encoder) throws {
        try super.encode(to: encoder)
  
        var container = encoder.container(keyedBy: CodingKeys.self)

        try container.encode(pointX0, forKey: .pointX0)
        try container.encode(pointY0, forKey: .pointY0)
        try container.encode(pointX1, forKey: .pointX1)
        try container.encode(pointY1, forKey: .pointY1)

        try container.encode(saturation, forKey: .saturation)
        try container.encode(unsharpMaskRadius, forKey: .unsharpMaskRadius)
        try container.encode(unsharpMaskIntensity, forKey: .unsharpMaskIntensity)
        try container.encode(radius, forKey: .radius)

    }
    
    override func setupProperties(_ parent: FiltersX?)
    {
        super.setupProperties(parent)
        
        if parent != nil{
            pointX0=0
            //the following is the value that makes it visible
            pointY0=Float(size.height/2)

            pointX1=Float(size.width)
            pointY1=Float(size.height)
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
            currentCIFilter = ciFilter!
        } else {
            currentCIFilter = CIFilter(name: type)!
            ciFilter=currentCIFilter
        }
        currentCIFilter.setValue(ciImage, forKey: kCIInputImageKey)
        let center0=CIVector(x:CGFloat(pointX0),y:CGFloat(pointY0))
        currentCIFilter.setValue(center0, forKey: "inputPoint0")
        let center1=CIVector(x:CGFloat(pointX1),y:CGFloat(pointY1))
        currentCIFilter.setValue(center1, forKey: "inputPoint1")

        currentCIFilter.setValue(saturation, forKey: "inputSaturation")
        currentCIFilter.setValue(unsharpMaskRadius, forKey: "inputUnsharpMaskRadius")
        currentCIFilter.setValue(unsharpMaskIntensity, forKey: "inputUnsharpMaskIntensity")
        currentCIFilter.setValue(radius, forKey: "inputRadius")

        return currentCIFilter
        
    }

}
