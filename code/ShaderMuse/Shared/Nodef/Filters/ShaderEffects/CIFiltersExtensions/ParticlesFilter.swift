//
//  Copyright © 2022 James Boo. All rights reserved.
//

import Foundation
import CoreImage
import Accelerate


class ParticlesFilter: CIFilter {

    private let kernel: CIKernel

    @objc dynamic var inputImage: CIImage?
    @objc dynamic var inputAnimType: CGFloat = 0
    @objc dynamic var inputFactor: CGFloat = 0
    @objc dynamic var inputRotation: CGFloat = 0
    @objc dynamic var initvelocity : CIVector = CIVector(x: 0.5089, y: 0.1501)
    @objc dynamic var initcolormod : CIVector = CIVector(x: 0.3061, y: 0.2403)
    @objc dynamic var initlocation : CIVector = CIVector(x: 0.45, y: 0.5)
    @objc dynamic var vscaling : CIVector = CIVector(x: 0.145256,y: 0.4022)
    @objc dynamic var acceleration : CIVector = CIVector( x: -0.043,y: -0.02)
    @objc dynamic var timescaling : CIVector = CIVector( x: 5.0,y: 5.0)
   
    //ver 1.1
    @objc dynamic var inputTime : CGFloat = 0

    override init() {
        let url = Bundle.main.url(forResource: "default", withExtension: "metallib")!
        let data = try! Data(contentsOf: url)
        kernel = try! CIKernel(functionName: "particlesFilter", fromMetalLibraryData: data)
               
        //kernel = try! CIColorKernel(functionName: "artFilter", fromMetalLibraryData: data)
        
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
     
        //let initvelocity = CIVector(x: 0.5089, y: 0.1501)
        //let initcolormod = CIVector(x: 0.3061, y: 0.2403)
        //let initlocation = CIVector(x: 0.45, y: 0.5)
        //let vscaling = CIVector(x: 0.145256,y: 0.4022)
        
        let genx = CIFilter.randomGenerator()
        let noiseImage = genx.outputImage
        
        let arguments = [inputImage, noiseImage, inputAnimType, inputFactor,inputRotation,inputTime,initvelocity,initcolormod,initlocation, vscaling,acceleration,timescaling] as [Any]
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


