//
//  Copyright © 2022 James Boo. All rights reserved.
//

import SwiftUI

class AreaAverageFX: FilterX {
       
    @Published var x:Float = 0.0
    @Published var y:Float = 0.0
    @Published var extentWidth:Float = 300.0
    @Published var extentHeight:Float = 300.0
    
    //let description = "Returns a single-pixel image that contains the average color for the region of interest."
    let description = "Returns an image that contains the average color for the region of interest."

    override init()
    {
        let name="CIAreaAverage"
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
    
    override func encode(to encoder: Encoder) throws {
        try super.encode(to: encoder)
  
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(x, forKey: .x)
        try container.encode(y, forKey: .y)
        try container.encode(extentWidth, forKey: .extentWidth)
        try container.encode(extentHeight, forKey: .extentHeight)

    }
    
    var areaAverageCIFilter: CIFilter?
    //deprecate
    override func getCIFilter(currentImage: CIImage, beginImage: CIImage) -> CIFilter? {
        
        var currentCIFilter: CIFilter
        var areaAverageFilter: CIFilter
        
        if ciFilter != nil {
            //print("current Area Average")
            currentCIFilter = ciFilter!
            areaAverageFilter = areaAverageCIFilter!
        } else {
            //print("new Area Average")
            areaAverageFilter = CIFilter(name: type)!
            currentCIFilter = CIFilter(name: "CIConstantColorGenerator")!
        }
        
        let aliasImage=handleAlias(alias: inputImageAlias,
                                      inputImage: currentImage,
                                      beginImage: beginImage)
        
        areaAverageFilter.setValue(aliasImage, forKey: kCIInputImageKey)
        let extent = CIVector(cgRect: CGRect(x: CGFloat(x), y: CGFloat(y), width: CGFloat(extentWidth), height: CGFloat(extentHeight)))
        areaAverageFilter.setValue(extent, forKey: "inputExtent")
        
        var ciColor: CIColor = .black
        if let parentUw = parent{
            var bitmap = [UInt8](repeating: 0, count: 4)
            //ANCHISES
            parentUw.getContext().render(areaAverageFilter.outputImage!, toBitmap: &bitmap, rowBytes: 4, bounds: CGRect(x: 0, y: 0, width: 1, height: 1), format: .RGBA8, colorSpace: nil)
            let ucolor = UIColor(red: CGFloat(bitmap[0]) / 255, green: CGFloat(bitmap[1]) / 255, blue: CGFloat(bitmap[2]) / 255, alpha: (CGFloat(bitmap[3]) / 255))

            ciColor = CIColor(color: ucolor)
        }
        currentCIFilter.setValue(ciColor, forKey: kCIInputColorKey)
        ciFilter = currentCIFilter
        areaAverageCIFilter = areaAverageFilter
        
        return currentCIFilter
        
    }
    
    //ANCHISES
    override func getCIFilter(_ ciImage: CIImage) -> CIFilter {
        
        var currentCIFilter: CIFilter
        var areaAverageFilter: CIFilter
        
        if ciFilter != nil {
            currentCIFilter = ciFilter!
            areaAverageFilter = areaAverageCIFilter!
        } else {
            areaAverageFilter = CIFilter(name: type)!
            currentCIFilter = CIFilter(name: "CIConstantColorGenerator")!
   
        }
    
        areaAverageFilter.setValue(ciImage, forKey: kCIInputImageKey)
        let extent = CIVector(cgRect: CGRect(x: CGFloat(x), y: CGFloat(y), width: CGFloat(extentWidth), height: CGFloat(extentHeight)))
        areaAverageFilter.setValue(extent, forKey: "inputExtent")
        
        var ciColor: CIColor = .black
        if let parentUw = parent{
            var bitmap = [UInt8](repeating: 0, count: 4)
            parentUw.getContext().render(areaAverageFilter.outputImage!, toBitmap: &bitmap, rowBytes: 4, bounds: CGRect(x: 0, y: 0, width: 1, height: 1), format: .RGBA8, colorSpace: nil)
            let ucolor = UIColor(red: CGFloat(bitmap[0]) / 255, green: CGFloat(bitmap[1]) / 255, blue: CGFloat(bitmap[2]) / 255, alpha: (CGFloat(bitmap[3]) / 255))

            ciColor = CIColor(color: ucolor)
        }
        currentCIFilter.setValue(ciColor, forKey: kCIInputColorKey)
        ciFilter = currentCIFilter
        areaAverageCIFilter = areaAverageFilter
        
        return currentCIFilter
        
    }

}
