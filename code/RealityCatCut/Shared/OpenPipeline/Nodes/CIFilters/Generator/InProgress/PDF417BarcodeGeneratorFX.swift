//
//  Copyright © 2022 James Boo. All rights reserved.
//


import SwiftUI

class PDF417BarcodeGeneratorFX: BaseGeneratorFX {
       
    @Published var message:String = "12345678"

    @Published var minWidth:Float = 0.0
    @Published var maxWidth:Float = 0.0
    @Published var minHeight:Float = 0.0
    @Published var maxHeight:Float = 0.0
    @Published var dataColumns:Float = 3.0
    @Published var rows:Float = 3.0
    @Published var preferredAspectRatio:Float = 0.0
    @Published var compactionMode:Float = 0.0
    @Published var compactStyle:Float = 0.0
    @Published var correctionLevel:Float = 0.0
    @Published var alwaysSpecifyCompaction:Float = 0.0

    let description = "Generates a PDF417 code (two-dimensional barcode) from input data."

    override init()
    {
        let name="CIPDF417BarcodeGenerator"
        super.init(name)
        desc=description
        /*
        print(CIFilter.localizedName(forFilterName: name))
        print(CIFilter.localizedDescription(forFilterName: name))
        print(CIFilter.localizedReferenceDocumentation(forFilterName: name))

        
        print("inputMinWidth")
        if let attribute = CIFilter.pdf417BarcodeGenerator().attributes["inputMinWidth"] as? [String: AnyObject]
        {
           let minimum = attribute[kCIAttributeSliderMin] as? Float
           let maximum = attribute[kCIAttributeSliderMax] as? Float
           let defaultValue = attribute[kCIAttributeDefault] as? Float
            
            print(minimum)
            print(maximum)
            print(defaultValue)
            
        }
        print("inputMaxWidth")
        if let attribute = CIFilter.pdf417BarcodeGenerator().attributes["inputMaxWidth"] as? [String: AnyObject]
        {
           let minimum = attribute[kCIAttributeSliderMin] as? Float
           let maximum = attribute[kCIAttributeSliderMax] as? Float
           let defaultValue = attribute[kCIAttributeDefault] as? Float
            
            print(minimum)
            print(maximum)
            print(defaultValue)
            
        }
        print("inputMinHeight")
        if let attribute = CIFilter.pdf417BarcodeGenerator().attributes["inputMinHeight"] as? [String: AnyObject]
        {
           let minimum = attribute[kCIAttributeSliderMin] as? Float
           let maximum = attribute[kCIAttributeSliderMax] as? Float
           let defaultValue = attribute[kCIAttributeDefault] as? Float
            
            print(minimum)
            print(maximum)
            print(defaultValue)
            
        }
        print("inputMaxHeight")
        if let attribute = CIFilter.pdf417BarcodeGenerator().attributes["inputMaxHeight"] as? [String: AnyObject]
        {
           let minimum = attribute[kCIAttributeSliderMin] as? Float
           let maximum = attribute[kCIAttributeSliderMax] as? Float
           let defaultValue = attribute[kCIAttributeDefault] as? Float
            
            print(minimum)
            print(maximum)
            print(defaultValue)
            
        }
        print("inputDataColumns")
        if let attribute = CIFilter.pdf417BarcodeGenerator().attributes["inputDataColumns"] as? [String: AnyObject]
        {
           let minimum = attribute[kCIAttributeSliderMin] as? Float
           let maximum = attribute[kCIAttributeSliderMax] as? Float
           let defaultValue = attribute[kCIAttributeDefault] as? Float
            
            print(minimum)
            print(maximum)
            print(defaultValue)
            
        }
        print("inputRows")
        if let attribute = CIFilter.pdf417BarcodeGenerator().attributes["inputRows"] as? [String: AnyObject]
        {
           let minimum = attribute[kCIAttributeSliderMin] as? Float
           let maximum = attribute[kCIAttributeSliderMax] as? Float
           let defaultValue = attribute[kCIAttributeDefault] as? Float
            
            print(minimum)
            print(maximum)
            print(defaultValue)
            
        }
        print("inputPreferredAspectRatio")
        if let attribute = CIFilter.pdf417BarcodeGenerator().attributes["inputPreferredAspectRatio"] as? [String: AnyObject]
        {
           let minimum = attribute[kCIAttributeSliderMin] as? Float
           let maximum = attribute[kCIAttributeSliderMax] as? Float
           let defaultValue = attribute[kCIAttributeDefault] as? Float
            
            print(minimum)
            print(maximum)
            print(defaultValue)
            
        }
        print("inputCompactionMode")
        if let attribute = CIFilter.pdf417BarcodeGenerator().attributes["inputCompactionMode"] as? [String: AnyObject]
        {
           let minimum = attribute[kCIAttributeSliderMin] as? Float
           let maximum = attribute[kCIAttributeSliderMax] as? Float
           let defaultValue = attribute[kCIAttributeDefault] as? Float
            
            print(minimum)
            print(maximum)
            print(defaultValue)
            
        }
        print("inputCompactStyle")
        if let attribute = CIFilter.pdf417BarcodeGenerator().attributes["inputCompactStyle"] as? [String: AnyObject]
        {
           let minimum = attribute[kCIAttributeSliderMin] as? Float
           let maximum = attribute[kCIAttributeSliderMax] as? Float
           let defaultValue = attribute[kCIAttributeDefault] as? Float
            
            print(minimum)
            print(maximum)
            print(defaultValue)
            
        }
        print("inputCorrectionLevel")
        if let attribute = CIFilter.pdf417BarcodeGenerator().attributes["inputCorrectionLevel"] as? [String: AnyObject]
        {
           let minimum = attribute[kCIAttributeSliderMin] as? Float
           let maximum = attribute[kCIAttributeSliderMax] as? Float
           let defaultValue = attribute[kCIAttributeDefault] as? Float
            
            print(minimum)
            print(maximum)
            print(defaultValue)
            
        }
        print("inputAlwaysSpecifyCompaction")
        if let attribute = CIFilter.pdf417BarcodeGenerator().attributes["inputAlwaysSpecifyCompaction"] as? [String: AnyObject]
        {
           let minimum = attribute[kCIAttributeSliderMin] as? Float
           let maximum = attribute[kCIAttributeSliderMax] as? Float
           let defaultValue = attribute[kCIAttributeDefault] as? Float
            
            print(minimum)
            print(maximum)
            print(defaultValue)
            
        }
         */
        
  
    }

    enum CodingKeys : String, CodingKey {
        case message
        case minWidth
        case maxWidth
        case minHeight
        case maxHeight
        case dataColumns
        case rows
        case preferredAspectRatio
        case compactionMode
        case compactStyle
        case correctionLevel
        case alwaysSpecifyCompaction

    }

    required init(from decoder: Decoder) throws {
        try super.init(from: decoder)
        let values = try decoder.container(keyedBy: CodingKeys.self)
        desc=description
        
        message = try values.decodeIfPresent(String.self, forKey: .message) ?? ""
        minWidth = try values.decodeIfPresent(Float.self, forKey: .minWidth) ?? 0.0
        
        maxWidth = try values.decodeIfPresent(Float.self, forKey: .maxWidth) ?? 0.0
        minHeight = try values.decodeIfPresent(Float.self, forKey: .minHeight) ?? 0.0
        maxHeight = try values.decodeIfPresent(Float.self, forKey: .maxHeight) ?? 0.0

        dataColumns = try values.decodeIfPresent(Float.self, forKey: .dataColumns) ?? 0.0
        rows = try values.decodeIfPresent(Float.self, forKey: .rows) ?? 0.0
        preferredAspectRatio = try values.decodeIfPresent(Float.self, forKey: .preferredAspectRatio) ?? 0.0
        compactionMode = try values.decodeIfPresent(Float.self, forKey: .compactionMode) ?? 0.0
        compactStyle = try values.decodeIfPresent(Float.self, forKey: .compactStyle) ?? 0.0
        correctionLevel = try values.decodeIfPresent(Float.self, forKey: .correctionLevel) ?? 0.0
        alwaysSpecifyCompaction = try values.decodeIfPresent(Float.self, forKey: .alwaysSpecifyCompaction) ?? 0.0
        
    }
    
    override func encode(to encoder: Encoder) throws {
        try super.encode(to: encoder)
  
        var container = encoder.container(keyedBy: CodingKeys.self)

        try container.encode(message, forKey: .message)
        
        try container.encode(minWidth, forKey: .minWidth)
        try container.encode(maxWidth, forKey: .maxWidth)
        try container.encode(minHeight, forKey: .minHeight)
        try container.encode(maxHeight, forKey: .maxHeight)
        try container.encode(dataColumns, forKey: .dataColumns)
        try container.encode(rows, forKey: .rows)
        try container.encode(preferredAspectRatio, forKey: .preferredAspectRatio)
        try container.encode(compactionMode, forKey: .compactionMode)
        try container.encode(compactStyle, forKey: .compactStyle)
        try container.encode(correctionLevel, forKey: .correctionLevel)
        try container.encode(alwaysSpecifyCompaction, forKey: .alwaysSpecifyCompaction)

    }
    
    override func getCIFilter()->CIFilter?
    {
        var currentCIFilter: CIFilter
        if ciFilter != nil {
            print("current PDF417")
            currentCIFilter = ciFilter!
        } else {
            print("new PDF417")
            currentCIFilter = CIFilter(name: type)!
            ciFilter=currentCIFilter
        }
        
        currentCIFilter.setValue(message.data(using: .utf8), forKey: "inputMessage")
        currentCIFilter.setValue(minWidth, forKey: "inputMinWidth")
        currentCIFilter.setValue(maxWidth, forKey: "inputMaxWidth")
        currentCIFilter.setValue(minHeight, forKey: "inputMinHeight")
        currentCIFilter.setValue(maxHeight, forKey: "inputMaxHeight")
        currentCIFilter.setValue(dataColumns, forKey: "inputDataColumns")
        currentCIFilter.setValue(rows, forKey: "inputRows")
        currentCIFilter.setValue(preferredAspectRatio, forKey: "inputPreferredAspectRatio")
        currentCIFilter.setValue(compactionMode, forKey: "inputCompactionMode")
        currentCIFilter.setValue(compactStyle, forKey: "inputCompactStyle")
        currentCIFilter.setValue(correctionLevel, forKey: "inputCorrectionLevel")
        currentCIFilter.setValue(alwaysSpecifyCompaction, forKey: "inputAlwaysSpecifyCompaction")
   
        return currentCIFilter
    }

}
