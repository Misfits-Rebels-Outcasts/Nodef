//
//  Copyright © 2022-2023 James Boo. All rights reserved.
//

import SwiftUI
import ARKit

struct Singleton{
    
    #if targetEnvironment(simulator)
        static var photoARView: PhotoARView! = PhotoARView(frame: .zero)
    #else
        static var photoARView: PhotoARView! = PhotoARView(frame: .zero, cameraMode: .nonAR, automaticallyConfigureSession: true)
    #endif
    
}
