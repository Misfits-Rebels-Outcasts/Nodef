//
//  Copyright © 2022 James Boo. All rights reserved.
//


import SwiftUI

//ANCHISES-BaseTransitionFX
class PageCurlWithShadowTransitionFX: BaseTransitionMaskFX {
       
    @Published var inputBacksideImageAlias : String=""
    @Published var inputBacksideImageAliasId : String=""

    @Published var x:Float = 0.0
    @Published var y:Float = 0.0
    @Published var extentWidth:Float = 300.0
    @Published var extentHeight:Float = 300.0
    
    @Published var angle:Float = 0.25//0.00
    @Published var radius:Float = 100.0
    
    @Published var shadowSize:Float = 0.50
    @Published var shadowAmount:Float = 0.7
    
    @Published var shadowx:Float = 0.0
    @Published var shadowy:Float = 0.0
    @Published var shadowExtentWidth:Float = 0.0
    @Published var shadowExtentHeight:Float = 0.0
    
    
    let description = "Transitions from one image (A) to another (B) by simulating a curling page, revealing the new image as the page curls. Backside Image (C) is the image that appears on the back of the source image, as the page curls to reveal the target image. Angle is the angle of the curling page. Radius is the radius of the curl. Please refer to the Presets on how to use this filter node. Shadow Amount is the strength of the shadow. Shadow Size is the maximum size in pixels of the shadow. Shadow Extent is the rectagular portion of input image that will cast a shadow."

    override init()
    {
        let name="CIPageCurlWithShadowTransition"
        super.init(name)
        desc=description
        time=0.2
        /*
        print(CIFilter.localizedName(forFilterName: name))
        print(CIFilter.localizedDescription(forFilterName: name))
        print(CIFilter.localizedReferenceDocumentation(forFilterName: name))
 
        print("inputAngle")
        if let attribute = CIFilter.pageCurlWithShadowTransition().attributes["inputAngle"] as? [String: AnyObject]
        {
           let minimum = attribute[kCIAttributeSliderMin] as? Float
           let maximum = attribute[kCIAttributeSliderMax] as? Float
           let defaultValue = attribute[kCIAttributeDefault] as? Float
            
            print(minimum)
            print(maximum)
            print(defaultValue)
            
        }
        print("inputRadius")
        if let attribute = CIFilter.pageCurlWithShadowTransition().attributes["inputRadius"] as? [String: AnyObject]
        {
           let minimum = attribute[kCIAttributeSliderMin] as? Float
           let maximum = attribute[kCIAttributeSliderMax] as? Float
           let defaultValue = attribute[kCIAttributeDefault] as? Float
            
            print(minimum)
            print(maximum)
            print(defaultValue)
            
        }
        print("inputShadowSize")
        if let attribute = CIFilter.pageCurlWithShadowTransition().attributes["inputShadowSize"] as? [String: AnyObject]
        {
           let minimum = attribute[kCIAttributeSliderMin] as? Float
           let maximum = attribute[kCIAttributeSliderMax] as? Float
           let defaultValue = attribute[kCIAttributeDefault] as? Float
            
            print(minimum)
            print(maximum)
            print(defaultValue)
            
        }
        print("inputShadowAmount")
        if let attribute = CIFilter.pageCurlWithShadowTransition().attributes["inputShadowAmount"] as? [String: AnyObject]
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
        case inputBacksideImageAlias
        case x
        case y
        case extentWidth
        case extentHeight
        
        case angle
        case radius
        case shadowSize
        case shadowAmount
        case shadowx
        case shadowy
        case shadowExtentWidth
        case shadowExtentHeight
        
    }

    required init(from decoder: Decoder) throws {
        try super.init(from: decoder)
        let values = try decoder.container(keyedBy: CodingKeys.self)
        desc=description
        
        inputBacksideImageAlias = try values.decodeIfPresent(String.self, forKey: .inputBacksideImageAlias) ?? ""
        
        x = try values.decodeIfPresent(Float.self, forKey: .x) ?? 0
        y = try values.decodeIfPresent(Float.self, forKey: .y) ?? 0
        extentWidth = try values.decodeIfPresent(Float.self, forKey: .extentWidth) ?? 0
        extentHeight = try values.decodeIfPresent(Float.self, forKey: .extentHeight) ?? 0
        
        angle = try values.decodeIfPresent(Float.self, forKey: .angle) ?? 0.0
        radius = try values.decodeIfPresent(Float.self, forKey: .radius) ?? 0.0

        shadowSize = try values.decodeIfPresent(Float.self, forKey: .shadowSize) ?? 0.0
        shadowAmount = try values.decodeIfPresent(Float.self, forKey: .shadowAmount) ?? 0.0

        shadowx = try values.decodeIfPresent(Float.self, forKey: .shadowx) ?? 0
        shadowy = try values.decodeIfPresent(Float.self, forKey: .shadowy) ?? 0
        shadowExtentWidth = try values.decodeIfPresent(Float.self, forKey: .shadowExtentWidth) ?? 0
        shadowExtentHeight = try values.decodeIfPresent(Float.self, forKey: .shadowExtentHeight) ?? 0

    }
    
    override func encode(to encoder: Encoder) throws {
        try super.encode(to: encoder)
  
        var container = encoder.container(keyedBy: CodingKeys.self)
        
        try container.encode(inputBacksideImageAlias, forKey: .inputBacksideImageAlias)
        
        try container.encode(x, forKey: .x)
        try container.encode(y, forKey: .y)
        try container.encode(extentWidth, forKey: .extentWidth)
        try container.encode(extentHeight, forKey: .extentHeight)
        
        try container.encode(angle, forKey: .angle)
        try container.encode(radius, forKey: .radius)
        
        try container.encode(shadowSize, forKey: .shadowSize)
        try container.encode(shadowAmount, forKey: .shadowAmount)
        
        try container.encode(shadowx, forKey: .shadowx)
        try container.encode(shadowy, forKey: .shadowy)
        try container.encode(shadowExtentWidth, forKey: .shadowExtentWidth)
        try container.encode(shadowExtentHeight, forKey: .shadowExtentHeight)

    }
    
    override func setupProperties(_ parent: FiltersX?)
    {
        super.setupProperties(parent)
        
        if parent != nil{
            x=0
            y=0
            
            extentWidth=Float(size.width)
            extentHeight=Float(size.height)
            
            shadowx=0
            shadowy=0
            
            shadowExtentWidth=Float(size.width)
            shadowExtentHeight=Float(size.height)

        }
        
    }
    
    override func adjustPropertiesToBounds(_ parent: FiltersX?)
    {
        super.adjustPropertiesToBounds(parent)
        
        x = x > Float(size.width) ? Float(size.width) : x
        y = y > Float(size.height) ? Float(size.height) : y
        
        extentWidth = extentWidth > Float(size.width) ? Float(size.width) : extentWidth
        extentHeight = extentHeight > Float(size.height) ? Float(size.height) : extentHeight
        
        shadowx = shadowx > Float(size.width) ? Float(size.width) : shadowx
        shadowy = shadowy > Float(size.height) ? Float(size.height) : shadowy
        
        shadowExtentWidth = shadowExtentWidth > Float(size.width) ? Float(size.width) : shadowExtentWidth
        shadowExtentHeight = shadowExtentHeight > Float(size.height) ? Float(size.height) : shadowExtentHeight
        
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
        
        currentCIFilter.setValue(inputImage, forKey: kCIInputImageKey)
        currentCIFilter.setValue(targetImage, forKey: kCIInputTargetImageKey)
        currentCIFilter.setValue(backSideImage, forKey: "inputBacksideImage")

        let extent = CIVector(cgRect: CGRect(x: CGFloat(x), y: CGFloat(y), width: CGFloat(extentWidth), height: CGFloat(extentHeight)))
        currentCIFilter.setValue(extent, forKey: "inputExtent")
        
        currentCIFilter.setValue(time, forKey: kCIInputTimeKey)
        currentCIFilter.setValue(angle, forKey: kCIInputAngleKey)
        currentCIFilter.setValue(radius, forKey: kCIInputRadiusKey)
        
        currentCIFilter.setValue(shadowSize, forKey: "inputShadowSize")
        currentCIFilter.setValue(shadowAmount, forKey: "inputShadowAmount")
        currentCIFilter.setValue(radius, forKey: kCIInputRadiusKey)
        
        
        let shadowExtent = CIVector(cgRect: CGRect(x: CGFloat(shadowx), y: CGFloat(shadowy), width: CGFloat(shadowExtentWidth), height: CGFloat(shadowExtentHeight)))
        currentCIFilter.setValue(shadowExtent, forKey: "inputShadowExtent")
                
        return currentCIFilter
        
    }
    
    //ANCHISES
    override func getCIFilter(firstImage: CIImage, secondImage: CIImage, thirdImage: CIImage) -> CIFilter?
    {
        
        var currentCIFilter: CIFilter
        if ciFilter != nil {
            currentCIFilter = ciFilter!
        } else {
            currentCIFilter = CIFilter(name: type)!
            ciFilter=currentCIFilter
        }
        
        currentCIFilter.setValue(firstImage, forKey: kCIInputImageKey)
        currentCIFilter.setValue(secondImage, forKey: kCIInputTargetImageKey)
        currentCIFilter.setValue(thirdImage, forKey: "inputBacksideImage")

        let extent = CIVector(cgRect: CGRect(x: CGFloat(x), y: CGFloat(y), width: CGFloat(extentWidth), height: CGFloat(extentHeight)))
        currentCIFilter.setValue(extent, forKey: "inputExtent")
        
        currentCIFilter.setValue(time, forKey: kCIInputTimeKey)
        currentCIFilter.setValue(angle, forKey: kCIInputAngleKey)
        currentCIFilter.setValue(radius, forKey: kCIInputRadiusKey)
        
        currentCIFilter.setValue(shadowSize, forKey: "inputShadowSize")
        currentCIFilter.setValue(shadowAmount, forKey: "inputShadowAmount")
        currentCIFilter.setValue(radius, forKey: kCIInputRadiusKey)
        
        
        let shadowExtent = CIVector(cgRect: CGRect(x: CGFloat(shadowx), y: CGFloat(shadowy), width: CGFloat(shadowExtentWidth), height: CGFloat(shadowExtentHeight)))
        currentCIFilter.setValue(shadowExtent, forKey: "inputShadowExtent")
                
        return currentCIFilter
    }
    /*
    override func getDisplayNameFX() -> String
    {

        var fxStr = "" //retName
        var previousStr="previous"
        if nodeIndex == 1 {
            previousStr="0"//"0 (original image)"
        }
        else {
            previousStr="" + String(nodeIndex-1)
        }
            
        var inputImageAliasStr = previousStr
        if inputImageAlias != ""{
            inputImageAliasStr = "\""+inputImageAlias+"\""
        }
        
        var targetImageAliasStr = previousStr
        if targetImageAlias != ""{
            targetImageAliasStr = "\""+targetImageAlias+"\""
        }
        
        var inputBacksideImageAliasStr = previousStr
        if inputBacksideImageAlias != ""{
            inputBacksideImageAliasStr = "\""+inputBacksideImageAlias+"\""
        }
        
        fxStr = "input - " + inputImageAliasStr + ", target - " + targetImageAliasStr + ", backside - " + inputBacksideImageAliasStr

        return fxStr
   
    }
    */
}
