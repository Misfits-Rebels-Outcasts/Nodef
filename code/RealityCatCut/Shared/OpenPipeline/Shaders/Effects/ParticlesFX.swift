//
//  Copyright © 2022 James Boo. All rights reserved.
//

import SwiftUI

class ParticlesFX: FilterX {
       
    @Published var timeElapsed:Float = 0.0
    @Published var animType:Float = 0.0
    
    //@Published var m_inputAnimType: CGFloat = 0
    //@Published var m_inputFactor: CGFloat = 0
    //@Published var m_inputRotation: CGFloat = 0
    @Published var initvelocityx : Float = 0.5089
    @Published var initvelocityy : Float = 0.1501
    //@Published var m_initcolormodx : CGFloat = 0.3061
    //@Published var m_initcolormody : CGFloat = 0.2403
    @Published var initlocationx : Float = 0.45
    @Published var initlocationy : Float = 0.5
    @Published var vscalingx :  Float = 0.145256
    @Published var vscalingy :  Float = 0.4022
    @Published var accelerationx : Float = -0.043
    @Published var accelerationy : Float =  -0.02
    @Published var timescalingForward : Float = 5.0
    @Published var timescalingRemainder : Float =  5.0
    
    @Published var regenerate:Bool = false
    let description = "A simple 2D Particles effect."

    override init()
    {
        let name = "CIParticles"
        super.init(name)
        desc=description
         
    }

    enum CodingKeys : String, CodingKey {
        case timeElapsed
        case animType
        case initvelocityx
        case initvelocityy
        case initlocationx
        case initlocationy
        case vscalingx
        case vscalingy
        case accelerationx
        case accelerationy
        case timescalingForward
        case timescalingRemainder
    }

    required init(from decoder: Decoder) throws {
        try super.init(from: decoder)
        let values = try decoder.container(keyedBy: CodingKeys.self)
        desc=description
     
        timeElapsed = try values.decodeIfPresent(Float.self, forKey: .timeElapsed) ?? 0.0
        animType = try values.decodeIfPresent(Float.self, forKey: .animType) ?? 0.0
        initvelocityx = try values.decodeIfPresent(Float.self, forKey: .initvelocityx) ?? 0.0
        initvelocityy = try values.decodeIfPresent(Float.self, forKey: .initvelocityy) ?? 0.0
        initlocationx = try values.decodeIfPresent(Float.self, forKey: .initlocationx) ?? 0.0
        initlocationy = try values.decodeIfPresent(Float.self, forKey: .initlocationy) ?? 0.0
        vscalingx = try values.decodeIfPresent(Float.self, forKey: .vscalingx) ?? 0.0
        vscalingy = try values.decodeIfPresent(Float.self, forKey: .vscalingy) ?? 0.0
        accelerationx = try values.decodeIfPresent(Float.self, forKey: .accelerationx) ?? 0.0
        accelerationy = try values.decodeIfPresent(Float.self, forKey: .accelerationy) ?? 0.0
        timescalingForward = try values.decodeIfPresent(Float.self, forKey: .timescalingForward) ?? 0.0
        timescalingRemainder = try values.decodeIfPresent(Float.self, forKey: .timescalingRemainder) ?? 0.0
        
    }
    
    override func encode(to encoder: Encoder) throws {
        try super.encode(to: encoder)
        var container = encoder.container(keyedBy: CodingKeys.self)

        try container.encode(timeElapsed, forKey: .timeElapsed)
        try container.encode(animType, forKey: .animType)
        try container.encode(initvelocityx, forKey: .initvelocityx)
        try container.encode(initvelocityy, forKey: .initvelocityy)
        try container.encode(initlocationx, forKey: .initlocationx)
        try container.encode(initlocationy, forKey: .initlocationy)
        try container.encode(vscalingx, forKey: .vscalingx)
        try container.encode(vscalingy, forKey: .vscalingy)
        try container.encode(accelerationx, forKey: .accelerationx)
        try container.encode(accelerationy, forKey: .accelerationy)
        try container.encode(timescalingForward, forKey: .timescalingForward)
        try container.encode(timescalingRemainder, forKey: .timescalingRemainder)
    }
    
    override func getCIFilter(_ ciImage: CIImage)->CIFilter
    {
        var currentCIFilter: ParticlesFilter
        if ciFilter != nil {
            currentCIFilter = ciFilter as! ParticlesFilter
        } else {
            currentCIFilter =  ParticlesFilter()
            ciFilter=currentCIFilter
            //regenerate=true
        }
        currentCIFilter.inputImage = ciImage
       
        timeElapsed=Float(timeElapsedX)
        currentCIFilter.inputTime = CGFloat(timeElapsed)
        currentCIFilter.inputAnimType =  CGFloat(animType)
        currentCIFilter.initvelocity =  CIVector(x:CGFloat(initvelocityx), y:CGFloat(initvelocityy))
        currentCIFilter.initlocation =  CIVector(x:CGFloat(initlocationx), y:CGFloat(initlocationy))
        currentCIFilter.vscaling =  CIVector(x:CGFloat(vscalingx), y:CGFloat(vscalingy))
        currentCIFilter.acceleration =  CIVector(x:CGFloat(accelerationx), y:CGFloat(accelerationy))
        currentCIFilter.timescaling =  CIVector(x:CGFloat(timescalingForward), y:CGFloat(timescalingRemainder))
        return currentCIFilter
        
    }

}
