//
//  Copyright © 2022 James Boo. All rights reserved.
//

import SwiftUI

class PerspectiveTileFX: BaseTileFX {
       
    //revisit set values for change
    @Published var topLeftX:Float = 118
    @Published var topLeftY:Float = 484

    @Published var topRightX:Float = 646
    @Published var topRightY:Float = 507

    @Published var bottomRightX:Float = 548
    @Published var bottomRightY:Float = 140

    @Published var bottomLeftX:Float = 155
    @Published var bottomLeftY:Float = 153

    let description = "Applies a perspective transform to an image and then tiles the result. Width is the width of a tile."
    
    override init()
    {
        let name="CIPerspectiveTile"
        super.init(name)
        desc=description
        /*
        print(CIFilter.localizedName(forFilterName: name))
        print(CIFilter.localizedDescription(forFilterName: name))
        print(CIFilter.localizedReferenceDocumentation(forFilterName: name))
         */
        
    }

    enum CodingKeys : String, CodingKey {
        case topLeftX
        case topLeftY
        case topRightX
        case topRightY
        case bottomRightX
        case bottomRightY
        case bottomLeftX
        case bottomLeftY

    }

    required init(from decoder: Decoder) throws {
        try super.init(from: decoder)
        let values = try decoder.container(keyedBy: CodingKeys.self)
        desc=description
        

        topLeftX = try values.decodeIfPresent(Float.self, forKey: .topLeftX) ?? 0.0
        topLeftY = try values.decodeIfPresent(Float.self, forKey: .topLeftY) ?? 0.0

        topRightX = try values.decodeIfPresent(Float.self, forKey: .topRightX) ?? 0.0
        topRightY = try values.decodeIfPresent(Float.self, forKey: .topRightY) ?? 0.0

        bottomRightX = try values.decodeIfPresent(Float.self, forKey: .bottomRightX) ?? 0.0
        bottomRightY = try values.decodeIfPresent(Float.self, forKey: .bottomRightY) ?? 0.0

        bottomLeftX = try values.decodeIfPresent(Float.self, forKey: .bottomLeftX) ?? 0.0
        bottomLeftY = try values.decodeIfPresent(Float.self, forKey: .bottomLeftY) ?? 0.0


    }
    
    override func encode(to encoder: Encoder) throws {
        try super.encode(to: encoder)
  
        var container = encoder.container(keyedBy: CodingKeys.self)

        try container.encode(topLeftX, forKey: .topLeftX)
        try container.encode(topLeftY, forKey: .topLeftY)

        try container.encode(topRightX, forKey: .topRightX)
        try container.encode(topRightY, forKey: .topRightY)
        
        try container.encode(bottomRightX, forKey: .bottomRightX)
        try container.encode(bottomRightY, forKey: .bottomRightY)
        
        try container.encode(bottomLeftX, forKey: .bottomLeftX)
        try container.encode(bottomLeftY, forKey: .bottomLeftY)
  
    }
    
    override func setupProperties(_ parent: FiltersX?)
    {
        super.setupProperties(parent)
        
        if parent != nil{
            topLeftX=0
            topLeftY=Float(size.height)

            topRightX=Float(size.width)
            topRightY=Float(size.height)

            bottomRightX=Float(size.width)
            bottomRightY=0
            
            bottomLeftX=0
            bottomLeftY=0
        }
        
    }
    
    override func adjustPropertiesToBounds(_ parent: FiltersX?)
    {
        super.adjustPropertiesToBounds(parent)
        
        topLeftX = topLeftX > Float(size.width) ? Float(size.width) : topLeftX
        topLeftY = topLeftY > Float(size.height) ? Float(size.height) : topLeftY
  
        topRightX = topRightX > Float(size.width) ? Float(size.width) : topRightX
        topRightY = topRightY > Float(size.height) ? Float(size.height) : topRightY
        
        bottomRightX = bottomRightX > Float(size.width) ? Float(size.width) : bottomRightX
        bottomRightY = bottomRightY > Float(size.height) ? Float(size.height) : bottomRightY
        
        bottomLeftX = bottomLeftX > Float(size.width) ? Float(size.width) : bottomLeftX
        bottomLeftY = bottomLeftY > Float(size.height) ? Float(size.height) : bottomLeftY
        
        
    }
    
    
    var perspectiveTileCIFilter:CIFilter?
    //deprecate
    override func getCIFilter(currentImage: CIImage, beginImage: CIImage) -> CIFilter? {
        
        var perspectiveTileFilter: CIFilter

        perspectiveTileFilter = perspectiveTileCIFilter != nil ? perspectiveTileCIFilter! : CIFilter(name: type)!
        
        let inputImage=handleAlias(alias: inputImageAlias,
                                      inputImage: currentImage,
                                      beginImage: beginImage)
        perspectiveTileFilter.setValue(inputImage, forKey: kCIInputImageKey)
        
        let topLeft=CIVector(x:CGFloat(topLeftX),y:CGFloat(topLeftY))
        perspectiveTileFilter.setValue(topLeft, forKey: "inputTopLeft")

        let topRight=CIVector(x:CGFloat(topRightX),y:CGFloat(topRightY))
        perspectiveTileFilter.setValue(topRight, forKey: "inputTopRight")

        let bottomRight=CIVector(x:CGFloat(bottomRightX),y:CGFloat(bottomRightY))
        perspectiveTileFilter.setValue(bottomRight, forKey: "inputBottomRight")

        let bottomLeft=CIVector(x:CGFloat(bottomLeftX),y:CGFloat(bottomLeftY))
        perspectiveTileFilter.setValue(bottomLeft, forKey: "inputBottomLeft")

        if cropToFormat{
            super.setCIFilterAndCropImage(inputImage: perspectiveTileFilter.outputImage!)
            return ciFilter!
        }
        else{
            ciFilter=perspectiveTileFilter
            return ciFilter!
        }
        
        
    }
    //ANCHISES
    override func getCIFilter(_ ciImage: CIImage)->CIFilter
    {
        
        var perspectiveTileFilter: CIFilter
        if perspectiveTileCIFilter != nil {
            perspectiveTileFilter = perspectiveTileCIFilter!
        } else {
            perspectiveTileFilter = CIFilter(name: type)!
            perspectiveTileCIFilter=perspectiveTileFilter
 
        }
        
        perspectiveTileFilter.setValue(ciImage, forKey: kCIInputImageKey)
        
        let topLeft=CIVector(x:CGFloat(topLeftX),y:CGFloat(topLeftY))
        perspectiveTileFilter.setValue(topLeft, forKey: "inputTopLeft")

        let topRight=CIVector(x:CGFloat(topRightX),y:CGFloat(topRightY))
        perspectiveTileFilter.setValue(topRight, forKey: "inputTopRight")

        let bottomRight=CIVector(x:CGFloat(bottomRightX),y:CGFloat(bottomRightY))
        perspectiveTileFilter.setValue(bottomRight, forKey: "inputBottomRight")

        let bottomLeft=CIVector(x:CGFloat(bottomLeftX),y:CGFloat(bottomLeftY))
        perspectiveTileFilter.setValue(bottomLeft, forKey: "inputBottomLeft")

        if cropToFormat{
            super.setCIFilterAndCropImage(inputImage: perspectiveTileFilter.outputImage!)
            return ciFilter!
        }
        else{
            ciFilter=perspectiveTileFilter
            return ciFilter!
        }
        
    }

}
