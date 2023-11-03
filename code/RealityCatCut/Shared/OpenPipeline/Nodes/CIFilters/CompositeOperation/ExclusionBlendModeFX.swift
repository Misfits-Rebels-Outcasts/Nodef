//
//  Copyright © 2022 James Boo. All rights reserved.
//

import SwiftUI

class ExclusionBlendModeFX: BaseBlendFX {
       
    let description = "Produces an effect similar to that produced by the Difference Blend Mode filter but with lower contrast. The Difference Blend Mode subtracts either the source image (A) sample color from the background image (B) sample color, or the reverse, depending on which sample has the greater brightness value. Source image sample values that are black produce no change; white inverts the background color values. "
    override init()
    {
        let name = "CIExclusionBlendMode"
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
