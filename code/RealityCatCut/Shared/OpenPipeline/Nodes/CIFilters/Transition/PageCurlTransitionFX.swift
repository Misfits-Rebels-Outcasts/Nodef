//
//  Copyright © 2022 James Boo. All rights reserved.
//


import SwiftUI
import AVFoundation
class PageCurlTransitionFX: BaseTransitionFX {
       
    @Published var inputBacksideImageAlias : String=""
    @Published var inputShadingImageAlias : String=""
    
    @Published var inputBacksideImageAliasId : String=""
    @Published var inputShadingImageAliasId : String=""

    @Published var x:Float = 0.0
    @Published var y:Float = 0.0
    @Published var extentWidth:Float = 300.0
    @Published var extentHeight:Float = 300.0
    
    @Published var angle:Float = 0.25//0.00
    @Published var radius:Float = 100.0
    
    let description = "Transitions from one image (A) to another (B) by simulating a curling page, revealing the new image as the page curls. Backside Image (C) is the image that appears on the back of the source image, as the page curls to reveal the target image. Angle is the angle of the curling page. Radius is the radius of the curl. (D) is the Shading Image. Please refer to the Presets on how to use this filter node."
  
    override init()
    {
        let name="CIPageCurlTransition"
        super.init(name)
        desc=description
        time = 0.2
        /*
        print(CIFilter.localizedName(forFilterName: name))
        print(CIFilter.localizedDescription(forFilterName: name))
        print(CIFilter.localizedReferenceDocumentation(forFilterName: name))
        
        print("inputAngle")
        if let attribute = CIFilter.pageCurlTransition().attributes["inputAngle"] as? [String: AnyObject]
        {
           let minimum = attribute[kCIAttributeSliderMin] as? Float
           let maximum = attribute[kCIAttributeSliderMax] as? Float
           let defaultValue = attribute[kCIAttributeDefault] as? Float
            
            print(minimum)
            print(maximum)
            print(defaultValue)
            
        }
        print("inputRadius")
        if let attribute = CIFilter.pageCurlTransition().attributes["inputRadius"] as? [String: AnyObject]
        {
           let minimum = attribute[kCIAttributeSliderMin] as? Float
           let maximum = attribute[kCIAttributeSliderMax] as? Float
           let defaultValue = attribute[kCIAttributeDefault] as? Float
            
            print(minimum)
            print(maximum)
            print(defaultValue)
            
        }
         */
    }

    enum CodingKeys : String, CodingKey {
        
        case inputBacksideImageAlias
        case inputShadingImageAlias
        
        case x
        case y
        case extentWidth
        case extentHeight
        
        case angle
        case radius
    }

    required init(from decoder: Decoder) throws {
        try super.init(from: decoder)
        let values = try decoder.container(keyedBy: CodingKeys.self)
        desc=description

        
        inputBacksideImageAlias = try values.decodeIfPresent(String.self, forKey: .inputBacksideImageAlias) ?? ""
        inputShadingImageAlias = try values.decodeIfPresent(String.self, forKey: .inputShadingImageAlias) ?? ""
        
        x = try values.decodeIfPresent(Float.self, forKey: .x) ?? 0
        y = try values.decodeIfPresent(Float.self, forKey: .y) ?? 0
        extentWidth = try values.decodeIfPresent(Float.self, forKey: .extentWidth) ?? 0
        extentHeight = try values.decodeIfPresent(Float.self, forKey: .extentHeight) ?? 0
        
        angle = try values.decodeIfPresent(Float.self, forKey: .angle) ?? 0.0
        radius = try values.decodeIfPresent(Float.self, forKey: .radius) ?? 0.0

    }
    
    override func encode(to encoder: Encoder) throws {
        try super.encode(to: encoder)
  
        var container = encoder.container(keyedBy: CodingKeys.self)

        try container.encode(inputBacksideImageAlias, forKey: .inputBacksideImageAlias)
        try container.encode(inputShadingImageAlias, forKey: .inputShadingImageAlias)
        
        try container.encode(x, forKey: .x)
        try container.encode(y, forKey: .y)
        try container.encode(extentWidth, forKey: .extentWidth)
        try container.encode(extentHeight, forKey: .extentHeight)
        
        try container.encode(angle, forKey: .angle)
        try container.encode(radius, forKey: .radius)

    }
    
    
    override func setupProperties(_ parent: FiltersX?)
    {
        super.setupProperties(parent)
        
        if parent != nil{
            x=0
            y=0
            
            extentWidth=Float(size.width)
            extentHeight=Float(size.height)

        }
        
    }
    
    override func adjustPropertiesToBounds(_ parent: FiltersX?)
    {
        super.adjustPropertiesToBounds(parent)
        
        x = x > Float(size.width) ? Float(size.width) : x
        y = y > Float(size.height) ? Float(size.height) : y
        
        extentWidth = extentWidth > Float(size.width) ? Float(size.width) : extentWidth
        extentHeight = extentHeight > Float(size.height) ? Float(size.height) : extentHeight
        
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
        
        let backSideImage=handleAlias(alias: inputBacksideImageAlias,
                                      inputImage: currentImage,
                                      beginImage: beginImage)
        
        let shadingImage=handleAlias(alias: inputShadingImageAlias,
                                      inputImage: currentImage,
                                      beginImage: beginImage)
        
        currentCIFilter.setValue(inputImage, forKey: kCIInputImageKey)
        currentCIFilter.setValue(targetImage, forKey: kCIInputTargetImageKey)
        currentCIFilter.setValue(backSideImage, forKey: "inputBacksideImage")
        currentCIFilter.setValue(shadingImage, forKey: "inputShadingImage")
        
        let extent = CIVector(cgRect: CGRect(x: CGFloat(x), y: CGFloat(y), width: CGFloat(extentWidth), height: CGFloat(extentHeight)))
        currentCIFilter.setValue(extent, forKey: "inputExtent")
        
        currentCIFilter.setValue(time, forKey: kCIInputTimeKey)
        currentCIFilter.setValue(angle, forKey: kCIInputAngleKey)
        currentCIFilter.setValue(radius, forKey: kCIInputRadiusKey)

        return currentCIFilter
        
    }
    //ANCHISES
    func getCIFilter(firstImage: CIImage, secondImage: CIImage, thirdImage: CIImage, fourthImage: CIImage) -> CIFilter? {
        var currentCIFilter: CIFilter
        if ciFilter != nil {
            currentCIFilter = ciFilter!
        } else {
            currentCIFilter = CIFilter(name: type)!
            ciFilter=currentCIFilter
        }
        
        currentCIFilter.setValue(firstImage, forKey: kCIInputImageKey)
        currentCIFilter.setValue(secondImage, forKey: kCIInputTargetImageKey)
        currentCIFilter.setValue(thirdImage, forKey: "inputBacksideImage")
        currentCIFilter.setValue(fourthImage, forKey: "inputShadingImage")
        
        let extent = CIVector(cgRect: CGRect(x: CGFloat(x), y: CGFloat(y), width: CGFloat(extentWidth), height: CGFloat(extentHeight)))
        currentCIFilter.setValue(extent, forKey: "inputExtent")
        
        currentCIFilter.setValue(time, forKey: kCIInputTimeKey)
        currentCIFilter.setValue(angle, forKey: kCIInputAngleKey)
        currentCIFilter.setValue(radius, forKey: kCIInputRadiusKey)

        return currentCIFilter
    }
    
    override func getDisplayNameFX() -> String
    {

        var fxStr = ""
        let previousStr="" + String(nodeIndex-1)
        
        var inputAAliasStr = previousStr
        var inputBAliasStr = previousStr
        var inputCAliasStr = previousStr
        var inputDAliasStr = previousStr

        inputAAliasStr = inputAAlias == "" ? previousStr : "\""+inputAAlias+"\""
        inputBAliasStr = inputBAlias == "" ? previousStr : "\""+inputBAlias+"\""
        inputCAliasStr = inputCAlias == "" ? previousStr : "\""+inputCAlias+"\""
        inputDAliasStr = inputDAlias == "" ? previousStr : "\""+inputDAlias+"\""
        fxStr = "A - " + inputAAliasStr + ", B - " + inputBAliasStr + ", C - " + inputCAliasStr + ", D - " + inputDAliasStr
        
        return fxStr
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
            
        var inputImageAliasStr = previousStr
        if inputImageAlias != ""{
            inputImageAliasStr = "\""+inputImageAlias+"\""
        }
        
        var targetImageAliasStr = previousStr
        if targetImageAlias != ""{
            targetImageAliasStr = "\""+targetImageAlias+"\""
        }
        
        var inputBacksideImageAliasStr = previousStr
        if inputBacksideImageAlias != ""{
            inputBacksideImageAliasStr = "\""+inputBacksideImageAlias+"\""
        }
        
        var inputShadingImageAliasStr = previousStr
        if inputShadingImageAlias != ""{
            inputShadingImageAliasStr = "\""+inputShadingImageAlias+"\""
        }
        
        fxStr = "input - " + inputImageAliasStr + ", target - " + targetImageAliasStr + ", backside - " + inputBacksideImageAliasStr + ", shading - " + inputShadingImageAliasStr

        return fxStr
   
    }
     */
    override func doExecute() async {
        
        //if videoStatus == "Completed" {
        //    return
        //}
        
        //print("base blend mask doexecute")
        let urlA = inputA!.assetURL1
        let urlB = inputB!.assetURL1
        let urlC = inputC!.assetURL1
        let urlD = inputD!.assetURL1

        let firstAsset = AVURLAsset(url: urlA)
        let secondAsset = AVURLAsset(url: urlB)
        let thirdAsset = AVURLAsset(url: urlC)
        let fourthAsset = AVURLAsset(url: urlD)

        do{
            let duration1 = try await firstAsset.load(.duration)
            let duration2 = try await secondAsset.load(.duration)
            let duration3 = try await thirdAsset.load(.duration)
            let duration4 = try await fourthAsset.load(.duration)
            var duration = duration1 > duration2 ? duration2 : duration1
            duration = duration3 > duration ? duration : duration3
            duration = duration4 > duration ? duration : duration4
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
            //let size2 = try await secondSourceTracks[0].load(.naturalSize)
            //let secondNominalFrameRate = try await secondSourceTracks[0].load(.nominalFrameRate)

            let thirdTrack = composition.addMutableTrack(withMediaType: .video,
                        preferredTrackID: kCMPersistentTrackID_Invalid)
            let timerange3 = CMTimeRange(start: .zero, duration: duration)
            let thirdSourceTracks = try await thirdAsset.loadTracks(withMediaType: .video)
            try thirdTrack!.insertTimeRange(timerange3, of:thirdSourceTracks[0],at: .zero)
            let preferredTransform3 = try await thirdSourceTracks[0].load(.preferredTransform)
            thirdTrack?.preferredTransform = preferredTransform3
            //let size3 = try await thirdSourceTracks[0].load(.naturalSize)
            //let thirdNominalFrameRate = try await thirdSourceTracks[0].load(.nominalFrameRate)
            
            let fourthTrack = composition.addMutableTrack(withMediaType: .video,
                        preferredTrackID: kCMPersistentTrackID_Invalid)
            let timerange4 = CMTimeRange(start: .zero, duration: duration)
            let fourthSourceTracks = try await fourthAsset.loadTracks(withMediaType: .video)
            try fourthTrack!.insertTimeRange(timerange4, of:fourthSourceTracks[0],at: .zero)
            let preferredTransform4 = try await fourthSourceTracks[0].load(.preferredTransform)
            fourthTrack?.preferredTransform = preferredTransform3
            //let size4 = try await fourthSourceTracks[0].load(.naturalSize)
            //let fourthNominalFrameRate = try await fourthSourceTracks[0].load(.nominalFrameRate)
            
            let instruction = CustomNodeVideo4WayInstruction(
                timerange: CMTimeRange(start: .zero, duration: duration1),
                node: self,
                preferredTransform1: preferredTransform1,
                preferredTransform2: preferredTransform2,
                preferredTransform3: preferredTransform3,
                preferredTransform4: preferredTransform4)
            
            videoComposition.customVideoCompositorClass = CustomNodeVideo4WayCompositor.self
            
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
        if inputD != nil {
            if inputD?.videoStatus == "Completed" {
                
            } else if inputD?.videoStatus != "Completed" {
                await inputD?.executeBackwards()
            }
        }
        
        await doExecute()

    }
    
    override func executeImageBackwards() async -> CIImage? {
        print("Page Curl Image Nodes",self,inputA!, inputB!)
             
        if inputA != nil && inputB != nil {
            frameA = await inputA!.executeImageBackwards()
            frameB = await inputB!.executeImageBackwards()
            frameC = await inputC!.executeImageBackwards()
            frameD = await inputD!.executeImageBackwards()

        }
        
        return getCIFilter(firstImage: frameA!,secondImage: frameB!,thirdImage: frameC!,fourthImage: frameD!)!.outputImage
    }
}
