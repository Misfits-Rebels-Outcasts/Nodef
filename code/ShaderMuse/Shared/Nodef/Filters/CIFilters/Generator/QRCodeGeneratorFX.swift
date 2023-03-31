//
//  Copyright © 2022 James Boo. All rights reserved.
//


import SwiftUI

class QRCodeGeneratorFX: BaseGeneratorFX {
       
    @Published var message:String = "12345678"
    @Published var correctionLevel:String = "M"
    
    let description = "Generates a Quick Response code (two-dimensional barcode) from input data. The Correction Level parameter controls the amount of additional data encoded in the output image to provide error correction. Higher levels of error correction result in larger output images but allow larger areas of the code to be damaged or obscured without. "

    override init()
    {
        let name="CIQRCodeGenerator"
        super.init(name)
        desc=description
        
        print(CIFilter.localizedName(forFilterName: name))
        print(CIFilter.localizedDescription(forFilterName: name))
        print(CIFilter.localizedReferenceDocumentation(forFilterName: name))

    }

    enum CodingKeys : String, CodingKey {
        case message
        case correctionLevel
    }

    required init(from decoder: Decoder) throws {
        try super.init(from: decoder)
        let values = try decoder.container(keyedBy: CodingKeys.self)
        desc=description
        
        message = try values.decodeIfPresent(String.self, forKey: .message) ?? ""
        correctionLevel = try values.decodeIfPresent(String.self, forKey: .correctionLevel) ?? ""
        
    }
    
    override func encode(to encoder: Encoder) throws {
        try super.encode(to: encoder)
  
        var container = encoder.container(keyedBy: CodingKeys.self)

        try container.encode(message, forKey: .message)
        try container.encode(correctionLevel, forKey: .correctionLevel)
    }
    
    var qrcodeCIFilter: CIFilter?
    override func getCIFilter(currentImage: CIImage, beginImage: CIImage) -> CIFilter? {
        
        var currentCIFilter: CIFilter
        var qrcodeFilter: CIFilter
        
        if ciFilter != nil {
            print("current QR Code")
            currentCIFilter = ciFilter!
            qrcodeFilter = qrcodeCIFilter!
        } else {
            print("new QR Code")
            qrcodeFilter = CIFilter(name: type)!
            currentCIFilter = CIFilter(name: "CIAffineTransform")!
        }
        
        qrcodeFilter.setValue(message.data(using: .utf8), forKey: "inputMessage")
        qrcodeFilter.setValue(correctionLevel, forKey: "inputCorrectionLevel")

        currentCIFilter.setValue(qrcodeFilter.outputImage!,forKey:kCIInputImageKey)
        let cow = qrcodeFilter.outputImage!.extent.width
        let coh = qrcodeFilter.outputImage!.extent.height
        let rx = cow <= 0 ? 1 : beginImage.extent.width / cow
        let ry = coh <= 0 ? 1 : beginImage.extent.height / coh
        let r = rx < ry ? rx/2.0 : ry / 2.0
        let transform=CGAffineTransform(a:1.0*r,b:0,c:0,d:1.0*r,tx:0,ty:0)
        currentCIFilter.setValue(transform, forKey: kCIInputTransformKey)
    
        ciFilter=currentCIFilter
        qrcodeCIFilter=qrcodeFilter
        
        return currentCIFilter
    }

}
