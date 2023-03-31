
import Foundation
import CoreImage
import Accelerate
import SwiftUI

class CIReciprocalFilter: CIFilter {

    @objc dynamic var inputNumerator: CGFloat = 0.07053
    @objc dynamic var inputDenominatorExp : CGFloat = 4.32
    
    @objc dynamic var inputNumerator2: CGFloat = 0.062
    @objc dynamic var inputDenominatorExp2 : CGFloat = 4.5
   
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
        let url = Bundle.main.url(forResource: "default", withExtension: "metallib")!
        let data = try! Data(contentsOf: url)
        kernel = try! CIKernel(functionName: "reciprocalFilter", fromMetalLibraryData: data)
               
        //kernel = try! CIColorKernel(functionName: "artFilter", fromMetalLibraryData: data)
        
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
        
         
        let arguments = [inputImage, samplingImage, inputAnimType, inputNumerator,inputDenominatorExp,inputTime,inputNumerator2, inputDenominatorExp2] as [Any]
         
        guard let outputImage = kernel.apply(extent: extent,
                                  roiCallback:
                                  {
                                      (index, rect) in
                                      return rect
                                  },
                                  arguments: arguments)  else { return nil }
        
          var croppedImage : CIImage?
          let  context = CIContext(options: [CIContextOption.outputColorSpace: NSNull(),
                                     CIContextOption.workingColorSpace: NSNull()])

          if let cgimg = context.createCGImage(outputImage , from: outputImage.extent) {
              croppedImage = CIImage(cgImage:cgimg)
          }
        
          return croppedImage
        
       }
    
    
    
}


