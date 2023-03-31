//
//  Copyright © 2022 James Boo. All rights reserved.
//


import SwiftUI

class FlashTransitionFX: BaseTransitionFX {
       
    @Published var centerX:Float = 150
    @Published var centerY:Float = 150
    
    @Published var x:Float = 0.0
    @Published var y:Float = 0.0
    @Published var extentWidth:Float = 300.0
    @Published var extentHeight:Float = 300.0
    
    @Published var colorx:Color = .red
    @Published var color:CIColor = .red
    
    @Published var maxStriationRadius:Float = 2.58
    @Published var striationStrength:Float = 0.5
    @Published var striationContrast:Float = 1.38
    @Published var fadeThreshold:Float = 0.85
    
    let description = "Transitions from one image to another by creating a flash. Max Striation Radius The radius of the light rays emanating from the flash. Striation Strength is the strength of the light rays emanating from the flash. Striation Contrast is the contrast of the light rays emanating from the flash. Fade Threshold is the amount of fade between the flash and the target image. The higher the value, the more flash time and the less fade time. Color is the color of the light rays emanating from the flash. Extent is the rectangle extent of the flash."

    override init()
    {
        let name="CIFlashTransition"
        super.init(name)
        desc=description
        time=0.6
        print(CIFilter.localizedName(forFilterName: name))
        print(CIFilter.localizedDescription(forFilterName: name))
        print(CIFilter.localizedReferenceDocumentation(forFilterName: name))
        
        print("inputMaxStriationRadius")
        if let attribute = CIFilter.flashTransition().attributes["inputMaxStriationRadius"] as? [String: AnyObject]
        {
           let minimum = attribute[kCIAttributeSliderMin] as? Float
           let maximum = attribute[kCIAttributeSliderMax] as? Float
           let defaultValue = attribute[kCIAttributeDefault] as? Float
            
            print(minimum)
            print(maximum)
            print(defaultValue)
            
        }
        print("inputStriationStrength")
        if let attribute = CIFilter.flashTransition().attributes["inputStriationStrength"] as? [String: AnyObject]
        {
           let minimum = attribute[kCIAttributeSliderMin] as? Float
           let maximum = attribute[kCIAttributeSliderMax] as? Float
           let defaultValue = attribute[kCIAttributeDefault] as? Float
            
            print(minimum)
            print(maximum)
            print(defaultValue)
            
        }
        print("inputStriationContrast")
        if let attribute = CIFilter.flashTransition().attributes["inputStriationContrast"] as? [String: AnyObject]
        {
           let minimum = attribute[kCIAttributeSliderMin] as? Float
           let maximum = attribute[kCIAttributeSliderMax] as? Float
           let defaultValue = attribute[kCIAttributeDefault] as? Float
            
            print(minimum)
            print(maximum)
            print(defaultValue)
            
        }
        print("inputFadeThreshold")
        if let attribute = CIFilter.flashTransition().attributes["inputFadeThreshold"] as? [String: AnyObject]
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
        
        case x
        case y
        case extentWidth
        case extentHeight
        
        case color
        
        case maxStriationRadius
        case striationStrength
        case striationContrast
        case fadeThreshold
        
    }

    required init(from decoder: Decoder) throws {
        try super.init(from: decoder)
        let values = try decoder.container(keyedBy: CodingKeys.self)
        desc=description

        centerX = try values.decodeIfPresent(Float.self, forKey: .centerX) ?? 0.0
        centerY = try values.decodeIfPresent(Float.self, forKey: .centerY) ?? 0.0
        
        x = try values.decodeIfPresent(Float.self, forKey: .x) ?? 0
        y = try values.decodeIfPresent(Float.self, forKey: .y) ?? 0
        extentWidth = try values.decodeIfPresent(Float.self, forKey: .extentWidth) ?? 0
        extentHeight = try values.decodeIfPresent(Float.self, forKey: .extentHeight) ?? 0
        
        let colorData = try values.decodeIfPresent(Data.self, forKey: .color) ?? nil
        if colorData != nil
        {
            let uicolor=try NSKeyedUnarchiver.unarchivedObject(ofClass: UIColor.self, from: colorData!)!
            color = CIColor(color:uicolor)
            colorx = Color(uicolor)
        }
        
        maxStriationRadius = try values.decodeIfPresent(Float.self, forKey: .maxStriationRadius) ?? 0
        striationStrength = try values.decodeIfPresent(Float.self, forKey: .striationStrength) ?? 0
        striationContrast = try values.decodeIfPresent(Float.self, forKey: .striationContrast) ?? 0
        fadeThreshold = try values.decodeIfPresent(Float.self, forKey: .fadeThreshold) ?? 0

    }
    
    override func encode(to encoder: Encoder) throws {
        try super.encode(to: encoder)
  
        var container = encoder.container(keyedBy: CodingKeys.self)

        try container.encode(centerX, forKey: .centerX)
        try container.encode(centerY, forKey: .centerY)
        
        try container.encode(x, forKey: .x)
        try container.encode(y, forKey: .y)
        try container.encode(extentWidth, forKey: .extentWidth)
        try container.encode(extentHeight, forKey: .extentHeight)

        try container.encode(try NSKeyedArchiver.archivedData(withRootObject: UIColor(ciColor: color), requiringSecureCoding: false), forKey: .color)
        
        try container.encode(maxStriationRadius, forKey: .maxStriationRadius)
        try container.encode(striationStrength, forKey: .striationStrength)
        try container.encode(striationContrast, forKey: .striationContrast)
        try container.encode(fadeThreshold, forKey: .fadeThreshold)

    }
    
    override func setupProperties(_ parent: FiltersX?)
    {
        super.setupProperties(parent)
        
        if parent != nil{
            centerX=Float(size.width/2.0)
            centerY=Float(size.height/2.0)
            
            x=0
            y=0
            
            extentWidth=Float(size.width/4.0)
            extentHeight=Float(size.height)
        }
        
    }
    
    override func adjustPropertiesToBounds(_ parent: FiltersX?)
    {
        super.adjustPropertiesToBounds(parent)
        
        centerX = centerX > Float(size.width) ? Float(size.width) : centerX
        centerY = centerY > Float(size.height) ? Float(size.height) : centerY

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
        
   
        print("BarsSwipe FX")
        currentCIFilter.setValue(inputImage, forKey: kCIInputImageKey)
        currentCIFilter.setValue(targetImage, forKey: kCIInputTargetImageKey)
        
        let tcenter=CIVector(x:CGFloat(centerX),y:CGFloat(centerY))
        currentCIFilter.setValue(tcenter, forKey: kCIInputCenterKey)
        
        let extent = CIVector(cgRect: CGRect(x: CGFloat(x), y: CGFloat(y), width: CGFloat(extentWidth), height: CGFloat(extentHeight)))
        currentCIFilter.setValue(extent, forKey: "inputExtent")
        
        currentCIFilter.setValue(color, forKey: kCIInputColorKey)
        
        currentCIFilter.setValue(time, forKey: kCIInputTimeKey)
    
        currentCIFilter.setValue(maxStriationRadius, forKey: "inputMaxStriationRadius")
        currentCIFilter.setValue(striationStrength, forKey: "inputStriationStrength")
        currentCIFilter.setValue(striationContrast, forKey: "inputStriationContrast")
        currentCIFilter.setValue(fadeThreshold, forKey: "inputFadeThreshold")
        
        
        return currentCIFilter
         

    }


}
