//
//  Copyright © 2022 James Boo. All rights reserved.
//

import SwiftUI

class SmoothLinearGradientFX: BaseGeneratorFX {
       
    @Published var pointX0:Float = 0
    @Published var pointY0:Float = 0
    
    @Published var pointX1:Float = 200
    @Published var pointY1:Float = 200

    @Published var color0:CIColor = .black
    @Published var colorx0:Color = .black
    
    @Published var color1:CIColor = .white
    @Published var colorx1:Color = .white
    
    let description = "Generates a gradient that uses an S-curve function to blend colors along a linear axis between two defined endpoints. Point 1 is the starting position of the gradient -- where the first color begins. Point 2 is the ending position of the gradient -- where the second color begins."

    override init()
    {
        let name="CISmoothLinearGradient"
        super.init(name)
        desc=description
        
        print(CIFilter.localizedName(forFilterName: name))
        print(CIFilter.localizedDescription(forFilterName: name))
        
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
    
    override func encode(to encoder: Encoder) throws {
        try super.encode(to: encoder)
  
        var container = encoder.container(keyedBy: CodingKeys.self)

        try container.encode(pointX0, forKey: .pointX0)
        try container.encode(pointY0, forKey: .pointY0)
        try container.encode(pointX1, forKey: .pointX1)
        try container.encode(pointY1, forKey: .pointY1)

        try container.encode(try NSKeyedArchiver.archivedData(withRootObject: UIColor(ciColor: color0), requiringSecureCoding: false), forKey: .color0)
        try container.encode(try NSKeyedArchiver.archivedData(withRootObject: UIColor(ciColor: color1), requiringSecureCoding: false), forKey: .color1)
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
    
    var smoothLinearGraidentCIFilter:CIFilter?
    override func getCIFilter(currentImage: CIImage, beginImage: CIImage) -> CIFilter? {
       
        var smoothLinearGraidentFilter: CIFilter
        smoothLinearGraidentFilter = smoothLinearGraidentCIFilter != nil ? smoothLinearGraidentCIFilter! : CIFilter(name: type)!
        
        let center0=CIVector(x:CGFloat(pointX0),y:CGFloat(pointY0))
        smoothLinearGraidentFilter.setValue(center0, forKey: "inputPoint0")
        let center1=CIVector(x:CGFloat(pointX1),y:CGFloat(pointY1))
        smoothLinearGraidentFilter.setValue(center1, forKey: "inputPoint1")
        smoothLinearGraidentFilter.setValue(color0, forKey: "inputColor0")
        smoothLinearGraidentFilter.setValue(color1, forKey: "inputColor1")

        if cropToFormat{
            super.setCIFilterAndCropImage(inputImage: smoothLinearGraidentFilter.outputImage!)
            return ciFilter!
        }
        else{
            ciFilter=smoothLinearGraidentFilter
            return ciFilter!

        }
    }
    override func getDisplayNameFX() -> String
    {

        let fxStr = "input - none"
        return fxStr
   
    }
}
