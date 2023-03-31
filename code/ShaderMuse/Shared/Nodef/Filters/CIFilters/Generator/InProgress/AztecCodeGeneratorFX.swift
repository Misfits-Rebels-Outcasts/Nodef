//
//  Copyright © 2022 James Boo. All rights reserved.
//


import SwiftUI

class AztecCodeGeneratorFX: BaseGeneratorFX {
       
    @Published var message:String = "12345678"
    @Published var correctionLevel:Float = 23.0
    @Published var layers:Float = 3.0 //1-32
    @Published var compactStyle:Float = 0.0

    let description = "Generates an Aztec code (two-dimensional barcode) from input data."

    override init()
    {
        let name="CIAztecCodeGenerator"
        super.init(name)
        desc=description
        
        print(CIFilter.localizedName(forFilterName: name))
        print(CIFilter.localizedDescription(forFilterName: name))
        print(CIFilter.localizedReferenceDocumentation(forFilterName: name))
             
        print("inputCorrectionLevel")
        if let attribute = CIFilter.aztecCodeGenerator().attributes["inputCorrectionLevel"] as? [String: AnyObject]
        {
           let minimum = attribute[kCIAttributeSliderMin] as? Float
           let maximum = attribute[kCIAttributeSliderMax] as? Float
           let defaultValue = attribute[kCIAttributeDefault] as? Float
            
            print(minimum)
            print(maximum)
            print(defaultValue)
            
        }
        
       print("inputLayers")
       if let attribute = CIFilter.aztecCodeGenerator().attributes["inputLayers"] as? [String: AnyObject]
       {
          let minimum = attribute[kCIAttributeSliderMin] as? Float
          let maximum = attribute[kCIAttributeSliderMax] as? Float
          let defaultValue = attribute[kCIAttributeDefault] as? Float
           
           print(minimum)
           print(maximum)
           print(defaultValue)
           
       }
        
       print("inputCompactStyle")
       if let attribute = CIFilter.aztecCodeGenerator().attributes["inputCompactStyle"] as? [String: AnyObject]
       {
          let minimum = attribute[kCIAttributeSliderMin] as? Float
          let maximum = attribute[kCIAttributeSliderMax] as? Float
          let defaultValue = attribute[kCIAttributeDefault] as? Float
           
           print(minimum)
           print(maximum)
           print(defaultValue)
           
       }
        

    }

    enum CodingKeys : String, CodingKey {
        case message
        case correctionLevel
        case layers
        case compactStyle
        
    }

    required init(from decoder: Decoder) throws {
        try super.init(from: decoder)
        let values = try decoder.container(keyedBy: CodingKeys.self)
        desc=description
        
        message = try values.decodeIfPresent(String.self, forKey: .message) ?? ""
        correctionLevel = try values.decodeIfPresent(Float.self, forKey: .correctionLevel) ?? 0.0
        layers = try values.decodeIfPresent(Float.self, forKey: .layers) ?? 0.0
        compactStyle = try values.decodeIfPresent(Float.self, forKey: .compactStyle) ?? 0.0

    }
    
    override func encode(to encoder: Encoder) throws {
        try super.encode(to: encoder)
  
        var container = encoder.container(keyedBy: CodingKeys.self)

        try container.encode(message, forKey: .message)
        try container.encode(correctionLevel, forKey: .correctionLevel)
        try container.encode(layers, forKey: .layers)
        try container.encode(compactStyle, forKey: .compactStyle)
    }
    
    override func getCIFilter()->CIFilter?
    {
        var currentCIFilter: CIFilter
        if ciFilter != nil {
            print("current Aztec")
            currentCIFilter = ciFilter!
        } else {
            print("new Aztec")
            currentCIFilter = CIFilter(name: type)!
            ciFilter=currentCIFilter
        }
        
        currentCIFilter.setValue(message.data(using: .utf8), forKey: "inputMessage")
        currentCIFilter.setValue(correctionLevel, forKey: "inputCorrectionLevel")
        currentCIFilter.setValue(layers, forKey: "inputLayers")
        currentCIFilter.setValue(compactStyle, forKey: "inputCompactStyle")

        return currentCIFilter
    }

}
