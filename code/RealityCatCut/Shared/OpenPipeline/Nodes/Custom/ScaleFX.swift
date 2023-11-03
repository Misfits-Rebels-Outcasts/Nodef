//
//  Copyright © 2022 James Boo. All rights reserved.
//

import SwiftUI

class ScaleFX: FilterX {

    @Published var a:Float = 0.75
    //@Published var b:CGFloat = 0.0
    //@Published var c:CGFloat = 0.0
    @Published var d:Float = 0.75

    //@Published var tx:CGFloat = 0.0
    //@Published var ty:CGFloat = 0.0
    
    let description = "Scale in the axis directions. A X value of 0.5 and Y value of 0.5 would produce an image of width and height that would be half of what they used to be."

    override init()
    {
        let name="CIScale"
        super.init(name)
        desc=description
        /*
        print(CIFilter.localizedName(forFilterName: name))
        print(CIFilter.localizedDescription(forFilterName: name))
        print(CIFilter.localizedReferenceDocumentation(forFilterName: name))
        */
    }

    enum CodingKeys : String, CodingKey {
        case a
        //case b
        //case c
        case d
        //case tx
        //case ty
    }

    required init(from decoder: Decoder) throws {
        try super.init(from: decoder)
        let values = try decoder.container(keyedBy: CodingKeys.self)
        desc=description
        
        a = try values.decodeIfPresent(Float.self, forKey: .a) ?? 0
        //b = try values.decodeIfPresent(CGFloat.self, forKey: .b) ?? 0
        //c = try values.decodeIfPresent(CGFloat.self, forKey: .c) ?? 0
        d = try values.decodeIfPresent(Float.self, forKey: .d) ?? 0
        
        //tx = try values.decodeIfPresent(CGFloat.self, forKey: .tx) ?? 0
        //ty = try values.decodeIfPresent(CGFloat.self, forKey: .ty) ?? 0

    }
    
    override func encode(to encoder: Encoder) throws {
        try super.encode(to: encoder)
  
        var container = encoder.container(keyedBy: CodingKeys.self)

        try container.encode(a, forKey: .a)
        //try container.encode(b, forKey: .b)
        //try container.encode(c, forKey: .c)
        try container.encode(d, forKey: .d)

        //try container.encode(tx, forKey: .tx)
        //try container.encode(ty, forKey: .ty)

    }
    

    override func getCIFilter(_ ciImage: CIImage)->CIFilter
    {
        
        var currentCIFilter: CIFilter
        if ciFilter != nil {
            currentCIFilter = ciFilter!
        } else {
            currentCIFilter = CIFilter(name: "CIAffineTransform")!
            ciFilter=currentCIFilter
        }
        currentCIFilter.setValue(ciImage, forKey: kCIInputImageKey)
        //let transform=CGAffineTransform(a:a,b:b,c:c,d:d,tx:tx,ty:ty)
        //let transform=CGAffineTransform(a:1,b:0,c:0,d:1,tx:tx,ty:ty)
        let transform=CGAffineTransform(a:CGFloat(a),b:0,c:0,d:CGFloat(d),tx:0,ty:0)
        currentCIFilter.setValue(transform, forKey: kCIInputTransformKey)

        return currentCIFilter
        
    }

}
