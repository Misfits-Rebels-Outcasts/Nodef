//
//  Copyright © 2022 James Boo. All rights reserved.
//


import SwiftUI

class PerspectiveTransformWithExtentFX: FilterX {
       
    //revisit centerX and centerY with base class conflict explore
    @Published var x:Float = 0.0
    @Published var y:Float = 0.0
    @Published var extentWidth:Float = 300.0
    @Published var extentHeight:Float = 300.0
    
    @Published var topLeftX:Float = 118
    @Published var topLeftY:Float = 484

    @Published var topRightX:Float = 646
    @Published var topRightY:Float = 507

    @Published var bottomRightX:Float = 548
    @Published var bottomRightY:Float = 140

    @Published var bottomLeftX:Float = 155
    @Published var bottomLeftY:Float = 153

    let description = "Alters the geometry of a portion of an image to simulate the observer changing viewing position."

    override init()
    {
        let name="CIPerspectiveTransformWithExtent"
        super.init(name)
        desc=description
        
        print(CIFilter.localizedName(forFilterName: name))
        print(CIFilter.localizedDescription(forFilterName: name))
        print(CIFilter.localizedReferenceDocumentation(forFilterName: name))
        
    }

    enum CodingKeys : String, CodingKey {
        case x
        case y
        case extentWidth
        case extentHeight
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
        
        x = try values.decodeIfPresent(Float.self, forKey: .x) ?? 0
        y = try values.decodeIfPresent(Float.self, forKey: .y) ?? 0
        extentWidth = try values.decodeIfPresent(Float.self, forKey: .extentWidth) ?? 0
        extentHeight = try values.decodeIfPresent(Float.self, forKey: .extentHeight) ?? 0
        
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

        try container.encode(x, forKey: .x)
        try container.encode(y, forKey: .y)
        try container.encode(extentWidth, forKey: .extentWidth)
        try container.encode(extentHeight, forKey: .extentHeight)

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
            x=Float(size.width/3.0)
            y=Float(size.height/3.0)
            extentWidth=Float(size.width/3.0)
            extentHeight=Float(size.height/3.0)

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

        x = x > Float(size.width) ? Float(size.width) : x
        y = y > Float(size.height) ? Float(size.height) : y

        extentWidth = extentWidth > Float(size.width) ? Float(size.width) : extentWidth
        extentHeight = extentHeight > Float(size.height) ? Float(size.height) : extentHeight
        
        topLeftX = topLeftX > Float(size.width) ? Float(size.width) : topLeftX
        topLeftY = topLeftY > Float(size.height) ? Float(size.height) : topLeftY
  
        topRightX = topRightX > Float(size.width) ? Float(size.width) : topRightX
        topRightY = topRightY > Float(size.height) ? Float(size.height) : topRightY
        
        bottomRightX = bottomRightX > Float(size.width) ? Float(size.width) : bottomRightX
        bottomRightY = bottomRightY > Float(size.height) ? Float(size.height) : bottomRightY
        
        bottomLeftX = bottomLeftX > Float(size.width) ? Float(size.width) : bottomLeftX
        bottomLeftY = bottomLeftY > Float(size.height) ? Float(size.height) : bottomLeftY
        
        
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
        let rect = CIVector(cgRect: CGRect(x: CGFloat(x), y: CGFloat(y), width: CGFloat(extentWidth), height: CGFloat(extentHeight)))
        currentCIFilter.setValue(rect, forKey: "InputExtent")
        
        let topLeft=CIVector(x:CGFloat(topLeftX),y:CGFloat(topLeftY))
        currentCIFilter.setValue(topLeft, forKey: "inputTopLeft")

        let topRight=CIVector(x:CGFloat(topRightX),y:CGFloat(topRightY))
        currentCIFilter.setValue(topRight, forKey: "inputTopRight")

        let bottomRight=CIVector(x:CGFloat(bottomRightX),y:CGFloat(bottomRightY))
        currentCIFilter.setValue(bottomRight, forKey: "inputBottomRight")

        let bottomLeft=CIVector(x:CGFloat(bottomLeftX),y:CGFloat(bottomLeftY))
        currentCIFilter.setValue(bottomLeft, forKey: "inputBottomLeft")
        
        return currentCIFilter
        
    }

}
