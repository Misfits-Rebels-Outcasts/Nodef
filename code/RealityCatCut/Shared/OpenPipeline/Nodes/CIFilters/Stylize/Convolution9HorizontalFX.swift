//
//  Copyright © 2022 James Boo. All rights reserved.
//

import SwiftUI

class Convolution9HorizontalFX: FilterX {
    
    @Published var w1:Float = 1.0
    @Published var w2:Float = -1.0
    @Published var w3:Float = 1.0
    @Published var w4:Float = 0.0
    @Published var w5:Float = 1.0
    @Published var w6:Float = 0.0
    @Published var w7:Float = -1.0
    @Published var w8:Float = 1.0
    @Published var w9:Float = -1.0
    @Published var bias:Float = 0.0

    
       /*
    @Published var w1:Float = 0.0
    @Published var w2:Float = 0.0
    @Published var w3:Float = 0.0
    @Published var w4:Float = 0.0
    @Published var w5:Float = 1.0
    @Published var w6:Float = 0.0
    @Published var w7:Float = 0.0
    @Published var w8:Float = 0.0
    @Published var w9:Float = 0.0
    @Published var bias:Float = 0.0
    */
    
    let description = "Modifies pixel values by performing a 9-element horizontal convolution. The default values provide a convolution matrix to sharpen the image."

    override init()
    {
        let name="CIConvolution9Horizontal"
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
        
        let vector = CIVector(values: floatArr, count: floatArr.count)
    
        currentCIFilter.setValue(vector, forKey: "inputWeights")
        currentCIFilter.setValue(bias, forKey: "inputBias")
        return currentCIFilter
        
        
    }

}
