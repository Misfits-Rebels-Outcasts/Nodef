//
//  Copyright © 2022 James Boo. All rights reserved.
//

import Foundation
import CoreImage
import Accelerate
import SwiftUI



class FBMNoiseFilter: CIFilter {

    private let kernel: CIKernel

    @objc dynamic var inputImage: CIImage?
    @objc dynamic var inputAnimType: CGFloat = 0
    @objc dynamic var inputAuraMask: CGFloat = 0
    @objc dynamic var inputRotation: CGFloat = 0
    @objc dynamic var inputColor : CIVector = CIVector(x: 0.5, y: 0.8, z: 1.0)
  
    @objc dynamic var param_sampletype : CGFloat = 0.0
  
    
    //ver 1.1
    @objc dynamic var inputTime : CGFloat = 0

    override init() {
        //let url = Bundle.main.url(forResource: "default", withExtension: "metallib")!
        //let data = try! Data(contentsOf: url)
        //kernel = try! CIKernel(functionName: "fBMNoise", fromMetalLibraryData: data)
               
        //kernel = try! CIColorKernel(functionName: "artFilter", fromMetalLibraryData: data)
        let url = Bundle.main.url(forResource: "NodefMetalLibrary", withExtension: "metallib")!
        let data = try! Data(contentsOf: url)
        kernel = try! CIKernel(functionName: "fBMNoise", fromMetalLibraryData: data)
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
      
        
        //guard let inputMaskImage  = inputMask else {return nil}
        
       
        
        //let maskImage = inputMaskImage.samplingLinear();
        
        
        
      
        
       
        /*
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
         */
       
        
        let samplingImage = inputImage;
        let extent = inputImage.extent
        
      
         
        let arguments = [inputImage, samplingImage, inputAnimType, inputAuraMask,inputRotation,inputTime,inputColor, param_sampletype] as [Any]
         
      
       
        return kernel.apply(extent: extent,
                            roiCallback:
                            {
                                (index, rect) in
                                return rect
                            },
                            arguments: arguments)
        
       }
    
    
    
}


