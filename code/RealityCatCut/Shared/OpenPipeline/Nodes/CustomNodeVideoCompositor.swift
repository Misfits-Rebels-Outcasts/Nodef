//
//  Copyright © 2022 James Boo. All rights reserved.
//
import SwiftUI
import Foundation
import AVFoundation
import VideoToolbox



class CustomNodeVideoInstruction: NSObject ,  AVVideoCompositionInstructionProtocol{
    var timeRange: CMTimeRange
    var enablePostProcessing: Bool = true
    var containsTweening: Bool = false
    var requiredSourceTrackIDs: [NSValue]?
    var passthroughTrackID: CMPersistentTrackID = kCMPersistentTrackID_Invalid
    var rotateSecondAsset: Bool?
    var preferredTransform1: CGAffineTransform
    var preferredTransform2: CGAffineTransform

    var node: FilterX?
    init(timerange:CMTimeRange , rotateSecondAsset: Bool, node: FilterX, preferredTransform1: CGAffineTransform, preferredTransform2: CGAffineTransform){
        let temp = timerange
        
        self.timeRange = temp
        self.rotateSecondAsset = rotateSecondAsset
        self.node = node
        self.preferredTransform1 = preferredTransform1
        self.preferredTransform2 = preferredTransform2
    }

}

class CustomNodeVideoCompositor: NSObject , AVVideoCompositing{
    
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
        if(request.sourceTrackIDs.count == 2){
            
            //print("retrieve",request.sourceTrackIDs[0].int32Value)
            let firstFrame = request.sourceFrame(byTrackID: request.sourceTrackIDs[0].int32Value)
            //print("firstFrame",request.sourceTrackIDs[0].int32Value)
            let secondFrame = request.sourceFrame(byTrackID: request.sourceTrackIDs[1].int32Value)
            //print("secondFrame",request.sourceTrackIDs[1].int32Value)

            let instruction = request.videoCompositionInstruction
            if let inst = instruction as? CustomNodeVideoInstruction , let _ = inst.rotateSecondAsset {
                
                processInstruction(destinationFrame, firstFrame, secondFrame, request, inst)
            }
            else{
       
            }
         }
    }
    
    func processInstruction(_ destinationFrame: CVPixelBuffer?, _ firstFrame: CVPixelBuffer?, _ secondFrame: CVPixelBuffer?,_ request: AVAsynchronousVideoCompositionRequest, _ nodeInst: CustomNodeVideoInstruction) {
        CVPixelBufferLockBaseAddress(firstFrame! , .readOnly)
        CVPixelBufferLockBaseAddress(secondFrame!, .readOnly)
        CVPixelBufferLockBaseAddress(destinationFrame!, CVPixelBufferLockFlags(rawValue: 0))
        
        var firstciImg = createSourceCIXImage(from: firstFrame)
        var secondciImg = createSourceCIXImage(from: secondFrame)
     
        let destWidth = CVPixelBufferGetWidth(destinationFrame!)
        let destHeight = CVPixelBufferGetHeight(destinationFrame!)

        //need to check and then set the transform
        //https://stackoverflow.com/questions/71447131/swift-avmutablevideocompositionlayerinstruction-misalignment-when-merging-video
        
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
        
        //print("assetOrient",assetOrientation)
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
        
 
        counter=counter+1
        

        _ = CGRect(x: 0, y: 0, width: destWidth , height: destHeight)
        _ = CGRect(x: 0, y: 0, width: destWidth , height: destHeight)
        
        if nodeInst.node is BaseBlendFX {
            let outputNodeCI = (nodeInst.node as! BaseBlendFX).getCIFilter(firstImage: firstciImg!,secondImage: secondciImg!)!            
            let context = nodeInst.node?.parent?.getContext()
            context!.render(outputNodeCI.outputImage!, to:destinationFrame!)
            //context.render(outputNodeCI.outputImage!, to:destinationFrame!, bounds: CGRect(x: 0, y: 0, width: destWidth , height: destHeight), colorSpace: nil)
        } else  if nodeInst.node is BaseTransitionFX {
            let outputNodeCI = (nodeInst.node as! BaseTransitionFX).getCIFilter(firstImage: firstciImg!,secondImage: secondciImg!)!
            let context = nodeInst.node?.parent?.getContext()
            context!.render(outputNodeCI.outputImage!, to:destinationFrame!)
        }
         
        CVPixelBufferUnlockBaseAddress(destinationFrame!, CVPixelBufferLockFlags(rawValue: 0))
        CVPixelBufferUnlockBaseAddress(firstFrame!, .readOnly)
        CVPixelBufferUnlockBaseAddress(secondFrame!, .readOnly)
     
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

        //let degreesToRotate = orienation.getDegree()
        //let mirrored = orienation.isMirror()
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
