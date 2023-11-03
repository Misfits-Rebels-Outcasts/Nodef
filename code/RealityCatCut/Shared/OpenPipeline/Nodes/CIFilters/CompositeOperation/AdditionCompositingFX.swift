//
//  Copyright © 2022 James Boo. All rights reserved.
//
import SwiftUI

class AdditionCompositingFX: BaseBlendFX {
       
    let description = "Adds color components to achieve a brightening effect. This filter is typically used to add highlights and lens flare effects. The formula used to create this filter is described in Thomas Porter and Tom Duff. 1984."
    override init()
    {
        let name = "CIAdditionCompositing"
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
