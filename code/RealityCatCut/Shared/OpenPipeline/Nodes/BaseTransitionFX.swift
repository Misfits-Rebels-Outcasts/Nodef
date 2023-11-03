//
//  Copyright © 2022 James Boo. All rights reserved.
//


import SwiftUI
import AVFoundation
class BaseTransitionFX: FilterX {

    @Published var targetImageAlias : String=""
    @Published var targetImageAliasId : String=""
    @Published var time:Float = 0.0
    
    override init()
    {
        super.init()
    }
    
    override init(_ type:String) {
        super.init(type)
    }
    
    enum CodingKeys : String, CodingKey {
        case targetImageAlias
        case time
    }

    required init(from decoder: Decoder) throws {
 
        try super.init(from: decoder)
        let values = try decoder.container(keyedBy: CodingKeys.self)
        targetImageAlias = try values.decodeIfPresent(String.self, forKey: .targetImageAlias) ?? ""
        time = try values.decodeIfPresent(Float.self, forKey: .time) ?? 0.0
    }
    
    override func encode(to encoder: Encoder) throws {
        try super.encode(to: encoder)
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(targetImageAlias, forKey: .targetImageAlias)
        try container.encode(time, forKey: .time)
    }
    
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
        
        let targetImage=handleAlias(alias: targetImageAlias,
                                      inputImage: currentImage,
                                      beginImage: beginImage)
        
        currentCIFilter.setValue(inputImage, forKey: kCIInputImageKey)
        currentCIFilter.setValue(targetImage, forKey: kCIInputTargetImageKey)
        currentCIFilter.setValue(time, forKey: kCIInputTimeKey)

        return currentCIFilter

    }
    //ANCHISES
    func getCIFilter(firstImage: CIImage, secondImage: CIImage) -> CIFilter? {
            
        var currentCIFilter: CIFilter
        if ciFilter != nil {
            currentCIFilter = ciFilter!
        } else {
            currentCIFilter = CIFilter(name: type)!
            ciFilter=currentCIFilter
        }

        currentCIFilter.setValue(firstImage, forKey: kCIInputImageKey)
        currentCIFilter.setValue(secondImage, forKey: kCIInputTargetImageKey)
        currentCIFilter.setValue(time, forKey: kCIInputTimeKey)
        return ciFilter!

    }
    /*
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
 
        if inputImageAlias == "" && targetImageAlias == ""
        {
            fxStr="input - "+previousStr+", target - "+previousStr
        }
        else if inputImageAlias != "" && targetImageAlias == ""
        {
            let inputImageAliasStr = "\""+inputImageAlias+"\""
            fxStr = "input - "+inputImageAliasStr + ", target - "+previousStr
        }
        else if inputImageAlias == "" && targetImageAlias != ""
        {
            let targetImageAliasStr = "\""+targetImageAlias+"\""
            fxStr = "input - "+previousStr+", target - "+targetImageAliasStr
        }
        else if inputImageAlias != "" && targetImageAlias != ""
        {
            let inputImageAliasStr = "\""+inputImageAlias+"\""
            let targetImageAliasStr = "\""+targetImageAlias+"\""
            fxStr = "input - " + inputImageAliasStr + ", target - " + targetImageAliasStr
        }

        return fxStr
   
    }
     */
    
    //ANCHISES
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
   
        //return fxStr+aliasStr
    }
   
    
    override func doExecute() async {
        
        if videoStatus == "Completed" {
            return
        }
        
        print("base transition doexecute")
        let urlA = inputA!.assetURL1
        let urlB = inputB!.assetURL1
        
        let firstAsset = AVURLAsset(url: urlA)
        let secondAsset = AVURLAsset(url: urlB)
        

        do{
            let duration1 = try await firstAsset.load(.duration)
            let duration2 = try await secondAsset.load(.duration)
            let duration = duration1 > duration2 ? duration2 : duration1
            print("duration select",duration,duration1,duration2)
            //need to set the shorter duration or otherwise the first track duration have to be longer. otherwise crash.
            composition = AVMutableComposition()
            let firstTrack = composition.addMutableTrack(withMediaType: .video,
                        preferredTrackID: kCMPersistentTrackID_Invalid)
            //print("base blend doexecute firstAsset",firstTrack?.trackID)
            let timerange1 = CMTimeRange(start: .zero, duration: duration)
            let firstSourceTracks = try await firstAsset.loadTracks(withMediaType: .video)
            try firstTrack!.insertTimeRange(timerange1, of:firstSourceTracks[0],at: .zero)
            let preferredTransform1 = try await firstSourceTracks[0].load(.preferredTransform)
            firstTrack?.preferredTransform = preferredTransform1
            let size1 = try await firstSourceTracks[0].load(.naturalSize)
            let firstNominalFrameRate = try await firstSourceTracks[0].load(.nominalFrameRate)
            
            
            //let duration2 = try await secondAsset.load(.duration)
            let secondTrack = composition.addMutableTrack(withMediaType: .video,
                        preferredTrackID: kCMPersistentTrackID_Invalid)
            //print("base blend doexecute secondAsset",secondTrack?.trackID)
            let timerange2 = CMTimeRange(start: .zero, duration: duration)
            let secondSourceTracks = try await secondAsset.loadTracks(withMediaType: .video)
            try secondTrack!.insertTimeRange(timerange2, of:secondSourceTracks[0],at: .zero)
            let preferredTransform2 = try await secondSourceTracks[0].load(.preferredTransform)
            secondTrack?.preferredTransform = preferredTransform2
            _ = try await secondSourceTracks[0].load(.naturalSize)
            _ = try await secondSourceTracks[0].load(.nominalFrameRate)


            
            
            let instruction = CustomNodeVideoInstruction(timerange: CMTimeRange(start: .zero, duration: duration1) , rotateSecondAsset:false, node: self, preferredTransform1: preferredTransform1, preferredTransform2: preferredTransform2)
            //print("base blend doexecute CustomNode",duration1)
            videoComposition.customVideoCompositorClass = CustomNodeVideoCompositor.self
            
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
            //print("base blend doexecute rendersize",videoComposition.renderSize)
            //videoComposition.renderSize = CGSize(width: 1080, height: 1920)
            //videoComposition.renderSize = CGSize(width: 1920, height: 1080)
            //videoComposition.frameDuration = CMTimeMake(value: 1, timescale: 30)
            //print("firstNominalFrameRate",firstNominalFrameRate)
            videoComposition.frameDuration = CMTimeMake(value: 1, timescale: Int32(firstNominalFrameRate))
            
            
            videoComposition.instructions = [instruction]
            //print("base blend doexecute instructions")
                                
        }catch{
            print("Error in Load Duration or setupTrack")
        }
        await saveVideoToDocCache(asset: composition)
        
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
        
        let minDuration = inputA!.duration > inputB!.duration ? inputB!.duration : inputA!.duration
        duration=minDuration
        
        return self
    }
    
    override func executeBackwards() async {
        //print("Transition Nodes",self,inputA, inputB)
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
        print("Base Transition Image Nodes",self,inputA!, inputB!)
             
        if inputA != nil && inputB != nil {
            frameA = await inputA!.executeImageBackwards()
            frameB = await inputB!.executeImageBackwards()
        }
        
        return getCIFilter(firstImage: frameA!,secondImage: frameB!)!.outputImage
    }

    
}
