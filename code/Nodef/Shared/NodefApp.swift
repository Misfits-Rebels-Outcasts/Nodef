//
//  Copyright © 2022 James Boo. All rights reserved.
//


import SwiftUI

@main
@available(iOS 15.0, *)
struct NodefApp: App {
    var body: some Scene {
        WindowGroup {
            //TikTok
            //ShaderContentView()
            //ArtContentView().environmentObject(Shapes())


            PhotoMainViewX()
                //.environmentObject(ShapesX())
                .environmentObject(AppSettings(1000,0.28,"Pixels",0.44,0.44))
                .environmentObject(OptionSettings())
                //.environmentObject(OptionSettings("Design"))
                .environmentObject(PageSettings(image: UIImage(named: "PhotoImage")!))
                .environmentObject(DataSettings())
                .environmentObject(FilterSettings(7,10,false,100,0,100))
                //.environmentObject(Store())

 
        }
       
    }
}
