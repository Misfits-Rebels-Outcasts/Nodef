//
//  Copyright © 2022 James Boo. All rights reserved.
//


import SwiftUI

class SinusoidalGradientFX: BaseGeneratorFX {
       
    @Published var gradient0Color0:CIColor = .blue
    @Published var gradient0Colorx0:Color = .blue
    @Published var gradient0Color1:CIColor = .yellow
    @Published var gradient0Colorx1:Color = .yellow
    @Published var gradient0Angle:Float = 43.0
    @Published var gradient0CenterShift:Float = 1.0
    @Published var gradient0RangeType:Float = 1.0

    @Published var gradient1Color0:CIColor = .red
    @Published var gradient1Colorx0:Color = .red
    @Published var gradient1Color1:CIColor = .green
    @Published var gradient1Colorx1:Color = .green
    @Published var gradient1Angle:Float = 108.0
    @Published var gradient1CenterShift:Float = 1.0
    @Published var gradient1RangeType:Float = 1.0

    @Published var amount:Float = 0.5

    let description = "Generates a gradient with two sinusoidal wave. Each sine wave comes with a start and stop color, angle of the wave, and a parameter to shift the center."

    override init()
    {
        let name="CISinusoidalGradient"
        super.init(name)
        desc=description
        
    }

    enum CodingKeys : String, CodingKey {
        case gradient0Color0
        case gradient0Color1
        case gradient0Angle
        case gradient0CenterShift
        case gradient0RangeType
        
        case gradient1Color0
        case gradient1Color1
        case gradient1Angle
        case gradient1CenterShift
        case gradient1RangeType
        
        case amount
    }

    required init(from decoder: Decoder) throws {
        try super.init(from: decoder)
        let values = try decoder.container(keyedBy: CodingKeys.self)
        desc=description
        
        var colorData = try values.decodeIfPresent(Data.self, forKey: .gradient0Color0) ?? nil
        if colorData != nil
        {
            let uicolor=try NSKeyedUnarchiver.unarchivedObject(ofClass: UIColor.self, from: colorData!)!
            gradient0Color0 = CIColor(color:uicolor)
            gradient0Colorx0 = Color(uicolor)
        }
        colorData = try values.decodeIfPresent(Data.self, forKey: .gradient0Color1) ?? nil
        if colorData != nil
        {
            let uicolor=try NSKeyedUnarchiver.unarchivedObject(ofClass: UIColor.self, from: colorData!)!
            gradient0Color1 = CIColor(color:uicolor)
            gradient0Colorx1 = Color(uicolor)
        }

        gradient0Angle = try values.decodeIfPresent(Float.self, forKey: .gradient0Angle) ?? 0.0
        gradient0CenterShift = try values.decodeIfPresent(Float.self, forKey: .gradient0CenterShift) ?? 0.0
        gradient0RangeType = try values.decodeIfPresent(Float.self, forKey: .gradient0RangeType) ?? 0.0


        colorData = try values.decodeIfPresent(Data.self, forKey: .gradient1Color0) ?? nil
        if colorData != nil
        {
            let uicolor=try NSKeyedUnarchiver.unarchivedObject(ofClass: UIColor.self, from: colorData!)!
            gradient1Color0 = CIColor(color:uicolor)
            gradient1Colorx0 = Color(uicolor)
        }
        colorData = try values.decodeIfPresent(Data.self, forKey: .gradient1Color1) ?? nil
        if colorData != nil
        {
            let uicolor=try NSKeyedUnarchiver.unarchivedObject(ofClass: UIColor.self, from: colorData!)!
            gradient1Color1 = CIColor(color:uicolor)
            gradient1Colorx1 = Color(uicolor)
        }

        gradient1Angle = try values.decodeIfPresent(Float.self, forKey: .gradient1Angle) ?? 0.0
        gradient1CenterShift = try values.decodeIfPresent(Float.self, forKey: .gradient1CenterShift) ?? 0.0
        gradient1RangeType = try values.decodeIfPresent(Float.self, forKey: .gradient1RangeType) ?? 0.0
        
        amount = try values.decodeIfPresent(Float.self, forKey: .amount) ?? 0.0
    }
    
    override func setupProperties(_ parent: FiltersX?)
    {
        super.setupProperties(parent)

    }
    
    override func adjustPropertiesToBounds(_ parent: FiltersX?)
    {
        super.adjustPropertiesToBounds(parent)
    }
    
    
    override func encode(to encoder: Encoder) throws {
        try super.encode(to: encoder)
  
        var container = encoder.container(keyedBy: CodingKeys.self)

        try container.encode(try NSKeyedArchiver.archivedData(withRootObject: UIColor(ciColor: gradient0Color0), requiringSecureCoding: false), forKey: .gradient0Color0)
        try container.encode(try NSKeyedArchiver.archivedData(withRootObject: UIColor(ciColor: gradient0Color1), requiringSecureCoding: false), forKey: .gradient0Color1)
        try container.encode(gradient0Angle, forKey: .gradient0Angle)
        try container.encode(gradient0CenterShift, forKey: .gradient0CenterShift)
        try container.encode(gradient0RangeType, forKey: .gradient0RangeType)

        try container.encode(try NSKeyedArchiver.archivedData(withRootObject: UIColor(ciColor: gradient1Color0), requiringSecureCoding: false), forKey: .gradient1Color0)
        try container.encode(try NSKeyedArchiver.archivedData(withRootObject: UIColor(ciColor: gradient1Color1), requiringSecureCoding: false), forKey: .gradient1Color1)
        try container.encode(gradient1Angle, forKey: .gradient1Angle)
        try container.encode(gradient1CenterShift, forKey: .gradient1CenterShift)
        try container.encode(gradient1RangeType, forKey: .gradient1RangeType)
        
        try container.encode(amount, forKey: .amount)
        
    }

    override func getCIFilter(currentImage: CIImage, beginImage: CIImage) -> CIFilter? {
       
        var currentCIFilter: CIGradientNLFilter
        if ciFilter != nil {
            currentCIFilter = ciFilter as! CIGradientNLFilter
        } else {
            currentCIFilter =  CIGradientNLFilter()
            ciFilter=currentCIFilter
        }
        
        currentCIFilter.inputImage = currentImage
        
        currentCIFilter.center = CIVector(x: CGFloat(gradient0CenterShift), y: 0.0)
        currentCIFilter.angle = CGFloat(gradient0Angle)
        currentCIFilter.rangeType = CGFloat(gradient0RangeType)
                
        currentCIFilter.color1 = CIVector(x: gradient0Color0.red, y: gradient0Color0.green, z:gradient0Color0.blue)
        currentCIFilter.color2 = CIVector(x: gradient0Color1.red, y: gradient0Color1.green, z:gradient0Color1.blue)

        currentCIFilter.center_2 = CIVector(x: CGFloat(gradient1CenterShift), y: 0.0)
        currentCIFilter.angle_2 = CGFloat(gradient1Angle)
        currentCIFilter.rangeType_2 = CGFloat(gradient1RangeType)
        
        currentCIFilter.useSecondGrad = CGFloat(1.0)
        currentCIFilter.blendweight = CGFloat(amount)
        
        currentCIFilter.color1_2 = CIVector(x: gradient1Color0.red, y: gradient1Color0.green, z:gradient1Color0.blue)
        currentCIFilter.color2_2 = CIVector(x: gradient1Color1.red, y: gradient1Color1.green, z:gradient1Color1.blue)
        
        return ciFilter!

/*
        if cropToFormat{
            super.setCIFilterAndCropImage(inputImage: linearGraidentFilter.outputImage!)
            return ciFilter!
        }
        else{
            ciFilter=linearGraidentFilter
            return ciFilter!
        }
*/
    }
    
    override func getDisplayNameFX() -> String
    {

        let fxStr = "input - none"
        return fxStr
   
    }
}
