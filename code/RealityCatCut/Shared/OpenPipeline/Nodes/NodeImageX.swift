//
//  Copyright © 2023 James Boo. All rights reserved.
//

import AVKit
import PhotosUI
import SwiftUI
import CoreTransferable

struct NodeImageX: Transferable {
    let image: Image
    
    enum TransferError: Error {
        case importFailed
    }
    
    static var transferRepresentation: some TransferRepresentation {
          DataRepresentation(importedContentType: .image) { data in
          //#if canImport(AppKit)
          //    guard let nsImage = NSImage(data: data) else {
          //        throw TransferError.importFailed
          //    }
          //    let image = Image(nsImage: nsImage)
          //    return NodeImageX(image: image)
          //#elseif canImport(UIKit)
              guard let uiImage = UIImage(data: data) else {
                  throw TransferError.importFailed
              }
              let image = Image(uiImage: uiImage)
              return NodeImageX(image: image)
          //#else
          //    throw TransferError.importFailed
          //#endif
          }
      }

}
