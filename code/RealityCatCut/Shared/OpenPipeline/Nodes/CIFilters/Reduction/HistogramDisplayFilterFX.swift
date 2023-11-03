//
//  Copyright © 2022 James Boo. All rights reserved.
//


import SwiftUI

class HistogramDisplayFilterFX: FilterX {
       
    @Published var height:Float = 100.0
    @Published var highLimit:Float = 1.0
    @Published var lowLimit:Float = 0.0
    
    @Published var x:Float = 0.0
    @Published var y:Float = 0.0
    @Published var extentWidth:Float = 300
    @Published var extentHeight:Float = 300
    @Published var count:Float = 256
    @Published var scale:Float = 15

//    let description = "Generates a histogram image from the output of the CIAreaHistogram filter."
    let description = "Generates a histogram image. High Limit refers to the fraction of the right portion of the histogram image to make lighter. Low Limit refers to the fraction of the left portion of the histogram image to make darker. Count is the number of bins. If the scale is 1.0, then the bins in the resulting image will add up to 1.0."

    override init()
    {
        let name="CIHistogramDisplayFilter"
        super.init(name)
        desc=description
        /*
        print(CIFilter.localizedName(forFilterName: name))
        print(CIFilter.localizedDescription(forFilterName: name))
        print(CIFilter.localizedReferenceDocumentation(forFilterName: name))

        print("inputHeight")
        if let attribute = CIFilter.histogramDisplay().attributes["inputHeight"] as? [String: AnyObject]
        {
           let minimum = attribute[kCIAttributeSliderMin] as? Float
           let maximum = attribute[kCIAttributeSliderMax] as? Float
           let defaultValue = attribute[kCIAttributeDefault] as? Float
            
            print(minimum)
            print(maximum)
            print(defaultValue)
            
        }
        print("inputHighLimit")
        if let attribute = CIFilter.histogramDisplay().attributes["inputHighLimit"] as? [String: AnyObject]
        {
           let minimum = attribute[kCIAttributeSliderMin] as? Float
           let maximum = attribute[kCIAttributeSliderMax] as? Float
           let defaultValue = attribute[kCIAttributeDefault] as? Float
            
            print(minimum)
            print(maximum)
            print(defaultValue)
            
        }
        print("inputLowLimit")
        if let attribute = CIFilter.histogramDisplay().attributes["inputLowLimit"] as? [String: AnyObject]
        {
           let minimum = attribute[kCIAttributeSliderMin] as? Float
           let maximum = attribute[kCIAttributeSliderMax] as? Float
           let defaultValue = attribute[kCIAttributeDefault] as? Float
            
            print(minimum)
            print(maximum)
            print(defaultValue)
            
        }
        
        print("inputCount")
        if let attribute = CIFilter.areaHistogram().attributes["inputCount"] as? [String: AnyObject]
        {
           let minimum = attribute[kCIAttributeSliderMin] as? Float
           let maximum = attribute[kCIAttributeSliderMax] as? Float
           let defaultValue = attribute[kCIAttributeDefault] as? Float
            
            print(minimum)
            print(maximum)
            print(defaultValue)
            
        }
        
        print("inputScale")
        if let attribute = CIFilter.areaHistogram().attributes["inputScale"] as? [String: AnyObject]
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
        case height
        case highLimit
        case lowLimit
    }

    required init(from decoder: Decoder) throws {
        try super.init(from: decoder)
        let values = try decoder.container(keyedBy: CodingKeys.self)
        desc=description
        
        //revisit save load histogramarea
        height = try values.decodeIfPresent(Float.self, forKey: .height) ?? 0
        highLimit = try values.decodeIfPresent(Float.self, forKey: .highLimit) ?? 0
        lowLimit = try values.decodeIfPresent(Float.self, forKey: .lowLimit) ?? 0
        

    }
    
    override func encode(to encoder: Encoder) throws {
        try super.encode(to: encoder)
  
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(height, forKey: .height)
        try container.encode(highLimit, forKey: .highLimit)
        try container.encode(lowLimit, forKey: .lowLimit)

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
    
    var areaHistogramCIFilter: CIFilter?
    var histogramDisplayCIFilter: CIFilter?
    //deprecate
    override func getCIFilter(currentImage: CIImage, beginImage: CIImage) -> CIFilter? {
        
        var currentCIFilter: CIFilter
        var areaHistogramFilter: CIFilter
        var histogramDisplayFilter: CIFilter
        
        if ciFilter != nil {
            print("current Histogram Display")
            currentCIFilter = ciFilter!
            areaHistogramFilter = areaHistogramCIFilter!
            histogramDisplayFilter = histogramDisplayCIFilter!
        } else {
            print("new Histogram Display")
            currentCIFilter = CIFilter(name: "CIAffineTransform")!
            areaHistogramFilter = CIFilter(name: "CIAreaHistogram")!
            histogramDisplayFilter = CIFilter(name: type)!
        }
        
        let aliasImage=handleAlias(alias: inputImageAlias,
                                      inputImage: currentImage,
                                      beginImage: beginImage)
        
        areaHistogramFilter.setValue(aliasImage, forKey: kCIInputImageKey)
        let extent = CIVector(cgRect: CGRect(x: CGFloat(x), y: CGFloat(y), width: CGFloat(extentWidth), height: CGFloat(extentHeight)))
        areaHistogramFilter.setValue(extent, forKey: "inputExtent")
        areaHistogramFilter.setValue(count, forKey: "inputCount")
        areaHistogramFilter.setValue(scale, forKey: "inputScale")

        histogramDisplayFilter.setValue(areaHistogramFilter.outputImage!, forKey: kCIInputImageKey)
        histogramDisplayFilter.setValue(height, forKey: "inputHeight")
        histogramDisplayFilter.setValue(highLimit, forKey: "inputHighLimit")
        histogramDisplayFilter.setValue(lowLimit, forKey: "inputLowLimit")
                
        currentCIFilter.setValue(histogramDisplayFilter.outputImage!,forKey:kCIInputImageKey)
        
        let cow = histogramDisplayFilter.outputImage!.extent.width
        let coh = histogramDisplayFilter.outputImage!.extent.height
        let rx = cow <= 0 ? 1 : beginImage.extent.width / cow
        let ry = coh <= 0 ? 1 : beginImage.extent.height / coh
        let transform=CGAffineTransform(a:1.0*rx,b:0,c:0,d:1.0*ry,tx:0,ty:0)
        currentCIFilter.setValue(transform, forKey: kCIInputTransformKey)
        
        areaHistogramCIFilter = areaHistogramFilter
        histogramDisplayCIFilter = histogramDisplayFilter
        ciFilter = currentCIFilter
        
        return currentCIFilter
        
    }
    //ANCHISES
    override func getCIFilter(_ ciImage: CIImage) -> CIFilter {
        
        var currentCIFilter: CIFilter
        var areaHistogramFilter: CIFilter
        var histogramDisplayFilter: CIFilter
        
        if ciFilter != nil {
            print("current Histogram Display")
            currentCIFilter = ciFilter!
            areaHistogramFilter = areaHistogramCIFilter!
            histogramDisplayFilter = histogramDisplayCIFilter!
        } else {
            print("new Histogram Display")
            currentCIFilter = CIFilter(name: "CIAffineTransform")!
            areaHistogramFilter = CIFilter(name: "CIAreaHistogram")!
            histogramDisplayFilter = CIFilter(name: type)!
 
        }
        
    
        areaHistogramFilter.setValue(ciImage, forKey: kCIInputImageKey)
        let extent = CIVector(cgRect: CGRect(x: CGFloat(x), y: CGFloat(y), width: CGFloat(extentWidth), height: CGFloat(extentHeight)))
        areaHistogramFilter.setValue(extent, forKey: "inputExtent")
        areaHistogramFilter.setValue(count, forKey: "inputCount")
        areaHistogramFilter.setValue(scale, forKey: "inputScale")

        histogramDisplayFilter.setValue(areaHistogramFilter.outputImage!, forKey: kCIInputImageKey)
        histogramDisplayFilter.setValue(height, forKey: "inputHeight")
        histogramDisplayFilter.setValue(highLimit, forKey: "inputHighLimit")
        histogramDisplayFilter.setValue(lowLimit, forKey: "inputLowLimit")
                
        currentCIFilter.setValue(histogramDisplayFilter.outputImage!,forKey:kCIInputImageKey)
        
        let cow = histogramDisplayFilter.outputImage!.extent.width
        let coh = histogramDisplayFilter.outputImage!.extent.height
        //ANCHISES
        let rx = cow <= 0 ? 1 : size.width / cow
        let ry = coh <= 0 ? 1 : size.height / coh
        let transform=CGAffineTransform(a:1.0*rx,b:0,c:0,d:1.0*ry,tx:0,ty:0)
        currentCIFilter.setValue(transform, forKey: kCIInputTransformKey)
        
        areaHistogramCIFilter = areaHistogramFilter
        histogramDisplayCIFilter = histogramDisplayFilter
        ciFilter = currentCIFilter
        
        return currentCIFilter
        
    }
}
