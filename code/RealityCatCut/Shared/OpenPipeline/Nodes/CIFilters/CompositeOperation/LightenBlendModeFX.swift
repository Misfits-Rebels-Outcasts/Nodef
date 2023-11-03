//
//  Copyright © 2022 James Boo. All rights reserved.
//

import SwiftUI

class LightenBlendModeFX: BaseBlendFX {
       
    let description = "Creates composite image samples by choosing the lighter samples from the source image (A) or the background (B). The result is that the background image samples are replaced by any source image samples that are lighter."
    override init()
    {
        let name = "CILightenBlendMode"
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
