//
//  Copyright © 2022 James Boo. All rights reserved.
//

import SwiftUI

class SourceAtopCompositingFX: BaseBlendFX {
       
    let description = "Places the input image (A) over the background image (B), then uses the luminance of the background image to determine what to show. The composite shows the background image and only those portions of the source image that are over visible parts of the background. "
    override init()
    {
        let name = "CISourceAtopCompositing"
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
