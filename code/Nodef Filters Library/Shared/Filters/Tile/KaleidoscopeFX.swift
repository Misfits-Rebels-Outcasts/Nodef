//
//  Copyright © 2022 James Boo. All rights reserved.
//

import SwiftUI

class KaleidoscopeFX: BaseTileFX {
       
    @Published var centerX:Float = 150
    @Published var centerY:Float = 150
    @Published var count:Float = 12.0//6.0

    @Published var angle:Float = 0.0
    
    let description = "Produces a kaleidoscopic image from a source image by applying 12-way symmetry. Count is the number of reflections in the pattern. Angle is the angle of reflection."
    
    override init()
    {
        let name="CIKaleidoscope"
        super.init(name)
        desc=description
        
        print(CIFilter.localizedName(forFilterName: name))
        print(CIFilter.localizedDescription(forFilterName: name))
        print(CIFilter.localizedReferenceDocumentation(forFilterName: name))
        print("inputCount")
        if let attribute = CIFilter.kaleidoscope().attributes["inputCount"] as? [String: AnyObject]
        {
           let minimum = attribute[kCIAttributeSliderMin] as? Float
           let maximum = attribute[kCIAttributeSliderMax] as? Float
           let defaultValue = attribute[kCIAttributeDefault] as? Float
            
            print(minimum)
            print(maximum)
            print(defaultValue)
            
        }
        print("inputAngle")
        if let attribute = CIFilter.kaleidoscope().attributes["inputAngle"] as? [String: AnyObject]
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
        case centerX
        case centerY
        case count
        case angle
    }

    required init(from decoder: Decoder) throws {
        try super.init(from: decoder)
        let values = try decoder.container(keyedBy: CodingKeys.self)
        desc=description
        

        centerX = try values.decodeIfPresent(Float.self, forKey: .centerX) ?? 0.0
        centerY = try values.decodeIfPresent(Float.self, forKey: .centerY) ?? 0.0

        count = try values.decodeIfPresent(Float.self, forKey: .count) ?? 0.0
        angle = try values.decodeIfPresent(Float.self, forKey: .angle) ?? 0.0

    }
    
    override func encode(to encoder: Encoder) throws {
        try super.encode(to: encoder)
  
        var container = encoder.container(keyedBy: CodingKeys.self)

        try container.encode(centerX, forKey: .centerX)
        try container.encode(centerY, forKey: .centerY)
        try container.encode(count, forKey: .count)
        try container.encode(angle, forKey: .angle)
  
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
    
    var kaleidoscopeCIFilter:CIFilter?
    override func getCIFilter(currentImage: CIImage, beginImage: CIImage) -> CIFilter? {
        
        var kaleidoscopeFilter: CIFilter

        kaleidoscopeFilter = kaleidoscopeCIFilter != nil ? kaleidoscopeCIFilter! : CIFilter(name: type)!
        
        let inputImage=handleAlias(alias: inputImageAlias,
                                      inputImage: currentImage,
                                      beginImage: beginImage)
        
        kaleidoscopeFilter.setValue(inputImage, forKey: kCIInputImageKey)
        let tcenter=CIVector(x:CGFloat(centerX),y:CGFloat(centerY))
        kaleidoscopeFilter.setValue(tcenter, forKey: kCIInputCenterKey)
        kaleidoscopeFilter.setValue(count, forKey: "inputCount")
        kaleidoscopeFilter.setValue(angle, forKey: kCIInputAngleKey)

        if cropToFormat{
            super.setCIFilterAndCropImage(inputImage: kaleidoscopeFilter.outputImage!)
            return ciFilter!
        }
        else{
            ciFilter=kaleidoscopeFilter
            return ciFilter!
        }
        
        
    }

}
