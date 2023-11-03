//
//  Copyright © 2022 James Boo. All rights reserved.
//

import SwiftUI

class DissolveTransitionFX: BaseTransitionFX {
       
    
    let description = "Uses a dissolve to transition from one image (A) to another (B)."

    override init()
    {
        let name="CIDissolveTransition"
        super.init(name)
        desc=description
        time=0.5
        
        /*
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
        _ = try decoder.container(keyedBy: CodingKeys.self)
        desc=description

    }
    
    override func encode(to encoder: Encoder) throws {
        try super.encode(to: encoder)
        _ = encoder.container(keyedBy: CodingKeys.self)

    }

}
