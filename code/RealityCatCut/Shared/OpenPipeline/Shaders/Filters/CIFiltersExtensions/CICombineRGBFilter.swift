//
//  Copyright © 2022-2023 James Boo. All rights reserved.
//

import Foundation
import CoreImage
import Accelerate



class CICombineRGBFilter: CIFilter {

    private let kernel: CIKernel

    var inputImageR: CIImage?
    var inputImageG: CIImage?
    var inputImageB: CIImage?
    
    //ver 1.1
    var inputTime : CGFloat = 0
    var inputMode : CGFloat = 0

    override init() {
        //let url = Bundle.main.url(forResource: "default", withExtension: "metallib")!
        //let data = try! Data(contentsOf: url)
        //kernel = try! CIKernel(functionName: "combineRGBFilter", fromMetalLibraryData: data)
               
        let url = Bundle.main.url(forResource: "NodefMetalLibrary", withExtension: "metallib")!
        let data = try! Data(contentsOf: url)
        kernel = try! CIKernel(functionName: "combineRGBFilter", fromMetalLibraryData: data)
  
        super.init()
      
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    //func outputImage() -> CIImage? {
    override var outputImage: CIImage? {
        guard let inputImageR = inputImageR else {return nil}
        guard let inputImageG = inputImageG else {return nil}
        guard let inputImageB = inputImageB else {return nil}
     
        
        //not calling..
        //print("xtime" , inputTime)
     
        
        let arguments = [inputImageR,inputImageG,inputImageB, inputTime, inputMode] as [Any]
        let extent = inputImageR.extent
        
        
       
        return kernel.apply(extent: extent,
                            roiCallback:
                            {
                                (index, rect) in
                                return rect
                            },
                            arguments: arguments)
        
       }
}

