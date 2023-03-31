//
//  Copyright © 2022 James Boo. All rights reserved.
//

import SwiftUI

class FractalFlowNoiseFX: FilterX {

    @Published var inputMaskImageAlias : String=""
    @Published var inputMaskImageAliasId : String=""
    
    @Published var timeElapsed:Float = 0.0
    @Published var indexOriginalImageColor:Bool = false

    @Published var animType:Float = 5.0
    @Published var maskEffect:Float = 7.0//5.0
    
    @Published var color:CIColor = .red
    @Published var colorx:Color = .red
    
    @Published var m_flowMaskType:Float = 4
    @Published var m_flowBlend:Float = 0.0//2.0
    
    @Published var param_direction_deg:Float = 0.0
    @Published var param_expon:Float = 0.9
    @Published var param_strength:Float = 0.5
    @Published var param_layerscale:Float = 0.1356
    @Published var param_layervelocity:Float = 0.132135
    @Published var param_sampletype:Float = 0.0
    @Published var param_mipmaptype:Float = 2.0
    
    @Published var m_textMaskStr : String = "Text \u{2022} String"
    @Published var m_textsize = 140.0//60.0*5

    @Published var regenerate:Bool = false
    let description = "Fractal Flow Noise is a fractal sum of a given image."

    override init()
    {
        let name = "CIFractalFlowNoise"
        super.init(name)
        desc=description
         
        colorx = Color(red: 0.15, green: 0.06, blue: 0.01)
        color = CIColor(color: UIColor(colorx))
    }

    enum CodingKeys : String, CodingKey {
        case inputMaskImageAlias
        case animType
        case color
        
        case param_direction_deg
        case param_expon
        case param_strength
        case param_layerscale
        case param_layervelocity
        case param_sampletype
        case param_mipmaptype
    }

    required init(from decoder: Decoder) throws {
        try super.init(from: decoder)
        let values = try decoder.container(keyedBy: CodingKeys.self)
        desc=description
        inputMaskImageAlias = try values.decodeIfPresent(String.self, forKey: .inputMaskImageAlias) ?? ""
        
        animType = try values.decodeIfPresent(Float.self, forKey: .animType) ?? 5.0

        if animType == 4.0 {
            indexOriginalImageColor=true
        }
        else {
            indexOriginalImageColor=false
        }
            
        let colorData = try values.decodeIfPresent(Data.self, forKey: .color) ?? nil
        if colorData != nil
        {
            let uicolor=try NSKeyedUnarchiver.unarchivedObject(ofClass: UIColor.self, from: colorData!)!
            color = CIColor(color:uicolor)
            colorx = Color(uicolor)
        }
        param_direction_deg = try values.decodeIfPresent(Float.self, forKey: .param_direction_deg) ?? 0.0
        param_expon = try values.decodeIfPresent(Float.self, forKey: .param_expon) ?? 0.0
        param_strength = try values.decodeIfPresent(Float.self, forKey: .param_strength) ?? 0.0
        param_direction_deg = try values.decodeIfPresent(Float.self, forKey: .param_direction_deg) ?? 0.0
        param_layerscale = try values.decodeIfPresent(Float.self, forKey: .param_layerscale) ?? 0.0
        param_layervelocity = try values.decodeIfPresent(Float.self, forKey: .param_layervelocity) ?? 0.0
        param_sampletype = try values.decodeIfPresent(Float.self, forKey: .param_sampletype) ?? 0.0
        param_mipmaptype = try values.decodeIfPresent(Float.self, forKey: .param_mipmaptype) ?? 0.0

    }
    
    override func encode(to encoder: Encoder) throws {
        try super.encode(to: encoder)
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(inputMaskImageAlias, forKey: .inputMaskImageAlias)
        
        try container.encode(animType, forKey: .animType)
        
        
        try container.encode(try NSKeyedArchiver.archivedData(withRootObject: UIColor(ciColor: color), requiringSecureCoding: false), forKey: .color)
        
        try container.encode(param_direction_deg, forKey: .param_direction_deg)
        try container.encode(param_expon, forKey: .param_expon)
        try container.encode(param_strength, forKey: .param_strength)
        try container.encode(param_direction_deg, forKey: .param_direction_deg)
        try container.encode(param_layerscale, forKey: .param_layerscale)
        try container.encode(param_layervelocity, forKey: .param_layervelocity)
        try container.encode(param_sampletype, forKey: .param_sampletype)
        try container.encode(param_mipmaptype, forKey: .param_mipmaptype)

    }
    /*
    override func getDisplayNameFX() -> String
    {

        var fxStr = "" //retName
        var previousStr="previous"
        if nodeIndex == 1 {
            previousStr="0"//"0 (original image)"
        }
        else {
            previousStr="" + String(nodeIndex-1)
        }
            
        var inputImageAliasStr = previousStr
        if inputImageAlias != ""{
            inputImageAliasStr = "\""+inputImageAlias+"\""
        }
        
        var maskImageAliasStr = previousStr
        if inputMaskImageAlias != ""{
            maskImageAliasStr = "\""+inputMaskImageAlias+"\""
        }
        
        fxStr = "input - " + inputImageAliasStr + ", mask - " + maskImageAliasStr

        return fxStr
   
    }
    */
    override func getCIFilter(currentImage: CIImage, beginImage: CIImage) -> CIFilter? {
            
        var currentCIFilter: FractalFlowNoiseFilter
        if ciFilter != nil {
            currentCIFilter = ciFilter as! FractalFlowNoiseFilter
        } else {
            currentCIFilter =  FractalFlowNoiseFilter()
            ciFilter=currentCIFilter
            //regenerate=true
        }
        
        let inputImage=handleAlias(alias: inputImageAlias,
                                      inputImage: currentImage,
                                      beginImage: beginImage)
        
        let maskImage=handleAlias(alias: inputMaskImageAlias,
                                      inputImage: currentImage,
                                      beginImage: beginImage)
        
        currentCIFilter.inputImage = inputImage
        currentCIFilter.inputTime = CGFloat(timeElapsed)
        timeElapsed=Float(timeElapsedX)
        currentCIFilter.inputAnimType =  CGFloat(animType)
     

         let dimension = inputImage.extent
        

        
        if (m_flowMaskType==0.0)
        {
            let textMask = CIImage(image: self.makeImageMask(sizex : m_textsize, widthx: dimension.width, heightx: dimension.height, namex: m_textMaskStr)!)
            
            currentCIFilter.inputMask = textMask
        }
        else if (m_flowMaskType==1.0)
        {
            var m_initvelocityx : CGFloat = 0.5089
            var m_initvelocityy : CGFloat = 0.1501
            var m_inputAnimType: CGFloat = 0
            var m_initlocationx : CGFloat = 0.45
            var m_initlocationy : CGFloat = 0.5
            var m_accelerationx : CGFloat = -0.043
            var m_accelerationy : CGFloat =  -0.02
            var m_vscalingx :  CGFloat = 0.145256
            var m_vscalingy :  CGFloat = 0.4022
            var m_timescalingForward : CGFloat = 5.0
            var m_timescalingRemainder : CGFloat =  5.0
            
            let afilter =  ParticlesFilter()
            afilter.inputImage = beginImage
            //afilter.inputTime = CGFloat(ctimeElapsed)
            afilter.inputAnimType =  CGFloat(m_inputAnimType)
            afilter.initcolormod = CIVector(x: 0.3061, y: 0.2403)
            afilter.initvelocity = CIVector(x: m_initvelocityx, y: m_initvelocityy)
            afilter.initlocation = CIVector(x: m_initlocationx, y: m_initlocationy)
            afilter.acceleration =  CIVector(x: m_accelerationx,y: m_accelerationy)
            afilter.vscaling = CIVector(x: m_vscalingx,y: m_vscalingy)
            afilter.timescaling = CIVector(x: m_timescalingForward, y: m_timescalingRemainder)
            
            let agrayscaleFilter = CIFilter.photoEffectNoir()
            agrayscaleFilter.inputImage =  afilter.outputImage
            
            let ainvertFilter = CIFilter.colorInvert()
            ainvertFilter.inputImage = agrayscaleFilter.outputImage
            
            currentCIFilter.inputMask =  ainvertFilter.outputImage
             
        }
        else if (m_flowMaskType==2.0)
        {
            var m_flowBlur = CGFloat(2.0)
            
            let bgrayscaleFilter = CIFilter.photoEffectNoir()
            bgrayscaleFilter.inputImage = beginImage
            let bworkImage = bgrayscaleFilter.outputImage
            let binvertFilter = CIFilter.colorInvert()
            binvertFilter.inputImage = bworkImage
            
            let bblurFilter = CIFilter.gaussianBlur()
            bblurFilter.inputImage = binvertFilter.outputImage
            bblurFilter.radius = Float(m_flowBlur)
            
            let bblurWorkFilterOrg = CIFilter.gaussianBlur()
            bblurWorkFilterOrg.inputImage = bworkImage
            bblurWorkFilterOrg.radius = Float(0.0)
            
            let bblendFilter = CIFilter.colorDodgeBlendMode()
            bblendFilter.backgroundImage =  bblurWorkFilterOrg.outputImage
            bblendFilter.inputImage = bblurFilter.outputImage
            
            currentCIFilter.inputMask = bblendFilter.outputImage
             
        }
        else if (m_flowMaskType==3.0)
        {
            var m_angle = CGFloat(0)
            var m_rangeType = CGFloat(1)
            var m_color1 = CIVector(x: 0.0, y: 0.0, z:0.0)
            var m_color2 = CIVector(x: 0.6, y: 0.72, z: 0.4)
            var m_red1 = CGFloat(0.0)
            var m_green1 =  CGFloat(0.0)
            var m_blue1 =  CGFloat(0.0)
            var m_red2 = CGFloat(0.6)
            var m_green2 =  CGFloat(0.72)
            var m_blue2 =  CGFloat(0.4)
            var m_centershift = CGFloat(0.0)
            var m_angle_2 = CGFloat(60)
            var m_centershift_2 = CGFloat(0.0)
            var m_rangeType_2 = CGFloat(1)
            var m_red1_2 = CGFloat(0.06)
            var m_green1_2 =  CGFloat(0.03)
            var m_blue1_2 =  CGFloat(0.1)
            var m_red2_2 = CGFloat(1.0)
            var m_green2_2 =  CGFloat(0.72)
            var m_blue2_2 =  CGFloat(0.8)
            var m_useSecondGrad = CGFloat(1.0)
            var m_blendweight = CGFloat(0.5)
            
            let gnlfilter =  CIGradientNLFilter()
            gnlfilter.inputImage = beginImage
            gnlfilter.center = CIVector(x: 0.5, y: 0.0)
            gnlfilter.angle = CGFloat(m_angle)
            gnlfilter.rangeType = CGFloat(m_rangeType)
            gnlfilter.color1 = CIVector(x: m_red1, y: m_green1, z:m_blue1)
            gnlfilter.color2 = CIVector(x: m_red2, y: m_green2, z:m_blue2)
            
            gnlfilter.center_2 = CIVector(x: m_centershift_2, y: 0.0)
            gnlfilter.angle_2 = CGFloat(m_angle_2)
            gnlfilter.rangeType_2 = CGFloat(m_rangeType_2)
            gnlfilter.color1_2 = CIVector(x: m_red1_2, y: m_green1_2, z:m_blue1_2)
            gnlfilter.color2_2 = CIVector(x: m_red2_2, y: m_green2_2, z:m_blue2_2)
           
            gnlfilter.useSecondGrad = CGFloat(m_useSecondGrad)
            gnlfilter.blendweight = CGFloat(m_blendweight)
          
            let dgrayscaleFilter = CIFilter.photoEffectNoir()
            dgrayscaleFilter.inputImage = gnlfilter.outputImage
            
            currentCIFilter.inputMask =   dgrayscaleFilter.outputImage
        }
        else {
            currentCIFilter.inputMask = maskImage
        }
        
        
        currentCIFilter.inputAuraMask = CGFloat(maskEffect)
        //currentCIFilter.inputColor = CIVector(x: m_red_base, y: m_green_base, z:m_blue_base)
        currentCIFilter.inputColor = CIVector(x: color.red, y: color.green, z:color.blue)
        
        currentCIFilter.param_direction_deg = CGFloat(param_direction_deg)
        currentCIFilter.param_expon = CGFloat(param_expon)
        currentCIFilter.param_strength = CGFloat(param_strength)
        currentCIFilter.param_layerscale =  CGFloat(param_layerscale)
        currentCIFilter.param_layervelocity = CGFloat(param_layervelocity)
        currentCIFilter.param_sampletype =  CGFloat(param_sampletype)
        currentCIFilter.param_mipmaptype =  CGFloat(param_mipmaptype)

        currentCIFilter.inputBlend = CGFloat(m_flowBlend)
        currentCIFilter.inputText = m_textMaskStr
        currentCIFilter.inputTextSize = m_textsize
        
        return currentCIFilter
        
    }
    
    func makeImageMask(sizex : Double, widthx : Double, heightx : Double, namex: String?) -> UIImage? {
            let fullframe = CGRect(x: 0, y: 0, width: widthx, height: heightx)
          
            //let frame = CGRect(x: 0, y: 115, width: widthx-125, height: 340)
            let smallline = CGRect(x: 50, y: 355, width: widthx-150, height: 7)

            let nameLabel = UILabel(frame: fullframe)
            //let nameLabel = UILabel(frame: frame)
            nameLabel.textAlignment = .center
            nameLabel.backgroundColor = .white
            nameLabel.textColor = .black

            nameLabel.layer.cornerRadius = 15
            nameLabel.font = UIFont(name: "Georgia",size :sizex)
                    
            nameLabel.text = namex
            UIGraphicsBeginImageContext(fullframe.size)
             if let currentContext = UIGraphicsGetCurrentContext() {
                 
                 //
                 //currentContext.setFillColor(red: 1.0, green: 1.0, blue : 1.0, alpha : 1.0);
                 //currentContext.fill(frame);
                 
                 nameLabel.layer.render(in: currentContext)
                 
                 //comment to remove the line
                 currentContext.setFillColor(red: 0.0, green: 0.0, blue : 0.0, alpha : 1.0);
                 currentContext.fill(smallline);
                 
                 
                // currentContext.fill(smallline);
                let nameImage = UIGraphicsGetImageFromCurrentImageContext()
                return nameImage
             }
             return nil
       }
    
}
