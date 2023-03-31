//
//  Copyright © 2022 James Boo. All rights reserved.
//

import SwiftUI

class StretchCropFX: FilterX {
       
    //@Published var x:Float = 0.0
    //@Published var y:Float = 0.0
    @Published var cropWidth:Float = 300.0
    @Published var cropHeight:Float = 300.0
    
    @Published var cropAmount:Float = 0.25
    @Published var centerStretchAmount:Float = 0.25
    //let description = "Distorts an image by stretching and or cropping it to fit a target size."

    let description = "Distorts an image by stretching and or cropping it to fit a target size. Center Stretch Amount determines how much the center of the image is stretched. If value is 0 then the center of the image maintains the original aspect ratio. If 1 then the image is stretched uniformly. Crop Amount determines if and how much cropping should be used to achieve the target size. If value is 0 then only stretching is used. If 1 then only cropping is used."

    override init()
    {
        let name="CIStretchCrop"
        super.init(name)
        desc=description
        
        print(CIFilter.localizedName(forFilterName: name))
        print(CIFilter.localizedDescription(forFilterName: name))
        print(CIFilter.localizedReferenceDocumentation(forFilterName: name))
                    
        print("inputCropAmount")
        if let attribute = CIFilter.stretchCrop().attributes["inputCropAmount"] as? [String: AnyObject]
        {
           let minimum = attribute[kCIAttributeSliderMin] as? Float
           let maximum = attribute[kCIAttributeSliderMax] as? Float
           let defaultValue = attribute[kCIAttributeDefault] as? Float
            
            print(minimum)
            print(maximum)
            print(defaultValue)
            
        }
        
        print("inputCenterStretchAmount")
        if let attribute = CIFilter.stretchCrop().attributes["inputCenterStretchAmount"] as? [String: AnyObject]
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
        //case x
        //case y
        case cropWidth
        case cropHeight
        case cropAmount
        case centerStretchAmount
    }

    required init(from decoder: Decoder) throws {
        try super.init(from: decoder)
        let values = try decoder.container(keyedBy: CodingKeys.self)
        desc=description
        
        //x = try values.decodeIfPresent(Float.self, forKey: .x) ?? 0
        //y = try values.decodeIfPresent(Float.self, forKey: .y) ?? 0
        cropWidth = try values.decodeIfPresent(Float.self, forKey: .cropWidth) ?? 0
        cropHeight = try values.decodeIfPresent(Float.self, forKey: .cropHeight) ?? 0
        
        cropAmount = try values.decodeIfPresent(Float.self, forKey: .cropAmount) ?? 0.0
        centerStretchAmount = try values.decodeIfPresent(Float.self, forKey: .centerStretchAmount) ?? 0.0

    }
    
    override func encode(to encoder: Encoder) throws {
        try super.encode(to: encoder)
  
        var container = encoder.container(keyedBy: CodingKeys.self)
        //try container.encode(x, forKey: .x)
        //try container.encode(y, forKey: .y)
        try container.encode(cropWidth, forKey: .cropWidth)
        try container.encode(cropHeight, forKey: .cropHeight)
        try container.encode(cropAmount, forKey: .cropAmount)
        try container.encode(centerStretchAmount, forKey: .centerStretchAmount)

    }
    
    override func setupProperties(_ parent: FiltersX?)
    {
        super.setupProperties(parent)
        
        if parent != nil{
            cropWidth=Float(size.width/2.0)
            cropHeight=Float(size.height/2.0)
        }
        
    }
    
    override func adjustPropertiesToBounds(_ parent: FiltersX?)
    {
        super.adjustPropertiesToBounds(parent)
        
        cropWidth = cropWidth > Float(size.width) ? Float(size.width) : cropWidth
        cropHeight = cropHeight > Float(size.height) ? Float(size.height) : cropHeight
        
    }
    
    
    override func getCIFilter(_ ciImage: CIImage)->CIFilter
    {
        let currentCIFilter = CIFilter(name: type)!
        currentCIFilter.setValue(ciImage, forKey: kCIInputImageKey)
        
        //let rect = CIVector(cgRect: CGRect(x: CGFloat(x), y: CGFloat(y), width: CGFloat(cropWidth), height: CGFloat(cropHeight)))
        var floatArr: [CGFloat] = []
        floatArr.append(CGFloat(cropWidth))
        floatArr.append(CGFloat(cropHeight))
        let vector = CIVector(values: floatArr, count: floatArr.count)
        
        //let rect = CIVector(width: CGFloat(cropWidth), height: CGFloat(cropHeight))
        currentCIFilter.setValue(vector, forKey: "inputSize")
     
        currentCIFilter.setValue(cropAmount, forKey: "inputCropAmount")
        currentCIFilter.setValue(centerStretchAmount, forKey: "inputCenterStretchAmount")
        ciFilter=currentCIFilter

        return currentCIFilter
    }

}
