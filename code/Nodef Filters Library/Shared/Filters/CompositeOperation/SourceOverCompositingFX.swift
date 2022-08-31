//
//  Copyright © 2022 James Boo. All rights reserved.
//

import SwiftUI

class SourceOverCompositingFX: BaseBlendFX {
       
    let description = "Places the input image over the input background image."
    override init()
    {
        let name = "CISourceOverCompositing"
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
