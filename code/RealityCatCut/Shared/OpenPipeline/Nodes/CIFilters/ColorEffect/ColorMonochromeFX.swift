//
//  Copyright © 2022 James Boo. All rights reserved.
//

import SwiftUI

class ColorMonochromeFX: FilterX {
       
    @Published var color:CIColor = .blue
    @Published var colorx:Color = .blue
    @Published var colorStr:String = "blue"
    @Published var intensity:Float = 0.75//1.0

    let description = "Remaps colors so they fall within shades of a single color."
    override init()
    {
        let name = "CIColorMonochrome"
        super.init(name)
        desc=description
        /*
        print(CIFilter.localizedName(forFilterName: name))
        print(CIFilter.localizedDescription(forFilterName: name))
        print(CIFilter.localizedReferenceDocumentation(forFilterName: name))
        
        
        print(CIFilter.localizedName(forFilterName: name))
        if let attribute = CIFilter.colorMonochrome().attributes["inputIntensity"] as? [String: AnyObject]
        {
           let minimum = attribute[kCIAttributeSliderMin] as? Float
           let maximum = attribute[kCIAttributeSliderMax] as? Float
           let defaultValue = attribute[kCIAttributeDefault] as? Float
            
            print(minimum)
            print(maximum)
            print(defaultValue)
            
            //Optional(-1.0)
            //Optional(1.0)
            //Optional(0.0)
            
        }
         */
         
    }

    enum CodingKeys : String, CodingKey {
        case color
        case intensity
    }

    required init(from decoder: Decoder) throws {
        try super.init(from: decoder)
        let values = try decoder.container(keyedBy: CodingKeys.self)
        desc=description
        intensity = try values.decodeIfPresent(Float.self, forKey: .intensity) ?? 0.0
        //colorStr = try values.decodeIfPresent(String.self, forKey: .color) ?? "blue"
        //color = getColorFromString(colorStr: colorStr)

        let colorData = try values.decodeIfPresent(Data.self, forKey: .color) ?? nil
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
        try container.encode(intensity, forKey: .intensity)
        //try container.encode(colorStr, forKey: .color)

        try container.encode(try NSKeyedArchiver.archivedData(withRootObject: UIColor(ciColor: color), requiringSecureCoding: false), forKey: .color)
    }
    
    func getColorFromString(colorStr: String)->CIColor
    {
        var fxcolor: CIColor = .blue
        if colorStr == "black"
        {
            fxcolor=CIColor.black
        }
        else if colorStr == "blue"
        {
            fxcolor=CIColor.blue
        }
        else if colorStr == "clear"
        {
            fxcolor=CIColor.clear
        }
        else if colorStr == "cyan"
        {
            fxcolor=CIColor.cyan
        }
        else if colorStr == "gray"
        {
            fxcolor=CIColor.gray
        }
        else if colorStr == "green"
        {
            fxcolor=CIColor.green
        }
        else if colorStr == "magenta"
        {
            fxcolor=CIColor.magenta
        }
        else if colorStr == "red"
        {
            fxcolor=CIColor.red
        }
        else if colorStr == "yellow"
        {
            fxcolor=CIColor.yellow
        }
        return fxcolor
    }
    
    override func getCIFilter(_ ciImage: CIImage)->CIFilter
    {
        let currentCIFilter = CIFilter(name: type)!
        currentCIFilter.setValue(ciImage, forKey: kCIInputImageKey)
        currentCIFilter.setValue(color, forKey: kCIInputColorKey)
        currentCIFilter.setValue(intensity, forKey: kCIInputIntensityKey)
        ciFilter=currentCIFilter
        return currentCIFilter

    }

}
