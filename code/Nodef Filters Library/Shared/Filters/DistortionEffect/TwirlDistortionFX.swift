//
//  Copyright © 2022 James Boo. All rights reserved.
//

import SwiftUI

class TwirlDistortionFX: FilterX {
       
    @Published var center:CIVector = CIVector(x:150,y:150)
    @Published var centerX:CGFloat = 150
    @Published var centerY:CGFloat = 150
    @Published var radius:Float = 300.0
    @Published var angle:Float = 3.14
    let description = "Rotates pixels around a point to give a twirling effect. You can specify the number of rotations as well as the center and radius of the effect."

    override init()
    {
        let name="CITwirlDistortion"
        super.init(name)
        desc=description
        
        print(CIFilter.localizedName(forFilterName: name))
        print(CIFilter.localizedDescription(forFilterName: name))
        print(CIFilter.localizedReferenceDocumentation(forFilterName: name))
                    
        if let attribute = CIFilter.twirlDistortion().attributes["inputRadius"] as? [String: AnyObject]
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
        case angle
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
        centerX = try values.decodeIfPresent(CGFloat.self, forKey: .centerX) ?? 0.0
        centerY = try values.decodeIfPresent(CGFloat.self, forKey: .centerY) ?? 0.0

        radius = try values.decodeIfPresent(Float.self, forKey: .radius) ?? 0.0
        angle = try values.decodeIfPresent(Float.self, forKey: .angle) ?? 0.0

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
        try container.encode(radius, forKey: .radius)
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
        let tcenter=CIVector(x:centerX,y:centerY)
        //print(center,radius,scale)
        currentCIFilter.setValue(tcenter, forKey: kCIInputCenterKey)
        currentCIFilter.setValue(radius, forKey: kCIInputRadiusKey)
        currentCIFilter.setValue(angle, forKey: kCIInputAngleKey)
        ciFilter=currentCIFilter

        return currentCIFilter
    }

}
