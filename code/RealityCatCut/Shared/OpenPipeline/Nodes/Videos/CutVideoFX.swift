//
//  Copyright © 2022-2023 James Boo. All rights reserved.
//

import SwiftUI
import AVFoundation

//ANCHISES
//-assetURL1 is cut
//-assetURL2 is uncut
class CutVideoFX: FilterX {
    
    let description = "Trim or cut a video base with start and stop time."
    var creation=false //control the init of st and et to only create. other times just respect what is set with respect to crash. aka it will internally reset to the smaller value quielty.

    var updateTimeline=false
    //used for offing Timeline when coming back from CutVideo Set Input A
    
    override init() {
        let name="CICutVideo"
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
    //ANCHISES
    override func executeBackwards() async {
        
        if inputA != nil {
            if inputA?.videoStatus == "Completed" {

            } else if inputA?.videoStatus != "Completed" {
                await inputA?.executeBackwards()

            }
        }
        
        await doExecute()

    }
    

    
    override func doExecute() async {
        
        if videoStatus == "Completed" {
            return
        }
        
        let urlA = inputA!.assetURL1
        let firstAsset = AVURLAsset(url: urlA)
        assetURL2 = urlA
        
        do {
            
            let videoAssetTrack = try await firstAsset.loadTracks(withMediaType: .video).first
            timeScale = try await videoAssetTrack!.load(.naturalTimeScale)
            
            await saveVideoToDocCacheWithStartEnd(asset: firstAsset)
            print("Cut Video Completed")
        }catch{
            print("Error in Cut Video Save")
            print("Error in Cut Video Save")
            print("Error in Cut Video Save")
        }
        
    }
    
    
    func saveVideoToDocCacheWithStartEnd(asset: AVAsset) async {
        videoStatus="Saving"

      
            guard let exporter = AVAssetExportSession(asset: asset, presetName: AVAssetExportPresetHighestQuality) else {
                //completion(nil, nil)
                return //AVAssetExportSession.Status.failed
            }
            
            guard let documentDirectory = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first else {
                    videoStatus="Error"
                return //AVAssetExportSession.Status.failed
              }
            
            let outputURL = documentDirectory.appendingPathComponent(id.uuidString+".mp4")

            let startTime = CMTime(seconds: Double(startTime), preferredTimescale: timeScale)
            let endTime = CMTime(seconds: Double(endTime ), preferredTimescale: timeScale)
            let timeRange = CMTimeRange(start: startTime, end: endTime)
            print("Cut Video", timeRange, timeScale)
            exporter.timeRange = timeRange
            exporter.outputURL = outputURL
            exporter.outputFileType = .mp4
           
            do {
                let status = try await executeSession(exporter)
                print(status)
                if status == AVAssetExportSession.Status.completed {
                    print("AVAssetExportSession completed - Cut Video",outputURL)
                    self.videoStatus="Completed"
                    assetURL1=outputURL
                }
            }
            catch {
                print("Cut Error in AVExportSession")
            }

  
    }

    override func executeImageBackwards() async -> CIImage? {
    
        if inputA != nil {
            frameA = await inputA!.executeImageBackwards()
 
        }
        /*
        if inputA != nil {
            
            if inputA?.videoStatus=="Completed" {
                do {
                    frameA = try await imageFromVideo(url: assetURL1, at: 0)
                    //frameA = try await imageFromVideo(url: assetURL1, at: TimeInterval(startTime))

                } catch {
                    print(error)
                }
                
            } else {
                frameA = await inputA!.executeImageBackwards()
            }
            
        }
        */
        //ensure getCIFilter is available even for video nodes
        _ = getCIFilter(frameA!)
        return frameA
    }
    
    override func runThrough(previousNode: FilterX?) -> FilterX? {

        self.previousNode=previousNode
        inputA = handleNodeAlias(alias: inputAAlias, previousNode: previousNode)
        if inputA != nil {
            duration = inputA!.duration
            preferredTransform = inputA!.preferredTransform
            naturalSize = inputA!.naturalSize
            size = inputA!.size
            timeScale = inputA!.timeScale
            nominalFrameRate = inputA!.nominalFrameRate
            self.videoStatus=inputA!.videoStatus //this is the line causing the issue
            self.assetURL1=inputA!.assetURL1
            self.assetURL2=inputA!.assetURL1
            
            if self.creation == true {
                self.startTime=0.0
                self.endTime=Float(duration.seconds)
                sourceId=getSourceId()
                self.creation=false
            } else {
                if self.SourceChanged() {
                    print("source changed")
                    self.startTime=0.0
                    self.endTime=Float(duration.seconds)
                }
                else {
                    print("source not changed")
                    //keep time
                }
                //will keep quiet even when invalid range
                //during doExecute it will then set it to the full duration.
        
            }
        }
        
        return self
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
     
    

}


