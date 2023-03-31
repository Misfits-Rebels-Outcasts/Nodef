import Foundation
import CoreImage
import Accelerate
import SwiftUI

class CIColorChannels: CIFilter {

    private let kernel: CIKernel

    @objc dynamic var inputImage: CIImage?
    @objc dynamic var rAmount: CGFloat = 1.0
    @objc dynamic var gAmount: CGFloat = 1.0
    @objc dynamic var bAmount: CGFloat = 1.0
    @objc dynamic var aAmount: CGFloat = 1.0

    override init() {
        let url = Bundle.main.url(forResource: "default", withExtension: "metallib")!
        let data = try! Data(contentsOf: url)
        kernel = try! CIKernel(functionName: "colorChannels", fromMetalLibraryData: data)
        super.init()
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override var outputImage: CIImage? {
        guard let inputImage = inputImage else {return nil}
                
        let arguments = [inputImage, rAmount, gAmount, bAmount, aAmount] as [Any]
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


