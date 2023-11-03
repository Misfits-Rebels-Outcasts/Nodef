//
//  Copyright © 2022 James Boo. All rights reserved.
//
import SwiftUI
import Foundation
import AVFoundation
import VideoToolbox



class CustomNodeVideo4WayInstruction: NSObject ,  AVVideoCompositionInstructionProtocol{
    var timeRange: CMTimeRange
    var enablePostProcessing: Bool = true
    var containsTweening: Bool = false
    var requiredSourceTrackIDs: [NSValue]?
    var passthroughTrackID: CMPersistentTrackID = kCMPersistentTrackID_Invalid
    var preferredTransform1: CGAffineTransform
    var preferredTransform2: CGAffineTransform
    var preferredTransform3: CGAffineTransform
    var preferredTransform4: CGAffineTransform

    var node: FilterX?
    init(timerange:CMTimeRange,
         node: FilterX,
         preferredTransform1: CGAffineTransform,
         preferredTransform2: CGAffineTransform,
         preferredTransform3: CGAffineTransform,
         preferredTransform4: CGAffineTransform){
        
        let temp = timerange
        
        self.timeRange = temp
        self.node = node
        self.preferredTransform1 = preferredTransform1
        self.preferredTransform2 = preferredTransform2
        self.preferredTransform3 = preferredTransform3
        self.preferredTransform4 = preferredTransform4
    }

}

class CustomNodeVideo4WayCompositor: NSObject , AVVideoCompositing{
    
    private var renderContext : AVVideoCompositionRenderContext?
    
    var sourcePixelBufferAttributes: [String : Any]?{
        get {
            return ["\(kCVPixelBufferPixelFormatTypeKey)": kCVPixelFormatType_32BGRA]
        }
    }
    
    var requiredPixelBufferAttributesForRenderContext: [String : Any]{
        get {
            return ["\(kCVPixelBufferPixelFormatTypeKey)": kCVPixelFormatType_32BGRA]
        }
    }
    func renderContextChanged(_ newRenderContext: AVVideoCompositionRenderContext){
         renderContext = newRenderContext
    }
    
    var counter=1
     func startRequest(_ request: AVAsynchronousVideoCompositionRequest) {
         
         let destinationFrame = request.renderContext.newPixelBuffer()
        if(request.sourceTrackIDs.count == 4){
            var firstFrame: CVPixelBuffer?
            var secondFrame: CVPixelBuffer?
            var thirdFrame: CVPixelBuffer?
            var fourthFrame: CVPixelBuffer?
            //ANCHISES-comeback and improve
            if request.sourceTrackIDs[0].int32Value == 1 {
                firstFrame = request.sourceFrame(byTrackID: request.sourceTrackIDs[0].int32Value)
            }
            else if request.sourceTrackIDs[0].int32Value == 2 {
                secondFrame = request.sourceFrame(byTrackID: request.sourceTrackIDs[0].int32Value)
            }
            else if request.sourceTrackIDs[0].int32Value == 3 {
                thirdFrame = request.sourceFrame(byTrackID: request.sourceTrackIDs[0].int32Value)
            }
            else if request.sourceTrackIDs[0].int32Value == 4 {
                fourthFrame = request.sourceFrame(byTrackID: request.sourceTrackIDs[0].int32Value)
            }

            if request.sourceTrackIDs[1].int32Value == 1 {
                firstFrame = request.sourceFrame(byTrackID: request.sourceTrackIDs[1].int32Value)
            }
            else if request.sourceTrackIDs[1].int32Value == 2 {
                secondFrame = request.sourceFrame(byTrackID: request.sourceTrackIDs[1].int32Value)
            }
            else if request.sourceTrackIDs[1].int32Value == 3 {
                thirdFrame = request.sourceFrame(byTrackID: request.sourceTrackIDs[1].int32Value)
            }
            else if request.sourceTrackIDs[1].int32Value == 4 {
                fourthFrame = request.sourceFrame(byTrackID: request.sourceTrackIDs[1].int32Value)
            }

            if request.sourceTrackIDs[2].int32Value == 1 {
                firstFrame = request.sourceFrame(byTrackID: request.sourceTrackIDs[2].int32Value)
            }
            else if request.sourceTrackIDs[2].int32Value == 2 {
                secondFrame = request.sourceFrame(byTrackID: request.sourceTrackIDs[2].int32Value)
            }
            else if request.sourceTrackIDs[2].int32Value == 3 {
                thirdFrame = request.sourceFrame(byTrackID: request.sourceTrackIDs[2].int32Value)
            }
            else if request.sourceTrackIDs[2].int32Value == 4 {
                fourthFrame = request.sourceFrame(byTrackID: request.sourceTrackIDs[2].int32Value)
            }
            
            if request.sourceTrackIDs[3].int32Value == 1 {
                firstFrame = request.sourceFrame(byTrackID: request.sourceTrackIDs[3].int32Value)
            }
            else if request.sourceTrackIDs[3].int32Value == 2 {
                secondFrame = request.sourceFrame(byTrackID: request.sourceTrackIDs[3].int32Value)
            }
            else if request.sourceTrackIDs[3].int32Value == 3 {
                thirdFrame = request.sourceFrame(byTrackID: request.sourceTrackIDs[3].int32Value)
            }
            else if request.sourceTrackIDs[3].int32Value == 4 {
                fourthFrame = request.sourceFrame(byTrackID: request.sourceTrackIDs[3].int32Value)
            }

            
            let instruction = request.videoCompositionInstruction
            if let inst = instruction as? CustomNodeVideo4WayInstruction {
                
                processInstruction(destinationFrame, firstFrame, secondFrame, thirdFrame, fourthFrame, request, inst)
            }
            else{
       
            }
         }
    }
    
    func processInstruction(_ destinationFrame: CVPixelBuffer?, _ firstFrame: CVPixelBuffer?, _ secondFrame: CVPixelBuffer?, _ thirdFrame: CVPixelBuffer?, _ fourthFrame: CVPixelBuffer?,_ request: AVAsynchronousVideoCompositionRequest, _ nodeInst: CustomNodeVideo4WayInstruction) {
        CVPixelBufferLockBaseAddress(firstFrame! , .readOnly)
        CVPixelBufferLockBaseAddress(secondFrame!, .readOnly)
        CVPixelBufferLockBaseAddress(thirdFrame!, .readOnly)
        CVPixelBufferLockBaseAddress(fourthFrame!, .readOnly)
        CVPixelBufferLockBaseAddress(destinationFrame!, CVPixelBufferLockFlags(rawValue: 0))
        
        var firstciImg = createSourceCIXImage(from: firstFrame)
        var secondciImg = createSourceCIXImage(from: secondFrame)
        var thirdciImg = createSourceCIXImage(from: thirdFrame)
        var fourthciImg = createSourceCIXImage(from: fourthFrame)

        let destWidth = CVPixelBufferGetWidth(destinationFrame!)
        let destHeight = CVPixelBufferGetHeight(destinationFrame!)
        
        var assetOrientation = CGImagePropertyOrientation.up
        switch [nodeInst.preferredTransform1.a, nodeInst.preferredTransform1.b, nodeInst.preferredTransform1.c, nodeInst.preferredTransform1.d] {
              case [0.0, 1.0, -1.0, 0.0]:
                  assetOrientation = .right
                  //isPortrait = true
                  
              case [0.0, -1.0, 1.0, 0.0]:
                  assetOrientation = .left
                  //isPortrait = true
                  
              case [1.0, 0.0, 0.0, 1.0]:
                  assetOrientation = .up
                  
              case [-1.0, 0.0, 0.0, -1.0]:
                  assetOrientation = .down

              default:
                  break
              }
        
        firstciImg=firstciImg?.transformed(by: (firstciImg?.orientationTransform(for: assetOrientation))!)
        
        switch [nodeInst.preferredTransform2.a, nodeInst.preferredTransform2.b, nodeInst.preferredTransform2.c, nodeInst.preferredTransform2.d] {
              case [0.0, 1.0, -1.0, 0.0]:
                  assetOrientation = .right
                  //isPortrait = true
                  
              case [0.0, -1.0, 1.0, 0.0]:
                  assetOrientation = .left
                  //isPortrait = true
                  
              case [1.0, 0.0, 0.0, 1.0]:
                  assetOrientation = .up
                  
              case [-1.0, 0.0, 0.0, -1.0]:
                  assetOrientation = .down

              default:
                  break
              }
        
        secondciImg=secondciImg?.transformed(by: (secondciImg?.orientationTransform(for: assetOrientation))!)

        switch [nodeInst.preferredTransform3.a, nodeInst.preferredTransform3.b, nodeInst.preferredTransform3.c, nodeInst.preferredTransform3.d] {
              case [0.0, 1.0, -1.0, 0.0]:
                  assetOrientation = .right
                  //isPortrait = true
                  
              case [0.0, -1.0, 1.0, 0.0]:
                  assetOrientation = .left
                  //isPortrait = true
                  
              case [1.0, 0.0, 0.0, 1.0]:
                  assetOrientation = .up
                  
              case [-1.0, 0.0, 0.0, -1.0]:
                  assetOrientation = .down

              default:
                  break
              }
        
        thirdciImg=thirdciImg?.transformed(by: (thirdciImg?.orientationTransform(for: assetOrientation))!)

        
        switch [nodeInst.preferredTransform4.a, nodeInst.preferredTransform4.b, nodeInst.preferredTransform4.c, nodeInst.preferredTransform4.d] {
              case [0.0, 1.0, -1.0, 0.0]:
                  assetOrientation = .right
                  //isPortrait = true
                  
              case [0.0, -1.0, 1.0, 0.0]:
                  assetOrientation = .left
                  //isPortrait = true
                  
              case [1.0, 0.0, 0.0, 1.0]:
                  assetOrientation = .up
                  
              case [-1.0, 0.0, 0.0, -1.0]:
                  assetOrientation = .down

              default:
                  break
              }
        
        fourthciImg=fourthciImg?.transformed(by: (fourthciImg?.orientationTransform(for: assetOrientation))!)
        
        counter=counter+1
        

        _ = CGRect(x: 0, y: 0, width: destWidth , height: destHeight)
        _ = CGRect(x: 0, y: 0, width: destWidth , height: destHeight)
        
        let outputNodeCI = (nodeInst.node as! PageCurlTransitionFX).getCIFilter(firstImage: firstciImg!,secondImage: secondciImg!,thirdImage: thirdciImg!,fourthImage: fourthciImg!)!
        
        let context = nodeInst.node?.parent?.getContext()
        context!.render(outputNodeCI.outputImage!, to:destinationFrame!)
         
        CVPixelBufferUnlockBaseAddress(destinationFrame!, CVPixelBufferLockFlags(rawValue: 0))
        CVPixelBufferUnlockBaseAddress(firstFrame!, .readOnly)
        CVPixelBufferUnlockBaseAddress(secondFrame!, .readOnly)
        CVPixelBufferUnlockBaseAddress(thirdFrame!, .readOnly)
        CVPixelBufferUnlockBaseAddress(fourthFrame!, .readOnly)

        request.finish(withComposedVideoFrame: destinationFrame!)

    }

    func createSourceCIXImage(from buffer: CVPixelBuffer?) -> CIImage? {
        var cimage : CIImage?
        
        cimage=CIImage(cvPixelBuffer: buffer!)

        return cimage
    }
    
    func correctImageOrientation(cgImage: CGImage?, orienation: UIImage.Orientation) -> CGImage? {
        guard let cgImage = cgImage else { return nil }
        var orientedImage: CGImage?

        let originalWidth = cgImage.width
        let originalHeight = cgImage.height
        let bitsPerComponent = cgImage.bitsPerComponent
        let bytesPerRow = cgImage.bytesPerRow
        let bitmapInfo = cgImage.bitmapInfo

        guard let colorSpace = cgImage.colorSpace else { return nil }

        let degreesToRotate = 90.0
        //let mirrored = false
        
        var width = originalWidth
        var height = originalHeight

        let radians = degreesToRotate * Double.pi / 180.0
        let swapWidthHeight = Int(degreesToRotate / 90) % 2 != 0

        if swapWidthHeight {
            swap(&width, &height)
        }

        let context = CGContext(data: nil, width: width, height: height, bitsPerComponent: bitsPerComponent, bytesPerRow: bytesPerRow, space: colorSpace, bitmapInfo: bitmapInfo.rawValue)

        context?.translateBy(x: CGFloat(width) / 2.0, y: CGFloat(height) / 2.0)
        //if mirrored {
        //    context?.scaleBy(x: -1.0, y: 1.0)
        //}
        context?.rotate(by: CGFloat(radians))
        if swapWidthHeight {
            swap(&width, &height)
        }
        context?.translateBy(x: -CGFloat(width) / 2.0, y: -CGFloat(height) / 2.0)

        context?.draw(cgImage, in: CGRect(x: 0.0, y: 0.0, width: CGFloat(originalWidth), height: CGFloat(originalHeight)))
        orientedImage = context?.makeImage()

        return orientedImage
    }
     
}
