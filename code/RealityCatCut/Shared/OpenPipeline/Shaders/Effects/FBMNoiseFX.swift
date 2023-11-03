//
//  Copyright © 2022 James Boo. All rights reserved.
//

import SwiftUI

class FBMNoiseFX: BaseGeneratorFX {
       
    @Published var timeElapsed:Float = 0.0
    @Published var animType:Float = 0.0
    @Published var regenerate:Bool = false
    let description = "Generates a Fractal Brownian Motion Noise based on an input image size. This is based on the shader originally developed by Morgan McGuire @morgan3d."

    override init()
    {
        let name = "CIFBMNoise"
        super.init(name)
        desc=description
    }

    enum CodingKeys : String, CodingKey {
        case radius
    }

    required init(from decoder: Decoder) throws {
        try super.init(from: decoder)
        _ = try decoder.container(keyedBy: CodingKeys.self)
        desc=description
    }
    
    override func encode(to encoder: Encoder) throws {
        try super.encode(to: encoder)
        _ = encoder.container(keyedBy: CodingKeys.self)

    }
    
    override func getCIFilter(_ ciImage: CIImage)->CIFilter
    {
        var currentCIFilter: FBMNoiseFilter
        if ciFilter != nil {
            currentCIFilter = ciFilter as! FBMNoiseFilter
        } else {
            currentCIFilter =  FBMNoiseFilter()
            ciFilter=currentCIFilter
            //regenerate=true
        }

        currentCIFilter.inputImage = ciImage
        //currentCIFilter.inputTime = CGFloat(timeElapsed)
        timeElapsed=Float(timeElapsedX)
        currentCIFilter.inputTime = CGFloat(timeElapsed)
        
        //all the properties below not yet used
        currentCIFilter.inputAnimType =  CGFloat(animType)
        currentCIFilter.inputAuraMask =  CGFloat(0)
        currentCIFilter.inputRotation = CGFloat(0)
        currentCIFilter.inputColor = CIVector(x: 0.5, y: 0.8, z: 1.0)
        currentCIFilter.param_sampletype =  CGFloat(0)
       
        return currentCIFilter
        
    }

}
