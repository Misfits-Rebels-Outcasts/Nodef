import Foundation
import CoreImage
import Accelerate
import SwiftUI

class CICircleGenerator: CIFilter {

    private let kernel: CIKernel

    @objc dynamic var inputImage: CIImage?
    @objc dynamic var x: CGFloat = 150
    @objc dynamic var y: CGFloat = 150
    @objc dynamic var inputRadius: CGFloat = 100
    @objc dynamic var inputColor : CIVector = CIVector(x: 0.5, y: 0.8, z: 1.0)
    @objc dynamic var backgroundColor : CIVector = CIVector(x: 1.0, y: 0.0, z: 0.0)


    override init() {
        let url = Bundle.main.url(forResource: "default", withExtension: "metallib")!
        let data = try! Data(contentsOf: url)
        kernel = try! CIKernel(functionName: "drawcircleFilter", fromMetalLibraryData: data)
        
        super.init()
      
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override var outputImage: CIImage? {
        guard let inputImage = inputImage else {return nil}
        
        let samplingImage = inputImage
        let extent = inputImage.extent
        
        var loc : CIVector = CIVector(x: CGFloat(x), y: CGFloat(extent.height-y))
        
        let arguments = [inputImage, samplingImage, inputRadius, loc,inputColor,backgroundColor] as [Any]
        
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


