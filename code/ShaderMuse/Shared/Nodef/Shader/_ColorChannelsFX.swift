//
//  Copyright © 2022 James Boo. All rights reserved.
//

import SwiftUI

class ColorChannelsFX: FilterX {
           
    @Published var rAmount:Float = 1.0
    @Published var gAmount:Float = 1.0
    @Published var bAmount:Float = 1.0
    @Published var aAmount:Float = 1.0

    let description = "Extracts the RGBA channels of an image."

    override init()
    {
        let name = "CIColorChannels"
        super.init(name)
        desc=description
    }

    enum CodingKeys : String, CodingKey {
        case rAmount
        case gAmount
        case bAmount
        case aAmount
    }

    required init(from decoder: Decoder) throws {
        try super.init(from: decoder)
        let values = try decoder.container(keyedBy: CodingKeys.self)
        desc=description
             
        rAmount = try values.decodeIfPresent(Float.self, forKey: .rAmount) ?? 1.0
        gAmount = try values.decodeIfPresent(Float.self, forKey: .gAmount) ?? 1.0
        bAmount = try values.decodeIfPresent(Float.self, forKey: .bAmount) ?? 1.0
        aAmount = try values.decodeIfPresent(Float.self, forKey: .aAmount) ?? 1.0

    }
    
    override func encode(to encoder: Encoder) throws {
        try super.encode(to: encoder)
        var container = encoder.container(keyedBy: CodingKeys.self)

        try container.encode(rAmount, forKey: .rAmount)
        try container.encode(gAmount, forKey: .gAmount)
        try container.encode(bAmount, forKey: .bAmount)
        try container.encode(aAmount, forKey: .aAmount)

    }
    
    override func getCIFilter(_ ciImage: CIImage)->CIFilter
    {
        var currentCIFilter: CIColorChannels
        
        if ciFilter != nil {
            currentCIFilter = ciFilter as! CIColorChannels
        } else {
            currentCIFilter =  CIColorChannels()
            ciFilter=currentCIFilter
        }

        currentCIFilter.inputImage = ciImage
        currentCIFilter.rAmount = CGFloat(rAmount)
        currentCIFilter.gAmount = CGFloat(gAmount)
        currentCIFilter.bAmount = CGFloat(bAmount)
        currentCIFilter.aAmount = CGFloat(aAmount)
        return currentCIFilter

        
    }

}
