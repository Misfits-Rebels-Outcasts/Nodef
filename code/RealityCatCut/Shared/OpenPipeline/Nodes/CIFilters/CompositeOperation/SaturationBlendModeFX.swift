//
//  Copyright © 2022 James Boo. All rights reserved.
//

import SwiftUI

class SaturationBlendModeFX: BaseBlendFX {
       
    let description = "Uses the luminance and hue values of the background image (B) with the saturation of the input image (A). Areas of the background that have no saturation (that is, pure gray areas) do not produce a change."
    override init()
    {
        let name = "CISaturationBlendMode"
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
