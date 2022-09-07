//
//  Copyright © 2022 James Boo. All rights reserved.
//


import SwiftUI

class SpotLightFX: FilterX {
       
    @Published var lightPositionX:Float = 400.0
    @Published var lightPositionY:Float = 600.0
    @Published var lightPositionZ:Float = 150.0

    @Published var lightPointsAtX:Float = 200.0
    @Published var lightPointsAtY:Float = 200.0
    @Published var lightPointsAtZ:Float = 0.0
    
    @Published var brightness:Float = 3.0
    @Published var concentration:Float = 0.10 //1.5 in attributes

    @Published var color:CIColor = .white
    @Published var colorx:Color = .white
    
    let description = "Applies a directional spotlight effect to an image. Color is the color of the spotlight. Concentration is the spotlight size. The smaller the value, the more tightly focused the light beam."

    override init()
    {
        let name="CISpotLight"
        super.init(name)
        desc=description
        
        print(CIFilter.localizedName(forFilterName: name))
        print(CIFilter.localizedDescription(forFilterName: name))
        print(CIFilter.localizedReferenceDocumentation(forFilterName: name))
        
        print("inputBrightness")
        if let attribute = CIFilter.spotLight().attributes["inputBrightness"] as? [String: AnyObject]
        {
           let minimum = attribute[kCIAttributeSliderMin] as? Float
           let maximum = attribute[kCIAttributeSliderMax] as? Float
           let defaultValue = attribute[kCIAttributeDefault] as? Float
            
            print(minimum)
            print(maximum)
            print(defaultValue)
            
        }
        print("inputConcentration")
        if let attribute = CIFilter.spotLight().attributes["inputConcentration"] as? [String: AnyObject]
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
        
        case lightPositionX
        case lightPositionY
        case lightPositionZ
        case lightPointsAtX
        case lightPointsAtY
        case lightPointsAtZ
        case brightness
        case concentration
        case color
        case colorx

    }

    required init(from decoder: Decoder) throws {
        try super.init(from: decoder)
        let values = try decoder.container(keyedBy: CodingKeys.self)
        desc=description
        
        lightPositionX = try values.decodeIfPresent(Float.self, forKey: .lightPositionX) ?? 0
        lightPositionY = try values.decodeIfPresent(Float.self, forKey: .lightPositionY) ?? 0
        lightPositionZ = try values.decodeIfPresent(Float.self, forKey: .lightPositionZ) ?? 0
        
        lightPointsAtX = try values.decodeIfPresent(Float.self, forKey: .lightPointsAtX) ?? 0
        lightPointsAtY = try values.decodeIfPresent(Float.self, forKey: .lightPointsAtY) ?? 0
        lightPointsAtZ = try values.decodeIfPresent(Float.self, forKey: .lightPointsAtZ) ?? 0
        
        brightness = try values.decodeIfPresent(Float.self, forKey: .brightness) ?? 0
        concentration = try values.decodeIfPresent(Float.self, forKey: .concentration) ?? 0
        
        var colorData = try values.decodeIfPresent(Data.self, forKey: .color) ?? nil
        if colorData != nil
        {
            let uicolor=try NSKeyedUnarchiver.unarchivedObject(ofClass: UIColor.self, from: colorData!)!
            color = CIColor(color:uicolor)
            colorx = Color(uicolor)
        }

    }
    
    override func encode(to encoder: Encoder) throws {
        try super.encode(to: encoder)
  
        var container = encoder.container(keyedBy: CodingKeys.self)

        try container.encode(lightPositionX, forKey: .lightPositionX)
        try container.encode(lightPositionY, forKey: .lightPositionY)
        try container.encode(lightPositionZ, forKey: .lightPositionZ)
        
        try container.encode(lightPointsAtX, forKey: .lightPointsAtX)
        try container.encode(lightPointsAtY, forKey: .lightPointsAtY)
        try container.encode(lightPointsAtZ, forKey: .lightPointsAtZ)
        
        try container.encode(brightness, forKey: .brightness)
        try container.encode(concentration, forKey: .concentration)
        
        try container.encode(try NSKeyedArchiver.archivedData(withRootObject: UIColor(ciColor: color), requiringSecureCoding: false), forKey: .color)

    }
    
    override func setupProperties(_ parent: FiltersX?)
    {
        super.setupProperties(parent)
        
        if parent != nil{
            lightPositionX=Float(size.width/2.0)
            lightPositionY=Float(size.height/2.0)
            lightPositionZ=800.0
            
            lightPointsAtX=Float(size.width/2.0)
            lightPointsAtY=Float(size.height/2.0)
            lightPointsAtZ=0.0
        }
        
    }
    
    override func adjustPropertiesToBounds(_ parent: FiltersX?)
    {
        super.adjustPropertiesToBounds(parent)
        
        lightPositionX = lightPositionX > Float(size.width) ? Float(size.width) : lightPositionX
        lightPositionY = lightPositionY > Float(size.height) ? Float(size.height) : lightPositionY

        lightPointsAtX = lightPointsAtX > Float(size.width) ? Float(size.width) : lightPointsAtX
        lightPointsAtY = lightPointsAtY > Float(size.height) ? Float(size.height) : lightPointsAtY
        
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

        var postionArr: [CGFloat] = []
        postionArr.append(CGFloat(lightPositionX))
        postionArr.append(CGFloat(lightPositionY))
        postionArr.append(CGFloat(lightPositionZ))
        var positionVector = CIVector(values: postionArr, count: postionArr.count)
        
        currentCIFilter.setValue(positionVector, forKey: "inputLightPosition")
                
        postionArr = []
        postionArr.append(CGFloat(lightPointsAtX))
        postionArr.append(CGFloat(lightPointsAtY))
        postionArr.append(CGFloat(lightPointsAtZ))
        positionVector = CIVector(values: postionArr, count: postionArr.count)
        currentCIFilter.setValue(positionVector, forKey: "inputLightPointsAt")

        currentCIFilter.setValue(brightness, forKey: "inputBrightness")
        currentCIFilter.setValue(concentration, forKey: "inputConcentration")

        currentCIFilter.setValue(color, forKey: "inputColor")
        
        return currentCIFilter
        
    }

}
