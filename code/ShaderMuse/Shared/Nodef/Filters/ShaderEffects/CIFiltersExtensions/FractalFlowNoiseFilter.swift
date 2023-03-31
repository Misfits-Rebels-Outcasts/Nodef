//
//  Copyright © 2022 James Boo. All rights reserved.
//


import Foundation
import CoreImage
import Accelerate
import SwiftUI



class FractalFlowNoiseFilter: CIFilter {

    private let kernel: CIKernel

    @objc dynamic var inputImage: CIImage?
    @objc dynamic var inputAnimType: CGFloat = 0
    @objc dynamic var inputAuraMask: CGFloat = 0
    @objc dynamic var inputRotation: CGFloat = 0
    @objc dynamic var inputColor : CIVector = CIVector(x: 0.5, y: 0.8, z: 1.0)
    @objc dynamic var initcolormod : CIVector = CIVector(x: 0.3061, y: 0.2403)
    @objc dynamic var initlocation : CIVector = CIVector(x: 0.45, y: 0.5)
    @objc dynamic var vscaling : CIVector = CIVector(x: 0.145256,y: 0.4022)
    @objc dynamic var inputMask: CIImage?
    @objc dynamic var inputText : String = "Text"
    @objc dynamic var inputTextSize : Double = 140.0
    @objc dynamic var inputBlend: CGFloat = -1.0
    @objc dynamic var inputMaskInvert: CGFloat = 0.0
    //var inputBlurOrg: CGFloat = 0.5
   
    //ver 2.0
    @objc dynamic var param_direction_deg : CGFloat = 0.0
    @objc dynamic var param_expon  : CGFloat = 0.9
    @objc dynamic var param_strength : CGFloat = 0.5
    @objc dynamic var param_layerscale : CGFloat = 0.1356
    @objc dynamic var param_layervelocity : CGFloat = 0.132135
    @objc dynamic var param_sampletype : CGFloat = 0.0
    @objc dynamic var param_mipmaptype : CGFloat = 1.0
    
    //ver 1.1
    @objc dynamic var inputTime : CGFloat = 0

    override init() {
        let url = Bundle.main.url(forResource: "default", withExtension: "metallib")!
        let data = try! Data(contentsOf: url)
        kernel = try! CIKernel(functionName: "fractalFlowNoise", fromMetalLibraryData: data)
               
        //kernel = try! CIColorKernel(functionName: "artFilter", fromMetalLibraryData: data)
        
        super.init()
      
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    //func outputImage() -> CIImage? {
    override var outputImage: CIImage? {
            guard let inputImage = inputImage else {return nil}
        
        //let inputMaskImage  = inputImage
        //let maskImage = inputImage
        //let maskExtend  = inputImage
      
        
        guard let inputMaskImage  = inputMask else {return nil}
        
       
        
        let maskImage = inputMaskImage.samplingLinear();
        
        
        
        var radiusFactor = inputTextSize / 140.0;
        //if (radiusFactor<1.0)
        //{
        //    radiusFactor=1.0;
        //}
        
        
       
        
        var maskExtend  : CIImage
        
        
        let genx = CIFilter.discBlur();
        genx.inputImage = inputMaskImage;
        genx.radius = 8.0 * Float(radiusFactor);
        maskExtend = genx.outputImage?.samplingLinear() ?? maskImage;
        
        
        if (inputAuraMask==1)
        {
            genx.radius = 7.0;
            maskExtend = genx.outputImage?.samplingLinear() ?? maskImage;
            
        }
        else if (inputAuraMask==2)
        {
            
            //not yet
            genx.radius  = 5.0 * Float(sqrt(radiusFactor));
            maskExtend = genx.outputImage?.samplingLinear() ?? maskImage;
            
            //maskExtend = inputMaskImage.applyingGaussianBlur(sigma: 3).samplingLinear();
        }
        else if (inputAuraMask==3)
        {
            //genx.radius = 8.0;
            //maskExtend = genx.outputImage?.samplingLinear() ?? maskImage;
         
            maskExtend = inputMaskImage.applyingGaussianBlur(sigma: 5 ).samplingLinear();
            
        }
        else if (inputAuraMask==4)
        {
            //genx.radius = 8.0;
            //maskExtend = genx.outputImage?.samplingLinear() ?? maskImage;
            
            maskExtend = inputMaskImage.applyingGaussianBlur(sigma: 5).samplingLinear();
            
        }
        else if (inputAuraMask==5)
        {
            genx.radius = 7.0 * Float(sqrt(radiusFactor));
            //genx.radius = 7.0;
            maskExtend = genx.outputImage?.samplingLinear() ?? maskImage;
            
          
        }
        else if (inputAuraMask==6)
        {
            maskExtend = inputMaskImage.applyingGaussianBlur(sigma: 6 * radiusFactor ).samplingLinear();
        }
         
       
        //let samplingImage = inputImage
        //let samplingImage = inputImage.samplingLinear()
        var samplingImage: CIImage
        if (param_mipmaptype==0)
        {
            samplingImage = inputImage.samplingLinear()
        }
        else if (param_mipmaptype==1)
        {
            let transform = CGAffineTransform(a: 1.2, b: 0, c: 0, d: 1.2, tx: 0, ty: 0);
            samplingImage = inputImage.transformed(by: transform, highQualityDownsample: true)
        }
        else if (param_mipmaptype==2)
        {
            let transform = CGAffineTransform(a: 1.4, b: 0, c: 0, d: 1.4, tx: 0, ty: 0);
            samplingImage = inputImage.transformed(by: transform, highQualityDownsample: true)
        }
        else
        {
            samplingImage = inputImage
            
        }
        
        
        let extent = inputImage.extent
        
        /*
        let randomx = CIFilter.randomGenerator();
        let inputImageMod
        = randomx.outputImage?.cropped(to: extent)
        
      
        let samplingImage = inputImageMod;
       */
        
       // let arguments = [inputImage, samplingImage, maskImage, maskExtend, inputAnimType, inputAuraMask,inputRotation,inputTime,inputColor,initcolormod,initlocation, vscaling,inputBlend,inputMaskInvert] as [Any]
        
        //let arguments = [inputImage, samplingImage, maskImage, maskExtend, inputAnimType, inputAuraMask,inputRotation,inputTime,inputColor,initcolormod,initlocation, vscaling,inputBlend,inputMaskInvert] as [Any]
        
        
        let arguments = [inputImage, samplingImage, maskImage, maskExtend, inputAnimType, inputAuraMask,inputRotation,inputTime,inputColor,initcolormod,initlocation, vscaling,inputBlend,inputMaskInvert, param_direction_deg,param_expon,param_strength,param_layerscale,param_layervelocity,param_sampletype] as [Any]
         
      
       
        return kernel.apply(extent: extent,
                            roiCallback:
                            {
                                (index, rect) in
                                return rect
                            },
                            arguments: arguments)
        
       }
    
    
    
}


