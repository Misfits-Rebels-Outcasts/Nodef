//
//  Copyright © 2022 James Boo. All rights reserved.
//

import Foundation
import CoreImage
import Accelerate
import SwiftUI



class WaterEffectsFilter: CIFilter {

    private let kernel: CIKernel

    var inputImage: CIImage?
    var inputWarpType: CGFloat = 0
    var inputAuraMask: CGFloat = 0
    var inputRotation: CGFloat = 0
    var inputScale : CGFloat = 5.0
    var inputTranslation : CIVector =  CIVector(x: 0.0, y: 0.0)
    var inputColor : CIVector = CIVector(x: 0.82, y: 0.63, z: 0.76) 
    var inputAnimVelocity : CIVector =  CIVector(x: 0.12, y: 0.09)
    var inputAnimScale : CIVector =  CIVector(x: 0.4632, y: 0.7567)
    
    var paletteInterpolate : CGFloat = 0
    var inputColor2  : CIVector = CIVector(x:0.111961,y:0.519608,z:0.24678)

    
    //ver 1.1
    var inputTime : CGFloat = 0

    override init() {
        //let url = Bundle.main.url(forResource: "default", withExtension: "metallib")!
        //let data = try! Data(contentsOf: url)
        //kernel = try! CIKernel(functionName: "waterEffects", fromMetalLibraryData: data)
               
        //kernel = try! CIColorKernel(functionName: "artFilter", fromMetalLibraryData: data)
        let url = Bundle.main.url(forResource: "NodefMetalLibrary", withExtension: "metallib")!
        let data = try! Data(contentsOf: url)
        kernel = try! CIKernel(functionName: "waterEffects", fromMetalLibraryData: data)
  
        super.init()
      
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    //func outputImage() -> CIImage? {
    override var outputImage: CIImage? {
        guard let inputImage = inputImage else {return nil}
        
         
        let samplingImage = inputImage;
        let extent = inputImage.extent
        
      
         
        let arguments = [inputImage, samplingImage, inputWarpType, inputAuraMask,inputRotation,inputTime,inputColor,inputScale,inputTranslation,inputAnimVelocity,inputAnimScale,paletteInterpolate, inputColor2] as [Any]
         
      
       
        return kernel.apply(extent: extent,
                            roiCallback:
                            {
                                (index, rect) in
                                return rect
                            },
                            arguments: arguments)
        
       }
    
    
    
}


