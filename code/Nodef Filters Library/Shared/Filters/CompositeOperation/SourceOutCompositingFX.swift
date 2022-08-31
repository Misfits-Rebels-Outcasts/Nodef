//
//  Copyright © 2022 James Boo. All rights reserved.
//

import SwiftUI

class SourceOutCompositingFX: BaseBlendFX {
       
    let description = "Uses the background image to define what to take out of the input image."
    override init()
    {
        let name = "CISourceOutCompositing"
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
