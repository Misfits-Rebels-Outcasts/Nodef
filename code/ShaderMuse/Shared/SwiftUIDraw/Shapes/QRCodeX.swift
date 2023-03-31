

import SwiftUI
import CoreImage.CIFilterBuiltins

class QRCodeX: ShapeX {
    @Published var image: UIImage = UIImage(named: "LabelImage")!
    @Published var input:String = "12345678"
    @Published var errorLevel:String = "L"
   // @Published var qrColor = Color.black

    let context = CIContext()

    init(_ dpi:Double, _ location: CGPoint, _ size: CGSize, _ canvasSize: CGSize, _ isSelected: Bool) {
        super.init(dpi,"QRCode",location,size,canvasSize,isSelected)
        print(location)
        print(size)
        print(canvasSize)
        print(isSelected)
    }

    enum CodingKeys : String, CodingKey {
      //case image
        case input
        case errorLevel
        //case qrColor

    }
    
    required init(from decoder: Decoder) throws {
        try super.init(from: decoder)
        let container = try decoder.container(keyedBy: CodingKeys.self)
        input = try container.decodeIfPresent(String.self, forKey: .input) ?? "12345678"
        errorLevel = try container.decodeIfPresent(String.self, forKey: .errorLevel) ?? "L"
        //let qrColorData = try container.decodeIfPresent(Data.self, forKey: .qrColor) ?? nil
        //if qrColorData != nil
        //{
        //    let color = try NSKeyedUnarchiver.unarchivedObject(ofClass: UIColor.self, from: qrColorData!)
        //    qrColor = Color(color!)
        //}
      }

    override func encode(to encoder: Encoder) throws {
        try super.encode(to: encoder)
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(input, forKey: .input)
        try container.encode(errorLevel, forKey: .errorLevel)
        //let convertedQRColor = UIColor(qrColor)
        //let qrColorData = try NSKeyedArchiver.archivedData(withRootObject: convertedQRColor, requiringSecureCoding: false)
        //try container.encode(qrColorData, forKey: .qrColor)
      }

    func generateQRCode(from text: String) -> UIImage {
        var qrImage = UIImage(systemName: "xmark.circle") ?? UIImage()
        //let data = Data(text.utf8)
        let filter = CIFilter.qrCodeGenerator()
        filter.setValue(errorLevel, forKey: "inputMessage")

          if let outputImage = filter.outputImage {
              if let image = context.createCGImage(
                  outputImage,
                from: outputImage.extent) {
                 qrImage = UIImage(cgImage: image)
             }
         }
          return qrImage
      }

    func generateQRCodeX(from text: String) -> UIImage {
            var qrImage = UIImage(systemName: "xmark.circle") ?? UIImage()
            let data = Data(text.utf8)
            let filter = CIFilter.qrCodeGenerator()
            //let filter = CIFilter.code128BarcodeGenerator()
            
            filter.setValue(data, forKey: "inputMessage")
            filter.setValue(errorLevel, forKey: "inputCorrectionLevel")
        
        /*code128*/
        /*
         filter.setValue(7.00, forKey: "inputQuietSpace")
            if let outputImage = filter.outputImage {
                let x = size.width / outputImage.extent.size.width
                let y = size.height / outputImage.extent.size.height
                //let transform = CGAffineTransform(scaleX: x*300.0/72.0, y: y*300.0/72.0)
                //let transform = CGAffineTransform(scaleX: x*300.0/72.0, y: x*300.0/72.0)
                let transform = CGAffineTransform(scaleX: x*10, y: x*10)
                if let scaledImage = filter.outputImage?.transformed(by: transform) {
                    let colorParameters = [
                        "inputColor0": CIColor(color: UIColor.black), // Foreground
                        "inputColor1": CIColor(color: UIColor.clear) // Background
                    ]
                    let colored = scaledImage.applyingFilter("CIFalseColor", parameters: colorParameters)

                    if let image = context.createCGImage(
                        colored,
                        from: colored.extent) {
                        
                        qrImage = UIImage(cgImage: image)
                    }
                }
         */
        
        if let outputImage = filter.outputImage {
            let x = size.width / outputImage.extent.size.width
            //let y = size.height / outputImage.extent.size.height
            //let transform = CGAffineTransform(scaleX: x*dpi/72.0, y: x*dpi/72.0)
            //multiply by 300 dpi causes ipad and older iphones to crash
            let transform = CGAffineTransform(scaleX: x, y: x)
            //let transform = CGAffineTransform(scaleX: x*10, y: x*10)
            if let scaledImage = filter.outputImage?.transformed(by: transform) {
                
                
                let colorParameters = [
                    //"inputColor0": CIColor(color: UIColor(qrColor)), // Foreground
                    //the above color setting not working on a Mac
                    "inputColor0": CIColor(color: UIColor.black), // Foreground
                    "inputColor1": CIColor(color: UIColor.clear) // Background
                ]
                let colored = scaledImage.applyingFilter("CIFalseColor", parameters: colorParameters)

                if let image = context.createCGImage(
                    colored,
                    from: colored.extent) {
                    
                    qrImage = UIImage(cgImage: image)
                }
                
            }
         
        }
     
        /*
            let transform = CGAffineTransform(scaleX: 5, y: 5)
            if let outputImage = filter.outputImage?.transformed(by: transform) {
                
                let colorParameters = [
                    "inputColor0": CIColor(color: UIColor.black), // Foreground
                    "inputColor1": CIColor(color: UIColor.clear) // Background
                ]
                let colored = outputImage.applyingFilter("CIFalseColor", parameters: colorParameters)

                if let image = context.createCGImage(
                    colored,
                    from: colored.extent) {
                    
                    qrImage = UIImage(cgImage: image)
                }
            }
         */
            return qrImage
    }
    
    override func view() -> AnyView {
        AnyView(
            Image(uiImage: self.generateQRCodeX(from: input))
                .resizable()
                .scaledToFit()
                .frame(width: self.size.width, height: self.size.height)
                .position(self.location))
        }
}
