//
//  Copyright © 2022 James Boo. All rights reserved.
//

import SwiftUI
import AVFoundation

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
    //ANCHISES
    @Published var naturalSize: CGSize =  CGSize(width:0,height:0) //for video
    @Published var previousNode:FilterX?
    @Published var inputA : FilterX?
    @Published var inputB : FilterX?
    @Published var inputC : FilterX?
    @Published var inputD : FilterX?
    @Published var inputAAlias : String=""
    @Published var inputAAliasId : String=""
    @Published var inputBAlias : String=""
    @Published var inputBAliasId : String=""
    @Published var inputCAlias : String=""
    @Published var inputCAliasId : String=""
    @Published var inputDAlias : String=""
    @Published var inputDAliasId : String=""
    @Published var inputAStart : CMTime = .zero
    @Published var inputADuration : CMTime = .zero
    @Published var inputAAt : CMTime = .zero
    @Published var inputBStart : CMTime = .zero
    @Published var inputBDuration : CMTime = .zero
    @Published var inputBAt : CMTime = .zero
    @Published var inputCStart : CMTime = .zero
    @Published var inputCDuration : CMTime = .zero
    @Published var inputCAt : CMTime = .zero
    @Published var inputDStart : CMTime = .zero
    @Published var inputDDuration : CMTime = .zero
    @Published var inputDAt : CMTime = .zero
    //ANCHISES
    @Published var nodeType = "Photo" //Photo, Video, AR
    @Published var assetURL1 = urlStep
    @Published var assetURL2 = urlStep
    @Published var assetURL3 = urlStep
    @Published var assetURL4 = urlStep

    var composition = AVMutableComposition()
    var videoComposition = AVMutableVideoComposition()
    @Published var videoStatus = "Not Started" //Not Started, In Progress, Completed, Error
    
    //revisit can cause publishing changes outside main
    //if used inside await executeimagebackwards
    var  startTime:Float=0
    var  endTime:Float=0
    var  duration: CMTime = .zero
    var  preferredTransform: CGAffineTransform = CGAffineTransform()
    var  timeScale: CMTimeScale = 600
    var  nominalFrameRate: Float = 30

    var frameA: CIImage?
    var frameB: CIImage?
    var frameC: CIImage?
    var frameD: CIImage?

    @Published var sticky: Bool = false
    @Published var readOnly: Bool = false

    var sourceId : UUID?
    
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
        
        case inputAAlias
        case inputBAlias
        case inputCAlias
        case inputDAlias
        case nodeType
        case assetURL1
        case assetURL2
        case assetURL3
        case assetURL4
        case sizeWidth
        case sizeHeight
        case naturalSizeWidth
        case naturalSizeHeight
        case durationValue
        case durationTimescale

        case preferredTransformA
        case preferredTransformB
        case preferredTransformC
        case preferredTransformD
        case preferredTransformTX
        case preferredTransformTY
        
        case timeScale
        case nominalFrameRate
        case startTime
        case endTime
        case sticky
        case readOnly
    }

    required init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        type = try values.decodeIfPresent(String.self, forKey: .type) ?? ""
        alias = try values.decodeIfPresent(String.self, forKey: .alias) ?? ""
        inputImageAlias = try values.decodeIfPresent(String.self, forKey: .inputImageAlias) ?? ""
        backgroundImageAlias = try values.decodeIfPresent(String.self, forKey: .backgroundImageAlias) ?? ""

        //ANCHISES
        inputAAlias = try values.decodeIfPresent(String.self, forKey: .inputAAlias) ?? ""
        inputBAlias = try values.decodeIfPresent(String.self, forKey: .inputBAlias) ?? ""
        inputCAlias = try values.decodeIfPresent(String.self, forKey: .inputCAlias) ?? ""
        inputDAlias = try values.decodeIfPresent(String.self, forKey: .inputDAlias) ?? ""
        nodeType = try values.decodeIfPresent(String.self, forKey: .nodeType) ?? ""

        let assetURL1Str = try values.decodeIfPresent(String.self, forKey: .assetURL1) ?? ""
        assetURL1=URL(fileURLWithPath: assetURL1Str)
        let assetURL2Str = try values.decodeIfPresent(String.self, forKey: .assetURL2) ?? ""
        assetURL2=URL(fileURLWithPath: assetURL2Str)
        let assetURL3Str = try values.decodeIfPresent(String.self, forKey: .assetURL3) ?? ""
        assetURL3=URL(fileURLWithPath: assetURL3Str)
        let assetURL4Str = try values.decodeIfPresent(String.self, forKey: .assetURL4) ?? ""
        assetURL4=URL(fileURLWithPath: assetURL4Str)

        let sizeW = try values.decodeIfPresent(Double.self, forKey: .sizeWidth) ?? 0.0
        let sizeH = try values.decodeIfPresent(Double.self, forKey: .sizeHeight) ?? 0.0
        size = CGSize(width: sizeW, height: sizeH)

        let naturalSizeW = try values.decodeIfPresent(Double.self, forKey: .naturalSizeWidth) ?? 0.0
        let naturalSizeH = try values.decodeIfPresent(Double.self, forKey: .naturalSizeHeight) ?? 0.0
        naturalSize = CGSize(width: naturalSizeW, height: naturalSizeH)

        let durationValue = try values.decodeIfPresent(Int64.self, forKey: .durationValue) ?? 1
        let durationTimescale = try values.decodeIfPresent(Int32.self, forKey: .durationTimescale) ?? 1
        duration = CMTimeMake(value: durationValue, timescale: durationTimescale)

        nominalFrameRate = try values.decodeIfPresent(Float.self, forKey: .nominalFrameRate) ?? 30
        
        let preferredTransformA = try values.decodeIfPresent(Double.self, forKey: .preferredTransformA) ?? 1.0
        let preferredTransformB = try values.decodeIfPresent(Double.self, forKey: .preferredTransformB) ?? 0.0
        let preferredTransformC = try values.decodeIfPresent(Double.self, forKey: .preferredTransformC) ?? 0.0
        let preferredTransformD = try values.decodeIfPresent(Double.self, forKey: .preferredTransformD) ?? 1.0
        let preferredTransformTX = try values.decodeIfPresent(Double.self, forKey: .preferredTransformTX) ?? 0.0
        let preferredTransformTY = try values.decodeIfPresent(Double.self, forKey: .preferredTransformTY) ?? 0.0

        preferredTransform=CGAffineTransform(a: preferredTransformA, b: preferredTransformB, c: preferredTransformC, d: preferredTransformD, tx: preferredTransformTX, ty: preferredTransformTY)
        
        startTime = try values.decodeIfPresent(Float.self, forKey: .startTime) ?? 0.0
        endTime = try values.decodeIfPresent(Float.self, forKey: .endTime) ?? 0.0
        timeScale = try values.decodeIfPresent(Int32.self, forKey: .timeScale) ?? 600

        sticky = try values.decodeIfPresent(Bool.self, forKey: .sticky) ?? false
        readOnly = try values.decodeIfPresent(Bool.self, forKey: .readOnly) ?? false

    }

    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(type, forKey: .type)
        try container.encode(alias, forKey: .alias)
        try container.encode(inputImageAlias, forKey: .inputImageAlias)
        try container.encode(backgroundImageAlias, forKey: .backgroundImageAlias)

        //ANCHISES
        try container.encode(inputAAlias, forKey: .inputAAlias)
        try container.encode(inputBAlias, forKey: .inputBAlias)
        try container.encode(inputCAlias, forKey: .inputCAlias)
        try container.encode(inputDAlias, forKey: .inputDAlias)
        try container.encode(nodeType, forKey: .nodeType)
        
        try container.encode(assetURL1.relativeString, forKey: .assetURL1)
        try container.encode(assetURL2.relativeString, forKey: .assetURL2)
        try container.encode(assetURL3.relativeString, forKey: .assetURL3)
        try container.encode(assetURL4.relativeString, forKey: .assetURL4)
        
        try container.encode(size.width, forKey: .sizeWidth)
        try container.encode(size.height, forKey: .sizeHeight)

        try container.encode(naturalSize.width, forKey: .naturalSizeWidth)
        try container.encode(naturalSize.height, forKey: .naturalSizeHeight)

        try container.encode(duration.value, forKey: .durationValue)
        try container.encode(duration.timescale, forKey: .durationTimescale)

        try container.encode(timeScale, forKey: .timeScale)

        let preferredTransformA = preferredTransform.a
        try container.encode(preferredTransformA, forKey: .preferredTransformA)
        
        let preferredTransformB = preferredTransform.b
        try container.encode(preferredTransformB, forKey: .preferredTransformB)

        let preferredTransformC = preferredTransform.c
        try container.encode(preferredTransformC, forKey: .preferredTransformC)

        let preferredTransformD = preferredTransform.d
        try container.encode(preferredTransformD, forKey: .preferredTransformD)

        let preferredTransformTX = preferredTransform.tx
        try container.encode(preferredTransformTX, forKey: .preferredTransformTX)

        let preferredTransformTY = preferredTransform.ty
        try container.encode(preferredTransformTY, forKey: .preferredTransformTY)

        try container.encode(nominalFrameRate, forKey: .nominalFrameRate)
        try container.encode(startTime, forKey: .startTime)
        try container.encode(endTime, forKey: .endTime)

        try container.encode(sticky, forKey: .sticky)
        try container.encode(readOnly, forKey: .readOnly)
        
    }
    
    func getSourceId()->UUID {
        if inputA != nil {
            
            if inputA!.type=="CICutVideo" {
                return inputA!.id
            }
            
            if inputA!.type=="CIJoinVideo" {
                return inputA!.id
            }
            
            if inputA!.type=="CIReadVideo" {
                return inputA!.id
            }

            return (inputA?.getSourceId())!
        }
        return id
    }
    
    func SourceChanged()->Bool {
        if sourceId == getSourceId() {
            return false
        }
        return true
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
        //NSLog("getCIFilter Time")
        //print("FilterX base getCIFilter()",ciFilter)
        return ciFilter
    }
    

    
    func getCIFilter(_ ciImage: CIImage) -> CIFilter {
        //print("FilterX base getCIFilter(ciImage) type",type)
        
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
            //ANCHISES-comebackZ
            //self.size=parentUw.size
            //self.boundsCenter=CIVector(x:parentUw.size.width/2.0,y:parentUw.size.height/2.0)
        }
        
    }
    
    func adjustPropertiesToBounds(_ parent: FiltersX?)
    {
        if let parentUw = parent
        {
            self.parent=parentUw
            //ANCHISES-comebackZ
            //self.size=parentUw.size
            //self.boundsCenter=CIVector(x:parentUw.size.width/2.0,y:parentUw.size.height/2.0)
        }
    }
    
    func getNodeNameFX() -> String
    {

        var aliasStr=""
        if alias == ""
        {
             aliasStr="Step "+String(nodeIndex)
        }
        else
        {            //aliasStr="node" + String(nodeIndex) + ", alias - "+alias
            aliasStr="Step "+String(nodeIndex)+" (or "+alias+")"
        }
        return aliasStr
    }
    
    //ANCHISES
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
            
        
        if inputAAlias == ""
        {
            fxStr = "input - "+previousStr

        }
        else if inputAAlias != ""
        {
            let inputAAliasStr = "\""+inputAAlias+"\""
            if inputAAlias != ""{
                //let num=Int(inputImageAlias)!
                //if num > nodeIndex-1{
                //    inputImageAliasStr=inputImageAliasStr+"*"
                //}
            }
            
            fxStr = "input - " + inputAAliasStr
        }
        
        return fxStr
   
    }
    
    func getDisplayNameFX_Old() -> String
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
            let inputImageAliasStr = "\""+inputImageAlias+"\""
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

    
/*
    func getDisplayNameFX() -> String
    {

        var fxStr = "" //retName
        var aliasStr = ""
        var previousStr="previous"
        if nodeIndex == 1 {
            previousStr="0"//"0 (original image)"
        }
        else {
            previousStr="" + String(nodeIndex-1)
        }
            

        if alias == ""
        {
            aliasStr=", name - "+String(nodeIndex)
        }
        else
        {
            aliasStr=", name - "+alias
        }
 
        if inputImageAlias == "" && backgroundImageAlias == ""
        {
            fxStr = "input - "+previousStr
            if type.contains("Blend") || type.contains("Compositing") || type.contains("Mix") {
                fxStr="input - "+previousStr+", background - "+previousStr
            }
            if type.contains("Gradient") || type.contains("Generator")  {
                fxStr="input - none"
            }
        }
        else if inputImageAlias != "" && backgroundImageAlias == ""
        {
            var inputImageAliasStr = "\""+inputImageAlias+"\""
            if inputImageAlias != ""{
                let num=Int(inputImageAlias)!
                if num > nodeIndex-1{
                    inputImageAliasStr=inputImageAliasStr+"*"
                }
            }
            
            fxStr = "input - " + inputImageAliasStr
            if type.contains("Blend") || type.contains("Compositing") || type.contains("Mix") {
                fxStr = "input - "+inputImageAliasStr + ", background - "+previousStr
            }
            if type.contains("Gradient") || type.contains("Generator")  {
                fxStr="input - none"
            }
        }
        else if inputImageAlias == "" && backgroundImageAlias != ""
        {
            var backgroundImageAliasStr = "\""+backgroundImageAlias+"\""
            if backgroundImageAlias != ""{
                let num=Int(backgroundImageAlias)!
                if num > nodeIndex-1{
                    backgroundImageAliasStr=backgroundImageAliasStr+"*"
                }
            }
            
            fxStr = "input - "+previousStr+"," + backgroundImageAliasStr + ")"
            if type.contains("Blend") || type.contains("Compositing") || type.contains("Mix") {
                fxStr = "input - "+previousStr+", background - "+backgroundImageAliasStr
            }
            if type.contains("Gradient") || type.contains("Generator")  {
                fxStr="input - none"
            }
        }
        else if inputImageAlias != "" && backgroundImageAlias != ""
        {
            var inputImageAliasStr = "\""+inputImageAlias+"\""
            if inputImageAlias != ""{
                let num=Int(inputImageAlias)!
                if num > nodeIndex-1{
                    inputImageAliasStr=inputImageAliasStr+"*"
                }
            }
            var backgroundImageAliasStr = "\""+backgroundImageAlias+"\""
            if backgroundImageAlias != ""{
                let num=Int(backgroundImageAlias)!
                if num > nodeIndex-1{
                    backgroundImageAliasStr=backgroundImageAliasStr+"*"
                }
            }
            fxStr = "input - " + inputImageAliasStr
            if type.contains("Blend") || type.contains("Compositing") || type.contains("Mix") {
                fxStr = "input - " + inputImageAliasStr + ", background - " + backgroundImageAliasStr
            }
            if type.contains("Gradient") || type.contains("Generator")  {
                fxStr="input - none"
            }
        }

        return fxStr
   
        //return fxStr+aliasStr
    }
*/
    
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
        else if name == "FBMNoise"
        {
            return "FBM Noise"
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
    
    func getCurrentImage(thumbImage: UIImage) async -> UIImage
    {

        //ANCHISES
        let context = parent!.getContext()
        let beginImage = CIImage(image: thumbImage)
        
        _ = await executeImageBackwards()
        
        if let cgimg = context.createCGImage(getCIFilter()!.outputImage!, from: beginImage!.extent) {
            let processedImage = UIImage(cgImage: cgimg, scale: thumbImage.scale, orientation: thumbImage.imageOrientation)
            return processedImage
        }

        return thumbImage
       

    }
    //ANCHISES
    func handleNodeAlias(alias: String, inputNode: FilterX, beginNode: FilterX)->FilterX
    {
        if let parentUw = parent {
            return parentUw.handleNodeAlias(inputAlias: alias,
                                             inputNode: inputNode,
                                             beginNode: beginNode)
        }
        return beginNode
    }
    
    func handleNodeAlias(alias: String, previousNode: FilterX?)->FilterX?
    {
        if let parentUw = parent {
            return parentUw.handleNodeAlias(inputAlias: alias,previousNode: previousNode)
        }
        return nil
    }
    
    func runThrough(previousNode: FilterX?) -> FilterX? {

        self.previousNode=previousNode
        inputA = handleNodeAlias(alias: inputAAlias, previousNode: previousNode)
        if inputA != nil {
            inheritNodeProperties(inputNode: inputA!)
        }
        inputB = handleNodeAlias(alias: inputBAlias, previousNode: previousNode)
        inputC = handleNodeAlias(alias: inputCAlias, previousNode: previousNode)
        inputD = handleNodeAlias(alias: inputDAlias, previousNode: previousNode)

        return self
    }
    
    func executeBackwards() async {
        //print("Nodes",self,inputA, inputB)
        
        if inputA != nil {
            if inputA?.videoStatus == "Completed" {
            } else if inputA?.videoStatus != "Completed" {
                await inputA?.executeBackwards()
            }
        }
            
        await doExecute()

    }
    
    func inheritNodeProperties(inputNode: FilterX) {
        //ANCHISES
        //inherit start/endtime?
            duration = inputNode.duration
            preferredTransform = inputNode.preferredTransform
            naturalSize = inputNode.naturalSize
            size = inputNode.size
            timeScale = inputNode.timeScale
            nominalFrameRate = inputNode.nominalFrameRate
         
    }
    
    @MainActor
    func executeImageBackwards() async -> CIImage? {
        //print("Image Nodes",self,inputA, inputB)
        if inputA != nil {
            frameA = await inputA!.executeImageBackwards()
            //this line causes publishing from main thread issue if not handled properyl
        }
        
        return getCIFilter(frameA!).outputImage
    }
    
    
    func imageFromVideo(url: URL, at time: TimeInterval) async throws -> CIImage {
            try await withCheckedThrowingContinuation({ continuation in
                DispatchQueue.global(qos: .background).async {
                    let asset = AVURLAsset(url: url)
                    
                    let assetIG = AVAssetImageGenerator(asset: asset)
                    assetIG.appliesPreferredTrackTransform = true
                    assetIG.apertureMode = AVAssetImageGenerator.ApertureMode.encodedPixels
                    assetIG.appliesPreferredTrackTransform=true
                    
                    let cmTime = CMTime(seconds: time, preferredTimescale: 60)
                    let thumbnailImageRef: CGImage
                    do {
                        thumbnailImageRef = try assetIG.copyCGImage(at: cmTime, actualTime: nil)
                    } catch {
                        continuation.resume(throwing: error)
                        return
                    }
                    continuation.resume(returning: CIImage(cgImage: thumbnailImageRef))
                }
            })
        }
    
    public func imageFromVideo(url: URL, at time: TimeInterval, completion: @escaping (UIImage?) -> Void) {
        DispatchQueue.global(qos: .background).async {
            let asset = AVURLAsset(url: url)

            let assetIG = AVAssetImageGenerator(asset: asset)
            assetIG.appliesPreferredTrackTransform = true
            assetIG.apertureMode = AVAssetImageGenerator.ApertureMode.encodedPixels

            let cmTime = CMTime(seconds: time, preferredTimescale: 60)
            let thumbnailImageRef: CGImage
            do {
                thumbnailImageRef = try assetIG.copyCGImage(at: cmTime, actualTime: nil)
            } catch let error {
                print("Error: \(error)")
                return completion(nil)
            }

            DispatchQueue.main.async {
                completion(UIImage(cgImage: thumbnailImageRef))
            }
        }
    }
 
    
    func removeGeneratedVideo() {
        videoStatus="Not Started"
        guard let documentDirectory = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first else {
              //completion(nil, nil)
                videoStatus="Not Started"
            return //AVAssetExportSession.Status.failed
          }

        let outputURL = documentDirectory.appendingPathComponent(id.uuidString+".mp4")
        
        do {
                try FileManager.default.removeItem(at: outputURL)
        } catch {
                //videoStatus="Error"
                print(error)
        }
    }
    /*
    func execute(previousNode: FilterX?) async -> FilterX? {
        videoStatus="In Progress"
        self.previousNode=previousNode
        inputA = handleNodeAlias(alias: inputAAlias, previousNode: previousNode)
        inputB = handleNodeAlias(alias: inputBAlias, previousNode: previousNode)
        if inputA != nil {
            nodeType=inputA!.nodeType
        }
        if inputB != nil {
            nodeType=inputB!.nodeType
        }
        //inputB = handleNodeAlias(alias: backgroundImageAlias, previousNode: previousNode)
        await doExecute()
    
        return self
    }
    */
    func executeSession(_ session: AVAssetExportSession) async throws -> AVAssetExportSession.Status {

        return try await withCheckedThrowingContinuation({
            (continuation: CheckedContinuation<AVAssetExportSession.Status, Error>) in
            
            session.exportAsynchronously {
                DispatchQueue.main.async {
                    if let error = session.error {
                        continuation.resume(throwing: error)
                    } else {
                        continuation.resume(returning: session.status)
                    }
                }
            }
        })
    }
    
    func      executeCIFilterComposition() async throws -> AVMutableVideoComposition {

        return try await withCheckedThrowingContinuation({ [self]
            (continuation: CheckedContinuation<AVMutableVideoComposition, Error>) in
                
            AVMutableVideoComposition.videoComposition(with: composition, applyingCIFiltersWithHandler: { [self]request in
                              
                let pcImage=getCIFilter(request.sourceImage)
                request.finish(with: pcImage.outputImage!, context: nil)
                
            }, completionHandler: { avmvc, error in
             
                    if let error = error {
                        continuation.resume(throwing: error)
                    } else {
                        continuation.resume(returning: avmvc!)
                    }
                
            })
            
    
        })
    }
    
    func doExecute() async {
        //if videoStatus == "Completed" {
        //    return
        // }
        /*
        if type == "CICheckerboardGenerator" {
            let urlA = Bundle.main.url(forResource: "catsweetpotato", withExtension: "MOV")!
            let firstAsset = AVURLAsset(url: urlA)
            //parent!.generatingNode=String(nodeIndex)
            //parent!.objectWillChange.send()

            do {
                composition = AVMutableComposition()
                
                let videoAssetTrack = try await firstAsset.loadTracks(withMediaType: .video).first
                let videoCompositionTrack = composition.addMutableTrack(withMediaType: .video, preferredTrackID: kCMPersistentTrackID_Invalid)
                //let duration = try await firstAsset.load(.duration)
                let duration = CMTimeMakeWithSeconds(30, preferredTimescale: Int32(30.0))
                try? videoCompositionTrack?.insertTimeRange(CMTimeRange(start:  CMTime.zero, duration: duration), of: videoAssetTrack!, at: CMTime.zero)
                
                videoCompositionTrack?.preferredTransform = try await videoAssetTrack!.load(.preferredTransform)
                let size = try await videoAssetTrack!.load(.naturalSize)
                _ = try await videoAssetTrack!.load(.naturalTimeScale)
                let nfr = try await videoAssetTrack!.load(.nominalFrameRate)
                let orient = MovieX.orientationFromTransform(videoCompositionTrack!.preferredTransform)
                
                videoComposition = try await executeCIFilterComposition()
                if orient.isPortrait {
                    videoComposition.renderSize = CGSize(width: size.height, height: size.width)
                }
                else {
                    videoComposition.renderSize = CGSize(width: size.width, height: size.height)
                }
                
                videoComposition.renderSize = CGSize(width: 1920, height: 1920)
                //videoComposition.frameDuration = CMTimeMake(value: 5, timescale: Int32(nfr))
                
                await saveVideoToDocCache(asset: composition)
            } catch {
                videoStatus="Error"
                print(error)
            }

           //print("run through")
            
        }

        else
         */
         if type != "CIReadVideo" && CMTimeCompare(duration, CMTime.zero)==1 && inputA != nil {
            let urlA = inputA!.assetURL1
            let firstAsset = AVURLAsset(url: urlA)
            parent!.generatingNode=String(nodeIndex)
            parent!.objectWillChange.send()

            do {
                composition = AVMutableComposition()
                
                let videoAssetTrack = try await firstAsset.loadTracks(withMediaType: .video).first
                let videoCompositionTrack = composition.addMutableTrack(withMediaType: .video, preferredTrackID: kCMPersistentTrackID_Invalid)
                let duration = try await firstAsset.load(.duration)
                try? videoCompositionTrack?.insertTimeRange(CMTimeRange(start:  CMTime.zero, duration: duration), of: videoAssetTrack!, at: CMTime.zero)
                
                videoCompositionTrack?.preferredTransform = try await videoAssetTrack!.load(.preferredTransform)
                let size = try await videoAssetTrack!.load(.naturalSize)
                _ = try await videoAssetTrack!.load(.naturalTimeScale)
                let nfr = try await videoAssetTrack!.load(.nominalFrameRate)
                let orient = MovieX.orientationFromTransform(videoCompositionTrack!.preferredTransform)
                
                videoComposition = try await executeCIFilterComposition()
                if orient.isPortrait {
                    videoComposition.renderSize = CGSize(width: size.height, height: size.width)
                }
                else {
                    videoComposition.renderSize = CGSize(width: size.width, height: size.height)
                }
                videoComposition.frameDuration = CMTimeMake(value: 1, timescale: Int32(nfr))
                
                await saveVideoToDocCache(asset: composition)
            } catch {
                videoStatus="Error"
                print(error)
            }

           //print("run through")
            
        }
        else if CMTimeCompare(duration, CMTime.zero) != 1 && inputA != nil {
            
            let pNodeCIImage=inputA!.ciFilter!.outputImage!
            let _ = getCIFilter(pNodeCIImage)
            //remove the use of beginImage?
            //ciFilteris stored
            //external loop calling execute can setup using previousNode
        }
    }
    
    func saveVideoToDocCache(asset: AVAsset) async {
        //do {
            print("composite videoComposition completed")
            //https://stackoverflow.com/questions/75312257/swift-add-watermark-to-a-video-is-very-slow
            
            guard let exporter = AVAssetExportSession(asset: asset, presetName: AVAssetExportPresetHighestQuality) else {
                //completion(nil, nil)
                return //AVAssetExportSession.Status.failed
            }
            guard let documentDirectory = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first else {
                  //completion(nil, nil)
                    videoStatus="Error"
                return //AVAssetExportSession.Status.failed
              }
            print("FilterX documentDirectory")
            let outputURL = documentDirectory.appendingPathComponent(id.uuidString+".mp4")

            
            do {
                    try FileManager.default.removeItem(at: outputURL)
            } catch {
                    videoStatus="Error"
                    print(error)
            }
             
            
            print("FilterX saveVideoToDocCache")
            exporter.outputURL = outputURL
            exporter.videoComposition = videoComposition
            exporter.outputFileType = .mp4

            assetURL1=outputURL
            do {
                let status = try await executeSession(exporter)
                print(status)
                if status == AVAssetExportSession.Status.completed {
                    print("AVAssetExportSession completed")
                    self.videoStatus="Completed"
                    //self.updateStatus()
                }
            }
            catch {
                print("Filter Error in AVExportSession",error,self)
            }

        //unreachable
        //}
        //catch {
        //    videoStatus="Error"
        //    print(error)
        //}
    }
    
    //ANCHISES-remove
    /*
    func updateStatusWithAsset(asset: AVAsset) {
        
        let avPlayerItem = AVPlayerItem(asset: asset)
        Singleton.getAVPlayerView().replaceCurrentItem(with: avPlayerItem)
    }
    
    //ANCHISES - to be replaced by the one in pageSettings
    func updateStatus() {
        print("done")
        
        
        //var avPlayerItem = AVPlayerItem(asset: AVURLAsset(url: assetURL1))
        if videoStatus == "Completed" {
            if type == "CIReadVideo" ||  type == "CICutVideo"  {
                print("updateStatus...")
                print(assetURL1)
                let avAsset = AVURLAsset(url: assetURL1)
                let avPlayerItem = AVPlayerItem(asset: avAsset)
                Singleton.getAVPlayerView().replaceCurrentItem(with: avPlayerItem)
            }
            else {
              
                let avPlayerItem = AVPlayerItem(asset: composition)
                avPlayerItem.videoComposition = videoComposition
                Singleton.getAVPlayerView().replaceCurrentItem(with: avPlayerItem)
            }
        }
                    
    }
     */
}
