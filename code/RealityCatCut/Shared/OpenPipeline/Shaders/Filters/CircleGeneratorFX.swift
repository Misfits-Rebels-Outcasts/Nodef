//
//  Copyright © 2022 James Boo. All rights reserved.
//

import SwiftUI

class CircleGeneratorFX: BaseGeneratorFX {
           
    @Published var x:Float = 150
    @Published var y:Float = 150
    
    @Published var color:CIColor = .black
    @Published var colorx:Color = .black

    @Published var backgroundColor:CIColor = .white
    @Published var backgroundColorx:Color = .white

    @Published var radius:Float = 125.0
    
    let description = "Generates a circle image with a specified radius, color and background color."

    override init()
    {
        let name = "CICircleGenerator"
        super.init(name)
        desc=description
         
    }

    enum CodingKeys : String, CodingKey {
        case color
        case backgroundColor
        case radius
        case x
        case y
    }

    required init(from decoder: Decoder) throws {
        try super.init(from: decoder)
        let values = try decoder.container(keyedBy: CodingKeys.self)
        desc=description
     
        var colorData = try values.decodeIfPresent(Data.self, forKey: .color) ?? nil
        if colorData != nil
        {
            let uicolor=try NSKeyedUnarchiver.unarchivedObject(ofClass: UIColor.self, from: colorData!)!
            color = CIColor(color:uicolor)
            colorx = Color(uicolor)
        }
        
        colorData = try values.decodeIfPresent(Data.self, forKey: .backgroundColor) ?? nil
        if colorData != nil
        {
            let uicolor=try NSKeyedUnarchiver.unarchivedObject(ofClass: UIColor.self, from: colorData!)!
            backgroundColor = CIColor(color:uicolor)
            backgroundColorx = Color(uicolor)
        }
        
        radius = try values.decodeIfPresent(Float.self, forKey: .radius) ?? 125.0
        x = try values.decodeIfPresent(Float.self, forKey: .x) ?? 0.0
        y = try values.decodeIfPresent(Float.self, forKey: .y) ?? 0.0

    }
    
    override func encode(to encoder: Encoder) throws {
        try super.encode(to: encoder)
        var container = encoder.container(keyedBy: CodingKeys.self)

        try container.encode(try NSKeyedArchiver.archivedData(withRootObject: UIColor(ciColor: color), requiringSecureCoding: false), forKey: .color)
        
        try container.encode(try NSKeyedArchiver.archivedData(withRootObject: UIColor(ciColor: backgroundColor), requiringSecureCoding: false), forKey: .backgroundColor)
        
        try container.encode(radius, forKey: .radius)
        try container.encode(x, forKey: .x)
        try container.encode(y, forKey: .y)

    }
    
    override func setupProperties(_ parent: FiltersX?)
    {
        super.setupProperties(parent)
        
        if parent != nil{
            x=Float(size.width/3.0)
            y=Float(size.height/3.0)

        }
        
    }
    
    override func adjustPropertiesToBounds(_ parent: FiltersX?)
    {
        super.adjustPropertiesToBounds(parent)
        
        x = x > Float(size.width) ? Float(size.width) : x
        y = y > Float(size.height) ? Float(size.height) : y
        
    }
    
    override func getCIFilter(_ ciImage: CIImage)->CIFilter
    {
        var currentCIFilter: CICircleGenerator
        if ciFilter != nil {
            currentCIFilter = ciFilter as! CICircleGenerator
        } else {
            currentCIFilter =  CICircleGenerator()
            ciFilter=currentCIFilter
        }

        currentCIFilter.inputImage = ciImage
        currentCIFilter.inputRadius =  CGFloat(radius)
        currentCIFilter.x =  CGFloat(x)
        currentCIFilter.y =  CGFloat(y)
        currentCIFilter.inputColor = CIVector(x: color.red, y: color.green, z:color.blue, w: color.alpha)
        currentCIFilter.backgroundColor = CIVector(x: backgroundColor.red, y: backgroundColor.green, z:backgroundColor.blue, w:backgroundColor.alpha)

        return currentCIFilter

        
    }

}
