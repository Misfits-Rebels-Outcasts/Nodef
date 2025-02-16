//
//  Copyright © 2022 James Boo. All rights reserved.
//


import SwiftUI
import AVFoundation

class BaseBlendMaskFX: FilterX {
              
    override init()
    {
        super.init()
    }
    
    override init(_ type:String) {
        super.init(type)
    }
    
    enum CodingKeys : String, CodingKey {
        case None
    }

    required init(from decoder: Decoder) throws {
 
        try super.init(from: decoder)
    }
    
    override func encode(to encoder: Encoder) throws {
        try super.encode(to: encoder)
    }
    
    //deprecate
    override func getCIFilter(currentImage: CIImage, beginImage: CIImage) -> CIFilter? {
            
        var currentCIFilter: CIFilter
        if ciFilter != nil {
            currentCIFilter = ciFilter!
        } else {
            currentCIFilter = CIFilter(name: type)!
            ciFilter=currentCIFilter

        }
        
        let inputImage=handleAlias(alias: inputImageAlias,
                                      inputImage: currentImage,
                                      beginImage: beginImage)
        
        let backgroundImage=handleAlias(alias: backgroundImageAlias,
                                      inputImage: currentImage,
                                      beginImage: beginImage)
        

        currentCIFilter.setValue(inputImage, forKey: kCIInputImageKey)
        currentCIFilter.setValue(backgroundImage, forKey: kCIInputBackgroundImageKey)
        return ciFilter!

    }

    //ANCHISES
    func getCIFilter(firstImage: CIImage, secondImage: CIImage, thirdImage: CIImage) -> CIFilter? {
            
        var currentCIFilter: CIFilter
        if ciFilter != nil {
            currentCIFilter = ciFilter!
        } else {
            currentCIFilter = CIFilter(name: type)!
            ciFilter=currentCIFilter
        }

        currentCIFilter.setValue(firstImage, forKey: kCIInputImageKey)
        currentCIFilter.setValue(secondImage, forKey: kCIInputBackgroundImageKey)
        currentCIFilter.setValue(thirdImage, forKey: kCIInputMaskImageKey)
        return ciFilter!

    }
    
    override func getDisplayNameFX() -> String
    {

        var fxStr = ""
        let previousStr="" + String(nodeIndex-1)
        

        if inputAAlias == "" && inputBAlias == "" && inputCAlias == ""
        {
            fxStr="A - "+previousStr+", B - "+previousStr + ", C - "+previousStr
        }
        else if inputAAlias == "" && inputBAlias == "" && inputCAlias != ""
        {
            let inputAAliasStr = previousStr
            let inputBAliasStr = previousStr
            let inputCAliasStr = "\""+inputCAlias+"\""
            fxStr = "A - " + inputAAliasStr + ", B - " + inputBAliasStr + ", C - " + inputCAliasStr
        }
        else if inputAAlias == "" && inputBAlias != "" && inputCAlias == ""
        {
            let inputAAliasStr = previousStr
            let inputBAliasStr = "\""+inputBAlias+"\""
            let inputCAliasStr = previousStr
            fxStr = "A - " + inputAAliasStr + ", B - " + inputBAliasStr + ", C - " + inputCAliasStr
        }
        else if inputAAlias == "" && inputBAlias != "" && inputCAlias != ""
        {
            let inputAAliasStr = previousStr
            let inputBAliasStr = "\""+inputBAlias+"\""
            let inputCAliasStr = "\""+inputCAlias+"\""
            fxStr = "A - " + inputAAliasStr + ", B - " + inputBAliasStr + ", C - " + inputCAliasStr
        }
        else if inputAAlias != "" && inputBAlias == "" && inputCAlias == ""
        {
            let inputAAliasStr = "\""+inputAAlias+"\""
            let inputBAliasStr = previousStr
            let inputCAliasStr = previousStr
            fxStr = "A - " + inputAAliasStr + ", B - " + inputBAliasStr + ", C - " + inputCAliasStr
        }
        else if inputAAlias != "" && inputBAlias == "" && inputCAlias != ""
        {
            let inputAAliasStr = "\""+inputAAlias+"\""
            let inputBAliasStr = previousStr
            let inputCAliasStr = "\""+inputCAlias+"\""
            fxStr = "A - " + inputAAliasStr + ", B - " + inputBAliasStr + ", C - " + inputCAliasStr
        }
        else if inputAAlias != "" && inputBAlias != "" && inputCAlias == ""
        {
            let inputAAliasStr = "\""+inputAAlias+"\""
            let inputBAliasStr = "\""+inputBAlias+"\""
            let inputCAliasStr = previousStr
            fxStr = "A - " + inputAAliasStr + ", B - " + inputBAliasStr + ", C - " + inputCAliasStr
        }
        else if inputAAlias != "" && inputBAlias != ""  && inputCAlias != ""
        {
            let inputAAliasStr = "\""+inputAAlias+"\""
            let inputBAliasStr = "\""+inputBAlias+"\""
            let inputCAliasStr = "\""+inputCAlias+"\""
            fxStr = "A - " + inputAAliasStr + ", B - " + inputBAliasStr + ", C - " + inputCAliasStr
        }

        return fxStr
   
    }
    override func runThrough(previousNode: FilterX?) -> FilterX? {

        self.previousNode=previousNode
        inputA = handleNodeAlias(alias: inputAAlias, previousNode: previousNode)
        if inputA != nil {
            inheritNodeProperties(inputNode: inputA!)
        }
        inputB = handleNodeAlias(alias: inputBAlias, previousNode: previousNode)
        inputC = handleNodeAlias(alias: inputCAlias, previousNode: previousNode)
        inputD = handleNodeAlias(alias: inputDAlias, previousNode: previousNode)
        
        var minDuration = inputA!.duration > inputB!.duration ? inputB!.duration : inputA!.duration
        minDuration = minDuration > inputC!.duration ? inputC!.duration : minDuration
        
        duration=minDuration
        
        return self
    }
    
    override func doExecute() async {
        
        if videoStatus == "Completed" {
            return
        }
        
        print("base blend mask doexecute")
        let urlA = inputA!.assetURL1
        let urlB = inputB!.assetURL1
        let urlC = inputC!.assetURL1
        
        let firstAsset = AVURLAsset(url: urlA)
        let secondAsset = AVURLAsset(url: urlB)
        let thirdAsset = AVURLAsset(url: urlC)

        do{
            let duration1 = try await firstAsset.load(.duration)
            let duration2 = try await secondAsset.load(.duration)
            let duration3 = try await secondAsset.load(.duration)
            var duration = duration1 > duration2 ? duration2 : duration1
            duration = duration3 > duration ? duration : duration3
            
            composition = AVMutableComposition()
            let firstTrack = composition.addMutableTrack(withMediaType: .video,
                        preferredTrackID: kCMPersistentTrackID_Invalid)
            let timerange1 = CMTimeRange(start: .zero, duration: duration)
            let firstSourceTracks = try await firstAsset.loadTracks(withMediaType: .video)
            try firstTrack!.insertTimeRange(timerange1, of:firstSourceTracks[0],at: .zero)
            let preferredTransform1 = try await firstSourceTracks[0].load(.preferredTransform)
            firstTrack?.preferredTransform = preferredTransform1
            let size1 = try await firstSourceTracks[0].load(.naturalSize)
            let firstNominalFrameRate = try await firstSourceTracks[0].load(.nominalFrameRate)
            
            
            let secondTrack = composition.addMutableTrack(withMediaType: .video,
                        preferredTrackID: kCMPersistentTrackID_Invalid)
            let timerange2 = CMTimeRange(start: .zero, duration: duration)
            let secondSourceTracks = try await secondAsset.loadTracks(withMediaType: .video)
            try secondTrack!.insertTimeRange(timerange2, of:secondSourceTracks[0],at: .zero)
            let preferredTransform2 = try await secondSourceTracks[0].load(.preferredTransform)
            secondTrack?.preferredTransform = preferredTransform2
            _ = try await secondSourceTracks[0].load(.naturalSize)
            _ = try await secondSourceTracks[0].load(.nominalFrameRate)

            let thirdTrack = composition.addMutableTrack(withMediaType: .video,
                        preferredTrackID: kCMPersistentTrackID_Invalid)
            let timerange3 = CMTimeRange(start: .zero, duration: duration)
            let thirdSourceTracks = try await thirdAsset.loadTracks(withMediaType: .video)
            try thirdTrack!.insertTimeRange(timerange3, of:thirdSourceTracks[0],at: .zero)
            let preferredTransform3 = try await thirdSourceTracks[0].load(.preferredTransform)
            thirdTrack?.preferredTransform = preferredTransform3
            _ = try await thirdSourceTracks[0].load(.naturalSize)
            _ = try await thirdSourceTracks[0].load(.nominalFrameRate)
            
            let instruction = CustomNodeVideo3WayInstruction(
                timerange: CMTimeRange(start: .zero, duration: duration1),
                node: self,
                preferredTransform1: preferredTransform1,
                preferredTransform2: preferredTransform2,
                preferredTransform3: preferredTransform3)
            
            videoComposition.customVideoCompositorClass = CustomNodeVideo3WayCompositor.self
            
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
            
            videoComposition.frameDuration = CMTimeMake(value: 1, timescale: Int32(firstNominalFrameRate))
            videoComposition.instructions = [instruction]
                                
        }catch{
            print("Error in Load Duration or setupTrack")
        }
        await saveVideoToDocCache(asset: composition)
        
    }
    
    override func executeBackwards() async {
        //print("Nodes",self,inputA, inputB, inputC)
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
        if inputC != nil {
            if inputC?.videoStatus == "Completed" {
                
            } else if inputC?.videoStatus != "Completed" {
                await inputC?.executeBackwards()
            }
        }

        await doExecute()

    }
    
    override func executeImageBackwards() async -> CIImage? {
        print("Base Blend Image Nodes",self,inputA!, inputB!)
             
        if inputA != nil && inputB != nil && inputC != nil{
            frameA = await inputA!.executeImageBackwards()
            frameB = await inputB!.executeImageBackwards()
            frameC = await inputC!.executeImageBackwards()

        }
        
        return getCIFilter(firstImage: frameA!,secondImage: frameB!,thirdImage: frameC!)!.outputImage
    }

}
