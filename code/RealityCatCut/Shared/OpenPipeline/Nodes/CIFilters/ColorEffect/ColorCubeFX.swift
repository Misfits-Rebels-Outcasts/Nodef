//
//  Copyright © 2022 James Boo. All rights reserved.
//

import SwiftUI

class ColorCubeFX: FilterX {
       
    //https://developer.apple.com/library/archive/documentation/GraphicsImaging/Conceptual/CoreImaging/ci_filer_recipes/ci_filter_recipes.html#//apple_ref/doc/uid/TP30001185-CH4-SW2

    @Published var color:CIColor = .red
    @Published var colorx:Color = .red
    @Published var closeness:Float = 0.08
    
    //@Published var hueRadian:Float = 0.5
    @Published var colorChange:Bool = false

    var cubeRGB = [Float]()
    
    let description = "Uses a three-dimensional color table to remove colors from the source image pixels. Closeness refers to the range of colors from the base color to use."
    
    override init()
    {
        let name = "CIRemoveColorWithColorCube"
        super.init(name)
        desc=description
        /*
        print(CIFilter.localizedName(forFilterName: name))
        print(CIFilter.localizedDescription(forFilterName: name))
        print(CIFilter.localizedReferenceDocumentation(forFilterName: name))
        */
    }

    enum CodingKeys : String, CodingKey {
        case color
        case closeness

    }

    required init(from decoder: Decoder) throws {
        try super.init(from: decoder)
        let values = try decoder.container(keyedBy: CodingKeys.self)
        desc=description
        let colorData = try values.decodeIfPresent(Data.self, forKey: .color) ?? nil
        if colorData != nil
        {
            let uicolor=try NSKeyedUnarchiver.unarchivedObject(ofClass: UIColor.self, from: colorData!)!
            color = CIColor(color:uicolor)
            colorx = Color(uicolor)
        }
        closeness = try values.decodeIfPresent(Float.self, forKey: .closeness) ?? 0.0
    }
    
    override func encode(to encoder: Encoder) throws {
        try super.encode(to: encoder)
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(try NSKeyedArchiver.archivedData(withRootObject: UIColor(ciColor: color), requiringSecureCoding: false), forKey: .color)
        

        try container.encode(closeness, forKey: .closeness)
    }
    
    override func getCIFilter(_ ciImage: CIImage)->CIFilter
    {
        var currentCIFilter: CIFilter
        if ciFilter != nil {
            currentCIFilter = ciFilter!
        } else {
            currentCIFilter = CIFilter(name: "CIColorCube")!
            ciFilter=currentCIFilter
        }
        
        currentCIFilter.setValue(ciImage, forKey: kCIInputImageKey)

        let size = 64

        if cubeRGB.count == 0 || colorChange == true
        {
            cubeRGB = [Float]()
            colorChange=false
            
            var huex: CGFloat = 0
            var saturationx: CGFloat = 0
            var brightnessx: CGFloat = 0
            var alphax: CGFloat = 0
            UIColor(colorx).getHue(&huex, saturation: &saturationx, brightness: &brightnessx, alpha: &alphax)
            
            let startRange: CGFloat = CGFloat(huex)
            let endRange: CGFloat = CGFloat(huex+CGFloat(closeness))
            print("Start Range:",startRange,endRange)
            print("Start Range:",startRange,endRange)
            print("Start Range:",startRange,endRange)
            print("Start Range:",startRange,endRange)
            print("Start Range:",startRange,endRange)
            
            for z in 0 ..< size {
                let blue = CGFloat(z) / CGFloat(size-1)
                for y in 0 ..< size {
                    let green = CGFloat(y) / CGFloat(size-1)
                    for x in 0 ..< size {
                        let red = CGFloat(x) / CGFloat(size-1)
                        let hue = getHue(red: red, green: green, blue: blue)
                        let alpha: CGFloat = (hue >= startRange && hue <= endRange) ? 0: 1
                        cubeRGB.append(Float(red * alpha))
                        cubeRGB.append(Float(green * alpha))
                        cubeRGB.append(Float(blue * alpha))
                        cubeRGB.append(Float(alpha))
                    }
                }
            }
         
        }
         
        
        let data = Data(buffer: UnsafeBufferPointer(start: &cubeRGB, count: cubeRGB.count))

        currentCIFilter.setValue(size, forKey: "inputCubeDimension")
        
        currentCIFilter.setValue(data, forKey: "inputCubeData")
 
        
        return currentCIFilter

    }


    func getHue(red: CGFloat, green: CGFloat, blue: CGFloat) -> CGFloat {
        let color = UIColor(red: red, green: green, blue: blue, alpha: 1)
        var hue: CGFloat = 0
        color.getHue(&hue, saturation: nil, brightness: nil, alpha: nil)
        return hue
    }
     
}
