//
//  Copyright © 2022-2023 James Boo. All rights reserved.
//
import Foundation
import CoreImage
import Accelerate


 
class CIConvertRGBToHSVFilter: CIFilter {

    private let kernel: CIKernel

    var inputImage: CIImage?
    
    
    
    //ver 1.1
    var inputTime : CGFloat = 0

    override init() {
        //let url = Bundle.main.url(forResource: "default", withExtension: "metallib")!
        //let data = try! Data(contentsOf: url)
        //kernel = try! CIKernel(functionName: "convertRGBToHSVFilter", fromMetalLibraryData: data)
              
        let url = Bundle.main.url(forResource: "NodefMetalLibrary", withExtension: "metallib")!
        let data = try! Data(contentsOf: url)
        kernel = try! CIKernel(functionName: "convertRGBToHSVFilter", fromMetalLibraryData: data)
  
        super.init()
      
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    //func outputImage() -> CIImage? {
    override var outputImage: CIImage? {
        guard let inputImage = inputImage else {return nil}
      
        //not calling..
        //print("xtime" , inputTime)
     
        
        let arguments = [inputImage,inputTime] as [Any]
        let extent = inputImage.extent
        
        return kernel.apply(extent: extent,
                            roiCallback:
                            {
                                (index, rect) in
                                return rect
                            },
                            arguments: arguments)
        
       }
}

