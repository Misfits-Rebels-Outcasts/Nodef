//
//  Copyright © 2022 James Boo. All rights reserved.
//

import SwiftUI

class ColorCrossPolynomialFX: FilterX {
       
    @Published var rw1:Float = 1.0
    @Published var rw2:Float = 0.0
    @Published var rw3:Float = 0.0
    @Published var rw4:Float = 0.0
    @Published var rw5:Float = 0.0
    @Published var rw6:Float = 0.0
    @Published var rw7:Float = 0.0
    @Published var rw8:Float = 0.0
    @Published var rw9:Float = 0.0
    @Published var rb:Float = 0.0

    @Published var gw1:Float = 0.0
    @Published var gw2:Float = 1.0
    @Published var gw3:Float = 0.0
    @Published var gw4:Float = 0.0
    @Published var gw5:Float = 0.0
    @Published var gw6:Float = 0.0
    @Published var gw7:Float = 0.0
    @Published var gw8:Float = 0.0
    @Published var gw9:Float = 0.0
    @Published var gb:Float = 0.0

    @Published var bw1:Float = 0.0
    @Published var bw2:Float = 0.0
    @Published var bw3:Float = 1.0
    @Published var bw4:Float = 0.0
    @Published var bw5:Float = 0.0
    @Published var bw6:Float = 0.0
    @Published var bw7:Float = 0.0
    @Published var bw8:Float = 0.0
    @Published var bw9:Float = 0.0
    @Published var bb:Float = 0.0

    
    let description = "Modifies the pixel values in an image by applying a set of polynomial cross-products. For each color coefficient, a ten element vector where the first nine values are cross product weights, and the final value in a bias is required."
    
    override init()
    {
        let name = "CIColorCrossPolynomial"
        super.init(name)
        desc=description
        
        print(CIFilter.localizedName(forFilterName: name))
        print(CIFilter.localizedDescription(forFilterName: name))
        print(CIFilter.localizedReferenceDocumentation(forFilterName: name))

    }

    enum CodingKeys : String, CodingKey {
        case rw1
        case rw2
        case rw3
        case rw4
        case rw5
        case rw6
        case rw7
        case rw8
        case rw9
        case rb
        
        case gw1
        case gw2
        case gw3
        case gw4
        case gw5
        case gw6
        case gw7
        case gw8
        case gw9
        case gb
        
        case bw1
        case bw2
        case bw3
        case bw4
        case bw5
        case bw6
        case bw7
        case bw8
        case bw9
        case bb
    }

    required init(from decoder: Decoder) throws {
        try super.init(from: decoder)
        let values = try decoder.container(keyedBy: CodingKeys.self)
        desc=description

        rw1 = try values.decodeIfPresent(Float.self, forKey: .rw1) ?? 0.0
        rw2 = try values.decodeIfPresent(Float.self, forKey: .rw2) ?? 0.0
        rw3 = try values.decodeIfPresent(Float.self, forKey: .rw3) ?? 0.0
        rw4 = try values.decodeIfPresent(Float.self, forKey: .rw4) ?? 0.0
        rw5 = try values.decodeIfPresent(Float.self, forKey: .rw5) ?? 0.0
        rw6 = try values.decodeIfPresent(Float.self, forKey: .rw6) ?? 0.0
        rw7 = try values.decodeIfPresent(Float.self, forKey: .rw7) ?? 0.0
        rw8 = try values.decodeIfPresent(Float.self, forKey: .rw8) ?? 0.0
        rw9 = try values.decodeIfPresent(Float.self, forKey: .rw9) ?? 0.0
        rb = try values.decodeIfPresent(Float.self, forKey: .rb) ?? 0.0

        gw1 = try values.decodeIfPresent(Float.self, forKey: .gw1) ?? 0.0
        gw2 = try values.decodeIfPresent(Float.self, forKey: .gw2) ?? 0.0
        gw3 = try values.decodeIfPresent(Float.self, forKey: .gw3) ?? 0.0
        gw4 = try values.decodeIfPresent(Float.self, forKey: .gw4) ?? 0.0
        gw5 = try values.decodeIfPresent(Float.self, forKey: .gw5) ?? 0.0
        gw6 = try values.decodeIfPresent(Float.self, forKey: .gw6) ?? 0.0
        gw7 = try values.decodeIfPresent(Float.self, forKey: .gw7) ?? 0.0
        gw8 = try values.decodeIfPresent(Float.self, forKey: .gw8) ?? 0.0
        gw9 = try values.decodeIfPresent(Float.self, forKey: .gw9) ?? 0.0
        gb = try values.decodeIfPresent(Float.self, forKey: .gb) ?? 0.0
        
        bw1 = try values.decodeIfPresent(Float.self, forKey: .bw1) ?? 0.0
        bw2 = try values.decodeIfPresent(Float.self, forKey: .bw2) ?? 0.0
        bw3 = try values.decodeIfPresent(Float.self, forKey: .bw3) ?? 0.0
        bw4 = try values.decodeIfPresent(Float.self, forKey: .bw4) ?? 0.0
        bw5 = try values.decodeIfPresent(Float.self, forKey: .bw5) ?? 0.0
        bw6 = try values.decodeIfPresent(Float.self, forKey: .bw6) ?? 0.0
        bw7 = try values.decodeIfPresent(Float.self, forKey: .bw7) ?? 0.0
        bw8 = try values.decodeIfPresent(Float.self, forKey: .bw8) ?? 0.0
        bw9 = try values.decodeIfPresent(Float.self, forKey: .bw9) ?? 0.0
        bb = try values.decodeIfPresent(Float.self, forKey: .bb) ?? 0.0
    }
    
    override func encode(to encoder: Encoder) throws {
        try super.encode(to: encoder)
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(rw1, forKey: .rw1)
        try container.encode(rw2, forKey: .rw2)
        try container.encode(rw3, forKey: .rw3)
        try container.encode(rw4, forKey: .rw4)
        try container.encode(rw5, forKey: .rw5)
        try container.encode(rw6, forKey: .rw6)
        try container.encode(rw7, forKey: .rw7)
        try container.encode(rw8, forKey: .rw8)
        try container.encode(rw9, forKey: .rw9)
        try container.encode(rb, forKey: .rb)

        try container.encode(gw1, forKey: .gw1)
        try container.encode(gw2, forKey: .gw2)
        try container.encode(gw3, forKey: .gw3)
        try container.encode(gw4, forKey: .gw4)
        try container.encode(gw5, forKey: .gw5)
        try container.encode(gw6, forKey: .gw6)
        try container.encode(gw7, forKey: .gw7)
        try container.encode(gw8, forKey: .gw8)
        try container.encode(gw9, forKey: .gw9)
        try container.encode(gb, forKey: .gb)
        
        try container.encode(bw1, forKey: .bw1)
        try container.encode(bw2, forKey: .bw2)
        try container.encode(bw3, forKey: .bw3)
        try container.encode(bw4, forKey: .bw4)
        try container.encode(bw5, forKey: .bw5)
        try container.encode(bw6, forKey: .bw6)
        try container.encode(bw7, forKey: .bw7)
        try container.encode(bw8, forKey: .bw8)
        try container.encode(bw9, forKey: .bw9)
        try container.encode(bb, forKey: .bb)
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
        
        var rfloatArr: [CGFloat] = []
        rfloatArr.append(CGFloat(rw1))
        rfloatArr.append(CGFloat(rw2))
        rfloatArr.append(CGFloat(rw3))
        rfloatArr.append(CGFloat(rw4))
        rfloatArr.append(CGFloat(rw5))
        rfloatArr.append(CGFloat(rw6))
        rfloatArr.append(CGFloat(rw7))
        rfloatArr.append(CGFloat(rw8))
        rfloatArr.append(CGFloat(rw9))
        rfloatArr.append(CGFloat(rb))
        let rvector = CIVector(values: rfloatArr, count: rfloatArr.count)
        currentCIFilter.setValue(rvector, forKey: "inputRedCoefficients")
        
        var gfloatArr: [CGFloat] = []
        gfloatArr.append(CGFloat(gw1))
        gfloatArr.append(CGFloat(gw2))
        gfloatArr.append(CGFloat(gw3))
        gfloatArr.append(CGFloat(gw4))
        gfloatArr.append(CGFloat(gw5))
        gfloatArr.append(CGFloat(gw6))
        gfloatArr.append(CGFloat(gw7))
        gfloatArr.append(CGFloat(gw8))
        gfloatArr.append(CGFloat(gw9))
        gfloatArr.append(CGFloat(gb))
        let gvector = CIVector(values: gfloatArr, count: gfloatArr.count)
        currentCIFilter.setValue(gvector, forKey: "inputGreenCoefficients")

        var bfloatArr: [CGFloat] = []
        bfloatArr.append(CGFloat(bw1))
        bfloatArr.append(CGFloat(bw2))
        bfloatArr.append(CGFloat(bw3))
        bfloatArr.append(CGFloat(bw4))
        bfloatArr.append(CGFloat(bw5))
        bfloatArr.append(CGFloat(bw6))
        bfloatArr.append(CGFloat(bw7))
        bfloatArr.append(CGFloat(bw8))
        bfloatArr.append(CGFloat(bw9))
        bfloatArr.append(CGFloat(bb))
        let bvector = CIVector(values: bfloatArr, count: bfloatArr.count)
        currentCIFilter.setValue(bvector, forKey: "inputBlueCoefficients")

        return currentCIFilter
    }

}
