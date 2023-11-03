//
//  Copyright © 2022 James Boo. All rights reserved.
//


import SwiftUI
//ANCHISES-BaseTransitionFX-comeback
//Ripple requires a crop image with bottom really trimmed away or black color(not tested)
//when the crop image becomes a video. it becomes green at the bottom
//thus causing issues.

class RippleTransitionFX: BaseTransitionMaskFX {
       
    @Published var inputShadingImageAlias : String=""
    @Published var inputShadingImageAliasId : String=""

    @Published var centerX:Float = 150
    @Published var centerY:Float = 150
    
    @Published var x:Float = 0.0
    @Published var y:Float = 0.0
    @Published var extentWidth:Float = 300.0
    @Published var extentHeight:Float = 300.0
    
    @Published var width:Float = 100.00
    @Published var scale:Float = 50.0
    
    let description = "Transitions from one image (A) to another (B) by creating a circular wave that expands from the center point, revealing the new image in the wake of the wave. Scale is a value that determines whether the ripple starts as a bulge (higher value) or a dimple (lower value). Width is the width of the ripple. Please note that the shading image (C) needs to be transparent at the bottom as illustrated in Presets."

    override init()
    {
        let name="CIRippleTransition"
        super.init(name)
        desc=description
        time = 0.5
        /*
        print(CIFilter.localizedName(forFilterName: name))
        print(CIFilter.localizedDescription(forFilterName: name))
        print(CIFilter.localizedReferenceDocumentation(forFilterName: name))
        
        print("inputWidth")
        if let attribute = CIFilter.rippleTransition().attributes["inputWidth"] as? [String: AnyObject]
        {
           let minimum = attribute[kCIAttributeSliderMin] as? Float
           let maximum = attribute[kCIAttributeSliderMax] as? Float
           let defaultValue = attribute[kCIAttributeDefault] as? Float
            
            print(minimum)
            print(maximum)
            print(defaultValue)
            
        }
        print("inputScale")
        if let attribute = CIFilter.rippleTransition().attributes["inputScale"] as? [String: AnyObject]
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
        case inputShadingImageAlias
        case centerX
        case centerY
        
        case x
        case y
        case extentWidth
        case extentHeight
        
        case width
        case scale
        
    }

    required init(from decoder: Decoder) throws {
        try super.init(from: decoder)
        let values = try decoder.container(keyedBy: CodingKeys.self)
        desc=description
        
        inputShadingImageAlias = try values.decodeIfPresent(String.self, forKey: .inputShadingImageAlias) ?? ""
        
        centerX = try values.decodeIfPresent(Float.self, forKey: .centerX) ?? 0.0
        centerY = try values.decodeIfPresent(Float.self, forKey: .centerY) ?? 0.0
        
        x = try values.decodeIfPresent(Float.self, forKey: .x) ?? 0
        y = try values.decodeIfPresent(Float.self, forKey: .y) ?? 0
        extentWidth = try values.decodeIfPresent(Float.self, forKey: .extentWidth) ?? 0
        extentHeight = try values.decodeIfPresent(Float.self, forKey: .extentHeight) ?? 0
        
        width = try values.decodeIfPresent(Float.self, forKey: .width) ?? 0.0
        scale = try values.decodeIfPresent(Float.self, forKey: .scale) ?? 0.0

    }
    
    override func encode(to encoder: Encoder) throws {
        try super.encode(to: encoder)
  
        var container = encoder.container(keyedBy: CodingKeys.self)

        try container.encode(inputShadingImageAlias, forKey: .inputShadingImageAlias)
        
        try container.encode(centerX, forKey: .centerX)
        try container.encode(centerY, forKey: .centerY)
        
        try container.encode(x, forKey: .x)
        try container.encode(y, forKey: .y)
        try container.encode(extentWidth, forKey: .extentWidth)
        try container.encode(extentHeight, forKey: .extentHeight)
        
        try container.encode(width, forKey: .width)
        try container.encode(scale, forKey: .scale)
    
    }

    override func setupProperties(_ parent: FiltersX?)
    {
        super.setupProperties(parent)
        
        if parent != nil{
            x=0
            y=0
            
            extentWidth=Float(size.width)
            extentHeight=Float(size.height)

            centerX=Float(size.width/2.0)
            centerY=Float(size.height/2.0)
        }
        
    }
    
    override func adjustPropertiesToBounds(_ parent: FiltersX?)
    {
        super.adjustPropertiesToBounds(parent)
        
        x = x > Float(size.width) ? Float(size.width) : x
        y = y > Float(size.height) ? Float(size.height) : y
        
        extentWidth = extentWidth > Float(size.width) ? Float(size.width) : extentWidth
        extentHeight = extentHeight > Float(size.height) ? Float(size.height) : extentHeight
        
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
        
        let shadingImage=handleAlias(alias: inputShadingImageAlias,
                                      inputImage: currentImage,
                                      beginImage: beginImage)
        
        currentCIFilter.setValue(inputImage, forKey: kCIInputImageKey)
        currentCIFilter.setValue(targetImage, forKey: kCIInputTargetImageKey)
        currentCIFilter.setValue(shadingImage, forKey: "inputShadingImage")

        let tcenter=CIVector(x:CGFloat(centerX),y:CGFloat(centerY))
        currentCIFilter.setValue(tcenter, forKey: kCIInputCenterKey)
        
        let extent = CIVector(cgRect: CGRect(x: CGFloat(x), y: CGFloat(y), width: CGFloat(extentWidth), height: CGFloat(extentHeight)))
        currentCIFilter.setValue(extent, forKey: "inputExtent")
        
        currentCIFilter.setValue(time, forKey: kCIInputTimeKey)
        currentCIFilter.setValue(width, forKey: kCIInputWidthKey)
        currentCIFilter.setValue(scale, forKey: kCIInputScaleKey)
        
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
        currentCIFilter.setValue(thirdImage, forKey: "inputShadingImage")

        let tcenter=CIVector(x:CGFloat(centerX),y:CGFloat(centerY))
        currentCIFilter.setValue(tcenter, forKey: kCIInputCenterKey)
        
        let extent = CIVector(cgRect: CGRect(x: CGFloat(x), y: CGFloat(y), width: CGFloat(extentWidth), height: CGFloat(extentHeight)))
        currentCIFilter.setValue(extent, forKey: "inputExtent")
        
        currentCIFilter.setValue(time, forKey: kCIInputTimeKey)
        currentCIFilter.setValue(width, forKey: kCIInputWidthKey)
        currentCIFilter.setValue(scale, forKey: kCIInputScaleKey)
        
        return currentCIFilter
        
    
    }
    //ANCHISES
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
        
        var inputShadingImageAliasStr = previousStr
        if inputShadingImageAlias != ""{
            inputShadingImageAliasStr = "\""+inputShadingImageAlias+"\""
        }
        
        fxStr = "input - " + inputImageAliasStr + ", target - " + targetImageAliasStr + ", shading - " + inputShadingImageAliasStr

        return fxStr
   
    }
     */
}
