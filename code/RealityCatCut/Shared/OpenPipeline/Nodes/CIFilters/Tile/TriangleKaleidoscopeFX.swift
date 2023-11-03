//
//  Copyright © 2022 James Boo. All rights reserved.
//


import SwiftUI

class TriangleKaleidoscopeFX: BaseTileFX {
       
    @Published var pointX:Float = 150
    @Published var pointY:Float = 150
    @Published var tksize:Float = 700
    @Published var rotation:Float = 0.0//-0.36
    @Published var decay:Float = 0.85

    let description = "Maps a triangular portion of an input image to create a kaleidoscope effect. Decay determines how fast the color fades from the center triangle. Size is the size of the triangles in pixels." 
    
    override init()
    {
        let name="CITriangleKaleidoscope"
        super.init(name)
        desc=description
        /*
        print(CIFilter.localizedName(forFilterName: name))
        print(CIFilter.localizedDescription(forFilterName: name))
        print(CIFilter.localizedReferenceDocumentation(forFilterName: name))
        print("inputSize")
        if let attribute = CIFilter.triangleKaleidoscope().attributes["inputSize"] as? [String: AnyObject]
        {
           let minimum = attribute[kCIAttributeSliderMin] as? Float
           let maximum = attribute[kCIAttributeSliderMax] as? Float
           let defaultValue = attribute[kCIAttributeDefault] as? Float
            
            print(minimum)
            print(maximum)
            print(defaultValue)
            
        }
        print("inputRotation")
        if let attribute = CIFilter.triangleKaleidoscope().attributes["inputRotation"] as? [String: AnyObject]
        {
           let minimum = attribute[kCIAttributeSliderMin] as? Float
           let maximum = attribute[kCIAttributeSliderMax] as? Float
           let defaultValue = attribute[kCIAttributeDefault] as? Float
            
            print(minimum)
            print(maximum)
            print(defaultValue)
            
        }
        print("inputDecay")
        if let attribute = CIFilter.triangleKaleidoscope().attributes["inputDecay"] as? [String: AnyObject]
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
        case pointX
        case pointY
        case tksize
        case rotation
        case decay
    }

    required init(from decoder: Decoder) throws {
        try super.init(from: decoder)
        let values = try decoder.container(keyedBy: CodingKeys.self)
        desc=description
        

        pointX = try values.decodeIfPresent(Float.self, forKey: .pointX) ?? 0.0
        pointY = try values.decodeIfPresent(Float.self, forKey: .pointY) ?? 0.0

        tksize = try values.decodeIfPresent(Float.self, forKey: .tksize) ?? 0.0
        rotation = try values.decodeIfPresent(Float.self, forKey: .rotation) ?? 0.0
        decay = try values.decodeIfPresent(Float.self, forKey: .decay) ?? 0.0

    }
    
    override func encode(to encoder: Encoder) throws {
        try super.encode(to: encoder)
  
        var container = encoder.container(keyedBy: CodingKeys.self)

        try container.encode(pointX, forKey: .pointX)
        try container.encode(pointY, forKey: .pointY)
        try container.encode(tksize, forKey: .tksize)
        try container.encode(rotation, forKey: .rotation)
        try container.encode(decay, forKey: .decay)

    }
    
    override func setupProperties(_ parent: FiltersX?)
    {
        super.setupProperties(parent)
        
        if parent != nil{
            pointX=Float(size.width/2.0)
            pointY=Float(size.height/2.0)
        }
        
    }
    
    override func adjustPropertiesToBounds(_ parent: FiltersX?)
    {
        super.adjustPropertiesToBounds(parent)
        
        pointX = pointX > Float(size.width) ? Float(size.width) : pointX
        pointY = pointY > Float(size.height) ? Float(size.height) : pointY
        
    }
    
    var trikaleidoscopeCIFilter:CIFilter?
    //deprecate
    override func getCIFilter(currentImage: CIImage, beginImage: CIImage) -> CIFilter? {
        
        var trikaleidoscopeFilter: CIFilter

        trikaleidoscopeFilter = trikaleidoscopeCIFilter != nil ? trikaleidoscopeCIFilter! : CIFilter(name: type)!
        
        let inputImage=handleAlias(alias: inputImageAlias,
                                      inputImage: currentImage,
                                      beginImage: beginImage)
        
        trikaleidoscopeFilter.setValue(inputImage, forKey: kCIInputImageKey)
        let pt=CIVector(x:CGFloat(pointX),y:CGFloat(pointY))
        trikaleidoscopeFilter.setValue(pt, forKey: "inputPoint")
        
        trikaleidoscopeFilter.setValue(tksize, forKey: "inputSize")
        trikaleidoscopeFilter.setValue(rotation, forKey: "inputRotation")
        trikaleidoscopeFilter.setValue(decay, forKey: "inputDecay")

        if cropToFormat{
            super.setCIFilterAndCropImage(inputImage: trikaleidoscopeFilter.outputImage!)
            return ciFilter!
        }
        else{
            ciFilter=trikaleidoscopeFilter
            return ciFilter!
        }
        
        
    }
    //ANCHISES
    override func getCIFilter(_ ciImage: CIImage)->CIFilter
    {
        
        var trikaleidoscopeFilter: CIFilter
        if trikaleidoscopeCIFilter != nil {
            trikaleidoscopeFilter = trikaleidoscopeCIFilter!
        } else {
            trikaleidoscopeFilter = CIFilter(name: type)!
            trikaleidoscopeCIFilter=trikaleidoscopeFilter
 
        }
        
        trikaleidoscopeFilter.setValue(ciImage, forKey: kCIInputImageKey)
        let pt=CIVector(x:CGFloat(pointX),y:CGFloat(pointY))
        trikaleidoscopeFilter.setValue(pt, forKey: "inputPoint")
        
        trikaleidoscopeFilter.setValue(tksize, forKey: "inputSize")
        trikaleidoscopeFilter.setValue(rotation, forKey: "inputRotation")
        trikaleidoscopeFilter.setValue(decay, forKey: "inputDecay")

        if cropToFormat{
            super.setCIFilterAndCropImage(inputImage: trikaleidoscopeFilter.outputImage!)
            return ciFilter!
        }
        else{
            ciFilter=trikaleidoscopeFilter
            return ciFilter!
        }
        
    }

}
