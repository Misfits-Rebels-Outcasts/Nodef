//
//  Copyright © 2022 James Boo. All rights reserved.
//

import SwiftUI

class ColorMatrixFX: FilterX {
       
    @Published var rx:CGFloat = 1.0
    @Published var ry:CGFloat = 0.0
    @Published var rz:CGFloat = 0.0
    @Published var rw:CGFloat = 0.0

    @Published var gx:CGFloat = 0.0
    @Published var gy:CGFloat = 1.0
    @Published var gz:CGFloat = 0.0
    @Published var gw:CGFloat = 0.0

    @Published var bx:CGFloat = 0.0
    @Published var by:CGFloat = 0.0
    @Published var bz:CGFloat = 1.0
    @Published var bw:CGFloat = 0.0

    @Published var ax:CGFloat = 0.0
    @Published var ay:CGFloat = 0.0
    @Published var az:CGFloat = 0.0
    @Published var aw:CGFloat = 1.0

    @Published var biasx:CGFloat = 0.0
    @Published var biasy:CGFloat = 0.0
    @Published var biasz:CGFloat = 0.0
    @Published var biasw:CGFloat = 0.0

    let description = "Multiplies source color values and adds a bias factor to each color component."

    override init()
    {
        let name = "CIColorMatrix"
        super.init(name)
        desc=description
      
        print(CIFilter.localizedName(forFilterName: name))
        print(CIFilter.localizedDescription(forFilterName: name))
        print(CIFilter.localizedReferenceDocumentation(forFilterName: name))
                    
        /*
        if let attribute = CIFilter.exposureAdjust().attributes["inputEV"] as? [String: AnyObject]
        {
           let minimum = attribute[kCIAttributeSliderMin] as? Float
           let maximum = attribute[kCIAttributeSliderMax] as? Float
           let defaultValue = attribute[kCIAttributeDefault] as? Float
            
            print(minimum)
            print(maximum)
            print(defaultValue)
            
            //Optional(-1.0)
            //Optional(1.0)
            //Optional(0.0)
            
        }

        print("completed")
         */
         
    }

    enum CodingKeys : String, CodingKey {
        case rx
        case ry
        case rz
        case rw
        
        case gx
        case gy
        case gz
        case gw

        case bx
        case by
        case bz
        case bw

        case ax
        case ay
        case az
        case aw

        case biasx
        case biasy
        case biasz
        case biasw

    }

    required init(from decoder: Decoder) throws {
        try super.init(from: decoder)
        let values = try decoder.container(keyedBy: CodingKeys.self)
        desc=description
        rx = try values.decodeIfPresent(CGFloat.self, forKey: .rx) ?? 0.0
        ry = try values.decodeIfPresent(CGFloat.self, forKey: .ry) ?? 0.0
        rz = try values.decodeIfPresent(CGFloat.self, forKey: .rz) ?? 0.0
        rw = try values.decodeIfPresent(CGFloat.self, forKey: .rw) ?? 0.0

        gx = try values.decodeIfPresent(CGFloat.self, forKey: .gx) ?? 0.0
        gy = try values.decodeIfPresent(CGFloat.self, forKey: .gy) ?? 0.0
        gz = try values.decodeIfPresent(CGFloat.self, forKey: .gz) ?? 0.0
        gw = try values.decodeIfPresent(CGFloat.self, forKey: .gw) ?? 0.0

        bx = try values.decodeIfPresent(CGFloat.self, forKey: .bx) ?? 0.0
        by = try values.decodeIfPresent(CGFloat.self, forKey: .by) ?? 0.0
        bz = try values.decodeIfPresent(CGFloat.self, forKey: .bz) ?? 0.0
        bw = try values.decodeIfPresent(CGFloat.self, forKey: .bw) ?? 0.0

        ax = try values.decodeIfPresent(CGFloat.self, forKey: .ax) ?? 0.0
        ay = try values.decodeIfPresent(CGFloat.self, forKey: .ay) ?? 0.0
        az = try values.decodeIfPresent(CGFloat.self, forKey: .az) ?? 0.0
        aw = try values.decodeIfPresent(CGFloat.self, forKey: .aw) ?? 0.0

        biasx = try values.decodeIfPresent(CGFloat.self, forKey: .biasx) ?? 0.0
        biasy = try values.decodeIfPresent(CGFloat.self, forKey: .biasy) ?? 0.0
        biasz = try values.decodeIfPresent(CGFloat.self, forKey: .biasz) ?? 0.0
        biasw = try values.decodeIfPresent(CGFloat.self, forKey: .biasw) ?? 0.0
        
    }
    
    override func encode(to encoder: Encoder) throws {
        try super.encode(to: encoder)
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(rx, forKey: .rx)
        try container.encode(ry, forKey: .ry)
        try container.encode(rz, forKey: .rz)
        try container.encode(rw, forKey: .rw)

        try container.encode(gx, forKey: .gx)
        try container.encode(gy, forKey: .gy)
        try container.encode(gz, forKey: .gz)
        try container.encode(gw, forKey: .gw)

        try container.encode(bx, forKey: .bx)
        try container.encode(by, forKey: .by)
        try container.encode(bz, forKey: .bz)
        try container.encode(bw, forKey: .bw)

        try container.encode(ax, forKey: .ax)
        try container.encode(ay, forKey: .ay)
        try container.encode(az, forKey: .az)
        try container.encode(aw, forKey: .aw)

        try container.encode(biasx, forKey: .biasx)
        try container.encode(biasy, forKey: .biasy)
        try container.encode(biasz, forKey: .biasz)
        try container.encode(biasw, forKey: .biasw)

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
        
        let rvector=CIVector(x:rx,y:ry,z:rz,w:rw)
        currentCIFilter.setValue(rvector, forKey: "inputRVector")

        let gvector=CIVector(x:gx,y:gy,z:gz,w:gw)
        currentCIFilter.setValue(gvector, forKey: "inputGVector")

        let bvector=CIVector(x:bx,y:by,z:bz,w:bw)
        currentCIFilter.setValue(bvector, forKey: "inputBVector")

        let avector=CIVector(x:ax,y:ay,z:az,w:aw)
        currentCIFilter.setValue(avector, forKey: "inputAVector")

        let biasvector=CIVector(x:biasx,y:biasy,z:biasz,w:biasw)
        currentCIFilter.setValue(biasvector, forKey: "inputBiasVector")

        return currentCIFilter
    }

}
