//
//  Copyright © 2022 James Boo. All rights reserved.
//

import SwiftUI

class PageCurlTransitionFX: BaseTransitionFX {
       
    @Published var inputBacksideImageAlias : String=""
    @Published var inputShadingImageAlias : String=""
    
    @Published var inputBacksideImageAliasId : String=""
    @Published var inputShadingImageAliasId : String=""
    
    @Published var x:Float = 0.0
    @Published var y:Float = 0.0
    @Published var extentWidth:Float = 300.0
    @Published var extentHeight:Float = 300.0
    
    @Published var angle:Float = 0.25//0.00
    @Published var radius:Float = 100.0
    
    let description = "Transitions from one image to another by simulating a curling page, revealing the new image as the page curls. Backside Image is the image that appears on the back of the source image, as the page curls to reveal the target image. Angle is the angle of the curling page. Radius is the radius of the curl. Please refer to the Presets on how to use this filter node."
  
    override init()
    {
        let name="CIPageCurlTransition"
        super.init(name)
        desc=description
        time = 0.2
        print(CIFilter.localizedName(forFilterName: name))
        print(CIFilter.localizedDescription(forFilterName: name))
        print(CIFilter.localizedReferenceDocumentation(forFilterName: name))
        
        print("inputAngle")
        if let attribute = CIFilter.pageCurlTransition().attributes["inputAngle"] as? [String: AnyObject]
        {
           let minimum = attribute[kCIAttributeSliderMin] as? Float
           let maximum = attribute[kCIAttributeSliderMax] as? Float
           let defaultValue = attribute[kCIAttributeDefault] as? Float
            
            print(minimum)
            print(maximum)
            print(defaultValue)
            
        }
        print("inputRadius")
        if let attribute = CIFilter.pageCurlTransition().attributes["inputRadius"] as? [String: AnyObject]
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
        
        case inputBacksideImageAlias
        case inputShadingImageAlias
        
        case x
        case y
        case extentWidth
        case extentHeight
        
        case angle
        case radius
    }

    required init(from decoder: Decoder) throws {
        try super.init(from: decoder)
        let values = try decoder.container(keyedBy: CodingKeys.self)
        desc=description

        
        inputBacksideImageAlias = try values.decodeIfPresent(String.self, forKey: .inputBacksideImageAlias) ?? ""
        inputShadingImageAlias = try values.decodeIfPresent(String.self, forKey: .inputShadingImageAlias) ?? ""
        
        x = try values.decodeIfPresent(Float.self, forKey: .x) ?? 0
        y = try values.decodeIfPresent(Float.self, forKey: .y) ?? 0
        extentWidth = try values.decodeIfPresent(Float.self, forKey: .extentWidth) ?? 0
        extentHeight = try values.decodeIfPresent(Float.self, forKey: .extentHeight) ?? 0
        
        angle = try values.decodeIfPresent(Float.self, forKey: .angle) ?? 0.0
        radius = try values.decodeIfPresent(Float.self, forKey: .radius) ?? 0.0

    }
    
    override func encode(to encoder: Encoder) throws {
        try super.encode(to: encoder)
  
        var container = encoder.container(keyedBy: CodingKeys.self)

        try container.encode(inputBacksideImageAlias, forKey: .inputBacksideImageAlias)
        try container.encode(inputShadingImageAlias, forKey: .inputShadingImageAlias)
        
        try container.encode(x, forKey: .x)
        try container.encode(y, forKey: .y)
        try container.encode(extentWidth, forKey: .extentWidth)
        try container.encode(extentHeight, forKey: .extentHeight)
        
        try container.encode(angle, forKey: .angle)
        try container.encode(radius, forKey: .radius)

    }
    
    
    override func setupProperties(_ parent: FiltersX?)
    {
        super.setupProperties(parent)
        
        if parent != nil{
            x=0
            y=0
            
            extentWidth=Float(size.width)
            extentHeight=Float(size.height)

        }
        
    }
    
    override func adjustPropertiesToBounds(_ parent: FiltersX?)
    {
        super.adjustPropertiesToBounds(parent)
        
        x = x > Float(size.width) ? Float(size.width) : x
        y = y > Float(size.height) ? Float(size.height) : y
        
        extentWidth = extentWidth > Float(size.width) ? Float(size.width) : extentWidth
        extentHeight = extentHeight > Float(size.height) ? Float(size.height) : extentHeight
        
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
        
        let backSideImage=handleAlias(alias: inputBacksideImageAlias,
                                      inputImage: currentImage,
                                      beginImage: beginImage)
        
        let shadingImage=handleAlias(alias: inputShadingImageAlias,
                                      inputImage: currentImage,
                                      beginImage: beginImage)
        
        currentCIFilter.setValue(inputImage, forKey: kCIInputImageKey)
        currentCIFilter.setValue(targetImage, forKey: kCIInputTargetImageKey)
        currentCIFilter.setValue(backSideImage, forKey: "inputBacksideImage")
        currentCIFilter.setValue(shadingImage, forKey: "inputShadingImage")
        
        let extent = CIVector(cgRect: CGRect(x: CGFloat(x), y: CGFloat(y), width: CGFloat(extentWidth), height: CGFloat(extentHeight)))
        currentCIFilter.setValue(extent, forKey: "inputExtent")
        
        currentCIFilter.setValue(time, forKey: kCIInputTimeKey)
        currentCIFilter.setValue(angle, forKey: kCIInputAngleKey)
        currentCIFilter.setValue(radius, forKey: kCIInputRadiusKey)

        return currentCIFilter
        
    }

}
