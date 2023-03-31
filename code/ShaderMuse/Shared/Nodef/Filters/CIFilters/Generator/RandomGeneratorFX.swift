//
//  Copyright © 2022 James Boo. All rights reserved.
//


import SwiftUI

class RandomGeneratorFX: BaseGeneratorFX {
           
    let description = "Generates an image of infinite extent whose pixel values are made up of four independent, uniformly-distributed random numbers in the 0 to 1 range."

    override init()
    {
        let name="CIRandomGenerator"
        super.init(name)
        desc=description
        
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

    
    var randomCIFilter:CIFilter?
    override func getCIFilter(currentImage: CIImage, beginImage: CIImage) -> CIFilter? {
        
        var randomFilter: CIFilter

        randomFilter = randomCIFilter != nil ? randomCIFilter! : CIFilter(name: type)!
        
        if cropToFormat{
            super.setCIFilterAndCropImage(inputImage: randomFilter.outputImage!)
            return ciFilter!
        }
        else{
            ciFilter=randomFilter
            return ciFilter!

        }
        
    }

}
