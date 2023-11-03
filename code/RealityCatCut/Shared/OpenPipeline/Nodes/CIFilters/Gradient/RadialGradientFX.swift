//
//  Copyright © 2022 James Boo. All rights reserved.
//


import SwiftUI

class RadialGradientFX: BaseGeneratorFX {
       
    @Published var centerX:Float = 150
    @Published var centerY:Float = 150
    @Published var color0:CIColor = .black
    @Published var colorx0:Color = .black
    @Published var colorStr0:String = "black"
    
    @Published var color1:CIColor = .white
    @Published var colorx1:Color = .white
    @Published var colorStr1:String = "white"

    @Published var radius0:Float = 5.0
    @Published var radius1:Float = 100.0
    let description = "Generates a gradient that varies radially between two circles having the same center. Radisu 1 is the radius of the starting circle to use in the gradient. Radius 2 is the radius of the ending circle to use in the gradient."

    override init()
    {
        let name="CIRadialGradient"
        super.init(name)
        desc=description
        /*
        print(CIFilter.localizedName(forFilterName: name))
        print(CIFilter.localizedDescription(forFilterName: name))
        print(CIFilter.localizedReferenceDocumentation(forFilterName: name))
                    
        print("inputRadius0")
        if let attribute = CIFilter.radialGradient().attributes["inputRadius0"] as? [String: AnyObject]
        {
           let minimum = attribute[kCIAttributeSliderMin] as? Float
           let maximum = attribute[kCIAttributeSliderMax] as? Float
           let defaultValue = attribute[kCIAttributeDefault] as? Float
            
            print(minimum)
            print(maximum)
            print(defaultValue)
            
        }
        print("inputRadius1")
        if let attribute = CIFilter.radialGradient().attributes["inputRadius1"] as? [String: AnyObject]
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
        case color0
        case color1
        case radius0
        case radius1
    }

    required init(from decoder: Decoder) throws {
        try super.init(from: decoder)
        let values = try decoder.container(keyedBy: CodingKeys.self)
        desc=description
        
        centerX = try values.decodeIfPresent(Float.self, forKey: .centerX) ?? 0.0
        centerY = try values.decodeIfPresent(Float.self, forKey: .centerY) ?? 0.0
        
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
         
        
        radius0 = try values.decodeIfPresent(Float.self, forKey: .radius0) ?? 0.0
        radius1 = try values.decodeIfPresent(Float.self, forKey: .radius1) ?? 0.0

    }
    
    override func encode(to encoder: Encoder) throws {
        try super.encode(to: encoder)
  
        var container = encoder.container(keyedBy: CodingKeys.self)

        try container.encode(centerX, forKey: .centerX)
        try container.encode(centerY, forKey: .centerY)
        //try container.encode(colorStr0, forKey: .color0)
        //try container.encode(colorStr1, forKey: .color1)
        
        try container.encode(try NSKeyedArchiver.archivedData(withRootObject: UIColor(ciColor: color0), requiringSecureCoding: false), forKey: .color0)
        try container.encode(try NSKeyedArchiver.archivedData(withRootObject: UIColor(ciColor: color1), requiringSecureCoding: false), forKey: .color1)
        
        try container.encode(radius0, forKey: .radius0)
        try container.encode(radius1, forKey: .radius1)
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
    
    var radialGraidentCIFilter:CIFilter?
    //deprecate
    override func getCIFilter(currentImage: CIImage, beginImage: CIImage) -> CIFilter? {
       
        var radialGraidentFilter: CIFilter
        radialGraidentFilter = radialGraidentCIFilter != nil ? radialGraidentCIFilter! : CIFilter(name: type)!
        
        let tcenter=CIVector(x:CGFloat(centerX),y:CGFloat(centerY))
        radialGraidentFilter.setValue(tcenter, forKey: kCIInputCenterKey)
        radialGraidentFilter.setValue(color0, forKey: "inputColor0")
        radialGraidentFilter.setValue(color1, forKey: "inputColor1")
        radialGraidentFilter.setValue(radius0, forKey: "inputRadius0")
        radialGraidentFilter.setValue(radius1, forKey: "inputRadius1")

        if cropToFormat{
            super.setCIFilterAndCropImage(inputImage: radialGraidentFilter.outputImage!)
            return ciFilter!
        }
        else{
            ciFilter=radialGraidentFilter
            return ciFilter!

        }
    }

    //ANCHISES
    override func getCIFilter(_ ciImage: CIImage) -> CIFilter {
        
        var radialGraidentFilter: CIFilter
        
        if radialGraidentCIFilter != nil {
            radialGraidentFilter = radialGraidentCIFilter!
        } else {
            radialGraidentFilter = CIFilter(name: type)!
            radialGraidentCIFilter=radialGraidentFilter
     
        }
        let tcenter=CIVector(x:CGFloat(centerX),y:CGFloat(centerY))
        radialGraidentFilter.setValue(tcenter, forKey: kCIInputCenterKey)
        radialGraidentFilter.setValue(color0, forKey: "inputColor0")
        radialGraidentFilter.setValue(color1, forKey: "inputColor1")
        radialGraidentFilter.setValue(radius0, forKey: "inputRadius0")
        radialGraidentFilter.setValue(radius1, forKey: "inputRadius1")

        if cropToFormat{
            super.setCIFilterAndCropImage(inputImage: radialGraidentFilter.outputImage!)
            return ciFilter!
        }
        else{
            ciFilter=radialGraidentFilter
            return ciFilter!

        }
    }
    override func getDisplayNameFX() -> String
    {

        let fxStr = "input - none"
        return fxStr
   
    }
}
