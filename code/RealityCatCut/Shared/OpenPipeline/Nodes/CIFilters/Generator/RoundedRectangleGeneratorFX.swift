//
//  Copyright © 2022 James Boo. All rights reserved.
//


import SwiftUI

class RoundedRectangleGeneratorFX: BaseGeneratorFX {
           
    @Published var x:Float = 0.0
    @Published var y:Float = 0.0
    @Published var extentWidth:Float = 300.0
    @Published var extentHeight:Float = 300.0
    
    @Published var color:CIColor = .black
    @Published var colorx:Color = .black
    
    @Published var backgroundColor:CIColor = .white
    @Published var backgroundColorx:Color = .white

    @Published var radius:Float = 5.0
/*
    @Published var tx:Float = 0.0
    @Published var ty:Float = 0.0
  */
    let description = "BETA NODE: Generates a rounded rectangle image with the specified extent, corner radius, and color."

    override init()
    {
        let name="CIRoundedRectangleGenerator"
        super.init(name)
        desc=description
        /*
        print(CIFilter.localizedName(forFilterName: name))
        print(CIFilter.localizedDescription(forFilterName: name))
        print(CIFilter.localizedReferenceDocumentation(forFilterName: name))

        print("inputRadius")
        if let attribute = CIFilter.checkerboardGenerator().attributes["inputRadius"] as? [String: AnyObject]
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
        case radius
        case backgroundColor
     
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
        
        radius = try values.decodeIfPresent(Float.self, forKey: .radius) ?? 0

        let bgcolorData = try values.decodeIfPresent(Data.self, forKey: .backgroundColor) ?? nil
        if bgcolorData != nil
        {
            let uicolor=try NSKeyedUnarchiver.unarchivedObject(ofClass: UIColor.self, from: bgcolorData!)!
            backgroundColor = CIColor(color:uicolor)
            backgroundColorx = Color(uicolor)
        }
        
        
    }
    
    override func encode(to encoder: Encoder) throws {
        try super.encode(to: encoder)
  
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(x, forKey: .x)
        try container.encode(y, forKey: .y)
        try container.encode(extentWidth, forKey: .extentWidth)
        try container.encode(extentHeight, forKey: .extentHeight)
        try container.encode(try NSKeyedArchiver.archivedData(withRootObject: UIColor(ciColor: color), requiringSecureCoding: false), forKey: .color)
        
        try container.encode(radius, forKey: .radius)
        
        try container.encode(try NSKeyedArchiver.archivedData(withRootObject: UIColor(ciColor: backgroundColor), requiringSecureCoding: false), forKey: .backgroundColor)

    }
    
    override func setupProperties(_ parent: FiltersX?)
    {
        super.setupProperties(parent)
        
        if parent != nil{
            x=Float(size.width/3.0)
            y=Float(size.height/3.0)
            
            extentWidth=Float(size.width/3.0)
            extentHeight=Float(size.height/3.0)
            /*
            tx=0.0
            ty=0.0
             */
        }
        
    }
    
    override func adjustPropertiesToBounds(_ parent: FiltersX?)
    {
        super.adjustPropertiesToBounds(parent)
        
        x = x > Float(size.width) ? Float(size.width) : x
        y = y > Float(size.height) ? Float(size.height) : y
        
        extentWidth = extentWidth > Float(size.width) ? Float(size.width) : extentWidth
        extentHeight = extentHeight > Float(size.height) ? Float(size.height) : extentHeight
        
        /*
        tx = tx > Float(size.width) ? Float(size.width) : tx
        ty = ty > Float(size.height) ? Float(size.height) : ty
        
        tx = tx < Float(0-size.width) ? Float(0-size.width) : tx
        ty = ty < Float(0-size.height) ? Float(0-size.height) : ty
         */
        
    }
    /*
     func setCIFilterAndCropImage(inputImage: CIImage) {

         var cropFilter: CIFilter
         if ciFilter != nil {
             cropFilter = ciFilter!
         } else {
             cropFilter = CIFilter(name: "CICrop")!
         }
         
         cropFilter.setValue(inputImage, forKey: kCIInputImageKey)
         let rect = CIVector(cgRect: CGRect(x:0, y: 0, width: CGFloat(size.width), height: CGFloat(size.height)))
         cropFilter.setValue(rect, forKey: "inputRectangle")
         ciFilter=cropFilter

     }
     
     */
    
    var constantColorCIFilter: CIFilter?
    var roundedRectangleGeneratorCIFilter: CIFilter?
    var sourceOverCIFilter: CIFilter?
    var cropCIFilter: CIFilter?
    //deprecate
    override func getCIFilter(currentImage: CIImage, beginImage: CIImage) -> CIFilter? {
        
        var currentCIFilter: CIFilter
        var roundedRectangleGeneratorFilter: CIFilter
        var constantColorFilter: CIFilter
        var sourceOverFilter: CIFilter
        var cropFilter: CIFilter

        if ciFilter != nil {
            
            //currentCIFilter = ciFilter!
            roundedRectangleGeneratorFilter = roundedRectangleGeneratorCIFilter!
            constantColorFilter = constantColorCIFilter!
            sourceOverFilter = sourceOverCIFilter!
            cropFilter = cropCIFilter!
            
        } else {
            
            constantColorFilter = CIFilter(name: "CIConstantColorGenerator")!
            roundedRectangleGeneratorFilter = CIFilter(name: type)!
            sourceOverFilter = CIFilter(name: "CISourceOverCompositing")!
            cropFilter = CIFilter(name: "CICrop")!
            //currentCIFilter = cropFilter
            //ciFilter=currentCIFilter
            
        }
        
        constantColorFilter.setValue(backgroundColor, forKey: kCIInputColorKey)
        
        let extent = CIVector(cgRect: CGRect(x: CGFloat(x), y: CGFloat(y), width: CGFloat(extentWidth), height: CGFloat(extentHeight)))
        roundedRectangleGeneratorFilter.setValue(extent, forKey: "inputExtent")
        roundedRectangleGeneratorFilter.setValue(color, forKey: "inputColor")
        roundedRectangleGeneratorFilter.setValue(radius, forKey: "inputRadius")
        
        sourceOverFilter.setValue(roundedRectangleGeneratorFilter.outputImage, forKey: kCIInputImageKey)
        sourceOverFilter.setValue(constantColorFilter.outputImage, forKey: kCIInputBackgroundImageKey)
        
        cropFilter.setValue(sourceOverFilter.outputImage, forKey: kCIInputImageKey)
        let rect = CIVector(cgRect: CGRect(x:0, y: 0, width: CGFloat(size.width), height: CGFloat(size.height)))
        cropFilter.setValue(rect, forKey: "inputRectangle")

        roundedRectangleGeneratorCIFilter = roundedRectangleGeneratorFilter
        constantColorCIFilter = constantColorFilter
        sourceOverCIFilter = sourceOverFilter
        cropCIFilter = cropFilter
        
        currentCIFilter=cropFilter
        ciFilter=currentCIFilter
        return currentCIFilter
        
/* Just Rectangle
        currentCIFilter.setValue(roundedRectangleGeneratorFilter.outputImage!,forKey:kCIInputImageKey)
        let transform=CGAffineTransform(a:1.0,b:0,c:0,d:1.0,tx:CGFloat(tx),ty:CGFloat(ty))
        
        currentCIFilter.setValue(transform, forKey: kCIInputTransformKey)
    
        ciFilter=currentCIFilter
        roundedRectangleGeneratorCIFilter=roundedRectangleGeneratorFilter
        
        return currentCIFilter
 */
        
    }
    //ANCHISES
    override func getCIFilter(_ ciImage: CIImage) -> CIFilter {
        var currentCIFilter: CIFilter
        var roundedRectangleGeneratorFilter: CIFilter
        var constantColorFilter: CIFilter
        var sourceOverFilter: CIFilter
        var cropFilter: CIFilter

        if ciFilter != nil {
            
            //currentCIFilter = ciFilter!
            roundedRectangleGeneratorFilter = roundedRectangleGeneratorCIFilter!
            constantColorFilter = constantColorCIFilter!
            sourceOverFilter = sourceOverCIFilter!
            cropFilter = cropCIFilter!
            
        } else {
            
            constantColorFilter = CIFilter(name: "CIConstantColorGenerator")!
            roundedRectangleGeneratorFilter = CIFilter(name: type)!
            sourceOverFilter = CIFilter(name: "CISourceOverCompositing")!
            cropFilter = CIFilter(name: "CICrop")!
               
        }
        
        constantColorFilter.setValue(backgroundColor, forKey: kCIInputColorKey)
        
        let extent = CIVector(cgRect: CGRect(x: CGFloat(x), y: CGFloat(y), width: CGFloat(extentWidth), height: CGFloat(extentHeight)))
        roundedRectangleGeneratorFilter.setValue(extent, forKey: "inputExtent")
        roundedRectangleGeneratorFilter.setValue(color, forKey: "inputColor")
        roundedRectangleGeneratorFilter.setValue(radius, forKey: "inputRadius")
        
        sourceOverFilter.setValue(roundedRectangleGeneratorFilter.outputImage, forKey: kCIInputImageKey)
        sourceOverFilter.setValue(constantColorFilter.outputImage, forKey: kCIInputBackgroundImageKey)
        
        cropFilter.setValue(sourceOverFilter.outputImage, forKey: kCIInputImageKey)
        let rect = CIVector(cgRect: CGRect(x:0, y: 0, width: CGFloat(size.width), height: CGFloat(size.height)))
        cropFilter.setValue(rect, forKey: "inputRectangle")

        roundedRectangleGeneratorCIFilter = roundedRectangleGeneratorFilter
        constantColorCIFilter = constantColorFilter
        sourceOverCIFilter = sourceOverFilter
        cropCIFilter = cropFilter
        
        currentCIFilter=cropFilter
        ciFilter=currentCIFilter
        return currentCIFilter
        
    }
    
}
