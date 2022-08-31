//
//  Copyright © 2022 James Boo. All rights reserved.
//

import SwiftUI

class PinchDistortionFX: FilterX {
    //when scale is large it causes gb of memory of be used.
    
    
    @Published var center:CIVector = CIVector(x:150,y:150)
    @Published var centerX:CGFloat = 150
    @Published var centerY:CGFloat = 150
    @Published var radius:Float = 150.0
    @Published var scale:Float = 0.50
    let description = "Creates a rectangular area that pinches source pixels inward, distorting those pixels closest to the rectangle the most. The larger the radius, the wider the extent of the distortion."

    override init()
    {
        let name="CIPinchDistortion"
        super.init(name)
        desc=description
        
        print(CIFilter.localizedName(forFilterName: name))
        print(CIFilter.localizedDescription(forFilterName: name))
        print(CIFilter.localizedReferenceDocumentation(forFilterName: name))
                    
        if let attribute = CIFilter.pinchDistortion().attributes["inputRadius"] as? [String: AnyObject]
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
        case radius
        case scale
    }

    required init(from decoder: Decoder) throws {
        try super.init(from: decoder)
        let values = try decoder.container(keyedBy: CodingKeys.self)
        desc=description
        
        centerX = try values.decodeIfPresent(CGFloat.self, forKey: .centerX) ?? 0.0
        centerY = try values.decodeIfPresent(CGFloat.self, forKey: .centerY) ?? 0.0

        radius = try values.decodeIfPresent(Float.self, forKey: .radius) ?? 0.0
        scale = try values.decodeIfPresent(Float.self, forKey: .scale) ?? 0.0

    }
    
    override func encode(to encoder: Encoder) throws {
        try super.encode(to: encoder)
  
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(centerX, forKey: .centerX)
        try container.encode(centerY, forKey: .centerY)
        try container.encode(radius, forKey: .radius)
        try container.encode(scale, forKey: .scale)
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
        var currentCIFilter: CIFilter
        if ciFilter != nil {
            currentCIFilter = ciFilter!
        } else {
            currentCIFilter = CIFilter(name: type)!
            ciFilter=currentCIFilter
        }
        
        currentCIFilter.setValue(ciImage, forKey: kCIInputImageKey)
        currentCIFilter.setValue(CIVector(x:centerX,y:centerY), forKey: kCIInputCenterKey)
        currentCIFilter.setValue(radius, forKey: kCIInputRadiusKey)
        currentCIFilter.setValue(scale, forKey: kCIInputScaleKey)
        return currentCIFilter
        
        /*
        if let currentCIFilter = ciFilter {
            print("reuse CIFilter Pinch")
            currentCIFilter.setValue(ciImage, forKey: kCIInputImageKey)
            let vcenter=CIVector(x:centerX,y:centerY)
            currentCIFilter.setValue(vcenter, forKey: kCIInputCenterKey)
            currentCIFilter.setValue(radius, forKey: kCIInputRadiusKey)
            currentCIFilter.setValue(scale, forKey: kCIInputScaleKey)
            return currentCIFilter
        } else {
            print("new CIFilter Pinch")
            let newCIFilter = CIFilter(name: type)!
            newCIFilter.setValue(ciImage, forKey: kCIInputImageKey)
            let vcenter=CIVector(x:centerX,y:centerY)
            newCIFilter.setValue(vcenter, forKey: kCIInputCenterKey)
            newCIFilter.setValue(radius, forKey: kCIInputRadiusKey)
            newCIFilter.setValue(scale, forKey: kCIInputScaleKey)
            ciFilter=newCIFilter
            return newCIFilter
        }*/
        
    }

}
