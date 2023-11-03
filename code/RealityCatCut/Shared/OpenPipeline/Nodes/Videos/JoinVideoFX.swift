//
//  Copyright © 2022-2023 James Boo. All rights reserved.
//

import SwiftUI
import AVFoundation

//ANCHISES
class JoinVideoFX: FilterX {

    let description = "BETA NODE: Join two videos. Currently only works on videos with the same dimensions."

    override init() {
        let name="CIJoinVideo"
        super.init(name)
        desc=description
        nodeType="Video"
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

    }
    
    override func setupProperties(_ parent: FiltersX?)
    {
        super.setupProperties(parent)
        
        if parent != nil{
            //tx=0.0
            //ty=0.0
        }
        
    }
    
    override func adjustPropertiesToBounds(_ parent: FiltersX?)
    {
        super.adjustPropertiesToBounds(parent)
        
        
    }
    


    func setupTrack(videoTrack: AVMutableCompositionTrack, asset: AVAsset, duration: CMTime, currentTime: CMTime) async {
 
        do{
            //let maxRenderSize = CGSize(width: 1080, height: 1920)
            let sourceTracks = try await asset.loadTracks(withMediaType: .video)
            let timeRange = CMTimeRangeMake(start: .zero, duration: duration)
            try videoTrack.insertTimeRange(timeRange, of: sourceTracks[0], at: currentTime)

            videoTrack.preferredTransform = try await sourceTracks[0].load(.preferredTransform)
            
            
            let layerInstruction = AVMutableVideoCompositionLayerInstruction(assetTrack: videoTrack)
            let preferredTransform = videoTrack.preferredTransform

            layerInstruction.setTransform(preferredTransform, at: currentTime)
            let videoCompositionInstruction = AVMutableVideoCompositionInstruction()
            videoCompositionInstruction.timeRange = CMTimeRangeMake(start: currentTime, duration: duration)
            videoCompositionInstruction.layerInstructions = [layerInstruction]
            instructions.append(videoCompositionInstruction)
            
        }catch{
          print("Error in Video Track")
        }
        
    }
    

    var instructions = [AVMutableVideoCompositionInstruction]()
    override func doExecute() async {
        if videoStatus == "Completed" {
            return
        }
        
        let urlA = inputA!.assetURL1
        let urlB = inputB!.assetURL1
        
        let firstAsset = AVURLAsset(url: urlA)
        let secondAsset = AVURLAsset(url: urlB)
        /*
        guard let documentDirectory = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first else {
              //completion(nil, nil)
              return
          }
         */
        //let maxRenderSize = CGSize(width: 1080, height: 1920)
        var currentTime = CMTime.zero
        //var renderSize = CGSize.zero
      
        //renderSize = CGSize(width:1080, height:1920)

        composition = AVMutableComposition()
        
        let videoTrack = composition.addMutableTrack(withMediaType: .video,preferredTrackID: kCMPersistentTrackID_Invalid)
        //let audioTrack = composition.addMutableTrack(withMediaType: .audio,preferredTrackID: kCMPersistentTrackID_Invalid)

        do{
            let duration1 = try await firstAsset.load(.duration)
            let sourceTracks1 = try await firstAsset.loadTracks(withMediaType: .video)
            let timeRange1 = CMTimeRangeMake(start: .zero, duration: duration1)
            try videoTrack!.insertTimeRange(timeRange1, of: sourceTracks1[0], at: currentTime)
            let preferredTransform1 = try await sourceTracks1[0].load(.preferredTransform)
            let size1 = try await sourceTracks1[0].load(.naturalSize)
            let nominalFrameRate1 = try await sourceTracks1[0].load(.nominalFrameRate)
           
            videoTrack!.preferredTransform = preferredTransform1
            let layerInstruction1 = AVMutableVideoCompositionLayerInstruction(assetTrack: videoTrack!)
            layerInstruction1.setTransform(preferredTransform1, at: currentTime)
            let videoCompositionInstruction1 = AVMutableVideoCompositionInstruction()
            videoCompositionInstruction1.timeRange = CMTimeRangeMake(start: currentTime, duration: duration1)
            videoCompositionInstruction1.layerInstructions = [layerInstruction1]
            instructions.append(videoCompositionInstruction1)

            currentTime = CMTimeAdd(currentTime, duration1)

            let duration2 = try await secondAsset.load(.duration)
            let sourceTracks2 = try await secondAsset.loadTracks(withMediaType: .video)
            let timeRange2 = CMTimeRangeMake(start: .zero, duration: duration2)
            try videoTrack!.insertTimeRange(timeRange2, of: sourceTracks2[0], at: currentTime)
            let preferredTransform2 = try await sourceTracks2[0].load(.preferredTransform)
            //let size2 = try await sourceTracks2[0].load(.naturalSize)
            //let nominalFrameRate2 = try await sourceTracks2[0].load(.nominalFrameRate)
            videoTrack!.preferredTransform = preferredTransform2
            let layerInstruction2 = AVMutableVideoCompositionLayerInstruction(assetTrack: videoTrack!)
            layerInstruction2.setTransform(preferredTransform2, at: currentTime)
            let videoCompositionInstruction2 = AVMutableVideoCompositionInstruction()
            videoCompositionInstruction2.timeRange = CMTimeRangeMake(start: currentTime, duration: duration2)
            videoCompositionInstruction2.layerInstructions = [layerInstruction2]
            instructions.append(videoCompositionInstruction2)

            switch [preferredTransform1.a, preferredTransform1.b, preferredTransform1.c, preferredTransform1.d] {
                  case [0.0, 1.0, -1.0, 0.0]:
                      //assetOrientation = .right
                      videoComposition.renderSize = CGSize(width: size1.height, height: size1.width)
                  case [0.0, -1.0, 1.0, 0.0]:
                      //assetOrientation = .left
                      videoComposition.renderSize = CGSize(width: size1.height, height: size1.width)
                  case [1.0, 0.0, 0.0, 1.0]:
                      //assetOrientation = .up
                      videoComposition.renderSize = CGSize(width: size1.width, height: size1.height)
                  case [-1.0, 0.0, 0.0, -1.0]:
                      //assetOrientation = .down
                      videoComposition.renderSize = CGSize(width: size1.width, height: size1.height)
                  default:
                      videoComposition.renderSize = CGSize(width: size1.width, height: size1.height)
                      break
                  }
            
            videoComposition.instructions = instructions
            //videoComposition.frameDuration = CMTimeMake(value: 1, timescale: 30)
            //videoComposition.renderSize = renderSize
            videoComposition.frameDuration = CMTimeMake(value: 1, timescale: Int32(nominalFrameRate1))
            //videoComposition.renderSize = size1
           
            await saveVideoToDocCache(asset: composition)
        }catch{
            print("Error in Load Duration or setupTrack")
        }
        


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
    
    override func executeBackwards() async {
        //print("Nodes",self,inputA, inputB)
        if inputA != nil {
            if inputA?.videoStatus == "Completed" {
            } else if inputA?.videoStatus != "Completed" {
                await inputA?.executeBackwards()
            }
        }
 
        if inputB != nil {
            if inputB?.videoStatus == "Completed" {
                
            } else if inputB?.videoStatus != "Completed" {
                await inputB?.executeBackwards()
            }
        }
  
        await doExecute()

    }
    
    override func executeImageBackwards() async -> CIImage? {

        if inputA != nil {
            frameA = await inputA!.executeImageBackwards()
 
        }
        //ensure getCIFilter is available even for video nodes
        _ = getCIFilter(frameA!)
        return frameA
    }
    
    override func getDisplayNameFX() -> String
    {

        var fxStr = "" //retName
        var previousStr="previous"
        if nodeIndex == 1 {
            previousStr="0"//"0 (original image)"
        }
        else {
            previousStr="" + String(nodeIndex-1)
        }
            
        if inputAAlias == "" && inputBAlias == ""
        {
            fxStr="A - "+previousStr+", B - "+previousStr
        }
        else if inputAAlias != "" && inputBAlias == ""
        {
            let inputAAliasStr = "\""+inputAAlias+"\""
            fxStr = "A - "+inputAAliasStr + ", B - "+previousStr
        }
        else if inputAAlias == "" && inputBAlias != ""
        {
            let inputBAliasStr = "\""+inputBAlias+"\""
            fxStr = "A - "+previousStr+", B - "+inputBAliasStr
        }
        else if inputAAlias != "" && inputBAlias != ""
        {
            let inputAAliasStr = "\""+inputAAlias+"\""
            let inputBAliasStr = "\""+inputBAlias+"\""
            fxStr = "A - " + inputAAliasStr + ", B - " + inputBAliasStr
        }

        return fxStr
   
    }

    

}


