//
//  Copyright © 2022 James Boo. All rights reserved.
//

import SwiftUI

class PinLightBlendModeFX: BaseBlendFX {
       
    let description = "Conditionally replaces background image (B) samples with source image (A) samples depending on the brightness of the source image samples."
    override init()
    {
        let name = "CIPinLightBlendMode"
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
