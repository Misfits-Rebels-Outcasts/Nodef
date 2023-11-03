//
//  Copyright © 2022 James Boo. All rights reserved.
//


import SwiftUI

class DrosteFX: FilterX {
       
    @Published var insetPointX0:Float = 200
    @Published var insetPointY0:Float = 200
    
    @Published var insetPointX1:Float = 400
    @Published var insetPointY1:Float = 400
    
    @Published var strands:Float = 1
    @Published var periodicity:Float = 1
    @Published var rotation:Float = 0.0
    @Published var zoom:Float = 1

    let description = "Recursively draws a portion of an image in imitation of an M. C. Escher drawing. Periodicity sets the number of times the image is repeated on each level of the spiral. Strand is the number of arms on the spiral. "

    override init()
    {
        let name="CIDroste"
        super.init(name)
        desc=description
        /*
        print(CIFilter.localizedName(forFilterName: name))
        print(CIFilter.localizedDescription(forFilterName: name))
        print(CIFilter.localizedReferenceDocumentation(forFilterName: name))
                    
        print("inputStrands")
        if let attribute = CIFilter.droste().attributes["inputStrands"] as? [String: AnyObject]
        {
           let minimum = attribute[kCIAttributeSliderMin] as? Float
           let maximum = attribute[kCIAttributeSliderMax] as? Float
           let defaultValue = attribute[kCIAttributeDefault] as? Float
            
            print(minimum)
            print(maximum)
            print(defaultValue)
            
        }

        print("inputPeriodicity")
        if let attribute = CIFilter.droste().attributes["inputPeriodicity"] as? [String: AnyObject]
        {
           let minimum = attribute[kCIAttributeSliderMin] as? Float
           let maximum = attribute[kCIAttributeSliderMax] as? Float
           let defaultValue = attribute[kCIAttributeDefault] as? Float
            
            print(minimum)
            print(maximum)
            print(defaultValue)
            
        }
        print("inputRotation")
        if let attribute = CIFilter.droste().attributes["inputRotation"] as? [String: AnyObject]
        {
           let minimum = attribute[kCIAttributeSliderMin] as? Float
           let maximum = attribute[kCIAttributeSliderMax] as? Float
           let defaultValue = attribute[kCIAttributeDefault] as? Float
            
            print(minimum)
            print(maximum)
            print(defaultValue)
            
        }
        print("inputZoom")
        if let attribute = CIFilter.droste().attributes["inputZoom"] as? [String: AnyObject]
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
        case insetPointX0
        case insetPointY0
        case insetPointX1
        case insetPointY1
        case strands
        case periodicity
        case rotation
        case zoom
    }

    required init(from decoder: Decoder) throws {
        try super.init(from: decoder)
        let values = try decoder.container(keyedBy: CodingKeys.self)
        desc=description
        
        insetPointX0 = try values.decodeIfPresent(Float.self, forKey: .insetPointX0) ?? 0.0
        insetPointY0 = try values.decodeIfPresent(Float.self, forKey: .insetPointY0) ?? 0.0
        insetPointX1 = try values.decodeIfPresent(Float.self, forKey: .insetPointX1) ?? 0.0
        insetPointY1 = try values.decodeIfPresent(Float.self, forKey: .insetPointY1) ?? 0.0
        strands = try values.decodeIfPresent(Float.self, forKey: .strands) ?? 0.0
        periodicity = try values.decodeIfPresent(Float.self, forKey: .periodicity) ?? 0.0
        rotation = try values.decodeIfPresent(Float.self, forKey: .rotation) ?? 0.0
        zoom = try values.decodeIfPresent(Float.self, forKey: .zoom) ?? 0.0

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
        try container.encode(insetPointX0, forKey: .insetPointX0)
        try container.encode(insetPointY0, forKey: .insetPointY0)
        try container.encode(insetPointX1, forKey: .insetPointX1)
        try container.encode(insetPointY1, forKey: .insetPointY1)
        
        try container.encode(strands, forKey: .strands)
        try container.encode(periodicity, forKey: .periodicity)
        try container.encode(rotation, forKey: .rotation)
        try container.encode(zoom, forKey: .zoom)
    }
    
    override func setupProperties(_ parent: FiltersX?)
    {
        super.setupProperties(parent)
        
        if parent != nil{
            insetPointX0=Float(size.width/3)
            insetPointY0=Float(size.height/3)

            insetPointX1=Float(2*size.width/3)
            insetPointY1=Float(2*size.height/3)
            
        }
        
    }
    
    override func adjustPropertiesToBounds(_ parent: FiltersX?)
    {
        super.adjustPropertiesToBounds(parent)
        
        insetPointX0 = insetPointX0 > Float(size.width) ? Float(size.width) : insetPointX0
        insetPointY0 = insetPointY0 > Float(size.height) ? Float(size.height) : insetPointY0

        insetPointX1 = insetPointX1 > Float(size.width) ? Float(size.width) : insetPointX1
        insetPointY1 = insetPointY1 > Float(size.height) ? Float(size.height) : insetPointY1
    }
        
    override func getCIFilter(_ ciImage: CIImage)->CIFilter
    {
        var currentCIFilter: CIFilter
        if ciFilter != nil {
            print("current Linear Gradient")
            currentCIFilter = ciFilter!
        } else {
            print("new Linear Gradient")
            currentCIFilter = CIFilter(name: type)!
            ciFilter=currentCIFilter
        }
        
        
        currentCIFilter.setValue(ciImage, forKey: kCIInputImageKey)
        let center0=CIVector(x:CGFloat(insetPointX0),y:CGFloat(insetPointY0))
        currentCIFilter.setValue(center0, forKey: "inputInsetPoint0")
        let center1=CIVector(x:CGFloat(insetPointX1),y:CGFloat(insetPointY1))
        currentCIFilter.setValue(center1, forKey: "inputInsetPoint0")
        
        currentCIFilter.setValue(strands, forKey: "inputStrands")
        currentCIFilter.setValue(periodicity, forKey: "inputPeriodicity")
        //revisit rotation vs angle
        currentCIFilter.setValue(rotation, forKey: "inputRotation")
        currentCIFilter.setValue(zoom, forKey: "inputZoom")

        return currentCIFilter
    }

}
