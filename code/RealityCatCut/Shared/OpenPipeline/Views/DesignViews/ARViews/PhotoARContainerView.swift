//
//  Copyright © 2022-2023 James Boo. All rights reserved.
//

import SwiftUI
import ARKit
import RealityKit

struct PhotoARContainerView: UIViewRepresentable {
    @EnvironmentObject var pageSettings: PageSettings
    
    func makeUIView(context: Context) -> some UIView {
        var parView: PhotoARView!
        
        parView=Singleton.getPhotoARView()
        (parView!).cameraMode = .nonAR
        
        #if !targetEnvironment(simulator)
        if !ProcessInfo.processInfo.isiOSAppOnMac {
            let config = ARWorldTrackingConfiguration()
            parView.session.run(config)
        }
        #endif

        parView.startPlaying()
        return parView
    }

    func updateUIView(_ uiView: UIViewType, context: Context) {
        print("update")
        /*
        var parView: PhotoARView!
        
        parView=Singleton.getPhotoARView()
        (parView!).cameraMode = .nonAR
         */
    }
}

struct LiveARContainerView: UIViewRepresentable {
    @EnvironmentObject var pageSettings: PageSettings
    
    func makeUIView(context: Context) -> some UIView {
        var parView: PhotoARView!
        
        parView=Singleton.getPhotoARView()
        (parView!).cameraMode = .nonAR
        
        #if !targetEnvironment(simulator)
        if !ProcessInfo.processInfo.isiOSAppOnMac {
            let config = ARWorldTrackingConfiguration()
            parView.session.run(config)
        }
        #endif

        parView.startPlaying()
        return parView
    }

    func updateUIView(_ uiView: UIViewType, context: Context) {
    }
}

