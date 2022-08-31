//
//  Copyright © 2022 James Boo. All rights reserved.
//

import SwiftUI

class Code128BarcodeGeneratorFX: BaseGeneratorFX {
       
    @Published var message:String = "12345678"
    @Published var quietSpace:Float = 7.0 //a 10.0
    
    let description = "Generate a Code 128 barcode image for message data."

    override init()
    {
        let name="CICode128BarcodeGenerator"
        super.init(name)
        desc=description
        
        print(CIFilter.localizedName(forFilterName: name))
        print(CIFilter.localizedDescription(forFilterName: name))
        print(CIFilter.localizedReferenceDocumentation(forFilterName: name))
    
        print("inputQuietSpace")
        if let attribute = CIFilter.code128BarcodeGenerator().attributes["inputQuietSpace"] as? [String: AnyObject]
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
        case quietSpace
    }

    required init(from decoder: Decoder) throws {
        try super.init(from: decoder)
        let values = try decoder.container(keyedBy: CodingKeys.self)
        desc=description
        
        message = try values.decodeIfPresent(String.self, forKey: .message) ?? ""
        quietSpace = try values.decodeIfPresent(Float.self, forKey: .quietSpace) ?? 0.0

    }
    
    override func encode(to encoder: Encoder) throws {
        try super.encode(to: encoder)
  
        var container = encoder.container(keyedBy: CodingKeys.self)

        try container.encode(message, forKey: .message)
        try container.encode(quietSpace, forKey: .quietSpace)
    }
    
    override func getCIFilter()->CIFilter?
    {
        var currentCIFilter: CIFilter
        if ciFilter != nil {
            print("current Constant Color")
            currentCIFilter = ciFilter!
        } else {
            print("new Constant Color")
            currentCIFilter = CIFilter(name: type)!
            ciFilter=currentCIFilter
        }
        
        currentCIFilter.setValue(message.data(using: .utf8), forKey: "inputMessage")
        currentCIFilter.setValue(quietSpace, forKey: "inputQuietSpace")

        return currentCIFilter
    }

}
