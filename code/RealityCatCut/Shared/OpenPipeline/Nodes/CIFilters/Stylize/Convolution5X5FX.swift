//
//  Copyright © 2022 James Boo. All rights reserved.
//


import SwiftUI

class Convolution5X5FX: FilterX {
       
    /*
    @Published var w1:Float = 0.0
    @Published var w2:Float = 0.0
    @Published var w3:Float = 0.0
    @Published var w4:Float = 0.0
    @Published var w5:Float = 0.0
    
    @Published var w6:Float = 0.0
    @Published var w7:Float = 0.0
    @Published var w8:Float = 0.0
    @Published var w9:Float = 0.0
    @Published var w10:Float = 0.0
    
    @Published var w11:Float = 0.0
    @Published var w12:Float = 0.0
    @Published var w13:Float = 1.0
    @Published var w14:Float = 0.0
    @Published var w15:Float = 0.0

    @Published var w16:Float = 0.0
    @Published var w17:Float = 0.0
    @Published var w18:Float = 0.0
    @Published var w19:Float = 0.0
    @Published var w20:Float = 0.0

    @Published var w21:Float = 0.0
    @Published var w22:Float = 0.0
    @Published var w23:Float = 0.0
    @Published var w24:Float = 0.0
    @Published var w25:Float = 0.0
     */

    //Gaussian Blur
    @Published var w1:Float = 1/256
    @Published var w2:Float = 4/256
    @Published var w3:Float = 6/256
    @Published var w4:Float = 4/256
    @Published var w5:Float = 1/256
    
    @Published var w6:Float = 4/256
    @Published var w7:Float = 16/256
    @Published var w8:Float = 24/256
    @Published var w9:Float = 16/256
    @Published var w10:Float = 4/256
    
    @Published var w11:Float = 6/256
    @Published var w12:Float = 24/256
    @Published var w13:Float = 36/256
    @Published var w14:Float = 24/256
    @Published var w15:Float = 6/256

    @Published var w16:Float = 4/256
    @Published var w17:Float = 16/256
    @Published var w18:Float = 24/256
    @Published var w19:Float = 16/256
    @Published var w20:Float = 4/256

    @Published var w21:Float = 1/256
    @Published var w22:Float = 4/256
    @Published var w23:Float = 6/256
    @Published var w24:Float = 4/256
    @Published var w25:Float = 1/256
    
    @Published var bias:Float = 0.0

    let description = "Modifies pixel values by performing a 5x5 matrix convolution. The default values provide a convolution matrix to blur (gaussian) the image."

    override init()
    {
        let name="CIConvolution5X5"
        super.init(name)
        desc=description
        /*
        print(CIFilter.localizedName(forFilterName: name))
        print(CIFilter.localizedDescription(forFilterName: name))
        print(CIFilter.localizedReferenceDocumentation(forFilterName: name))
        */
    }

    enum CodingKeys : String, CodingKey {
        case w1
        case w2
        case w3
        case w4
        case w5
        case w6
        case w7
        case w8
        case w9
        case w10
        
        case w11
        case w12
        case w13
        case w14
        case w15
        case w16
        case w17
        case w18
        case w19
        case w20
        
        case w21
        case w22
        case w23
        case w24
        case w25

        case bias

    }

    required init(from decoder: Decoder) throws {
        try super.init(from: decoder)
        let values = try decoder.container(keyedBy: CodingKeys.self)
        desc=description
        
        w1 = try values.decodeIfPresent(Float.self, forKey: .w1) ?? 0
        w2 = try values.decodeIfPresent(Float.self, forKey: .w2) ?? 0
        w3 = try values.decodeIfPresent(Float.self, forKey: .w3) ?? 0
        w4 = try values.decodeIfPresent(Float.self, forKey: .w4) ?? 0
        w5 = try values.decodeIfPresent(Float.self, forKey: .w5) ?? 0
        w6 = try values.decodeIfPresent(Float.self, forKey: .w6) ?? 0
        w7 = try values.decodeIfPresent(Float.self, forKey: .w7) ?? 0
        w8 = try values.decodeIfPresent(Float.self, forKey: .w8) ?? 0
        w9 = try values.decodeIfPresent(Float.self, forKey: .w9) ?? 0
        w10 = try values.decodeIfPresent(Float.self, forKey: .w10) ?? 0

        w11 = try values.decodeIfPresent(Float.self, forKey: .w11) ?? 0
        w12 = try values.decodeIfPresent(Float.self, forKey: .w12) ?? 0
        w13 = try values.decodeIfPresent(Float.self, forKey: .w13) ?? 0
        w14 = try values.decodeIfPresent(Float.self, forKey: .w14) ?? 0
        w15 = try values.decodeIfPresent(Float.self, forKey: .w15) ?? 0
        w16 = try values.decodeIfPresent(Float.self, forKey: .w16) ?? 0
        w17 = try values.decodeIfPresent(Float.self, forKey: .w17) ?? 0
        w18 = try values.decodeIfPresent(Float.self, forKey: .w18) ?? 0
        w19 = try values.decodeIfPresent(Float.self, forKey: .w19) ?? 0
        w20 = try values.decodeIfPresent(Float.self, forKey: .w20) ?? 0

        w21 = try values.decodeIfPresent(Float.self, forKey: .w21) ?? 0
        w22 = try values.decodeIfPresent(Float.self, forKey: .w22) ?? 0
        w23 = try values.decodeIfPresent(Float.self, forKey: .w23) ?? 0
        w24 = try values.decodeIfPresent(Float.self, forKey: .w24) ?? 0
        w25 = try values.decodeIfPresent(Float.self, forKey: .w25) ?? 0

        bias = try values.decodeIfPresent(Float.self, forKey: .bias) ?? 0
    }
    
    override func encode(to encoder: Encoder) throws {
        try super.encode(to: encoder)
  
        var container = encoder.container(keyedBy: CodingKeys.self)

        try container.encode(w1, forKey: .w1)
        try container.encode(w2, forKey: .w2)
        try container.encode(w3, forKey: .w3)
        try container.encode(w4, forKey: .w4)
        try container.encode(w5, forKey: .w5)
        try container.encode(w6, forKey: .w6)
        try container.encode(w7, forKey: .w7)
        try container.encode(w8, forKey: .w8)
        try container.encode(w9, forKey: .w9)
        
        try container.encode(w10, forKey: .w10)
        try container.encode(w11, forKey: .w11)
        try container.encode(w12, forKey: .w12)
        try container.encode(w13, forKey: .w13)
        try container.encode(w14, forKey: .w14)
        try container.encode(w15, forKey: .w15)
        try container.encode(w16, forKey: .w16)
        try container.encode(w17, forKey: .w17)
        try container.encode(w18, forKey: .w18)
        try container.encode(w19, forKey: .w19)

        try container.encode(w20, forKey: .w20)
        try container.encode(w21, forKey: .w21)
        try container.encode(w22, forKey: .w22)
        try container.encode(w23, forKey: .w23)
        try container.encode(w24, forKey: .w24)
        try container.encode(w25, forKey: .w25)

        try container.encode(bias, forKey: .bias)


    }
    
    override func getCIFilter(_ ciImage: CIImage)->CIFilter
    {
        
        var currentCIFilter: CIFilter
        if ciFilter != nil {
            currentCIFilter = ciFilter!
        } else {
            currentCIFilter = CIFilter(name: type)!
            ciFilter=currentCIFilter
        }
        currentCIFilter.setValue(ciImage, forKey: kCIInputImageKey)
        
        var floatArr: [CGFloat] = []
        floatArr.append(CGFloat(w1))
        floatArr.append(CGFloat(w2))
        floatArr.append(CGFloat(w3))
        floatArr.append(CGFloat(w4))
        floatArr.append(CGFloat(w5))
        floatArr.append(CGFloat(w6))
        floatArr.append(CGFloat(w7))
        floatArr.append(CGFloat(w8))
        floatArr.append(CGFloat(w9))

        floatArr.append(CGFloat(w10))
        floatArr.append(CGFloat(w11))
        floatArr.append(CGFloat(w12))
        floatArr.append(CGFloat(w13))
        floatArr.append(CGFloat(w14))
        floatArr.append(CGFloat(w15))
        floatArr.append(CGFloat(w16))
        floatArr.append(CGFloat(w17))
        floatArr.append(CGFloat(w18))
        floatArr.append(CGFloat(w19))

        floatArr.append(CGFloat(w20))
        floatArr.append(CGFloat(w21))
        floatArr.append(CGFloat(w22))
        floatArr.append(CGFloat(w23))
        floatArr.append(CGFloat(w24))
        floatArr.append(CGFloat(w25))

        let vector = CIVector(values: floatArr, count: floatArr.count)
    
        currentCIFilter.setValue(vector, forKey: "inputWeights")
        currentCIFilter.setValue(bias, forKey: "inputBias")
        return currentCIFilter
        
    }

}
