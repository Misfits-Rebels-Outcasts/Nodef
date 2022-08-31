//
//  Copyright © 2022 James Boo. All rights reserved.
//

import SwiftUI

class TemperatureAndTintFX: FilterX {
       
    @Published var neutralTemperature:CGFloat = 6500.0
    @Published var neutralTint:CGFloat = 0.0
    @Published var targetNeutralTemperature:CGFloat = 6500.0
    @Published var targetNeutralTint:CGFloat = 0.0

    let description = "Adapts the reference white point for an image."

    override init()
    {
        let name = "CITemperatureAndTint"
        super.init(name)
        desc=description
      
        print(CIFilter.localizedName(forFilterName: name))
        print(CIFilter.localizedDescription(forFilterName: name))
        print(CIFilter.localizedReferenceDocumentation(forFilterName: name))
        print("inputNeutral")
        if let attribute = CIFilter.temperatureAndTint().attributes["inputNeutral"] as? [String: AnyObject]
        {
           let minimum = attribute[kCIAttributeSliderMin] as? CIVector
           let maximum = attribute[kCIAttributeSliderMax] as? CIVector
           let defaultValue = attribute[kCIAttributeDefault] as? CIVector
            
            print(minimum)
            print(maximum)
            print(defaultValue)
            
        }
    }

    enum CodingKeys : String, CodingKey {
        case neutralTemperature
        case neutralTint
        case targetNeutralTemperature
        case targetNeutralTint
        
    }

    required init(from decoder: Decoder) throws {
        try super.init(from: decoder)
        let values = try decoder.container(keyedBy: CodingKeys.self)
        desc=description
        neutralTemperature = try values.decodeIfPresent(CGFloat.self, forKey: .neutralTemperature) ?? 0.0
        neutralTint = try values.decodeIfPresent(CGFloat.self, forKey: .neutralTint) ?? 0.0
        targetNeutralTemperature = try values.decodeIfPresent(CGFloat.self, forKey: .targetNeutralTemperature) ?? 0.0
        targetNeutralTint = try values.decodeIfPresent(CGFloat.self, forKey: .targetNeutralTint) ?? 0.0


        
    }
    
    override func encode(to encoder: Encoder) throws {
        try super.encode(to: encoder)
        var container = encoder.container(keyedBy: CodingKeys.self)
        
        try container.encode(neutralTemperature, forKey: .neutralTemperature)
        try container.encode(neutralTint, forKey: .neutralTint)
        try container.encode(targetNeutralTemperature, forKey: .targetNeutralTemperature)
        try container.encode(targetNeutralTint, forKey: .targetNeutralTint)

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
        
        let neutralvector=CIVector(x:neutralTemperature,y:neutralTint)
        currentCIFilter.setValue(neutralvector, forKey: "inputNeutral")

        let targetNeutralvector=CIVector(x:targetNeutralTemperature,y:targetNeutralTint)
        currentCIFilter.setValue(targetNeutralvector, forKey: "inputTargetNeutral")

        return currentCIFilter
    }

}
