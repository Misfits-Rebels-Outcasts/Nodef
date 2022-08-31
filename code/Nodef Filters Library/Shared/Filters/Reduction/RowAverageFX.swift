//
//  Copyright © 2022 James Boo. All rights reserved.
//

import SwiftUI

class RowAverageFX: FilterX {
       
    @Published var x:Float = 0.0
    @Published var y:Float = 0.0
    @Published var extentWidth:Float = 300.0
    @Published var extentHeight:Float = 300.0
    
    //let description = "Returns a 1-pixel high image that contains the average color for each scan row."
    let description = "Returns an image that contains the average color for each scan row."

    override init()
    {
        let name="CIRowAverage"
        super.init(name)
        desc=description
        
        print(CIFilter.localizedName(forFilterName: name))
        print(CIFilter.localizedDescription(forFilterName: name))
        print(CIFilter.localizedReferenceDocumentation(forFilterName: name))
                
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
    
    var rowAverageCIFilter: CIFilter?
    var t1CIFilter: CIFilter?
    var t2CIFilter: CIFilter?

    override func getCIFilter(currentImage: CIImage, beginImage: CIImage) -> CIFilter? {
        
        var currentCIFilter: CIFilter
        var rowAverageFilter: CIFilter
        var t1Filter: CIFilter
        var t2Filter: CIFilter

        if ciFilter != nil {
            print("current Area Average")
            currentCIFilter = ciFilter!
            rowAverageFilter = rowAverageCIFilter!
            t1Filter = t1CIFilter!
            t2Filter = t2CIFilter!
        } else {
            print("new Area Average")
            rowAverageFilter = CIFilter(name: type)!
            t1Filter = CIFilter(name: "CIAffineTransform")!
            t2Filter = CIFilter(name: "CIAffineTransform")!
            currentCIFilter = CIFilter(name: "CIAffineTransform")!
        }
        
        let aliasImage=handleAlias(alias: inputImageAlias,
                                      inputImage: currentImage,
                                      beginImage: beginImage)
        
        rowAverageFilter.setValue(aliasImage, forKey: kCIInputImageKey)
        let extent = CIVector(cgRect: CGRect(x: CGFloat(x), y: CGFloat(y), width: CGFloat(extentWidth), height: CGFloat(extentHeight)))
        rowAverageFilter.setValue(extent, forKey: "inputExtent")

        t1Filter.setValue(rowAverageFilter.outputImage!,forKey:kCIInputImageKey)
        //+10 othersize sometime after all the transform miss 1 or 2 pixels
        //the image will look bright on one side
        var transform=CGAffineTransform(a:CGFloat(1.0),b:0,c:0,d:CGFloat(beginImage.extent.width+10),tx:0,ty:0)
        t1Filter.setValue(transform, forKey: kCIInputTransformKey)
       
      
        t2Filter.setValue(t1Filter.outputImage!, forKey: kCIInputImageKey)
        transform=CGAffineTransform(a:CGFloat(1.0),b:0,c:0,d:CGFloat(1.0),tx:0,ty:CGFloat(0-beginImage.extent.width))
        t2Filter.setValue(transform, forKey: kCIInputTransformKey)
    
        //transform = CGAffineTransform.identity
        currentCIFilter = CIFilter(name: "CIAffineTransform")!
        currentCIFilter.setValue(t2Filter.outputImage!, forKey: kCIInputImageKey)
        let rotateTransform=CGAffineTransform(rotationAngle: 3.14/2)
        currentCIFilter.setValue(rotateTransform, forKey: kCIInputTransformKey)
        
        ciFilter=currentCIFilter
        rowAverageCIFilter=rowAverageFilter
        t1CIFilter=t1Filter
        t2CIFilter=t2Filter

        return currentCIFilter
        
    }

}
