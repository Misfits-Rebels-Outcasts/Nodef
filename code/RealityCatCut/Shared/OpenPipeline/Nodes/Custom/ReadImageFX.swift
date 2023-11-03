//
//  Copyright © 2022 James Boo. All rights reserved.
//

import SwiftUI
import PhotosUI

class ReadImageFX: FilterX {
   
    @Published var inputImage = UIImage(named: "KittyStep")
//    @Published var inputImage = UIImage(named: "sunflower")

    @Published var a:Float = 1.0
    //@Published var b:CGFloat = 0.0
    //@Published var c:CGFloat = 0.0
    @Published var d:Float = 1.0
    @Published var tx:Float = 0.0
    @Published var ty:Float = 0.0
    
    @Published var durationSeconds:Float = 0
    @Published var durationValue:Float = 0
    @Published var durationTimeScale:Float = 600
    
    //ANCHISES
    enum ImageState {
        case empty
        //case loading(Progress)
        case loading
        case success(Image)
        case failure(Error)
    }
    enum TransferError: Error {
        case importFailed
    }
    @Published var imageState: ImageState = .empty
    @Published var imageSelection: PhotosPickerItem?
    /*
    @Published var imageSelection: PhotosPickerItem? = nil {
        didSet {
            if let imageSelection {
                let progress = loadTransferable(from: imageSelection)
                imageState = .loading(progress)
            } else {
                imageState = .empty
            }
        }
    }
    */

    let description = "Read an image from file."
    var randomInt = 0
    override init() {
        let name="CIReadImage"
        super.init(name)
        desc=description
        randomInt = Int.random(in: 0..<2)
        //ANCHISES
        size=inputImage!.size
        
        
    }
    
    enum CodingKeys : String, CodingKey {
        case inputImage
        case a
        //case b
        //case c
        case d
        case tx
        case ty
        //case backgroundImage
    }

    required init(from decoder: Decoder) throws {
        try super.init(from: decoder)
        let values = try decoder.container(keyedBy: CodingKeys.self)
        
        let data = try values.decodeIfPresent(String.self, forKey: .inputImage) ?? nil
        if data != nil
        {
            self.inputImage = ImageUtil.convertBase64StringToImage(imageBase64String:data!)
        }
        a = try values.decodeIfPresent(Float.self, forKey: .a) ?? 0
        //b = try values.decodeIfPresent(CGFloat.self, forKey: .b) ?? 0
        //c = try values.decodeIfPresent(CGFloat.self, forKey: .c) ?? 0
        d = try values.decodeIfPresent(Float.self, forKey: .d) ?? 0
        
        tx = try values.decodeIfPresent(Float.self, forKey: .tx) ?? 0
        ty = try values.decodeIfPresent(Float.self, forKey: .ty) ?? 0
        

    }
    
    override func encode(to encoder: Encoder) throws {
        try super.encode(to: encoder)
        var container = encoder.container(keyedBy: CodingKeys.self)
        
        if let iImg = inputImage {
            try container.encode(ImageUtil.convertImageToBase64String(img:iImg), forKey: .inputImage)
        }
        try container.encode(a, forKey: .a)
        //try container.encode(b, forKey: .b)
        //try container.encode(c, forKey: .c)
        try container.encode(d, forKey: .d)

        try container.encode(tx, forKey: .tx)
        try container.encode(ty, forKey: .ty)

    }
    
    override func setupProperties(_ parent: FiltersX?)
    {
        super.setupProperties(parent)
        
        if parent != nil{
            tx=0.0
            ty=0.0
        }
        
        duration = .zero
        //ANCHISES-its good to set image size besides setting in the init
        //this is to cater for Select Image setting of size
        size = inputImage!.size
        
    }
    
    override func adjustPropertiesToBounds(_ parent: FiltersX?)
    {
        super.adjustPropertiesToBounds(parent)
        
        tx = tx > Float(size.width) ? Float(size.width) : tx
        ty = ty > Float(size.height) ? Float(size.height) : ty
        
        tx = tx < Float(0-size.width) ? Float(0-size.width) : tx
        ty = ty < Float(0-size.height) ? Float(0-size.height) : ty
        
    }
    
    override func getCIFilter(_ ciImage: CIImage)->CIFilter
    {
        
        var currentCIFilter: CIFilter
        if ciFilter != nil {
            currentCIFilter = ciFilter!
        } else {
            currentCIFilter = CIFilter(name: "CIAffineTransform")!
            ciFilter=currentCIFilter
        }
        
        let scaledImage = inputImage

        currentCIFilter.setValue(CIImage(image: scaledImage!), forKey: kCIInputImageKey)
        let transform=CGAffineTransform(a:CGFloat(a),b:0,c:0,d:CGFloat(d),tx:CGFloat(tx),ty:CGFloat(ty))
        currentCIFilter.setValue(transform, forKey: kCIInputTransformKey)
        return currentCIFilter
        
    }

    override func getDisplayNameFX() -> String
    {

        let fxStr = "input - none"
        return fxStr
   
    }
    
    //ANCHISES
    override func executeBackwards() async {
        //print("Nodes",self,inputA, inputB)
        await doExecute()
        
    
    }
    
    override func doExecute() async {
        let urlA = urlStep
        let firstAsset = AVURLAsset(url: urlA)

        do {
            composition = AVMutableComposition()
            
            let videoAssetTrack = try await firstAsset.loadTracks(withMediaType: .video).first
            let videoCompositionTrack = composition.addMutableTrack(withMediaType: .video, preferredTrackID: kCMPersistentTrackID_Invalid)
            
            var vduration = duration
            if vduration == .zero {
                //failsafe
                vduration=CMTimeMake(value: 3, timescale: 600)
            }
            try? videoCompositionTrack?.insertTimeRange(CMTimeRange(start:  CMTime.zero, duration: duration), of: videoAssetTrack!, at: CMTime.zero)
            videoComposition = try await executeCIFilterComposition()
            videoComposition.renderSize = CGSize(width: size.width, height: size.height)
            await saveVideoToDocCache(asset: composition)
        } catch {
            videoStatus="Error"
            print(error)
        }

        
    }

    
    override func executeImageBackwards() async -> CIImage? {
        
        //do {
            let beginImage = CIImage(image: inputImage!)
            frameA = getCIFilter(beginImage!).outputImage

        //} catch {
        //    print(error)
        //}
        return frameA
    }
    
    override func runThrough(previousNode: FilterX?) -> FilterX? {

        self.previousNode=nil
        inputA = nil
        inputB = nil
        return self

    }
}

