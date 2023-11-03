//
//  Copyright © 2022 James Boo. All rights reserved.
//

import SwiftUI
import AVFoundation

class BaseGeneratorFX: FilterX {
          
    @Published var cropToFormat:Bool = true
    override init()
    {
        super.init()
    }
    
    override init(_ type:String) {
        super.init(type)
    }
    
    enum CodingKeys : String, CodingKey {
        case cropToFormat

    }

    required init(from decoder: Decoder) throws {
 
        try super.init(from: decoder)
        let values = try decoder.container(keyedBy: CodingKeys.self)
        cropToFormat = try values.decodeIfPresent(Bool.self, forKey: .cropToFormat) ?? true

    }
    
    override func encode(to encoder: Encoder) throws {
        try super.encode(to: encoder)
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(cropToFormat, forKey: .cropToFormat)
    }
    
    func setCIFilterAndCropImage(inputImage: CIImage) {

        var cropFilter: CIFilter
        if ciFilter != nil {
            cropFilter = ciFilter!
        } else {
            cropFilter = CIFilter(name: "CICrop")!
        }
        
        cropFilter.setValue(inputImage, forKey: kCIInputImageKey)
        let rect = CIVector(cgRect: CGRect(x:0, y: 0, width: CGFloat(size.width), height: CGFloat(size.height)))
        cropFilter.setValue(rect, forKey: "inputRectangle")
        ciFilter=cropFilter

    }
    
    override func getDisplayNameFX() -> String
    {

        let fxStr = "input - none"
        return fxStr
   
    }
    
    override func doExecute() async {
        let urlA = urlStep
        let firstAsset = AVURLAsset(url: urlA)

        do {
            composition = AVMutableComposition()
            
            let videoAssetTrack = try await firstAsset.loadTracks(withMediaType: .video).first
            let videoCompositionTrack = composition.addMutableTrack(withMediaType: .video, preferredTrackID: kCMPersistentTrackID_Invalid)
            
            //let duration = CMTimeMakeWithSeconds(30, preferredTimescale: Int32(30.0))
            let vduration = duration
            
            try? videoCompositionTrack?.insertTimeRange(CMTimeRange(start:  CMTime.zero, duration: vduration), of: videoAssetTrack!, at: CMTime.zero)
            
            videoCompositionTrack?.preferredTransform = try await videoAssetTrack!.load(.preferredTransform)
            let size = try await videoAssetTrack!.load(.naturalSize)
            _ = try await videoAssetTrack!.load(.naturalTimeScale)
            //let nfr = try await videoAssetTrack!.load(.nominalFrameRate)
            let orient = MovieX.orientationFromTransform(videoCompositionTrack!.preferredTransform)
            
            videoComposition = try await executeCIFilterComposition()
            if orient.isPortrait {
                videoComposition.renderSize = CGSize(width: size.height, height: size.width)
            }
            else {
                videoComposition.renderSize = CGSize(width: size.width, height: size.height)
            }
            
            //videoComposition.renderSize = CGSize(width: 1080, height: 1920)
            
            await saveVideoToDocCache(asset: composition)
        } catch {
            videoStatus="Error"
            print(error)
        }

        
    }

}
