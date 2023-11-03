//
//  Copyright © 2022 James Boo. All rights reserved.
//

import SwiftUI

class RotateFX: FilterX {

    @Published var angle:Float = 3.14/4.0
    
    let description = "Rotate an image with the specified angle."

    override init()
    {
        let name="CIRotate"
        super.init(name)
        desc=description
        /*
        print(CIFilter.localizedName(forFilterName: name))
        print(CIFilter.localizedDescription(forFilterName: name))
        print(CIFilter.localizedReferenceDocumentation(forFilterName: name))
        */
    }

    enum CodingKeys : String, CodingKey {
        case angle
    }

    required init(from decoder: Decoder) throws {
        try super.init(from: decoder)
        let values = try decoder.container(keyedBy: CodingKeys.self)
        desc=description
        
        angle = try values.decodeIfPresent(Float.self, forKey: .angle) ?? 0

    }
    
    override func encode(to encoder: Encoder) throws {
        try super.encode(to: encoder)
  
        var container = encoder.container(keyedBy: CodingKeys.self)

        try container.encode(angle, forKey: .angle)

    }
    

    override func getCIFilter(_ ciImage: CIImage)->CIFilter
    {
        
        var currentCIFilter: CIFilter
        if ciFilter != nil {
            currentCIFilter = ciFilter!
        } else {
            currentCIFilter = CIFilter(name: "CIAffineTransform")!
            ciFilter=currentCIFilter
        }
        currentCIFilter.setValue(ciImage, forKey: kCIInputImageKey)
                
        let transform=CGAffineTransform(rotationAngle: CGFloat(angle))
        currentCIFilter.setValue(transform, forKey: kCIInputTransformKey)

        return currentCIFilter
        
    }

}
