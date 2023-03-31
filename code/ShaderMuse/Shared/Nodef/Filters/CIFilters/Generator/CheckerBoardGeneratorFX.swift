//
//  Copyright © 2022 James Boo. All rights reserved.
//

import SwiftUI

class CheckerboardGeneratorFX: BaseGeneratorFX {
       
    @Published var centerX:CGFloat = 150
    @Published var centerY:CGFloat = 150
    
    @Published var color0:CIColor = .black
    @Published var colorx0:Color = .black
    @Published var colorStr0:String = "black"
    
    @Published var color1:CIColor = .white
    @Published var colorx1:Color = .white
    @Published var colorStr1:String = "white"

    @Published var sharpness:Float = 1
    @Published var width:Float = 80
    let description = "Generates a pattern of squares of alternating colors. You can specify the size, colors, and the sharpness of the pattern. The smaller the sharpness value, the more blurry the pattern."

    override init()
    {
        let name="CICheckerboardGenerator"
        super.init(name)
        desc=description
        
        print(CIFilter.localizedName(forFilterName: name))
        print(CIFilter.localizedDescription(forFilterName: name))
        print(CIFilter.localizedReferenceDocumentation(forFilterName: name))
                    
        print("Sharpness")
        if let attribute = CIFilter.checkerboardGenerator().attributes["inputSharpness"] as? [String: AnyObject]
        {
           let minimum = attribute[kCIAttributeSliderMin] as? Float
           let maximum = attribute[kCIAttributeSliderMax] as? Float
           let defaultValue = attribute[kCIAttributeDefault] as? Float
            
            print(minimum)
            print(maximum)
            print(defaultValue)
            
        }
        
        print("Width")
        if let attribute = CIFilter.checkerboardGenerator().attributes["inputWidth"] as? [String: AnyObject]
        {
           let minimum = attribute[kCIAttributeSliderMin] as? Float
           let maximum = attribute[kCIAttributeSliderMax] as? Float
           let defaultValue = attribute[kCIAttributeDefault] as? Float
            
            print(minimum)
            print(maximum)
            print(defaultValue)
            
        }
        
        print("inputColor0")
        if let attribute = CIFilter.checkerboardGenerator().attributes["inputColor0"] as? [String: AnyObject]
        {

            print(attribute)
            
        }
    }

    enum CodingKeys : String, CodingKey {
        case centerX
        case centerY
        case color0
        case color1
        case sharpness
        case width
    }

    required init(from decoder: Decoder) throws {
        try super.init(from: decoder)
        let values = try decoder.container(keyedBy: CodingKeys.self)
        desc=description
        
        centerX = try values.decodeIfPresent(CGFloat.self, forKey: .centerX) ?? 0.0
        centerY = try values.decodeIfPresent(CGFloat.self, forKey: .centerY) ?? 0.0
        /*
        colorStr0 = try values.decodeIfPresent(String.self, forKey: .color0) ?? "black"
        color0 = getColorFromString(colorStr: colorStr0)
        colorStr1 = try values.decodeIfPresent(String.self, forKey: .color1) ?? "white"
        color1 = getColorFromString(colorStr: colorStr1)
         */
        /*
        let textColorData = try values.decodeIfPresent(Data.self, forKey: .textColor) ?? nil
        if textColorData != nil
        {
            let color = try NSKeyedUnarchiver.unarchivedObject(ofClass: UIColor.self, from: textColorData!)
            textColor = Color(color!)
        }*/
        /*
        var colorData = try values.decodeIfPresent(Data.self, forKey: .color0) ?? nil
        if colorData != nil
        {
            color0 = try NSKeyedUnarchiver.unarchivedObject(ofClass: CIColor.self, from: colorData!)!
            colorx0 = Color(UIColor(ciColor: color0))
        }
        colorData = try values.decodeIfPresent(Data.self, forKey: .color1) ?? nil
        if colorData != nil
        {
            color1 = try NSKeyedUnarchiver.unarchivedObject(ofClass: CIColor.self, from: colorData!)!
            colorx1 = Color(UIColor(ciColor: color1))
        }
         */
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
         
        sharpness = try values.decodeIfPresent(Float.self, forKey: .sharpness) ?? 0.0
        width = try values.decodeIfPresent(Float.self, forKey: .width) ?? 0.0

    }
    
    override func encode(to encoder: Encoder) throws {
        try super.encode(to: encoder)
  
        var container = encoder.container(keyedBy: CodingKeys.self)

        try container.encode(centerX, forKey: .centerX)
        try container.encode(centerY, forKey: .centerY)
  
        try container.encode(try NSKeyedArchiver.archivedData(withRootObject: UIColor(ciColor: color0), requiringSecureCoding: false), forKey: .color0)
        try container.encode(try NSKeyedArchiver.archivedData(withRootObject: UIColor(ciColor: color1), requiringSecureCoding: false), forKey: .color1)

        try container.encode(sharpness, forKey: .sharpness)
        try container.encode(width, forKey: .width)
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
    
    var checkerBoardCIFilter:CIFilter?
    override func getCIFilter(currentImage: CIImage, beginImage: CIImage) -> CIFilter? {
        
        var checkerBoardFilter: CIFilter

        checkerBoardFilter = checkerBoardCIFilter != nil ? checkerBoardCIFilter! : CIFilter(name: type)!
        
        let tcenter=CIVector(x:centerX,y:centerY)
        checkerBoardFilter.setValue(tcenter, forKey: kCIInputCenterKey)
  
        checkerBoardFilter.setValue(color0, forKey: "inputColor0")
        checkerBoardFilter.setValue(color1, forKey: "inputColor1")
        checkerBoardFilter.setValue(sharpness, forKey: kCIInputSharpnessKey)
        checkerBoardFilter.setValue(width, forKey: kCIInputWidthKey)
        
        if cropToFormat{
            super.setCIFilterAndCropImage(inputImage: checkerBoardFilter.outputImage!)
            return ciFilter!
        }
        else{
            ciFilter=checkerBoardFilter
            return ciFilter!

        }
        
    }

}
