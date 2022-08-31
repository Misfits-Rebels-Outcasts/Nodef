//
//  Copyright © 2022 James Boo. All rights reserved.
//

import SwiftUI

class FilterX: Codable, ObservableObject, Identifiable, Equatable {
    static func == (lhs: FilterX, rhs: FilterX) -> Bool {
        return lhs.id==rhs.id
    }
    
    var id = UUID()
    var desc: String = ""
    var ciFilter: CIFilter?

    @Published var type = ""
    @Published var alias = ""
    @Published var inputImageAlias : String=""
    @Published var backgroundImageAlias : String=""

    @Published var inputImageAliasId : String=""
    @Published var backgroundImageAliasId : String=""

    @Published var size: CGSize =  CGSize(width:0,height:0) //reassigned on load image
    @Published var boundsCenter: CIVector =  CIVector(x:0,y:0) //reassigned on load image
    @Published var nodeIndex: Int = 0 //reassigned on load image

    //@Published var targetImageAlias : String=""
    //@Published var time:Float = 0.0
    var parent: FiltersX?
    
    init()
    {

    }
    
    init(_ type:String,_ description:String, _ parent:FiltersX?) {
        self.parent=parent
        self.type=type
        self.desc=description
        if let parentUw = parent
        {
            self.size=parentUw.size
            self.boundsCenter=parentUw.boundsCenter
        }
        
    }
    
    init(_ type:String) {
        self.type=type
        desc=CIFilter.localizedDescription(forFilterName: type) ?? ""
        
    }
    
    enum CodingKeys: String, CodingKey {
        case type
        case alias
        case inputImageAlias
        case backgroundImageAlias

    }

    required init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        type = try values.decodeIfPresent(String.self, forKey: .type) ?? ""
        alias = try values.decodeIfPresent(String.self, forKey: .alias) ?? ""
        inputImageAlias = try values.decodeIfPresent(String.self, forKey: .inputImageAlias) ?? ""
        backgroundImageAlias = try values.decodeIfPresent(String.self, forKey: .backgroundImageAlias) ?? ""

    }

    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(type, forKey: .type)
        try container.encode(alias, forKey: .alias)
        try container.encode(inputImageAlias, forKey: .inputImageAlias)
        try container.encode(backgroundImageAlias, forKey: .backgroundImageAlias)

    }
    
    func handleAlias(alias: String, inputImage: CIImage, beginImage: CIImage)->CIImage
    {
        if let parentUw = parent {
            return parentUw.handleAlias(inputAlias: alias,
                                inputImage: inputImage,
                                beginImage: beginImage)
        }
        return inputImage
    }
    
    func getCIFilter(currentImage: CIImage, beginImage: CIImage) -> CIFilter? {
        
        //preconditionFailure("This method must be overridden for the main node loop.")
        let inputImage=handleAlias(alias: inputImageAlias,
                                      inputImage: currentImage,
                                      beginImage: beginImage)
        
        return getCIFilter(inputImage)
    }
    
    //can be used only after the above is called
    func getCIFilter() -> CIFilter? {
        
        print("FilterX base getCIFilter()",ciFilter)
        return ciFilter
    }
    

    
    func getCIFilter(_ ciImage: CIImage) -> CIFilter {
        print("FilterX base getCIFilter(ciImage) type",type)
        
        var currentCIFilter: CIFilter
        if ciFilter != nil {
            currentCIFilter = ciFilter!
        } else {
            currentCIFilter = CIFilter(name: type)!
            ciFilter=currentCIFilter
        }
        currentCIFilter.setValue(ciImage, forKey: kCIInputImageKey)
        return currentCIFilter

    }
    
    func setupProperties(_ parent: FiltersX?)
    {
        if let parentUw = parent
        {
            self.parent=parentUw
            self.size=parentUw.size
            self.boundsCenter=CIVector(x:parentUw.size.width/2.0,y:parentUw.size.height/2.0)
        }
        
    }
    
    func adjustPropertiesToBounds(_ parent: FiltersX?)
    {
        if let parentUw = parent
        {
            self.parent=parentUw
            self.size=parentUw.size
            self.boundsCenter=CIVector(x:parentUw.size.width/2.0,y:parentUw.size.height/2.0)
        }
    }
    
    func getNodeNameFX() -> String
    {

        var aliasStr=""
        if alias == ""
        {
             aliasStr="Node "+String(nodeIndex)
        }
        else
        {            //aliasStr="node" + String(nodeIndex) + ", alias - "+alias
            aliasStr="Node "+String(nodeIndex)+" (or "+alias+")"
        }
        return aliasStr
    }
    
    func getDisplayNameFX() -> String
    {

        var fxStr = "" //retName
        //var aliasStr = ""
        var previousStr="previous"
        if nodeIndex == 1 {
            previousStr="0"//"0 (original image)"
        }
        else {
            previousStr="" + String(nodeIndex-1)
        }
            
        
        if inputImageAlias == ""
        {
            fxStr = "input - "+previousStr

        }
        else if inputImageAlias != ""
        {
            var inputImageAliasStr = "\""+inputImageAlias+"\""
            if inputImageAlias != ""{
                //let num=Int(inputImageAlias)!
                //if num > nodeIndex-1{
                //    inputImageAliasStr=inputImageAliasStr+"*"
                //}
            }
            
            fxStr = "input - " + inputImageAliasStr
        }
        
        return fxStr
   
    }

    
    
    func getDisplayName() -> String
    {
        let lowerCase = CharacterSet.lowercaseLetters
        let upperCase = CharacterSet.uppercaseLetters

        let name = String(type.dropFirst(2))
        //patch
        if name == "CMYKHalftone"
        {
            return "CMYK Halftone"
        }
        else if name == "SRGBToneCurveToLinear"
        {
            return "SRGB Tone Curve To Linear"
        }
        else if name == "LinearToSRGBToneCurve"
        {
            return "Linear To SRGB Tone Curve"
        }
        else if name == "QRCodeGenerator"
        {
            return "QR Code Generator"
        }
        else if name == "PDF417BarcodeGenerator"
        {
            return "PDF417 Barcode Generator"
        }
        else if name == "Convolution3X3"
        {
            return "Convolution 3 X 3"
        }
        else if name == "Convolution5X5"
        {
            return "Convolution 5 X 5"
        }
        else if name == "Convolution7X7"
        {
            return "Convolution 7 X 7"
        }
        else if name == "Convolution9Horizontal"
        {
            return "Convolution 9 Horizontal"
        }
        else if name == "Convolution9Vertical"
        {
            return "Convolution 9 Vertical"
        }
        
        var firstTime = true
        var retName = String("")
        for currentCharacter in name.unicodeScalars {
            
            if lowerCase.contains(currentCharacter) {
                retName = retName+String(currentCharacter)
           } else if upperCase.contains(currentCharacter) {
                if firstTime {
                    retName = String(currentCharacter)
                    firstTime=false
                }
                else{
                    retName = retName + " " + String(currentCharacter)
                }
            } else {
                print("Character code \(currentCharacter) is neither upper- nor lowercase.")
                print("Character code \(currentCharacter) is neither upper- nor lowercase.")
                print("Character code \(currentCharacter) is neither upper- nor lowercase.")
            }
            
        }
        return retName
    }
    
    func getCurrentImage(thumbImage: UIImage) -> UIImage
    {
        //revisit
        //context is expensive

        let context = CIContext()
        let beginImage = CIImage(image: thumbImage)
        
        if let cgimg = context.createCGImage(getCIFilter()!.outputImage!, from: beginImage!.extent) {
            let processedImage = UIImage(cgImage: cgimg, scale: thumbImage.scale, orientation: thumbImage.imageOrientation)
            return processedImage
        }
        

        return thumbImage
        //return UIImage(image: originalImage)!

    }
}
