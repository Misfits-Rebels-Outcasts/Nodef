//
//  Copyright © 2022 James Boo. All rights reserved.
//

import SwiftUI

class ColorClampFX: FilterX {
       
    @Published var minx:CGFloat = 0.0
    @Published var miny:CGFloat = 0.0
    @Published var minz:CGFloat = 0.0
    @Published var minw:CGFloat = 0.0

    @Published var maxx:CGFloat = 1.0
    @Published var maxy:CGFloat = 1.0
    @Published var maxz:CGFloat = 1.0
    @Published var maxw:CGFloat = 1.0

    let description = "Modifies color values to keep them within a specified range."

    override init()
    {
        let name = "CIColorClamp"
        super.init(name)
        desc=description
      
        print(CIFilter.localizedName(forFilterName: name))
        print(CIFilter.localizedDescription(forFilterName: name))
        print(CIFilter.localizedReferenceDocumentation(forFilterName: name))
         
    }

    enum CodingKeys : String, CodingKey {
        case minx
        case miny
        case minz
        case minw
        
        case maxx
        case maxy
        case maxz
        case maxw


    }

    required init(from decoder: Decoder) throws {
        try super.init(from: decoder)
        let values = try decoder.container(keyedBy: CodingKeys.self)
        desc=description
        minx = try values.decodeIfPresent(CGFloat.self, forKey: .minx) ?? 0.0
        miny = try values.decodeIfPresent(CGFloat.self, forKey: .miny) ?? 0.0
        minz = try values.decodeIfPresent(CGFloat.self, forKey: .minz) ?? 0.0
        minw = try values.decodeIfPresent(CGFloat.self, forKey: .minw) ?? 0.0

        maxx = try values.decodeIfPresent(CGFloat.self, forKey: .maxx) ?? 1.0
        maxy = try values.decodeIfPresent(CGFloat.self, forKey: .maxy) ?? 1.0
        maxz = try values.decodeIfPresent(CGFloat.self, forKey: .maxz) ?? 1.0
        maxw = try values.decodeIfPresent(CGFloat.self, forKey: .maxw) ?? 1.0

        
    }
    
    override func encode(to encoder: Encoder) throws {
        try super.encode(to: encoder)
        var container = encoder.container(keyedBy: CodingKeys.self)
        
        try container.encode(minx, forKey: .minx)
        try container.encode(miny, forKey: .miny)
        try container.encode(minz, forKey: .minz)
        try container.encode(minw, forKey: .minw)

        try container.encode(maxx, forKey: .maxx)
        try container.encode(maxy, forKey: .maxy)
        try container.encode(maxz, forKey: .maxz)
        try container.encode(maxw, forKey: .maxw)

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
        
        let minvector=CIVector(x:minx,y:miny,z:minz,w:minw)
        currentCIFilter.setValue(minvector, forKey: "inputMinComponents")

        let maxvector=CIVector(x:maxx,y:maxy,z:maxz,w:maxw)
        currentCIFilter.setValue(maxvector, forKey: "inputMaxComponents")

        return currentCIFilter
    }

}
