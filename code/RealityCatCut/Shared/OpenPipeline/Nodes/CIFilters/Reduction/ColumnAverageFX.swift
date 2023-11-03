//
//  Copyright © 2022 James Boo. All rights reserved.
//


import SwiftUI

class ColumnAverageFX: FilterX {
       
    @Published var x:Float = 0.0
    @Published var y:Float = 0.0
    @Published var extentWidth:Float = 300.0
    @Published var extentHeight:Float = 300.0
    
    //let description = "Returns a 1-pixel high image that contains the average color for each scan column."
    let description = "Returns an image that contains the average color for each scan column."

    override init()
    {
        let name="CIColumnAverage"
        super.init(name)
        desc=description
        /*
        print(CIFilter.localizedName(forFilterName: name))
        print(CIFilter.localizedDescription(forFilterName: name))
        print(CIFilter.localizedReferenceDocumentation(forFilterName: name))
          */
    }

    enum CodingKeys : String, CodingKey {
        case x
        case y
        case extentWidth
        case extentHeight
    }

    required init(from decoder: Decoder) throws {
        try super.init(from: decoder)
        let values = try decoder.container(keyedBy: CodingKeys.self)
        desc=description
        
        x = try values.decodeIfPresent(Float.self, forKey: .x) ?? 0
        y = try values.decodeIfPresent(Float.self, forKey: .y) ?? 0
        extentWidth = try values.decodeIfPresent(Float.self, forKey: .extentWidth) ?? 0
        extentHeight = try values.decodeIfPresent(Float.self, forKey: .extentHeight) ?? 0
        

    }
    
    override func encode(to encoder: Encoder) throws {
        try super.encode(to: encoder)
  
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(x, forKey: .x)
        try container.encode(y, forKey: .y)
        try container.encode(extentWidth, forKey: .extentWidth)
        try container.encode(extentHeight, forKey: .extentHeight)

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
    
    var columnAverageCIFilter: CIFilter?
    //deprecate
    override func getCIFilter(currentImage: CIImage, beginImage: CIImage) -> CIFilter? {
        
        var currentCIFilter: CIFilter
        var columnAverageFilter: CIFilter
        
        if ciFilter != nil {
            print("current Column Average")
            currentCIFilter = ciFilter!
            columnAverageFilter = columnAverageCIFilter!
        } else {
            print("new Column Average")
            columnAverageFilter = CIFilter(name: type)!
            currentCIFilter = CIFilter(name: "CIAffineTransform")!
        }
        
        let aliasImage=handleAlias(alias: inputImageAlias,
                                      inputImage: currentImage,
                                      beginImage: beginImage)
        
        columnAverageFilter.setValue(aliasImage, forKey: kCIInputImageKey)
        let extent = CIVector(cgRect: CGRect(x: CGFloat(x), y: CGFloat(y), width: CGFloat(extentWidth), height: CGFloat(extentHeight)))
        columnAverageFilter.setValue(extent, forKey: "inputExtent")
        
        currentCIFilter.setValue(columnAverageFilter.outputImage!, forKey: kCIInputImageKey)
        let transform=CGAffineTransform(a:CGFloat(1),b:0,c:0,d:CGFloat(beginImage.extent.height),tx:0,ty:0)
        currentCIFilter.setValue(transform, forKey: kCIInputTransformKey)
        
        ciFilter=currentCIFilter
        columnAverageCIFilter=columnAverageFilter
        
        return currentCIFilter
        
    }
    //ANCHISES
    override func getCIFilter(_ ciImage: CIImage) -> CIFilter {
        var currentCIFilter: CIFilter
        var columnAverageFilter: CIFilter
        
        if ciFilter != nil {
            currentCIFilter = ciFilter!
            columnAverageFilter = columnAverageCIFilter!
        } else {
            columnAverageFilter = CIFilter(name: type)!
            currentCIFilter = CIFilter(name: "CIAffineTransform")!
   
        }
        
        columnAverageFilter.setValue(ciImage, forKey: kCIInputImageKey)
        let extent = CIVector(cgRect: CGRect(x: CGFloat(x), y: CGFloat(y), width: CGFloat(extentWidth), height: CGFloat(extentHeight)))
        columnAverageFilter.setValue(extent, forKey: "inputExtent")
        
        currentCIFilter.setValue(columnAverageFilter.outputImage!, forKey: kCIInputImageKey)
        //ANCHISES
        //let transform=CGAffineTransform(a:CGFloat(1),b:0,c:0,d:CGFloat(beginImage.extent.height),tx:0,ty:0)
        let transform=CGAffineTransform(a:CGFloat(1),b:0,c:0,d:CGFloat(size.height),tx:0,ty:0)
        currentCIFilter.setValue(transform, forKey: kCIInputTransformKey)
        
        ciFilter=currentCIFilter
        columnAverageCIFilter=columnAverageFilter
        
        return currentCIFilter
    }
}
