//
//  Copyright © 2022 James Boo. All rights reserved.
//

import SwiftUI

class ComicEffectFX: FilterX {
    
    let description = "Simulates a comic book drawing by outlining edges and applying a color halftone effect."

    override init()
    {
        let name="CIComicEffect"
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
  
        _ = encoder.container(keyedBy: CodingKeys.self)


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

        return currentCIFilter
        
    }

}
