//
//  Copyright © 2022 James Boo. All rights reserved.
//

import SwiftUI

class ColorBlendModeFX: BaseBlendFX {
       
    let description = "Uses the luminance values of the background with the hue and saturation values of the source image. This mode preserves the gray levels in the image."
    override init()
    {
        let name = "CIColorBlendMode"
        super.init(name)
        desc=description
        
        print(CIFilter.localizedName(forFilterName: name))
        print(CIFilter.localizedName(forFilterName: name))
        print(CIFilter.localizedDescription(forFilterName: name))
        print(CIFilter.localizedReferenceDocumentation(forFilterName: name))

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
