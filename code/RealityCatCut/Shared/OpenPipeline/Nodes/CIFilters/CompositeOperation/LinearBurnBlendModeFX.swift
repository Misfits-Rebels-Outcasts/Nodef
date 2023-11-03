//
//  Copyright © 2022 James Boo. All rights reserved.
//

import SwiftUI

class LinearBurnBlendModeFX: BaseBlendFX {
       
    let description = "Darkens the background image (B) samples to reflect the source image (A) samples while also increasing contrast."
      
    
    override init()
    {
        let name = "CILinearBurnBlendMode"
        super.init(name)
        desc=description
        /*
        print(CIFilter.localizedName(forFilterName: name))
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
        desc=description

    }
    
    override func encode(to encoder: Encoder) throws {
        try super.encode(to: encoder)
    }
}
