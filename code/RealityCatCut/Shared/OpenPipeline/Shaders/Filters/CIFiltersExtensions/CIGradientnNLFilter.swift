//
//  Copyright © 2022-2023 James Boo. All rights reserved.
//


import Foundation
import CoreImage
import Accelerate


class CIGradientNLFilter: CIFilter {

    private let kernel: CIKernel
//https://stackoverflow.com/questions/46566076/this-class-is-not-key-value-coding-compliant-using-coreimage    
    @objc dynamic var inputImage: CIImage?
    var center : CIVector = CIVector(x: 0.0, y: 0.0)
    var angle : CGFloat = 0.0
    var rangeType : CGFloat = 1.0
    var color1 : CIVector = CIVector(x: 1.0, y: 1.0, z:1.0)
    var color2 : CIVector = CIVector(x: 0.45, y: 0.5, z: 0.9)
    var center_2 : CIVector = CIVector(x: 0.0, y: 0.0)
    var angle_2 : CGFloat = 0.0
    var rangeType_2 : CGFloat = 1.0
    var color1_2 : CIVector = CIVector(x: 1.0, y: 1.0, z:1.0)
    var color2_2 : CIVector = CIVector(x: 0.45, y: 0.5, z: 0.9)
    var useSecondGrad : CGFloat = 1.0
    var blendweight : CGFloat = 0.50
    
    override init() {
        //let url = Bundle.main.url(forResource: "default", withExtension: "metallib")!
        //let data = try! Data(contentsOf: url)
        //kernel = try! CIKernel(functionName: "gradientnl", fromMetalLibraryData: data)
        let url = Bundle.main.url(forResource: "NodefMetalLibrary", withExtension: "metallib")!
        let data = try! Data(contentsOf: url)
        kernel = try! CIKernel(functionName: "gradientnl", fromMetalLibraryData: data)
  
        super.init()
      
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override var outputImage: CIImage? {
        guard let inputImage = inputImage else {return nil}
        
        let arguments = [inputImage, center, angle,rangeType,color1, color2,center_2, angle_2,rangeType_2,color1_2, color2_2, useSecondGrad,blendweight] as [Any]
        
        let extent = inputImage.extent
        /*
         return kernel.apply(extent: extent,
         roiCallback:
         {
         (index, rect) in
         return rect
         },
         arguments: arguments)
         
         }
         */
        
        guard let outputImage =  kernel.apply(extent: extent,
                                              roiCallback:
                                                {
            (index, rect) in
            return rect
        },
                                              arguments: arguments)
        else { return nil }
        
        var croppedImage : CIImage?
        let   context = CIContext()
        if let cgimg = context.createCGImage(outputImage , from: outputImage.extent) {
            croppedImage = CIImage(cgImage:cgimg)
        }
        return croppedImage
    }
}


