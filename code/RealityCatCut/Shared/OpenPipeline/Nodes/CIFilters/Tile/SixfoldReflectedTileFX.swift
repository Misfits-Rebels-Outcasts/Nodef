//
//  Copyright © 2022 James Boo. All rights reserved.
//

import SwiftUI

class SixfoldReflectedTileFX: BaseTileFX {
       
    @Published var centerX:Float = 150
    @Published var centerY:Float = 150
    
    @Published var angle:Float = 0.0
    @Published var width:Float = 100.0
    
    let description = "Produces a tiled image from a source image by applying a 6-way reflected symmetry. Width is the width of a tile."
    
    override init()
    {
        let name="CISixfoldReflectedTile"
        super.init(name)
        desc=description
        /*
        print(CIFilter.localizedName(forFilterName: name))
        print(CIFilter.localizedDescription(forFilterName: name))
        print(CIFilter.localizedReferenceDocumentation(forFilterName: name))
        print("inputAngle")
        if let attribute = CIFilter.sixfoldReflectedTile().attributes["inputAngle"] as? [String: AnyObject]
        {
           let minimum = attribute[kCIAttributeSliderMin] as? Float
           let maximum = attribute[kCIAttributeSliderMax] as? Float
           let defaultValue = attribute[kCIAttributeDefault] as? Float
            
            print(minimum)
            print(maximum)
            print(defaultValue)
            
        }
        print("inputWidth")
        if let attribute = CIFilter.sixfoldReflectedTile().attributes["inputWidth"] as? [String: AnyObject]
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
        case centerX
        case centerY
        case angle
        case width
    }

    required init(from decoder: Decoder) throws {
        try super.init(from: decoder)
        let values = try decoder.container(keyedBy: CodingKeys.self)
        desc=description
        

        centerX = try values.decodeIfPresent(Float.self, forKey: .centerX) ?? 0.0
        centerY = try values.decodeIfPresent(Float.self, forKey: .centerY) ?? 0.0

        angle = try values.decodeIfPresent(Float.self, forKey: .angle) ?? 0.0
        width = try values.decodeIfPresent(Float.self, forKey: .width) ?? 0.0

    }
    
    override func encode(to encoder: Encoder) throws {
        try super.encode(to: encoder)
  
        var container = encoder.container(keyedBy: CodingKeys.self)

        try container.encode(centerX, forKey: .centerX)
        try container.encode(centerY, forKey: .centerY)
        try container.encode(angle, forKey: .angle)
        try container.encode(width, forKey: .width)
  
    }
    
    override func setupProperties(_ parent: FiltersX?)
    {
        super.setupProperties(parent)
        
        if parent != nil{
            centerX=Float(size.width/2.0)
            centerY=Float(size.height/2.0)
        }
        
    }
    
    override func adjustPropertiesToBounds(_ parent: FiltersX?)
    {
        super.adjustPropertiesToBounds(parent)
        
        centerX = centerX > Float(size.width) ? Float(size.width) : centerX
        centerY = centerY > Float(size.height) ? Float(size.height) : centerY
        
    }
    
    var sixfoldReflectedTileCIFilter:CIFilter?
    //deprecate
    override func getCIFilter(currentImage: CIImage, beginImage: CIImage) -> CIFilter? {
        
        var sixfoldReflectedTileFilter: CIFilter

        sixfoldReflectedTileFilter = sixfoldReflectedTileCIFilter != nil ? sixfoldReflectedTileCIFilter! : CIFilter(name: type)!
        
        let inputImage=handleAlias(alias: inputImageAlias,
                                      inputImage: currentImage,
                                      beginImage: beginImage)
        
        sixfoldReflectedTileFilter.setValue(inputImage, forKey: kCIInputImageKey)
        let tcenter=CIVector(x:CGFloat(centerX),y:CGFloat(centerY))
        sixfoldReflectedTileFilter.setValue(tcenter, forKey: kCIInputCenterKey)
        sixfoldReflectedTileFilter.setValue(angle, forKey: kCIInputAngleKey)
        sixfoldReflectedTileFilter.setValue(width, forKey: kCIInputWidthKey)


        if cropToFormat{
            super.setCIFilterAndCropImage(inputImage: sixfoldReflectedTileFilter.outputImage!)
            return ciFilter!
        }
        else{
            ciFilter=sixfoldReflectedTileFilter
            return ciFilter!
        }
    }
    //ANCHISES
    override func getCIFilter(_ ciImage: CIImage)->CIFilter
    {

        var sixfoldReflectedTileFilter: CIFilter
        if sixfoldReflectedTileCIFilter != nil {
            sixfoldReflectedTileFilter = sixfoldReflectedTileCIFilter!
        } else {
            sixfoldReflectedTileFilter = CIFilter(name: type)!
            sixfoldReflectedTileCIFilter=sixfoldReflectedTileFilter
    
        }

        sixfoldReflectedTileFilter.setValue(ciImage, forKey: kCIInputImageKey)
        let tcenter=CIVector(x:CGFloat(centerX),y:CGFloat(centerY))
        sixfoldReflectedTileFilter.setValue(tcenter, forKey: kCIInputCenterKey)
        sixfoldReflectedTileFilter.setValue(angle, forKey: kCIInputAngleKey)
        sixfoldReflectedTileFilter.setValue(width, forKey: kCIInputWidthKey)


        if cropToFormat{
            super.setCIFilterAndCropImage(inputImage: sixfoldReflectedTileFilter.outputImage!)
            return ciFilter!
        }
        else{
            ciFilter=sixfoldReflectedTileFilter
            return ciFilter!
        }
    }

}
