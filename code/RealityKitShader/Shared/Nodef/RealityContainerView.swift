//
//  Copyright © 2022-2023 James Boo. All rights reserved.
//

import SwiftUI
import ARKit
import RealityKit
struct RealityContainerView: UIViewRepresentable {

    func makeUIView(context: Context) -> some UIView {
        
        var arView: RealityTerrianView!

        arView = RealityTerrianView(frame: .zero, cameraMode: .nonAR,
                           automaticallyConfigureSession: true)

        arView.setupScene()
        
        #if !targetEnvironment(simulator)
        if !ProcessInfo.processInfo.isiOSAppOnMac {
            let config = ARWorldTrackingConfiguration()
            arView.session.run(config)
        }
        #endif
        
        arView.startPlaying()
        return arView
         
       
    }

    func updateUIView(_ uiView: UIViewType, context: Context) {
    }
}


struct RealityContainerView_Previews: PreviewProvider {
    static var previews: some View {
        RealityContainerView()
    }
}
