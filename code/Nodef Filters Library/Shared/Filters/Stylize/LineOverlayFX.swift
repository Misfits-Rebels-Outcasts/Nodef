//
//  Copyright © 2022 James Boo. All rights reserved.
//

import SwiftUI

class LineOverlayFX: FilterX {
       
    @Published var nRNoiseLevel:Float = 0.07
    @Published var nRSharpness:Float = 0.71
    @Published var edgeIntensity:Float = 1.0
    @Published var threshold:Float = 0.1
    @Published var contrast:Float = 50.0
    
    let description = "Creates a sketch that outlines the edges of an image in black, leaving the non-outlined portions of the image transparent. The result has alpha and is rendered in black, so it won’t look like much until you render it over another image using source over compositing. Contrast is the amount of anti-aliasing to use on the edges produced by this filter. Higher values produce higher contrast edges (they are less anti-aliased). Edge Intensity is the accentuation factor of the Sobel gradient information when tracing the edges of the image. Higher values find more edges, although typically a low value (such as 1.0) is used. NR Noise Level is the noise level of the image (used with camera data) that gets removed before tracing the edges of the image. Increasing the noise level helps to clean up the traced edges of the image. NR Sharpness is the amount of sharpening done when removing noise in the image before tracing the edges of the image. This improves the edge acquisition. Threshold determines edge visibility. Larger values thin out the edges."
       
    //revisit can view without overlay
    //let description = "Creates a sketch that outlines the edges of an image in black."

    override init()
    {
        let name="CILineOverlay"
        super.init(name)
        desc=description
        
        print(CIFilter.localizedName(forFilterName: name))
        print(CIFilter.localizedDescription(forFilterName: name))
        print(CIFilter.localizedReferenceDocumentation(forFilterName: name))
        
        print("inputNRNoiseLevel")
        if let attribute = CIFilter.lineOverlay().attributes["inputNRNoiseLevel"] as? [String: AnyObject]
        {
           let minimum = attribute[kCIAttributeSliderMin] as? Float
           let maximum = attribute[kCIAttributeSliderMax] as? Float
           let defaultValue = attribute[kCIAttributeDefault] as? Float
            
            print(minimum)
            print(maximum)
            print(defaultValue)
            
        }
        print("inputNRSharpness")
        if let attribute = CIFilter.lineOverlay().attributes["inputNRSharpness"] as? [String: AnyObject]
        {
           let minimum = attribute[kCIAttributeSliderMin] as? Float
           let maximum = attribute[kCIAttributeSliderMax] as? Float
           let defaultValue = attribute[kCIAttributeDefault] as? Float
            
            print(minimum)
            print(maximum)
            print(defaultValue)
            
        }

        print("inputEdgeIntensity")
        if let attribute = CIFilter.lineOverlay().attributes["inputEdgeIntensity"] as? [String: AnyObject]
        {
           let minimum = attribute[kCIAttributeSliderMin] as? Float
           let maximum = attribute[kCIAttributeSliderMax] as? Float
           let defaultValue = attribute[kCIAttributeDefault] as? Float
            
            print(minimum)
            print(maximum)
            print(defaultValue)
            
        }

        print("inputThreshold")
        if let attribute = CIFilter.lineOverlay().attributes["inputThreshold"] as? [String: AnyObject]
        {
           let minimum = attribute[kCIAttributeSliderMin] as? Float
           let maximum = attribute[kCIAttributeSliderMax] as? Float
           let defaultValue = attribute[kCIAttributeDefault] as? Float
            
            print(minimum)
            print(maximum)
            print(defaultValue)
            
        }

        print("inputContrast")
        if let attribute = CIFilter.lineOverlay().attributes["inputContrast"] as? [String: AnyObject]
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
        case nRNoiseLevel
        case nRSharpness
        case edgeIntensity
        case threshold
        case contrast
    }

    required init(from decoder: Decoder) throws {
        try super.init(from: decoder)
        let values = try decoder.container(keyedBy: CodingKeys.self)
        desc=description
        
        nRNoiseLevel = try values.decodeIfPresent(Float.self, forKey: .nRNoiseLevel) ?? 0
        nRSharpness = try values.decodeIfPresent(Float.self, forKey: .nRSharpness) ?? 0
        edgeIntensity = try values.decodeIfPresent(Float.self, forKey: .edgeIntensity) ?? 0
        threshold = try values.decodeIfPresent(Float.self, forKey: .threshold) ?? 0
        contrast = try values.decodeIfPresent(Float.self, forKey: .contrast) ?? 0

    }
    
    override func encode(to encoder: Encoder) throws {
        try super.encode(to: encoder)
  
        var container = encoder.container(keyedBy: CodingKeys.self)

        try container.encode(nRNoiseLevel, forKey: .nRNoiseLevel)
        try container.encode(nRSharpness, forKey: .nRSharpness)
        try container.encode(edgeIntensity, forKey: .edgeIntensity)
        try container.encode(threshold, forKey: .threshold)
        try container.encode(contrast, forKey: .contrast)

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
        currentCIFilter.setValue(nRNoiseLevel, forKey: "inputNRNoiseLevel")
        currentCIFilter.setValue(nRSharpness, forKey: "inputNRSharpness")
        currentCIFilter.setValue(edgeIntensity, forKey: "inputEdgeIntensity")
        currentCIFilter.setValue(threshold, forKey: "inputThreshold")
        currentCIFilter.setValue(contrast, forKey: "inputContrast")

        return currentCIFilter
        
    }

}
