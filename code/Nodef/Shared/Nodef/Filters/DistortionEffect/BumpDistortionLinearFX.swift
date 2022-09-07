//
//  Copyright © 2022 James Boo. All rights reserved.
//


import SwiftUI

class BumpDistortionLinearFX: FilterX {
       
    @Published var centerX:CGFloat = 300
    @Published var centerY:CGFloat = 300
    @Published var radius:Float = 300.0
    @Published var scale:Float = 0.5
    @Published var angle:Float = 0.0

    let description = "Creates a concave or convex distortion that originates from a line in the image. The larger the radius, the wider the extent of the bump distortion."

    override init()
    {
        let name="CIBumpDistortionLinear"
        super.init(name)
        desc=description
        
        print(CIFilter.localizedName(forFilterName: name))
        print(CIFilter.localizedDescription(forFilterName: name))
        print(CIFilter.localizedReferenceDocumentation(forFilterName: name))
                    
        if let attribute = CIFilter.bumpDistortionLinear().attributes["inputRadius"] as? [String: AnyObject]
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
        case radius
        case scale
        case angle
    }

    required init(from decoder: Decoder) throws {
        try super.init(from: decoder)
        let values = try decoder.container(keyedBy: CodingKeys.self)
        desc=description
        
        centerX = try values.decodeIfPresent(CGFloat.self, forKey: .centerX) ?? 0.0
        centerY = try values.decodeIfPresent(CGFloat.self, forKey: .centerY) ?? 0.0

        radius = try values.decodeIfPresent(Float.self, forKey: .radius) ?? 0.0
        scale = try values.decodeIfPresent(Float.self, forKey: .scale) ?? 0.0
        angle = try values.decodeIfPresent(Float.self, forKey: .angle) ?? 0.0

    }
    
    override func encode(to encoder: Encoder) throws {
        try super.encode(to: encoder)
  
        var container = encoder.container(keyedBy: CodingKeys.self)

        try container.encode(centerX, forKey: .centerX)
        try container.encode(centerY, forKey: .centerY)
        try container.encode(radius, forKey: .radius)
        try container.encode(scale, forKey: .scale)
        try container.encode(angle, forKey: .angle)
    }
    
    override func setupProperties(_ parent: FiltersX?)
    {
        super.setupProperties(parent)
        
        if parent != nil{
            centerX=size.width/2.0
            centerY=size.height/2.0
        }
        
    }
    
    override func adjustPropertiesToBounds(_ parent: FiltersX?)
    {
        super.adjustPropertiesToBounds(parent)
        
        centerX = centerX > size.width ? size.width : centerX
        centerY = centerY > size.height ? size.height : centerY
        
    }
    
    override func getCIFilter(_ ciImage: CIImage)->CIFilter
    {
        let currentCIFilter = CIFilter(name: type)!
        currentCIFilter.setValue(ciImage, forKey: kCIInputImageKey)
        var tcenter=CIVector(x:centerX,y:centerY)
        
        //print(center,radius,scale)
        currentCIFilter.setValue(tcenter, forKey: kCIInputCenterKey)
        currentCIFilter.setValue(radius, forKey: kCIInputRadiusKey)
        currentCIFilter.setValue(scale, forKey: kCIInputScaleKey)
        currentCIFilter.setValue(angle, forKey: kCIInputAngleKey)
        ciFilter=currentCIFilter

        return currentCIFilter
    }

}
