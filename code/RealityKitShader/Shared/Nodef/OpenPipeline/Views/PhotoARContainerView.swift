//
//  Copyright © 2022-2023 James Boo. All rights reserved.
//

import SwiftUI
import ARKit

struct PhotoARContainerView: UIViewRepresentable {
    @EnvironmentObject var pageSettings: PageSettings
    
    func makeUIView(context: Context) -> some UIView {
        var parView: PhotoARView!

        parView=Singleton.photoARView
        
        #if !targetEnvironment(simulator)
        if !ProcessInfo.processInfo.isiOSAppOnMac {
            let config = ARWorldTrackingConfiguration()
            parView.session.run(config)
        }
        #endif

        //parView.startPlaying()
        return parView
    }

    func updateUIView(_ uiView: UIViewType, context: Context) {
    }
}

