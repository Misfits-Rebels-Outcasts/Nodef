//
//  Copyright © 2022 James Boo. All rights reserved.
//


import SwiftUI

class LinearGradientFX: BaseGeneratorFX {
       
    @Published var pointX0:Float = 0
    @Published var pointY0:Float = 0
    
    @Published var pointX1:Float = 200
    @Published var pointY1:Float = 200

    @Published var color0:CIColor = .black
    @Published var colorStr0:String = "black"
    @Published var colorx0:Color = .black
    
    @Published var color1:CIColor = .white
    @Published var colorStr1:String = "white"
    @Published var colorx1:Color = .white
    
    let description = "Generates a gradient that varies along a linear axis between two defined endpoints. Point 1 is the starting position of the gradient -- where the first color begins. Point 2 is the ending position of the gradient -- where the second color begins."

    override init()
    {
        let name="CILinearGradient"
        super.init(name)
        desc=description
        
        print(CIFilter.localizedName(forFilterName: name))
        print(CIFilter.localizedDescription(forFilterName: name))
        print(CIFilter.localizedReferenceDocumentation(forFilterName: name))
              /*
        print("inputRadius")
        if let attribute = CIFilter.gaussianGradient().attributes["inputRadius"] as? [String: AnyObject]
        {
           let minimum = attribute[kCIAttributeSliderMin] as? Float
           let maximum = attribute[kCIAttributeSliderMax] as? Float
           let defaultValue = attribute[kCIAttributeDefault] as? Float
            
            print(minimum)
            print(maximum)
            print(defaultValue)
            
        }*/
        
    }

    enum CodingKeys : String, CodingKey {
        case pointX0
        case pointY0
        case pointX1
        case pointY1
        case color0
        case color1
    }

    required init(from decoder: Decoder) throws {
        try super.init(from: decoder)
        let values = try decoder.container(keyedBy: CodingKeys.self)
        desc=description
        
        pointX0 = try values.decodeIfPresent(Float.self, forKey: .pointX0) ?? 0.0
        pointY0 = try values.decodeIfPresent(Float.self, forKey: .pointY0) ?? 0.0

        pointX1 = try values.decodeIfPresent(Float.self, forKey: .pointX1) ?? 0.0
        pointY1 = try values.decodeIfPresent(Float.self, forKey: .pointY1) ?? 0.0

        //colorStr0 = try values.decodeIfPresent(String.self, forKey: .color0) ?? "black"
        //color0 = getColorFromString(colorStr: colorStr0)
        //colorStr1 = try values.decodeIfPresent(String.self, forKey: .color1) ?? "white"
        //color1 = getColorFromString(colorStr: colorStr1)

        var colorData = try values.decodeIfPresent(Data.self, forKey: .color0) ?? nil
        if colorData != nil
        {
            let uicolor=try NSKeyedUnarchiver.unarchivedObject(ofClass: UIColor.self, from: colorData!)!
            color0 = CIColor(color:uicolor)
            colorx0 = Color(uicolor)
        }
        colorData = try values.decodeIfPresent(Data.self, forKey: .color1) ?? nil
        if colorData != nil
        {
            let uicolor=try NSKeyedUnarchiver.unarchivedObject(ofClass: UIColor.self, from: colorData!)!
            color1 = CIColor(color:uicolor)
            colorx1 = Color(uicolor)
        }
        
    }
    
    override func setupProperties(_ parent: FiltersX?)
    {
        super.setupProperties(parent)
        
        if parent != nil{
            pointX0=0
            pointY0=0

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
    
    
    override func encode(to encoder: Encoder) throws {
        try super.encode(to: encoder)
  
        var container = encoder.container(keyedBy: CodingKeys.self)

        try container.encode(pointX0, forKey: .pointX0)
        try container.encode(pointY0, forKey: .pointY0)
        try container.encode(pointX1, forKey: .pointX1)
        try container.encode(pointY1, forKey: .pointY1)
        //try container.encode(colorStr0, forKey: .color0)
        //try container.encode(colorStr1, forKey: .color1)
        
        try container.encode(try NSKeyedArchiver.archivedData(withRootObject: UIColor(ciColor: color0), requiringSecureCoding: false), forKey: .color0)
        try container.encode(try NSKeyedArchiver.archivedData(withRootObject: UIColor(ciColor: color1), requiringSecureCoding: false), forKey: .color1)
        //try container.encode(sharpness, forKey: .sharpness)
        //try container.encode(width, forKey: .width)
    }

    var linearGraidentCIFilter:CIFilter?
    override func getCIFilter(currentImage: CIImage, beginImage: CIImage) -> CIFilter? {
       
        var linearGraidentFilter: CIFilter
        linearGraidentFilter = linearGraidentCIFilter != nil ? linearGraidentCIFilter! : CIFilter(name: type)!
        
        let center0=CIVector(x:CGFloat(pointX0),y:CGFloat(pointY0))
        linearGraidentFilter.setValue(center0, forKey: "inputPoint0")
        let center1=CIVector(x:CGFloat(pointX1),y:CGFloat(pointY1))
        linearGraidentFilter.setValue(center1, forKey: "inputPoint1")
        linearGraidentFilter.setValue(color0, forKey: "inputColor0")
        linearGraidentFilter.setValue(color1, forKey: "inputColor1")

        if cropToFormat{
            super.setCIFilterAndCropImage(inputImage: linearGraidentFilter.outputImage!)
            return ciFilter!
        }
        else{
            ciFilter=linearGraidentFilter
            return ciFilter!

        }
    }
    override func getDisplayNameFX() -> String
    {

        var fxStr = "input - none"
        return fxStr
   
    }
}
