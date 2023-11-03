//
//  Copyright © 2022 James Boo. All rights reserved.
//


import SwiftUI
import TipKit

@main
@available(iOS 15.0, *)
struct SketchEffectsApp: App {
    



    var body: some Scene {
        
        WindowGroup {

             
            PipelineMainViewX()
               .environmentObject(AppSettings(1000,0.28,"Pixels",0.44,0.44))
               .environmentObject(OptionSettings())
               .environmentObject(PageSettings(image: UIImage(named: "KittyStep")!))

         
        }
        
  
        
    }
    init() {
        try? Tips.configure()
    }
}
