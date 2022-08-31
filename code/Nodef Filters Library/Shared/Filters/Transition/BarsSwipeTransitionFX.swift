//
//  Copyright © 2022 James Boo. All rights reserved.
//

import SwiftUI

class BarsSwipeTransitionFX: BaseTransitionFX {
       
    @Published var angle:Float = 0.0//3.14
    @Published var width:Float = 0.0//30.0
    @Published var barOffset:Float = 10.0
    
    let description = "Transitions from one image to another by passing a bar over the source image. Angle is the angle of the bars. Bar Offset is the offset of one bar with respect to another."

    override init()
    {
        let name="CIBarsSwipeTransition"
        super.init(name)
        desc=description
        
        time=0.5
        print(CIFilter.localizedName(forFilterName: name))
        print(CIFilter.localizedDescription(forFilterName: name))
        print(CIFilter.localizedReferenceDocumentation(forFilterName: name))
        
        print("inputAngle")
        if let attribute = CIFilter.barsSwipeTransition().attributes["inputAngle"] as? [String: AnyObject]
        {
           let minimum = attribute[kCIAttributeSliderMin] as? Float
           let maximum = attribute[kCIAttributeSliderMax] as? Float
           let defaultValue = attribute[kCIAttributeDefault] as? Float
            
            print(minimum)
            print(maximum)
            print(defaultValue)
            
        }
        print("inputWidth")
        if let attribute = CIFilter.barsSwipeTransition().attributes["inputWidth"] as? [String: AnyObject]
        {
           let minimum = attribute[kCIAttributeSliderMin] as? Float
           let maximum = attribute[kCIAttributeSliderMax] as? Float
           let defaultValue = attribute[kCIAttributeDefault] as? Float
            
            print(minimum)
            print(maximum)
            print(defaultValue)
            
        }
        print("inputBarOffset")
        if let attribute = CIFilter.barsSwipeTransition().attributes["inputBarOffset"] as? [String: AnyObject]
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
        case angle
        case width
        case barOffset
    }

    required init(from decoder: Decoder) throws {
        try super.init(from: decoder)
        let values = try decoder.container(keyedBy: CodingKeys.self)
        desc=description
        
        angle = try values.decodeIfPresent(Float.self, forKey: .angle) ?? 0
        width = try values.decodeIfPresent(Float.self, forKey: .width) ?? 0
        barOffset = try values.decodeIfPresent(Float.self, forKey: .barOffset) ?? 0

    }
    
    override func encode(to encoder: Encoder) throws {
        try super.encode(to: encoder)
  
        var container = encoder.container(keyedBy: CodingKeys.self)

        try container.encode(angle, forKey: .angle)
        try container.encode(width, forKey: .width)
        try container.encode(barOffset, forKey: .barOffset)


    }
    
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
   
        print("BarsSwipe FX")
        currentCIFilter.setValue(inputImage, forKey: kCIInputImageKey)
        currentCIFilter.setValue(targetImage, forKey: kCIInputTargetImageKey)
        currentCIFilter.setValue(angle, forKey: kCIInputAngleKey)
        currentCIFilter.setValue(width, forKey: kCIInputWidthKey)
        currentCIFilter.setValue(barOffset, forKey: "inputBarOffset")
        currentCIFilter.setValue(time, forKey: kCIInputTimeKey)
        return currentCIFilter
         

    }

}
