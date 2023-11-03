//
//  Copyright © 2022 James Boo. All rights reserved.
//

import SwiftUI

class LuminosityBlendModeFX: BaseBlendFX {
       
    let description = "Uses the hue and saturation of the background image (B) with the luminance of the input image (A)."
    
    override init()
    {
        let name = "CILuminosityBlendMode"
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
