//
//  Copyright © 2023 James Boo. All rights reserved.
//

import AVKit
import PhotosUI
import SwiftUI

struct MovieX: Transferable {
    let url: URL

    
    enum WatermarkError: Error {
        case cannotLoadResources
        case cannotAddTrack
        case cannotLoadVideoTrack(Error?)
        case cannotCopyOriginalAudioVideo(Error?)
        case noVideoTrackPresent
        case exportSessionCannotBeCreated
    }

    
    static var transferRepresentation: some TransferRepresentation {
        FileRepresentation(contentType: .movie) { movie in
            SentTransferredFile(movie.url)
        } importing: { received in
            
            let filename=UUID().uuidString + ".mp4"
            print(filename)
            //let copy = URL.documentsDirectory.appending(path: "movie.mp4")
            let copy = URL.documentsDirectory.appending(path: filename)

            if FileManager.default.fileExists(atPath: copy.path()) {
                try FileManager.default.removeItem(at: copy)
            }

            try FileManager.default.copyItem(at: received.file, to: copy)
            return Self.init(url: copy)
        }
    }

       static func orientationFromTransform(_ transform: CGAffineTransform) -> (orientation: UIImage.Orientation, isPortrait: Bool) {
           var assetOrientation = UIImage.Orientation.up
           var isPortrait = false
           
           switch [transform.a, transform.b, transform.c, transform.d] {
           case [0.0, 1.0, -1.0, 0.0]:
               assetOrientation = .right
               isPortrait = true
               
           case [0.0, -1.0, 1.0, 0.0]:
               assetOrientation = .left
               isPortrait = true
               
           case [1.0, 0.0, 0.0, 1.0]:
               assetOrientation = .up
               
           case [-1.0, 0.0, 0.0, -1.0]:
               assetOrientation = .down

           default:
               break
           }
       
           return (assetOrientation, isPortrait)
       }

}
