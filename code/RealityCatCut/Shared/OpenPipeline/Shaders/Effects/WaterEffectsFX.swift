//
//  Copyright © 2022 James Boo. All rights reserved.
//

import SwiftUI

class WaterEffectsFX: BaseGeneratorFX {
       
    @Published var timeElapsed:Float = 0.0
    @Published var animType:Float = 0.0
    //check if it is in use
    @Published var regenerate:Bool = false
    
    /*
    @Published var color:CIColor = .red
    @Published var colorx:Color = .red
    */
    let description = "Flowing Water Effects. This is based on a derivation of the Fractal Brownian Motion Noise. See FBM Noise by Morgan McGuire @morgan3d."

    override init()
    {
        let name = "CIWaterEffects"
        super.init(name)
        desc=description
        
        /*
        colorx = Color(red: 0.75, green: 0.70, blue: 0.30)
        color = CIColor(color: UIColor(colorx))
         */
    }

    enum CodingKeys : String, CodingKey {
        case radius
        //case color
    }

    required init(from decoder: Decoder) throws {
        try super.init(from: decoder)
        //let values = try decoder.container(keyedBy: CodingKeys.self)
        desc=description
     
        /*
        let colorData = try values.decodeIfPresent(Data.self, forKey: .color) ?? nil
        if colorData != nil
        {
            let uicolor=try NSKeyedUnarchiver.unarchivedObject(ofClass: UIColor.self, from: colorData!)!
            color = CIColor(color:uicolor)
            colorx = Color(uicolor)
        }
         */
        
    }
    
    override func encode(to encoder: Encoder) throws {
        try super.encode(to: encoder)
        //var container = encoder.container(keyedBy: CodingKeys.self)

        /*
        try container.encode(try NSKeyedArchiver.archivedData(withRootObject: UIColor(ciColor: color), requiringSecureCoding: false), forKey: .color)
        */
    }
    
    override func getCIFilter(_ ciImage: CIImage)->CIFilter
    {
        var currentCIFilter: WaterEffectsFilter
        if ciFilter != nil {
            currentCIFilter = ciFilter as! WaterEffectsFilter
        } else {
            currentCIFilter =  WaterEffectsFilter()
            ciFilter=currentCIFilter
            //regenerate=true
        }

        currentCIFilter.inputImage = ciImage
        //currentCIFilter.inputTime = CGFloat(timeElapsed)
        timeElapsed=Float(timeElapsedX)
        currentCIFilter.inputTime = CGFloat(timeElapsed)
        
        //currentCIFilter.inputAnimType =  CGFloat(animType)
        
        //currentCIFilter.inputAuraMask =  CGFloat(0)
        //currentCIFilter.inputRotation = CGFloat(0)
        //currentCIFilter.inputColor = CIVector(x: 0.5, y: 0.8, z: 1.0)
        //currentCIFilter.param_sampletype =  CGFloat(0)
       
        _ =  CGFloat(0)
        /*
        var inputAuraMask =  CGFloat(0)
        var inputRotation = CGFloat(0)
        var inputTranslationX = CGFloat(0)
        var inputTranslationY =  CGFloat(0)
        var inputScale =   CGFloat(5.0)
        var m_red_base = CGFloat(0.542)
        var m_green_base =  CGFloat(0.752)
        var m_blue_base =  CGFloat(0.942)
        var inputAnimVelocityX  =  CGFloat(0.20)
        var inputAnimVelocityY  =  CGFloat( 0.15)
        var inputAnimScaleX  =  CGFloat(0.4632)
        var inputAnimScaleY  =  CGFloat( 0.7567)
       
        var inputPaletteInterpolation =  CGFloat(0)
        var m_red_base2 = CGFloat(0.75)
        var m_green_base2 =  CGFloat(0.70)
        var m_blue_base2 =  CGFloat(0.30)
        
        currentCIFilter.inputWarpType =  CGFloat(inputWarpType)
        currentCIFilter.inputAuraMask =  CGFloat(inputAuraMask)
        currentCIFilter.inputRotation = CGFloat(inputRotation)
        currentCIFilter.inputColor = CIVector(x: m_red_base,y: m_green_base,z: m_blue_base)
        //currentCIFilter.inputColor = CIVector(x: color.red, y: color.green, z:color.blue)
        
        currentCIFilter.inputTranslation =  CIVector(x:inputTranslationX, y:inputTranslationY)
        currentCIFilter.inputScale =   inputScale
        currentCIFilter.inputAnimVelocity  =  CIVector(x:inputAnimVelocityX,y:inputAnimVelocityY)
        currentCIFilter.inputAnimScale  =   CIVector(x:inputAnimScaleX,y:inputAnimScaleY)
        
        currentCIFilter.inputColor2 = CIVector(x: m_red_base2,y: m_green_base2,z: m_blue_base2)
        currentCIFilter.paletteInterpolate = inputPaletteInterpolation
        */
        
        return currentCIFilter

        
    }

}
