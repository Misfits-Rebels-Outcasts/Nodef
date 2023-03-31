//
//  Copyright © 2022 James Boo. All rights reserved.
//


import SwiftUI

@main
@available(iOS 15.0, *)
struct SketchEffectsApp: App {
    var body: some Scene {
        
        WindowGroup {
            
            PhotoMainViewX()
                .environmentObject(ShapesX())
                .environmentObject(AppSettings(1000,0.28,"Pixels",0.44,0.44))
                .environmentObject(OptionSettings())
                .environmentObject(PageSettings(image: UIImage(named: "PhotoImage")!))
                .environmentObject(DataSettings())
                .environmentObject(FilterSettings(7,10,false,100,0,100))
             
            /*
            LabelMainViewX()
                .environmentObject(ShapesX())
                .environmentObject(AppSettings(300,0.28))
                .environmentObject(OptionSettings())
                .environmentObject(PageSettings())
                .environmentObject(DataSettings())
                .environmentObject(FilterSettings(7,10,false,100,0,100))
                .environmentObject(LabelStore())
                //.environmentObject(ARDrawFlags(false))
            */
        }


    }
}
