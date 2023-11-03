//
//  Copyright © 2022 James Boo. All rights reserved.
//

import SwiftUI

class ColorInvertFX: FilterX {
    let description = "Inverts the colors in an image."

    override init()
    {
        super.init("CIColorInvert")
        desc=description
        /*
        print(CIFilter.localizedName(forFilterName: "CIColorInvert"))
        print(CIFilter.localizedDescription(forFilterName: "CIColorInvert"))
        print(CIFilter.localizedReferenceDocumentation(forFilterName: "CIColorInvert"))
         */
    }

    enum CodingKeys : String, CodingKey {
        case None
    }

    required init(from decoder: Decoder) throws {
        try super.init(from: decoder)
        desc=description

        //let values = try decoder.container(keyedBy: CodingKeys.self)

    }
    
    override func encode(to encoder: Encoder) throws {
        try super.encode(to: encoder)
        //var container = encoder.container(keyedBy: CodingKeys.self)


    }

}
