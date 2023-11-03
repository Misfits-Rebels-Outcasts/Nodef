//
//  Copyright © 2022 James Boo. All rights reserved.
//

import SwiftUI

class ColorMapFX: FilterX {
       
    @Published var inputGradientImageAlias : String=""

    let description = "Performs a nonlinear transformation of source color values using mapping values provided in a table."
    
    override init()
    {
        let name = "CIColorMap"
        super.init(name)
        desc=description
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
    func getCIFilter(inputImage: CIImage,
                     gradientImage: CIImage)->CIFilter
    {
        var currentCIFilter: CIFilter
        if ciFilter != nil {
            currentCIFilter = ciFilter!
        } else {
            currentCIFilter = CIFilter(name: type)!
            ciFilter=currentCIFilter
        }
        
        currentCIFilter.setValue(inputImage, forKey: kCIInputImageKey)
        currentCIFilter.setValue(gradientImage, forKey: "inputGradientImage")

        return currentCIFilter

    }

}
