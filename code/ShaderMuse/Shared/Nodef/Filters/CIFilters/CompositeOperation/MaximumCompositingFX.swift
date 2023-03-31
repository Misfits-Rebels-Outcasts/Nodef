//
//  Copyright © 2022 James Boo. All rights reserved.
//

import SwiftUI

class MaximumCompositingFX: BaseBlendFX {
       
    let description = "Computes the maximum value, by color component, of two input images and creates an output image using the maximum values."
    override init()
    {
        let name = "CIMaximumCompositing"
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
