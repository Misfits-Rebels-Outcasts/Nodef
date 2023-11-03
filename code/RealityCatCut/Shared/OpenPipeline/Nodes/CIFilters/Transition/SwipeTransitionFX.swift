//
//  Copyright © 2022 James Boo. All rights reserved.
//


import SwiftUI

class SwipeTransitionFX: BaseTransitionFX {
       
    @Published var x:Float = 0.0
    @Published var y:Float = 0.0
    @Published var extentWidth:Float = 300.0
    @Published var extentHeight:Float = 300.0
    
    @Published var colorx:Color = .white
    @Published var color:CIColor = .white
    
    @Published var angle:Float = 0.0
    @Published var width:Float = 300.0
    @Published var opacity:Float = 0.0

    
    let description = "Transitions from one image (A) to another (B) by simulating a swiping action. Angle is the angle of the swipe. Color is the color of the swipe. Width is the width of the swipe"

    override init()
    {
        let name="CISwipeTransition"
        super.init(name)
        desc=description
        time=0.5
        /*
        print(CIFilter.localizedName(forFilterName: name))
        print(CIFilter.localizedDescription(forFilterName: name))
        print(CIFilter.localizedReferenceDocumentation(forFilterName: name))
        
        print("inputAngle")
        if let attribute = CIFilter.swipeTransition().attributes["inputAngle"] as? [String: AnyObject]
        {
           let minimum = attribute[kCIAttributeSliderMin] as? Float
           let maximum = attribute[kCIAttributeSliderMax] as? Float
           let defaultValue = attribute[kCIAttributeDefault] as? Float
            
            print(minimum)
            print(maximum)
            print(defaultValue)
            
        }
        
        print("inputWidth")
        if let attribute = CIFilter.swipeTransition().attributes["inputWidth"] as? [String: AnyObject]
        {
           let minimum = attribute[kCIAttributeSliderMin] as? Float
           let maximum = attribute[kCIAttributeSliderMax] as? Float
           let defaultValue = attribute[kCIAttributeDefault] as? Float
            
            print(minimum)
            print(maximum)
            print(defaultValue)
            
        }
        
        print("inputOpacity")
        if let attribute = CIFilter.swipeTransition().attributes["inputOpacity"] as? [String: AnyObject]
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
        case x
        case y
        case extentWidth
        case extentHeight
        
        case color
        
        case angle
        case width
        case opacity
        
    }

    required init(from decoder: Decoder) throws {
        try super.init(from: decoder)
        let values = try decoder.container(keyedBy: CodingKeys.self)
        desc=description
        
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

        angle = try values.decodeIfPresent(Float.self, forKey: .angle) ?? 0
        width = try values.decodeIfPresent(Float.self, forKey: .width) ?? 0
        opacity = try values.decodeIfPresent(Float.self, forKey: .opacity) ?? 0
        
    }
    
    override func encode(to encoder: Encoder) throws {
        try super.encode(to: encoder)
  
        var container = encoder.container(keyedBy: CodingKeys.self)
        
        try container.encode(x, forKey: .x)
        try container.encode(y, forKey: .y)
        try container.encode(extentWidth, forKey: .extentWidth)
        try container.encode(extentHeight, forKey: .extentHeight)
        
        try container.encode(try NSKeyedArchiver.archivedData(withRootObject: UIColor(ciColor: color), requiringSecureCoding: false), forKey: .color)
        
        try container.encode(angle, forKey: .angle)
        try container.encode(width, forKey: .width)
        try container.encode(opacity, forKey: .opacity)
        
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
    //deprecate
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
        
        let extent = CIVector(cgRect: CGRect(x: CGFloat(x), y: CGFloat(y), width: CGFloat(extentWidth), height: CGFloat(extentHeight)))
        currentCIFilter.setValue(extent, forKey: "inputExtent")
        
        currentCIFilter.setValue(color, forKey: kCIInputColorKey)
        
        currentCIFilter.setValue(time, forKey: kCIInputTimeKey)
    
        currentCIFilter.setValue(angle, forKey: kCIInputAngleKey)
        currentCIFilter.setValue(width, forKey: kCIInputWidthKey)
        currentCIFilter.setValue(opacity, forKey: "inputOpacity")
        
        return currentCIFilter
        
    }
    //ANCHISES
    override func getCIFilter(firstImage: CIImage, secondImage: CIImage) -> CIFilter? {
        
    var currentCIFilter: CIFilter
    if ciFilter != nil {
        currentCIFilter = ciFilter!
    } else {
        currentCIFilter = CIFilter(name: type)!
        ciFilter=currentCIFilter
    }
    
    currentCIFilter.setValue(firstImage, forKey: kCIInputImageKey)
    currentCIFilter.setValue(secondImage, forKey: kCIInputTargetImageKey)
    
    let extent = CIVector(cgRect: CGRect(x: CGFloat(x), y: CGFloat(y), width: CGFloat(extentWidth), height: CGFloat(extentHeight)))
    currentCIFilter.setValue(extent, forKey: "inputExtent")
    
    currentCIFilter.setValue(color, forKey: kCIInputColorKey)
    
    currentCIFilter.setValue(time, forKey: kCIInputTimeKey)

    currentCIFilter.setValue(angle, forKey: kCIInputAngleKey)
    currentCIFilter.setValue(width, forKey: kCIInputWidthKey)
    currentCIFilter.setValue(opacity, forKey: "inputOpacity")
    
    return currentCIFilter
    }
    
}
