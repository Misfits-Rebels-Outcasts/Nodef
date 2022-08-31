//
//  Copyright © 2022 James Boo. All rights reserved.
//

import SwiftUI

class ZoomBlurFX: FilterX {
    //changes to amount huge memory requirements
    
    @Published var centerX:CGFloat = 150
    @Published var centerY:CGFloat = 150
    @Published var amount:Float = 20.0
    let description = "Simulates the effect of zooming the camera while capturing the image. Larger Amount results in more zooming in."

    override init()
    {
        let name = "CIZoomBlur"
        super.init(name)
        desc=description
        
        print(CIFilter.localizedName(forFilterName: name))
        print(CIFilter.localizedDescription(forFilterName: name))
        print(CIFilter.localizedReferenceDocumentation(forFilterName: name))
                    
        if let attribute = CIFilter.zoomBlur().attributes["inputAmount"] as? [String: AnyObject]
        {
           let minimum = attribute[kCIAttributeSliderMin] as? Float
           let maximum = attribute[kCIAttributeSliderMax] as? Float
           let defaultValue = attribute[kCIAttributeDefault] as? Float
            
            print(minimum)
            print(maximum)
            print(defaultValue)
            
            //Optional(-1.0)
            //Optional(1.0)
            //Optional(0.0)
            
        }


         
    }

    enum CodingKeys : String, CodingKey {
        case centerX
        case centerY
        case amount
    }

    required init(from decoder: Decoder) throws {
        try super.init(from: decoder)
        let values = try decoder.container(keyedBy: CodingKeys.self)
        desc=description
        centerX = try values.decodeIfPresent(CGFloat.self, forKey: .centerX) ?? 0.0
        centerY = try values.decodeIfPresent(CGFloat.self, forKey: .centerY) ?? 0.0
        amount = try values.decodeIfPresent(Float.self, forKey: .amount) ?? 0.0
      
    }
    
    override func encode(to encoder: Encoder) throws {
        try super.encode(to: encoder)
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(centerX, forKey: .centerX)
        try container.encode(centerY, forKey: .centerY)
        try container.encode(amount, forKey: .amount)
    }
    
    override func setupProperties(_ parent: FiltersX?)
    {
        super.setupProperties(parent)
        
        if parent != nil{
            centerX=size.width/2.0
            centerY=size.height/2.0
        }
        
    }
    
    override func adjustPropertiesToBounds(_ parent: FiltersX?)
    {
        super.adjustPropertiesToBounds(parent)
        
        centerX = centerX > size.width ? size.width : centerX
        centerY = centerY > size.height ? size.height : centerY
        
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
        var tcenter=CIVector(x:centerX,y:centerY)
        currentCIFilter.setValue(tcenter, forKey: kCIInputCenterKey)
        currentCIFilter.setValue(amount, forKey: kCIInputAmountKey)
        return currentCIFilter
        
    }

}
