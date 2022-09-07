//
//  Copyright © 2022 James Boo. All rights reserved.
//


import SwiftUI

class CropFX: FilterX {
       
    @Published var x:Float = 0.0
    @Published var y:Float = 0.0
    @Published var cropWidth:Float = 300.0
    @Published var cropHeight:Float = 300.0
    
    let description = "Applies a crop to an image."

    override init()
    {
        let name="CICrop"
        super.init(name)
        desc=description
        
        print(CIFilter.localizedName(forFilterName: name))
        print(CIFilter.localizedDescription(forFilterName: name))
        print(CIFilter.localizedReferenceDocumentation(forFilterName: name))
        
    }

    enum CodingKeys : String, CodingKey {
        case x
        case y
        case cropWidth
        case cropHeight
    }

    required init(from decoder: Decoder) throws {
        try super.init(from: decoder)
        let values = try decoder.container(keyedBy: CodingKeys.self)
        desc=description
        
        x = try values.decodeIfPresent(Float.self, forKey: .x) ?? 0
        y = try values.decodeIfPresent(Float.self, forKey: .y) ?? 0
        cropWidth = try values.decodeIfPresent(Float.self, forKey: .cropWidth) ?? 0
        cropHeight = try values.decodeIfPresent(Float.self, forKey: .cropHeight) ?? 0

    }
    
    override func encode(to encoder: Encoder) throws {
        try super.encode(to: encoder)
  
        var container = encoder.container(keyedBy: CodingKeys.self)

        try container.encode(x, forKey: .x)
        try container.encode(y, forKey: .y)
        try container.encode(cropWidth, forKey: .cropWidth)
        try container.encode(cropHeight, forKey: .cropHeight)


    }
    
    override func setupProperties(_ parent: FiltersX?)
    {
        super.setupProperties(parent)
        
        if parent != nil{
            x=Float(size.width/3.0)
            y=Float(size.height/3.0)
            
            cropWidth=Float(size.width/3.0)
            cropHeight=Float(size.height/3.0)

        }
        
    }
    
    override func adjustPropertiesToBounds(_ parent: FiltersX?)
    {
        super.adjustPropertiesToBounds(parent)
        
        x = x > Float(size.width) ? Float(size.width) : x
        y = y > Float(size.height) ? Float(size.height) : y
        
        cropWidth = cropWidth > Float(size.width) ? Float(size.width) : cropWidth
        cropHeight = cropHeight > Float(size.height) ? Float(size.height) : cropHeight
        
    }
    
    override func getCIFilter(_ ciImage: CIImage)->CIFilter
    {
        
        var currentCIFilter: CIFilter
        if ciFilter != nil {
            currentCIFilter = ciFilter!
        } else {
            currentCIFilter = CIFilter(name: type)!
            ciFilter=currentCIFilter
        }
        currentCIFilter.setValue(ciImage, forKey: kCIInputImageKey)
        let rect = CIVector(cgRect: CGRect(x: CGFloat(x), y: CGFloat(y), width: CGFloat(cropWidth), height: CGFloat(cropHeight)))
        currentCIFilter.setValue(rect, forKey: "inputRectangle")
     
        return currentCIFilter
        
    }

}
