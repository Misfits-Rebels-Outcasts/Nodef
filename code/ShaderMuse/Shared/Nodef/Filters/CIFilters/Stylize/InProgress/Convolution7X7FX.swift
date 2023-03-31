//
//  Copyright © 2022 James Boo. All rights reserved.
//

import SwiftUI

class Convolution7X7FX: FilterX {
       
    @Published var w1:Float = 0.0
    @Published var w2:Float = 0.0
    @Published var w3:Float = 0.0
    @Published var w4:Float = 0.0
    @Published var w5:Float = 1.0
    
    @Published var w6:Float = 0.0
    @Published var w7:Float = 0.0
    @Published var w8:Float = 0.0
    @Published var w9:Float = 0.0
    @Published var w10:Float = 0.0
    
    @Published var w11:Float = 0.0
    @Published var w12:Float = 0.0
    @Published var w13:Float = 0.0
    @Published var w14:Float = 1.0
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
    @Published var w25:Float = 1.0

    @Published var w26:Float = 0.0
    @Published var w27:Float = 0.0
    @Published var w28:Float = 0.0
    @Published var w29:Float = 0.0
    @Published var w30:Float = 0.0

    @Published var w31:Float = 0.0
    @Published var w32:Float = 0.0
    @Published var w33:Float = 0.0
    @Published var w34:Float = 0.0
    @Published var w35:Float = 0.0

    @Published var w36:Float = 0.0
    @Published var w37:Float = 0.0
    @Published var w38:Float = 0.0
    @Published var w39:Float = 0.0
    @Published var w40:Float = 0.0

    @Published var w41:Float = 0.0
    @Published var w42:Float = 0.0
    @Published var w43:Float = 0.0
    @Published var w44:Float = 0.0
    @Published var w45:Float = 0.0

    @Published var w46:Float = 0.0
    @Published var w47:Float = 0.0
    @Published var w48:Float = 0.0
    @Published var w49:Float = 0.0
    
    @Published var bias:Float = 0.0
    let description = "Modifies pixel values by performing a 7x7 matrix convolution."

    override init()
    {
        let name="CIConvolution7X7"
        super.init(name)
        desc=description
        
        print(CIFilter.localizedName(forFilterName: name))
        print(CIFilter.localizedDescription(forFilterName: name))
        print(CIFilter.localizedReferenceDocumentation(forFilterName: name))
        
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
        
        case w26
        case w27
        case w28
        case w29
        case w30

        case w31
        case w32
        case w33
        case w34
        case w35
        
        case w36
        case w37
        case w38
        case w39
        case w40

        case w41
        case w42
        case w43
        case w44
        case w45
        
        case w46
        case w47
        case w48
        case w49
        
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
        
        w26 = try values.decodeIfPresent(Float.self, forKey: .w26) ?? 0
        w27 = try values.decodeIfPresent(Float.self, forKey: .w27) ?? 0
        w28 = try values.decodeIfPresent(Float.self, forKey: .w28) ?? 0
        w29 = try values.decodeIfPresent(Float.self, forKey: .w29) ?? 0
        w30 = try values.decodeIfPresent(Float.self, forKey: .w30) ?? 0

        w31 = try values.decodeIfPresent(Float.self, forKey: .w31) ?? 0
        w32 = try values.decodeIfPresent(Float.self, forKey: .w32) ?? 0
        w33 = try values.decodeIfPresent(Float.self, forKey: .w33) ?? 0
        w34 = try values.decodeIfPresent(Float.self, forKey: .w34) ?? 0
        w35 = try values.decodeIfPresent(Float.self, forKey: .w35) ?? 0
        
        w36 = try values.decodeIfPresent(Float.self, forKey: .w36) ?? 0
        w37 = try values.decodeIfPresent(Float.self, forKey: .w37) ?? 0
        w38 = try values.decodeIfPresent(Float.self, forKey: .w38) ?? 0
        w39 = try values.decodeIfPresent(Float.self, forKey: .w39) ?? 0
        w40 = try values.decodeIfPresent(Float.self, forKey: .w40) ?? 0

        w41 = try values.decodeIfPresent(Float.self, forKey: .w41) ?? 0
        w42 = try values.decodeIfPresent(Float.self, forKey: .w42) ?? 0
        w43 = try values.decodeIfPresent(Float.self, forKey: .w43) ?? 0
        w44 = try values.decodeIfPresent(Float.self, forKey: .w44) ?? 0
        w45 = try values.decodeIfPresent(Float.self, forKey: .w45) ?? 0
        
        w46 = try values.decodeIfPresent(Float.self, forKey: .w46) ?? 0
        w47 = try values.decodeIfPresent(Float.self, forKey: .w47) ?? 0
        w48 = try values.decodeIfPresent(Float.self, forKey: .w48) ?? 0
        w49 = try values.decodeIfPresent(Float.self, forKey: .w49) ?? 0
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
        try container.encode(w26, forKey: .w26)
        try container.encode(w27, forKey: .w27)
        try container.encode(w28, forKey: .w28)
        try container.encode(w29, forKey: .w29)
        try container.encode(w30, forKey: .w30)

        try container.encode(w31, forKey: .w31)
        try container.encode(w32, forKey: .w32)
        try container.encode(w33, forKey: .w33)
        try container.encode(w34, forKey: .w34)
        try container.encode(w35, forKey: .w35)
        try container.encode(w36, forKey: .w36)
        try container.encode(w37, forKey: .w37)
        try container.encode(w38, forKey: .w38)
        try container.encode(w39, forKey: .w39)
        try container.encode(w40, forKey: .w40)

        try container.encode(w41, forKey: .w41)
        try container.encode(w42, forKey: .w42)
        try container.encode(w43, forKey: .w43)
        try container.encode(w44, forKey: .w44)
        try container.encode(w45, forKey: .w45)
        try container.encode(w46, forKey: .w46)
        try container.encode(w47, forKey: .w47)
        try container.encode(w48, forKey: .w48)
        try container.encode(w49, forKey: .w49)
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
        floatArr.append(CGFloat(w26))
        floatArr.append(CGFloat(w27))
        floatArr.append(CGFloat(w28))
        floatArr.append(CGFloat(w29))

        floatArr.append(CGFloat(w30))
        floatArr.append(CGFloat(w31))
        floatArr.append(CGFloat(w32))
        floatArr.append(CGFloat(w33))
        floatArr.append(CGFloat(w34))
        floatArr.append(CGFloat(w35))
        floatArr.append(CGFloat(w36))
        floatArr.append(CGFloat(w37))
        floatArr.append(CGFloat(w38))
        floatArr.append(CGFloat(w39))

        floatArr.append(CGFloat(w40))
        floatArr.append(CGFloat(w41))
        floatArr.append(CGFloat(w42))
        floatArr.append(CGFloat(w43))
        floatArr.append(CGFloat(w44))
        floatArr.append(CGFloat(w45))
        floatArr.append(CGFloat(w46))
        floatArr.append(CGFloat(w47))
        floatArr.append(CGFloat(w48))
        floatArr.append(CGFloat(w49))
        
        let vector = CIVector(values: floatArr, count: floatArr.count)
    
        currentCIFilter.setValue(vector, forKey: "inputWeights")
        currentCIFilter.setValue(bias, forKey: "inputBias")
        return currentCIFilter
        
    }

}
