//
//  Copyright © 2022 James Boo. All rights reserved.
//


import SwiftUI

@main
@available(iOS 15.0, *)
struct SketchEffectsApp: App {
    var body: some Scene {
        
        WindowGroup {
           
           
            RealityContainerView()
                .background(Color.black)
                .ignoresSafeArea()
            
            /*
            PhotoMainViewX()
                .padding(0)
                .environmentObject(PageSettings())             
            */

        }
    }
    

}
