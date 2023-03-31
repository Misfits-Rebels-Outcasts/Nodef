//
//  Copyright © 2022 James Boo. All rights reserved.
//

import SwiftUI

class TranslateFX: FilterX {
       
    //@Published var a:CGFloat = 1.0
    //@Published var b:CGFloat = 0.0
    //@Published var c:CGFloat = 0.0
    //@Published var d:CGFloat = 1.0

    @Published var tx:Float = 0.0
    @Published var ty:Float = 0.0
    
    let description = "Translate an image horizontally (X) or vertically (Y)."

    override init()
    {
        let name="CITranslate"
        super.init(name)
        desc=description
        
        print(CIFilter.localizedName(forFilterName: name))
        print(CIFilter.localizedDescription(forFilterName: name))
        print(CIFilter.localizedReferenceDocumentation(forFilterName: name))
        
    }

    enum CodingKeys : String, CodingKey {
        //case a
        //case b
        //case c
        //case d
        case tx
        case ty
    }

    required init(from decoder: Decoder) throws {
        try super.init(from: decoder)
        let values = try decoder.container(keyedBy: CodingKeys.self)
        desc=description
        
        //a = try values.decodeIfPresent(CGFloat.self, forKey: .a) ?? 0
        //b = try values.decodeIfPresent(CGFloat.self, forKey: .b) ?? 0
        //c = try values.decodeIfPresent(CGFloat.self, forKey: .c) ?? 0
        //d = try values.decodeIfPresent(CGFloat.self, forKey: .d) ?? 0
        
        tx = try values.decodeIfPresent(Float.self, forKey: .tx) ?? 0
        ty = try values.decodeIfPresent(Float.self, forKey: .ty) ?? 0

    }
    
    override func encode(to encoder: Encoder) throws {
        try super.encode(to: encoder)
  
        var container = encoder.container(keyedBy: CodingKeys.self)

        //try container.encode(a, forKey: .a)
        //try container.encode(b, forKey: .b)
        //try container.encode(c, forKey: .c)
        //try container.encode(d, forKey: .d)

        try container.encode(tx, forKey: .tx)
        try container.encode(ty, forKey: .ty)

    }
    
    override func setupProperties(_ parent: FiltersX?)
    {
        super.setupProperties(parent)
        
        if parent != nil{
            tx=0.0
            ty=0.0
        }
        
    }
    
    override func adjustPropertiesToBounds(_ parent: FiltersX?)
    {
        super.adjustPropertiesToBounds(parent)
        
        tx = tx > Float(size.width) ? Float(size.width) : tx
        ty = ty > Float(size.height) ? Float(size.height) : ty
        
        tx = tx < Float(0-size.width) ? Float(0-size.width) : tx
        ty = ty < Float(0-size.height) ? Float(0-size.height) : ty
        
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
        let transform=CGAffineTransform(a:1,b:0,c:0,d:1,tx:CGFloat(tx),ty:CGFloat(ty))
        currentCIFilter.setValue(transform, forKey: kCIInputTransformKey)

        return currentCIFilter
        
    }

}
