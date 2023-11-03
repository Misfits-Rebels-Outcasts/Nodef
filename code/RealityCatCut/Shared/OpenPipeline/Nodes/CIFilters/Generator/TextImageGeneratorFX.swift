//
//  Copyright © 2022 James Boo. All rights reserved.
//


import SwiftUI

class TextImageGeneratorFX: BaseGeneratorFX {
       
    @Published var text:String = "Text"
    @Published var fontName:String = "Helvetica Neue"
    @Published var fontSize:Float = 60
    @Published var scaleFactor:Float = 3.0
    
    @Published var tx:Float = 0.0
    @Published var ty:Float = 0.0
    
    @Published var color:CIColor = .black
    @Published var colorx:Color = .black
    
    @Published var backgroundColor:CIColor = .white
    @Published var backgroundColorx:Color = .white
    
    let description = "BETA NODE: Generates an image from a string and font information."

    override init()
    {
        let name="CITextImageGenerator"
        super.init(name)
        desc=description
        /*
        print(CIFilter.localizedName(forFilterName: name))
        print(CIFilter.localizedDescription(forFilterName: name))
        print(CIFilter.localizedReferenceDocumentation(forFilterName: name))
         
        print("FontSize")
        if let attribute = CIFilter.checkerboardGenerator().attributes["inputFontSize"] as? [String: AnyObject]
        {
           let minimum = attribute[kCIAttributeSliderMin] as? Float
           let maximum = attribute[kCIAttributeSliderMax] as? Float
           let defaultValue = attribute[kCIAttributeDefault] as? Float
            
            print(minimum)
            print(maximum)
            print(defaultValue)
            
        }
        
        print("ScaleFactor")
        if let attribute = CIFilter.checkerboardGenerator().attributes["inputScaleFactor"] as? [String: AnyObject]
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
        case text
        case fontName
        case fontSize
        case scaleFactor
        case tx
        case ty
        case color
        case backgroundColor
    }

    required init(from decoder: Decoder) throws {
        try super.init(from: decoder)
        let values = try decoder.container(keyedBy: CodingKeys.self)
        desc=description
        
        text = try values.decodeIfPresent(String.self, forKey: .text) ?? ""
        fontName = try values.decodeIfPresent(String.self, forKey: .fontName) ?? ""
        fontSize = try values.decodeIfPresent(Float.self, forKey: .fontSize) ?? 40.0
        scaleFactor = try values.decodeIfPresent(Float.self, forKey: .scaleFactor) ?? 1.0
        
        tx = try values.decodeIfPresent(Float.self, forKey: .tx) ?? 0
        ty = try values.decodeIfPresent(Float.self, forKey: .ty) ?? 0
        
        var colorData = try values.decodeIfPresent(Data.self, forKey: .color) ?? nil
        if colorData != nil
        {
            let uicolor=try NSKeyedUnarchiver.unarchivedObject(ofClass: UIColor.self, from: colorData!)!
            color = CIColor(color:uicolor)
            colorx = Color(uicolor)
        }
        
        colorData = try values.decodeIfPresent(Data.self, forKey: .backgroundColor) ?? nil
        if colorData != nil
        {
            let uicolor=try NSKeyedUnarchiver.unarchivedObject(ofClass: UIColor.self, from: colorData!)!
            backgroundColor = CIColor(color:uicolor)
            backgroundColorx = Color(uicolor)
        }
    }
    
    override func encode(to encoder: Encoder) throws {
        try super.encode(to: encoder)
  
        var container = encoder.container(keyedBy: CodingKeys.self)

        try container.encode(text, forKey: .text)
        try container.encode(fontName, forKey: .fontName)
        try container.encode(fontSize, forKey: .fontSize)
        try container.encode(scaleFactor, forKey: .scaleFactor)
        
        try container.encode(tx, forKey: .tx)
        try container.encode(ty, forKey: .ty)
        
        try container.encode(try NSKeyedArchiver.archivedData(withRootObject: UIColor(ciColor: color), requiringSecureCoding: false), forKey: .color)
        
        try container.encode(try NSKeyedArchiver.archivedData(withRootObject: UIColor(ciColor: backgroundColor), requiringSecureCoding: false), forKey: .backgroundColor)
        
        
    }
    
    override func setupProperties(_ parent: FiltersX?)
    {
        super.setupProperties(parent)
        
        if parent != nil{
            //tx=0.0
            //ty=0.0
            tx=Float(size.width/5.0)
            ty=Float(size.height/5.0)
        }
        
    }
    
    override func adjustPropertiesToBounds(_ parent: FiltersX?)
    {
        super.adjustPropertiesToBounds(parent)
        
        tx = tx > Float(size.width) ? Float(size.width) : tx
        ty = ty > Float(size.height) ? Float(size.height) : ty
        
        tx = tx < Float(0-size.width) ? Float(0-size.width) : tx
        ty = ty < Float(0-size.height) ? Float(0-size.height) : ty
        
    }
    
    
    var constantColorCIFilter: CIFilter?
    var roundedRectangleGeneratorCIFilter: CIFilter?
    var sourceOverCIFilter: CIFilter?
    var constantCropCIFilter: CIFilter?
    var cropCIFilter: CIFilter?
    var textImageGeneratorCIFilter: CIFilter?
    var affineTransformCIFilter: CIFilter?
    var falseColorCIFilter: CIFilter?

    //deprecate
    override func getCIFilter(currentImage: CIImage, beginImage: CIImage) -> CIFilter? {
        
        var currentCIFilter: CIFilter
        var textImageGeneratorFilter: CIFilter
        var affineTransformFilter: CIFilter
        var constantColorFilter: CIFilter
        var sourceOverFilter: CIFilter
        var falseColorFilter: CIFilter
        var constantCropFilter: CIFilter
        var cropFilter: CIFilter
        
        if ciFilter != nil {
            textImageGeneratorFilter = textImageGeneratorCIFilter!
            affineTransformFilter = affineTransformCIFilter!
            constantColorFilter = constantColorCIFilter!
            sourceOverFilter = sourceOverCIFilter!
            falseColorFilter = falseColorCIFilter!
            constantCropFilter = constantCropCIFilter!
            cropFilter = cropCIFilter!
        } else {
            constantColorFilter = CIFilter(name: "CIConstantColorGenerator")!
            affineTransformFilter = CIFilter(name: "CIAffineTransform")!
            sourceOverFilter = CIFilter(name: "CISourceOverCompositing")!
            cropFilter = CIFilter(name: "CICrop")!
            textImageGeneratorFilter = CIFilter(name: type)!
            falseColorFilter = CIFilter(name: "CIFalseColor")!
            constantCropFilter = CIFilter(name: "CICrop")!
        }
        
        let bcolor:CIColor = .white
        constantColorFilter.setValue(bcolor, forKey: kCIInputColorKey)
        
        constantCropFilter.setValue(constantColorFilter.outputImage!, forKey: kCIInputImageKey)
        let rect = CIVector(cgRect: CGRect(x:0, y: 0, width: CGFloat(size.width), height: CGFloat(size.height)))
        constantCropFilter.setValue(rect, forKey: "inputRectangle")
        
        let postscriptFontName=fontName//.replacingOccurrences(of: " ", with: "")
        //postscript voncersion cannot be the above alone.
        textImageGeneratorFilter.setValue(postscriptFontName, forKey: "inputFontName")
        textImageGeneratorFilter.setValue(fontSize, forKey: "inputFontSize")
        textImageGeneratorFilter.setValue(scaleFactor, forKey: "inputScaleFactor")
        
        //bug fix
        if text == "" {
            textImageGeneratorFilter.setValue("...", forKey: "inputText")
        }
        else if text.trimmingCharacters(in: .whitespaces) == "" ||
                text.trimmingCharacters(in: .newlines) == ""
        {
            textImageGeneratorFilter.setValue("...", forKey: "inputText")
        }
        else {
            textImageGeneratorFilter.setValue(text, forKey: "inputText")
        }
        
        var tigImage : CIImage
        if textImageGeneratorFilter.outputImage != nil
        {
            tigImage = textImageGeneratorFilter.outputImage!
        }
        else {
            tigImage = constantColorFilter.outputImage!
        }
        
        let transform=CGAffineTransform(a:1.0,b:0,c:0,d:1.0,tx:CGFloat(tx),ty:CGFloat(ty))
        affineTransformFilter.setValue(tigImage,forKey:kCIInputImageKey)
        affineTransformFilter.setValue(transform, forKey: kCIInputTransformKey)
        
        sourceOverFilter.setValue(affineTransformFilter.outputImage!, forKey: kCIInputImageKey)
        sourceOverFilter.setValue(constantCropFilter.outputImage!, forKey: kCIInputBackgroundImageKey)
        
        falseColorFilter.setValue(sourceOverFilter.outputImage!, forKey: kCIInputImageKey)
        falseColorFilter.setValue(color, forKey: "inputColor0")
        falseColorFilter.setValue(backgroundColor, forKey: "inputColor1")
        
        cropFilter.setValue(falseColorFilter.outputImage!, forKey: kCIInputImageKey)
        cropFilter.setValue(rect, forKey: "inputRectangle")
        
        textImageGeneratorCIFilter = textImageGeneratorFilter
        affineTransformCIFilter = affineTransformFilter
        constantColorCIFilter = constantColorFilter
        constantCropCIFilter = constantCropFilter
        sourceOverCIFilter = sourceOverFilter
        falseColorCIFilter = falseColorFilter
        cropCIFilter = cropFilter
        
        currentCIFilter=cropFilter
        ciFilter=currentCIFilter
        
        return currentCIFilter


    }
    //ANCHISES
    override func getCIFilter(_ ciImage: CIImage) -> CIFilter {
        
        var currentCIFilter: CIFilter
        var textImageGeneratorFilter: CIFilter
        var affineTransformFilter: CIFilter
        var constantColorFilter: CIFilter
        var sourceOverFilter: CIFilter
        var falseColorFilter: CIFilter
        var constantCropFilter: CIFilter
        var cropFilter: CIFilter
        
        if ciFilter != nil {
            textImageGeneratorFilter = textImageGeneratorCIFilter!
            affineTransformFilter = affineTransformCIFilter!
            constantColorFilter = constantColorCIFilter!
            sourceOverFilter = sourceOverCIFilter!
            falseColorFilter = falseColorCIFilter!
            constantCropFilter = constantCropCIFilter!
            cropFilter = cropCIFilter!
        } else {
            constantColorFilter = CIFilter(name: "CIConstantColorGenerator")!
            affineTransformFilter = CIFilter(name: "CIAffineTransform")!
            sourceOverFilter = CIFilter(name: "CISourceOverCompositing")!
            cropFilter = CIFilter(name: "CICrop")!
            textImageGeneratorFilter = CIFilter(name: type)!
            falseColorFilter = CIFilter(name: "CIFalseColor")!
            constantCropFilter = CIFilter(name: "CICrop")!
       
        }
        
        let bcolor:CIColor = .white
        constantColorFilter.setValue(bcolor, forKey: kCIInputColorKey)
        
        constantCropFilter.setValue(constantColorFilter.outputImage!, forKey: kCIInputImageKey)
        let rect = CIVector(cgRect: CGRect(x:0, y: 0, width: CGFloat(size.width), height: CGFloat(size.height)))
        constantCropFilter.setValue(rect, forKey: "inputRectangle")
        
        let postscriptFontName=fontName//.replacingOccurrences(of: " ", with: "")
        //postscript voncersion cannot be the above alone.
        textImageGeneratorFilter.setValue(postscriptFontName, forKey: "inputFontName")
        textImageGeneratorFilter.setValue(fontSize, forKey: "inputFontSize")
        textImageGeneratorFilter.setValue(scaleFactor, forKey: "inputScaleFactor")
        
        //bug fix
        if text == "" {
            textImageGeneratorFilter.setValue("...", forKey: "inputText")
        }
        else if text.trimmingCharacters(in: .whitespaces) == "" ||
                text.trimmingCharacters(in: .newlines) == ""
        {
            textImageGeneratorFilter.setValue("...", forKey: "inputText")
        }
        else {
            textImageGeneratorFilter.setValue(text, forKey: "inputText")
        }
        
        var tigImage : CIImage
        if textImageGeneratorFilter.outputImage != nil
        {
            tigImage = textImageGeneratorFilter.outputImage!
        }
        else {
            tigImage = constantColorFilter.outputImage!
        }
        
        let transform=CGAffineTransform(a:1.0,b:0,c:0,d:1.0,tx:CGFloat(tx),ty:CGFloat(ty))
        affineTransformFilter.setValue(tigImage,forKey:kCIInputImageKey)
        affineTransformFilter.setValue(transform, forKey: kCIInputTransformKey)
        
        sourceOverFilter.setValue(affineTransformFilter.outputImage!, forKey: kCIInputImageKey)
        sourceOverFilter.setValue(constantCropFilter.outputImage!, forKey: kCIInputBackgroundImageKey)
        
        falseColorFilter.setValue(sourceOverFilter.outputImage!, forKey: kCIInputImageKey)
        falseColorFilter.setValue(color, forKey: "inputColor0")
        falseColorFilter.setValue(backgroundColor, forKey: "inputColor1")
        
        cropFilter.setValue(falseColorFilter.outputImage!, forKey: kCIInputImageKey)
        cropFilter.setValue(rect, forKey: "inputRectangle")
        
        textImageGeneratorCIFilter = textImageGeneratorFilter
        affineTransformCIFilter = affineTransformFilter
        constantColorCIFilter = constantColorFilter
        constantCropCIFilter = constantCropFilter
        sourceOverCIFilter = sourceOverFilter
        falseColorCIFilter = falseColorFilter
        cropCIFilter = cropFilter
        
        currentCIFilter=cropFilter
        ciFilter=currentCIFilter
        
        return currentCIFilter
    }
    
     
}
