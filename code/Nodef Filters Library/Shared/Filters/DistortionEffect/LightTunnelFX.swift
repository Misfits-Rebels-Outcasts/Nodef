//
//  Copyright © 2022 James Boo. All rights reserved.
//

import SwiftUI

class LightTunnelFX: FilterX {
       
    @Published var center:CIVector = CIVector(x:150,y:150)
    @Published var centerX:CGFloat = 150
    @Published var centerY:CGFloat = 150
    @Published var radius:Float = 100.0
    @Published var rotation:Float = 0.0
    let description = "Rotates a portion of the input image specified by the center and radius parameters to give a tunneling effect."

    override init()
    {
        let name="CILightTunnel"
        super.init(name)
        desc=description
        
        print(CIFilter.localizedName(forFilterName: name))
        print(CIFilter.localizedDescription(forFilterName: name))
        print(CIFilter.localizedReferenceDocumentation(forFilterName: name))

        print("inputRadius")
        if let attribute = CIFilter.lightTunnel().attributes["inputRadius"] as? [String: AnyObject]
        {
           let minimum = attribute[kCIAttributeSliderMin] as? Float
           let maximum = attribute[kCIAttributeSliderMax] as? Float
           let defaultValue = attribute[kCIAttributeDefault] as? Float
            
            print(minimum)
            print(maximum)
            print(defaultValue)
            
        }
        print("inputRotation")
        if let attribute = CIFilter.lightTunnel().attributes["inputRotation"] as? [String: AnyObject]
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
        case centerX
        case centerY
        case radius
        case rotation
    }

    required init(from decoder: Decoder) throws {
        try super.init(from: decoder)
        let values = try decoder.container(keyedBy: CodingKeys.self)
        desc=description
        
        centerX = try values.decodeIfPresent(CGFloat.self, forKey: .centerX) ?? 0.0
        centerY = try values.decodeIfPresent(CGFloat.self, forKey: .centerY) ?? 0.0

        radius = try values.decodeIfPresent(Float.self, forKey: .radius) ?? 0.0
        rotation = try values.decodeIfPresent(Float.self, forKey: .rotation) ?? 0.0

    }
    
    override func encode(to encoder: Encoder) throws {
        try super.encode(to: encoder)
  
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(centerX, forKey: .centerX)
        try container.encode(centerY, forKey: .centerY)
        try container.encode(radius, forKey: .radius)
        try container.encode(rotation, forKey: .rotation)
    }
    
    override func setupProperties(_ parent: FiltersX?)
    {
        super.setupProperties(parent)
        
        if parent != nil{
            centerX=size.width/2.0
            centerY=size.height/2.0
        }
        
    }
    
    override func adjustPropertiesToBounds(_ parent: FiltersX?)
    {
        super.adjustPropertiesToBounds(parent)
        
        centerX = centerX > size.width ? size.width : centerX
        centerY = centerY > size.height ? size.height : centerY
        
    }
    
    func setCIFilterAndCropImage(inputImage: CIImage) {

        var cropFilter: CIFilter
        if ciFilter != nil {
            cropFilter = ciFilter!
        } else {
            cropFilter = CIFilter(name: "CICrop")!
        }
        
        cropFilter.setValue(inputImage, forKey: kCIInputImageKey)
        let rect = CIVector(cgRect: CGRect(x:0, y: 0, width: CGFloat(size.width), height: CGFloat(size.height)))
        cropFilter.setValue(rect, forKey: "inputRectangle")
        ciFilter=cropFilter

    }
    
    var lightTunnelCIFilter: CIFilter?
    override func getCIFilter(currentImage: CIImage, beginImage: CIImage) -> CIFilter? {
        
        var lightTunnelFilter: CIFilter

        if lightTunnelCIFilter != nil {
            lightTunnelFilter = lightTunnelCIFilter!
        }
        else{
            lightTunnelFilter = CIFilter(name: type)!
        }
        
        let aliasImage=handleAlias(alias: inputImageAlias,
                                      inputImage: currentImage,
                                      beginImage: beginImage)
        
        lightTunnelFilter.setValue(aliasImage, forKey: kCIInputImageKey)
        let tcenter=CIVector(x:centerX,y:centerY)        
        lightTunnelFilter.setValue(tcenter, forKey: kCIInputCenterKey)
        lightTunnelFilter.setValue(radius, forKey: kCIInputRadiusKey)
        lightTunnelFilter.setValue(rotation, forKey: "inputRotation")
        lightTunnelCIFilter=lightTunnelFilter
                
        setCIFilterAndCropImage(inputImage: lightTunnelFilter.outputImage!)
        return ciFilter
    }

}
