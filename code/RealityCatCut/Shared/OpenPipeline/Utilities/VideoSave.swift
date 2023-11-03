//
//  Copyright © 2023 James Boo. All rights reserved.
//


import Foundation
import AVFoundation
import UIKit
import Photos
import SwiftUI

func build(outputSize: CGSize, pageSettings: PageSettings, optionSettings: OptionSettings, duration : Double, framerate : Int32) {
      let fileManager = FileManager.default
    let urls = fileManager.urls(for: .cachesDirectory, in: .userDomainMask)
    guard let documentDirectory = urls.first else {
        print("documentDir Error")
        return
    }
    
    let number = arc4random()
    

    let videoOutputURL = documentDirectory.appendingPathComponent("OutputVideo_"+String(number)+".mp4")

    if FileManager.default.fileExists(atPath: videoOutputURL.path) {
        do {
            try FileManager.default.removeItem(atPath: videoOutputURL.path)
        } catch {
            print("Unable to delete file: \(error) : \(#function).")
        }
    }

    guard let videoWriter = try? AVAssetWriter(outputURL: videoOutputURL, fileType: AVFileType.mp4) else {
        print("AVAssetWriter error")
        return
    }

    DispatchQueue.global(qos: .userInitiated).async {
        
        
        let outputSettings = [AVVideoCodecKey : AVVideoCodecType.h264, AVVideoWidthKey : NSNumber(value: Float(outputSize.width)), AVVideoHeightKey : NSNumber(value: Float(outputSize.height))] as [String : Any]

        guard videoWriter.canApply(outputSettings: outputSettings, forMediaType: AVMediaType.video) else {
            print("Negative : Can't apply the Output settings...")
            return
        }

        let videoWriterInput = AVAssetWriterInput(mediaType: AVMediaType.video, outputSettings: outputSettings)
        let sourcePixelBufferAttributesDictionary = [
            kCVPixelBufferPixelFormatTypeKey as String : NSNumber(value: kCVPixelFormatType_32ARGB),
            kCVPixelBufferWidthKey as String: NSNumber(value: Float(outputSize.width)),
            kCVPixelBufferHeightKey as String: NSNumber(value: Float(outputSize.height))
        ]
        let pixelBufferAdaptor = AVAssetWriterInputPixelBufferAdaptor(assetWriterInput: videoWriterInput, sourcePixelBufferAttributes: sourcePixelBufferAttributesDictionary)

        if videoWriter.canAdd(videoWriterInput) {
            videoWriter.add(videoWriterInput)
        }
        
        if videoWriter.startWriting() {
            videoWriter.startSession(atSourceTime: CMTime.zero)
            assert(pixelBufferAdaptor.pixelBufferPool != nil)

            let media_queue = DispatchQueue(__label: "mediaInputQueue", attr: nil)

            videoWriterInput.requestMediaDataWhenReady(on: media_queue, using: { () -> Void in
                let fps: Int32 = framerate
                let frameDuration = CMTimeMake(value: 1, timescale: fps)

                var frameCount: Int64 = 0
                var appendSucceeded = true

                let frameTimeIncr = 1.0/Double(fps)
                var frameTime = 0.0
                let movieDuration = duration
                
                
               // while (!choosenPhotos.isEmpty) {
                while (frameTime<=movieDuration) {
                
                    if (videoWriterInput.isReadyForMoreMediaData) {
                        //let nextPhoto = choosenPhotos.remove(at: 0)
                       
                        //let nextPhoto = parent.GetFrame(inputtime: frameTime)
                        timeElapsedX=frameTime
                        pageSettings.applyFiltersForVideo()
                        let nextPhoto = pageSettings.filteredBackgroundImageForVideo!
                        
                        let lastFrameTime = CMTimeMake(value: frameCount, timescale: fps)
                        let presentationTime = frameCount == 0 ? lastFrameTime : CMTimeAdd(lastFrameTime, frameDuration)

                       
                        var pixelBuffer: CVPixelBuffer? = nil
                        
                       
                       
                        let status: CVReturn = CVPixelBufferPoolCreatePixelBuffer(kCFAllocatorDefault, pixelBufferAdaptor.pixelBufferPool!, &pixelBuffer)

                        if let pixelBuffer = pixelBuffer, status == 0 {
                            let managedPixelBuffer = pixelBuffer

                            
                            //Status String
                            let formatter = NumberFormatter()
                            formatter.maximumFractionDigits = 2
                            //let stringtime = formatter.string(for: frameTime) ?? "?"
                            //parent.videoStateStr = "Saving Frame (Time " + stringtime + " of " + String(movieDuration) + " sec)";
                            ///
                            
                            lockRender(image: nextPhoto,  outputSize: outputSize, managedPixelBuffer: managedPixelBuffer )
                                appendSucceeded = pixelBufferAdaptor.append(pixelBuffer, withPresentationTime: presentationTime)
                            
                          
                        }
                        else {
                            print("Failed to allocate pixel buffer")
                            appendSucceeded = false
                        }
                    }
                    if !appendSucceeded {
                        break
                    }
                    frameCount += 1
                    frameTime += frameTimeIncr
                }
                videoWriterInput.markAsFinished()
                videoWriter.finishWriting { () -> Void in
                    print("FINISHED!!!!!"+videoOutputURL.path)
                    saveVideoToLibrary(videoURL: videoOutputURL)
                    
                    //parent.videoStateStr = "Video Saved ";
                    DispatchQueue.main.async {
                        pageSettings.savingInProgress=false
                        pageSettings.isStopped=true
                        optionSettings.showingAlertMessage=true
                        optionSettings.alertMessage="Video saved successfully."
                    }
                    
                }
               

            })
          
            
        }
    }
   
}

func generate(outputSize: CGSize, pageSettings: PageSettings, optionSettings: OptionSettings, duration : Double, framerate : Int32) {
      let fileManager = FileManager.default
    let urls = fileManager.urls(for: .cachesDirectory, in: .userDomainMask)
    guard let documentDirectory = urls.first else {
        print("documentDir Error")
        return
    }
    
    let number = arc4random()
    

    let videoOutputURL = documentDirectory.appendingPathComponent("OutputVideo_"+String(number)+".mp4")

    if FileManager.default.fileExists(atPath: videoOutputURL.path) {
        do {
            try FileManager.default.removeItem(atPath: videoOutputURL.path)
        } catch {
            print("Unable to delete file: \(error) : \(#function).")
        }
    }

    guard let videoWriter = try? AVAssetWriter(outputURL: videoOutputURL, fileType: AVFileType.mp4) else {
        print("AVAssetWriter error")
        return
    }

    DispatchQueue.global(qos: .userInitiated).async {
        
        
        let outputSettings = [AVVideoCodecKey : AVVideoCodecType.h264, AVVideoWidthKey : NSNumber(value: Float(outputSize.width)), AVVideoHeightKey : NSNumber(value: Float(outputSize.height))] as [String : Any]

        guard videoWriter.canApply(outputSettings: outputSettings, forMediaType: AVMediaType.video) else {
            print("Negative : Can't apply the Output settings...")
            return
        }

        let videoWriterInput = AVAssetWriterInput(mediaType: AVMediaType.video, outputSettings: outputSettings)
        let sourcePixelBufferAttributesDictionary = [
            kCVPixelBufferPixelFormatTypeKey as String : NSNumber(value: kCVPixelFormatType_32ARGB),
            kCVPixelBufferWidthKey as String: NSNumber(value: Float(outputSize.width)),
            kCVPixelBufferHeightKey as String: NSNumber(value: Float(outputSize.height))
        ]
        let pixelBufferAdaptor = AVAssetWriterInputPixelBufferAdaptor(assetWriterInput: videoWriterInput, sourcePixelBufferAttributes: sourcePixelBufferAttributesDictionary)

        if videoWriter.canAdd(videoWriterInput) {
            videoWriter.add(videoWriterInput)
        }
        
        if videoWriter.startWriting() {
            videoWriter.startSession(atSourceTime: CMTime.zero)
            assert(pixelBufferAdaptor.pixelBufferPool != nil)

            let media_queue = DispatchQueue(__label: "mediaInputQueue", attr: nil)

            videoWriterInput.requestMediaDataWhenReady(on: media_queue, using: { () -> Void in
                let fps: Int32 = framerate
                let frameDuration = CMTimeMake(value: 1, timescale: fps)

                var frameCount: Int64 = 0
                var appendSucceeded = true

                let frameTimeIncr = 1.0/Double(fps)
                var frameTime = 0.0
                let movieDuration = duration
                
                pageSettings.filters.videoGeneration = true
              
                while (frameTime<=movieDuration) {
                
                    if (videoWriterInput.isReadyForMoreMediaData) {
                      timeElapsedX=frameTime
                        pageSettings.applyFiltersForVideo()
                        let nextPhoto = pageSettings.filteredBackgroundImageForVideo!
                        
                        let lastFrameTime = CMTimeMake(value: frameCount, timescale: fps)
                        let presentationTime = frameCount == 0 ? lastFrameTime : CMTimeAdd(lastFrameTime, frameDuration)

                       
                        var pixelBuffer: CVPixelBuffer? = nil
                        
                       
                       
                        let status: CVReturn = CVPixelBufferPoolCreatePixelBuffer(kCFAllocatorDefault, pixelBufferAdaptor.pixelBufferPool!, &pixelBuffer)

                        if let pixelBuffer = pixelBuffer, status == 0 {
                            let managedPixelBuffer = pixelBuffer

                            
                            //Status String
                            let formatter = NumberFormatter()
                            formatter.maximumFractionDigits = 2
                            //let stringtime = formatter.string(for: frameTime) ?? "?"
                            //parent.videoStateStr = "Saving Frame (Time " + stringtime + " of " + String(movieDuration) + " sec)";
                            ///
                            
                            lockRender(image: nextPhoto,  outputSize: outputSize, managedPixelBuffer: managedPixelBuffer )
                                appendSucceeded = pixelBufferAdaptor.append(pixelBuffer, withPresentationTime: presentationTime)
                            
                          
                        }
                        else {
                            print("Failed to allocate pixel buffer")
                            appendSucceeded = false
                        }
                    }
                    if !appendSucceeded {
                        break
                    }
                    frameCount += 1
                    frameTime += frameTimeIncr
                }
                videoWriterInput.markAsFinished()
                videoWriter.finishWriting { () -> Void in
                    print("FINISHED!!!!!"+videoOutputURL.path)
                    //saveVideoToLibrary(videoURL: videoOutputURL)
                    
                    //parent.videoStateStr = "Video Saved ";
                    pageSettings.filters.generatedVideoURL=videoOutputURL
                    
                    DispatchQueue.main.async {
                        pageSettings.applyFilters()
                        pageSettings.savingInProgress=false
                        //pageSettings.isStopped=true
                        //optionSettings.showingAlertMessage=true
                        //optionSettings.alertMessage="Video generated successfully."
                    }
                    
                }
                pageSettings.filters.videoGeneration = false
                

            })
          
            
        }
    }
   
}

func saveVideoToLibrary(videoURL: URL) {

    
    
    PHPhotoLibrary.shared().performChanges({
        PHAssetChangeRequest.creationRequestForAssetFromVideo(atFileURL: videoURL)
    }) { saved, error in

        if let error = error {
            print("Error saving video to librayr: \(error.localizedDescription)")
        }
        if saved {
            print("Video save to library")

        }
    }
}

func lockRender(image: UIImage,  outputSize: CGSize, managedPixelBuffer :CVPixelBuffer)  {
    
        
        CVPixelBufferLockBaseAddress(managedPixelBuffer, [])

        let data = CVPixelBufferGetBaseAddress(managedPixelBuffer)
        let rgbColorSpace = CGColorSpaceCreateDeviceRGB()
        let context = CGContext(data: data, width: Int(outputSize.width), height: Int(outputSize.height), bitsPerComponent: 8, bytesPerRow: CVPixelBufferGetBytesPerRow(managedPixelBuffer), space: rgbColorSpace, bitmapInfo: CGImageAlphaInfo.premultipliedFirst.rawValue)
    
        context?.clear(CGRect(x: 0, y: 0, width: outputSize.width, height: outputSize.height))

        let horizontalRatio = CGFloat(outputSize.width) / image.size.width
        let verticalRatio = CGFloat(outputSize.height) / image.size.height

        let aspectRatio = min(horizontalRatio, verticalRatio) // ScaleAspectFit

        let newSize = CGSize(width: image.size.width * aspectRatio, height: image.size.height * aspectRatio)

        let x = newSize.width < outputSize.width ? (outputSize.width - newSize.width) / 2 : 0
        let y = newSize.height < outputSize.height ? (outputSize.height - newSize.height) / 2 : 0

        context?.draw(image.cgImage!, in: CGRect(x: x, y: y, width: newSize.width, height: newSize.height))

        CVPixelBufferUnlockBaseAddress(managedPixelBuffer, [])

       //return managedPixelBuffer
        
        
    }

