//
//  Copyright © 2022 James Boo. All rights reserved.
//

import SwiftUI

class ReciprocalFX: FilterX {
       
    @Published var n1:Float = 0.07053
    @Published var exp1:Float = 4.32
    @Published var n2:Float = 0.062
    @Published var exp2:Float = 4.5

    let description = "Applies a reciprocal tone curve to an image with the formula : (value*n1 / value^exp1) * (value*n2 / value^exp2)."

    override init()
    {
        let name = "CIReciprocal"
        super.init(name)
        desc=description
         
    }

    enum CodingKeys : String, CodingKey {
        case color
        case n1
        case exp1
        case n2
        case exp2

    }

    required init(from decoder: Decoder) throws {
        try super.init(from: decoder)
        let values = try decoder.container(keyedBy: CodingKeys.self)
        desc=description
        
        n1 = try values.decodeIfPresent(Float.self, forKey: .n1) ?? 0.0
        exp1 = try values.decodeIfPresent(Float.self, forKey: .exp1) ?? 0.0
        n2 = try values.decodeIfPresent(Float.self, forKey: .n2) ?? 0.0
        exp2 = try values.decodeIfPresent(Float.self, forKey: .exp2) ?? 0.0
    }
    
    override func encode(to encoder: Encoder) throws {
        try super.encode(to: encoder)
        var container = encoder.container(keyedBy: CodingKeys.self)
        
        try container.encode(n1, forKey: .n1)
        try container.encode(exp1, forKey: .exp1)
        try container.encode(n2, forKey: .n2)
        try container.encode(exp2, forKey: .exp2)
    }
    
    override func getCIFilter(_ ciImage: CIImage)->CIFilter
    {
        var currentCIFilter: CIReciprocalFilter
        if ciFilter != nil {
            currentCIFilter = ciFilter as! CIReciprocalFilter
        } else {
            currentCIFilter =  CIReciprocalFilter()
            ciFilter=currentCIFilter
        }
        //print("extent:",ciImage.extent)
        currentCIFilter.inputImage = ciImage

        currentCIFilter.inputNumerator = CGFloat(n1)
        currentCIFilter.inputDenominatorExp = CGFloat(exp1)
        currentCIFilter.inputNumerator2 = CGFloat(n2)
        currentCIFilter.inputDenominatorExp2 = CGFloat(exp2)
        
        return currentCIFilter

        
    }

}
