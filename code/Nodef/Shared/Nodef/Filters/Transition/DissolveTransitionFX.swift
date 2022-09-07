//
//  Copyright © 2022 James Boo. All rights reserved.
//

import SwiftUI

class DissolveTransitionFX: BaseTransitionFX {
       
    
    let description = "Uses a dissolve to transition from one image to another."

    override init()
    {
        let name="CIDissolveTransition"
        super.init(name)
        desc=description
        time=0.5
        
        print(CIFilter.localizedName(forFilterName: name))
        print(CIFilter.localizedDescription(forFilterName: name))
        print(CIFilter.localizedReferenceDocumentation(forFilterName: name))
        
    }

    enum CodingKeys : String, CodingKey {
        case None

    }

    required init(from decoder: Decoder) throws {
        try super.init(from: decoder)
        let values = try decoder.container(keyedBy: CodingKeys.self)
        desc=description

    }
    
    override func encode(to encoder: Encoder) throws {
        try super.encode(to: encoder)
        var container = encoder.container(keyedBy: CodingKeys.self)

    }

}
