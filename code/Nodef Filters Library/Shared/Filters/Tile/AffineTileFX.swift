//
//  Copyright © 2022 James Boo. All rights reserved.
//

import SwiftUI

class AffineTileFX: BaseTileFX {
       
    @Published var a:CGFloat = 0.5//1.0
    @Published var b:CGFloat = 0.0
    @Published var c:CGFloat = 0.0
    @Published var d:CGFloat = 0.5//1.0

    @Published var tx:CGFloat = 0.0
    @Published var ty:CGFloat = 0.0
    
    let description = "Applies an affine transform to an image and then tiles the transformed image."

    override init()
    {
        let name="CIAffineTile"
        super.init(name)
        desc=description
        
        print(CIFilter.localizedName(forFilterName: name))
        print(CIFilter.localizedDescription(forFilterName: name))
        print(CIFilter.localizedReferenceDocumentation(forFilterName: name))

        
    }

    enum CodingKeys : String, CodingKey {
        case a
        case b
        case c
        case d
        case tx
        case ty
    }

    required init(from decoder: Decoder) throws {
        try super.init(from: decoder)
        let values = try decoder.container(keyedBy: CodingKeys.self)
        desc=description
        
        a = try values.decodeIfPresent(CGFloat.self, forKey: .a) ?? 0
        b = try values.decodeIfPresent(CGFloat.self, forKey: .b) ?? 0
        c = try values.decodeIfPresent(CGFloat.self, forKey: .c) ?? 0
        d = try values.decodeIfPresent(CGFloat.self, forKey: .d) ?? 0
        
        tx = try values.decodeIfPresent(CGFloat.self, forKey: .tx) ?? 0
        ty = try values.decodeIfPresent(CGFloat.self, forKey: .ty) ?? 0


    }
    
    override func encode(to encoder: Encoder) throws {
        try super.encode(to: encoder)
  
        var container = encoder.container(keyedBy: CodingKeys.self)

        try container.encode(a, forKey: .a)
        try container.encode(b, forKey: .b)
        try container.encode(c, forKey: .c)
        try container.encode(d, forKey: .d)

        try container.encode(tx, forKey: .tx)
        try container.encode(ty, forKey: .ty)
    }
    
    var affineTileCIFilter:CIFilter?
    override func getCIFilter(currentImage: CIImage, beginImage: CIImage) -> CIFilter? {
        
        var affineTileFilter: CIFilter
        if affineTileCIFilter != nil {
            affineTileFilter = affineTileCIFilter!
        } else {
            affineTileFilter = CIFilter(name: type)!
            affineTileCIFilter=affineTileFilter
        }

        let inputImage=handleAlias(alias: inputImageAlias,
                                      inputImage: currentImage,
                                      beginImage: beginImage)
        
        affineTileFilter.setValue(inputImage, forKey: kCIInputImageKey)
        let transform=CGAffineTransform(a:a,b:b,c:c,d:d,tx:tx,ty:ty)
        affineTileFilter.setValue(transform, forKey: kCIInputTransformKey)

        if cropToFormat{
            super.setCIFilterAndCropImage(inputImage: affineTileFilter.outputImage!)
            return ciFilter!
        }
        else{
            ciFilter=affineTileFilter
            return ciFilter!
        }
        
    }

}
