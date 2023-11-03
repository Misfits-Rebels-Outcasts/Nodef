//
//  Copyright © 2022 James Boo. All rights reserved.
//

import SwiftUI

class VignetteEffectFX: FilterX {
       
    @Published var centerX:CGFloat = 150
    @Published var centerY:CGFloat = 150
    @Published var intensity:Float = 0.0
    @Published var radius:Float = 150.0

    let description = "Modifies the brightness of an image around the periphery of a specified region. This reduces the brightness of an image at the periphery of the region."

    override init()
    {
        let name = "CIVignetteEffect"
        super.init(name)
        desc=description
        /*
        print(CIFilter.localizedName(forFilterName: name))
        print(CIFilter.localizedDescription(forFilterName: name))
        print(CIFilter.localizedReferenceDocumentation(forFilterName: name))
        
        if let attribute = CIFilter.vignetteEffect().attributes["inputIntensity"] as? [String: AnyObject]
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
        if let attribute = CIFilter.vignetteEffect().attributes["inputRadius"] as? [String: AnyObject]
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
        case centerX
        case centerY
        case intensity
        case radius

    }

    required init(from decoder: Decoder) throws {
        try super.init(from: decoder)
        let values = try decoder.container(keyedBy: CodingKeys.self)
        desc=description
        centerX = try values.decodeIfPresent(CGFloat.self, forKey: .centerX) ?? 0.0
        centerY = try values.decodeIfPresent(CGFloat.self, forKey: .centerY) ?? 0.0
        intensity = try values.decodeIfPresent(Float.self, forKey: .intensity) ?? 0.0
        radius = try values.decodeIfPresent(Float.self, forKey: .radius) ?? 0.0


    }
    
    override func encode(to encoder: Encoder) throws {
        try super.encode(to: encoder)
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(centerX, forKey: .centerX)
        try container.encode(centerY, forKey: .centerY)
     
        try container.encode(intensity, forKey: .intensity)
        try container.encode(radius, forKey: .radius)


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
    
    override func getCIFilter(_ ciImage: CIImage)->CIFilter
    {
        let currentCIFilter = CIFilter(name: type)!
        currentCIFilter.setValue(ciImage, forKey: kCIInputImageKey)
        let tcenter=CIVector(x:centerX,y:centerY)
        currentCIFilter.setValue(tcenter, forKey: kCIInputCenterKey)
        currentCIFilter.setValue(intensity, forKey: kCIInputIntensityKey)
        currentCIFilter.setValue(radius, forKey: kCIInputRadiusKey)
        ciFilter=currentCIFilter
        return currentCIFilter

    }

}
