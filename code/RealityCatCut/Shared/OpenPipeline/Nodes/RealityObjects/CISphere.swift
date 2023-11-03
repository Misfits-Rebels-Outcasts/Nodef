//
//  Copyright © 2022 James Boo. All rights reserved.
//

import Foundation
import CoreImage
import Accelerate
import SwiftUI
import ARKit
import ReplayKit

class SphereFilter: CIFilter {

    //private let kernel: CIKernel
    var inputImage: CIImage?

    private var photoARView: PhotoARView!
    override init() {

        super.init()
      
    }

    init(photoARView: PhotoARView) {

        super.init()
        self.photoARView=photoARView
      
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override var outputImage: CIImage? {
        
        var ciImage: CIImage?
        ciImage=inputImage
        /*
        //do {
            photoARView.snapshot(saveToHDR: false) { (image) in
                let compressedImage = UIImage(data: (image?.pngData())!)
                UIImageWriteToSavedPhotosAlbum(compressedImage!, nil, nil, nil)
                ciImage = image?.ciImage
            }
        //}
        //catch {
            //ciImage=inputImage
        //}
        */
        return ciImage
    }
    
    
    
}


