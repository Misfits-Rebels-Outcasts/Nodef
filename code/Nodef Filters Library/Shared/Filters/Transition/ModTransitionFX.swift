//
//  Copyright © 2022 James Boo. All rights reserved.
//

import SwiftUI

class ModTransitionFX: BaseTransitionFX {
       
    @Published var centerX:Float = 150
    @Published var centerY:Float = 150
    
    @Published var angle:Float = 2.00
    @Published var radius:Float = 150.0
    @Published var compression:Float = 300.0
    
    let description = "Transitions from one image to another by revealing the target image through irregularly shaped holes. Make sure the target image looks different to see the transition holes. Compression is the amount of stretching applied to the mod hole pattern. Holes in the center are not distorted as much as those at the edge of the image. Radius is the radius of the undistorted holes in the pattern. Angle is the angle of the mod hole pattern."

    override init()
    {
        let name="CIModTransition"
        super.init(name)
        desc=description
        time = 0.5
        print(CIFilter.localizedName(forFilterName: name))
        print(CIFilter.localizedDescription(forFilterName: name))
        print(CIFilter.localizedReferenceDocumentation(forFilterName: name))
        
        print("inputAngle")
        if let attribute = CIFilter.modTransition().attributes["inputAngle"] as? [String: AnyObject]
        {
           let minimum = attribute[kCIAttributeSliderMin] as? Float
           let maximum = attribute[kCIAttributeSliderMax] as? Float
           let defaultValue = attribute[kCIAttributeDefault] as? Float
            
            print(minimum)
            print(maximum)
            print(defaultValue)
            
        }
        print("inputRadius")
        if let attribute = CIFilter.modTransition().attributes["inputRadius"] as? [String: AnyObject]
        {
           let minimum = attribute[kCIAttributeSliderMin] as? Float
           let maximum = attribute[kCIAttributeSliderMax] as? Float
           let defaultValue = attribute[kCIAttributeDefault] as? Float
            
            print(minimum)
            print(maximum)
            print(defaultValue)
            
        }
        print("inputCompression")
        if let attribute = CIFilter.modTransition().attributes["inputCompression"] as? [String: AnyObject]
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
        case angle
        case radius
        case compression
    }

    required init(from decoder: Decoder) throws {
        try super.init(from: decoder)
        let values = try decoder.container(keyedBy: CodingKeys.self)
        desc=description
        
        centerX = try values.decodeIfPresent(Float.self, forKey: .centerX) ?? 0.0
        centerY = try values.decodeIfPresent(Float.self, forKey: .centerY) ?? 0.0
        
        angle = try values.decodeIfPresent(Float.self, forKey: .angle) ?? 0.0
        radius = try values.decodeIfPresent(Float.self, forKey: .radius) ?? 0.0
        compression = try values.decodeIfPresent(Float.self, forKey: .compression) ?? 0.0
    }
    
    override func encode(to encoder: Encoder) throws {
        try super.encode(to: encoder)
  
        var container = encoder.container(keyedBy: CodingKeys.self)
        
        try container.encode(centerX, forKey: .centerX)
        try container.encode(centerY, forKey: .centerY)
                
        try container.encode(angle, forKey: .angle)
        try container.encode(radius, forKey: .radius)
        try container.encode(compression, forKey: .compression)

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
    
    override func getCIFilter(currentImage: CIImage, beginImage: CIImage) -> CIFilter? {
            
        var currentCIFilter: CIFilter
        if ciFilter != nil {
            currentCIFilter = ciFilter!
        } else {
            currentCIFilter = CIFilter(name: type)!
            ciFilter=currentCIFilter
        }
        
        let inputImage=handleAlias(alias: inputImageAlias,
                                      inputImage: currentImage,
                                      beginImage: beginImage)
        
        let targetImage=handleAlias(alias: targetImageAlias,
                                      inputImage: currentImage,
                                      beginImage: beginImage)
        
        currentCIFilter.setValue(inputImage, forKey: kCIInputImageKey)
        currentCIFilter.setValue(targetImage, forKey: kCIInputTargetImageKey)
        let tcenter=CIVector(x:CGFloat(centerX),y:CGFloat(centerY))
        currentCIFilter.setValue(tcenter, forKey: kCIInputCenterKey)
        
        currentCIFilter.setValue(time, forKey: kCIInputTimeKey)
        currentCIFilter.setValue(angle, forKey: kCIInputAngleKey)
        currentCIFilter.setValue(radius, forKey: kCIInputRadiusKey)
        currentCIFilter.setValue(compression, forKey: "inputCompression")

        return currentCIFilter
        
    }

}
