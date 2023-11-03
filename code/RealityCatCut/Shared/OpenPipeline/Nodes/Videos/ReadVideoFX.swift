//
//  Copyright © 2022 James Boo. All rights reserved.
//

import SwiftUI
import AVFoundation


class ReadVideoFX: FilterX {
   
    let description = "BETA NODE: Read a video from file."
    var updateTimeline=false
    
    override init() {
        let name="CIReadVideo"
        super.init(name)
        desc=description
        nodeType="Video"
        videoStatus="Completed"

    }
    
    enum CodingKeys : String, CodingKey {
        case assetURL


    }

    required init(from decoder: Decoder) throws {
        try super.init(from: decoder)
        let values = try decoder.container(keyedBy: CodingKeys.self)
        
        let data = try values.decodeIfPresent(String.self, forKey: .assetURL) ?? nil
        
        if data != nil
        {
            let assetData = Data(base64Encoded: data!)
            self.assetURL1 = try! URL(from: assetData as! Decoder)
        }
        

    }
    
    override func encode(to encoder: Encoder) throws {
        try super.encode(to: encoder)
        var container = encoder.container(keyedBy: CodingKeys.self)
        
        
        let data = try! Data(contentsOf: assetURL1)
        let base64String = data.base64EncodedString()
        try container.encode(base64String, forKey: .assetURL)
        /*
        if let iImg = inputImage {
            try container.encode(ImageUtil.convertImageToBase64String(img:iImg), forKey: .inputImage)
        }
         */
    }
    
    override func setupProperties(_ parent: FiltersX?)
    {
        //ANCHISES
        self.parent=parent
        
        //initialize base on csw video
        /*
        duration = CMTimeMake(value: 7125, timescale: 600)
        preferredTransform = CGAffineTransform(a: 1.0, b: 0.0, c: 0.0, d: 1.0, tx: 0.0, ty: 0.0)
        naturalSize = CGSize(width:1920.0, height:1080.0)
        size = CGSize(width:1920.0, height:1080.0)
        timeScale = 600
        nominalFrameRate = 29.978947
        */
        duration = CMTimeMake(value: 3012, timescale: 600)
        preferredTransform = CGAffineTransform(a: 0.0, b: 1.0, c: -1.0, d: 0.0, tx: 2160.0, ty: 0.0)
        naturalSize = CGSize(width:3840.0, height:2160.0)
        size = CGSize(width:2160.0, height:3840.0)
        timeScale = 600
        nominalFrameRate = 59.940258
        
    }
    
    override func adjustPropertiesToBounds(_ parent: FiltersX?)
    {
        //ANCHISES
        //super.adjustPropertiesToBounds(parent)
        self.parent=parent

        
    }
    
    override func executeBackwards() async {
        //print("Nodes",self,inputA, inputB)
      //do nothing/ dont go backward
        //await setupVideoProperties(url: assetURL1)
        await doExecute()
        
    
    }
    
    override func executeImageBackwards() async -> CIImage? {
        
        do {
       
            frameA = try await imageFromVideo(url: assetURL1, at: 0)

        } catch {
            print(error)
        }
        //ensure getCIFilter is available even for video nodes
        _ = getCIFilter(frameA!)
        return frameA
    }
    
    override func runThrough(previousNode: FilterX?) -> FilterX? {

        self.previousNode=nil
        inputA = nil
        inputB = nil
        return self

    }
    
    @MainActor
    func setupVideoProperties(url: URL) async {
        self.assetURL1=url
       
        
        
        let firstAsset = AVURLAsset(url: url)
        do {

            let videoAssetTrack = try await firstAsset.loadTracks(withMediaType: .video).first
            
            duration = try await firstAsset.load(.duration)
            preferredTransform = try await videoAssetTrack!.load(.preferredTransform)
            naturalSize = try await videoAssetTrack!.load(.naturalSize)
            size = try await videoAssetTrack!.load(.naturalSize)
            if MovieX.orientationFromTransform(preferredTransform).isPortrait {
                size.width=naturalSize.height
                size.height=naturalSize.width                
            }
            timeScale = try await videoAssetTrack!.load(.naturalTimeScale)
            nominalFrameRate = try await videoAssetTrack!.load(.nominalFrameRate)

            print(duration)
            print(preferredTransform)
            print(naturalSize)
            print(size)
            print(timeScale)
            print(nominalFrameRate)

         
            
            print("end setupVideoProperties")

        } catch {
            videoStatus="Error"
            print(error)
        }
        
    }
    
    override func doExecute() async {
        
    }
    
    override func getCIFilter(_ ciImage: CIImage)->CIFilter
    {
        
        var currentCIFilter: CIFilter
        
        if ciFilter != nil {
            currentCIFilter = ciFilter!
        } else {
            let color:CIColor = .white
            var constantColorFilter: CIFilter

            constantColorFilter = CIFilter(name: "CIConstantColorGenerator")!
            constantColorFilter.setValue(color, forKey: kCIInputColorKey)
            var cropFilter: CIFilter
            cropFilter = CIFilter(name: "CICrop")!
            cropFilter.setValue(constantColorFilter.outputImage!, forKey: kCIInputImageKey)
            let rect = CIVector(cgRect: CGRect(x:0, y: 0, width: CGFloat(size.width), height: CGFloat(size.height)))
            cropFilter.setValue(rect, forKey: "inputRectangle")
            
            currentCIFilter=cropFilter
            ciFilter=currentCIFilter
     
        }
        
        return currentCIFilter
        
    }

    override func getDisplayNameFX() -> String
    {

        let fxStr = "input - none"
        return fxStr
   
    }
    
}


