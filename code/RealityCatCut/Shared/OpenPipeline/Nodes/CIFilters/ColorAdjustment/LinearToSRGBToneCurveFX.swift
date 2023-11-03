//
//  Copyright © 2022 James Boo. All rights reserved.
//

import SwiftUI

class LinearToSRGBToneCurveFX: FilterX {
       

    let description = "Maps color intensity from a linear gamma curve to the sRGB color space."

    override init()
    {
        let name = "CILinearToSRGBToneCurve"
        super.init(name)
        desc=description
      
        /*
        print(CIFilter.localizedName(forFilterName: name))
        print(CIFilter.localizedDescription(forFilterName: name))
        print(CIFilter.localizedReferenceDocumentation(forFilterName: name))
         */
    }

    enum CodingKeys : String, CodingKey {
        case None



    }

    required init(from decoder: Decoder) throws {
        try super.init(from: decoder)
        _ = try decoder.container(keyedBy: CodingKeys.self)
        desc=description


        
    }
    
    override func encode(to encoder: Encoder) throws {
        try super.encode(to: encoder)
        //var container = encoder.container(keyedBy: CodingKeys.self)
        


    }
    /*
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
        
        let minvector=CIVector(x:minx,y:miny,z:minz,w:minw)
        currentCIFilter.setValue(minvector, forKey: "inputMinComponents")

        let maxvector=CIVector(x:maxx,y:maxy,z:maxz,w:maxw)
        currentCIFilter.setValue(maxvector, forKey: "inputMaxComponents")

        return currentCIFilter
    }
     */
}
