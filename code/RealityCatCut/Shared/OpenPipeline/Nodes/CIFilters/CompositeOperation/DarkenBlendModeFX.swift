//
//  Copyright © 2022 James Boo. All rights reserved.
//

import SwiftUI

class DarkenBlendModeFX: BaseBlendFX {
       
    let description = "Creates composite image samples by choosing the darker samples from either the source image (A) or the background (B)."
    override init()
    {
        let name = "CIDarkenBlendMode"
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
