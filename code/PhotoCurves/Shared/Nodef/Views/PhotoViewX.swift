//
//  Copyright © 2022 James Boo. All rights reserved.
//


import SwiftUI
//import Combine
@available(iOS 15.0, *)
struct PhotoViewX: View {
    
    @EnvironmentObject var optionSettings: OptionSettings
    @EnvironmentObject var appSettings: AppSettings
    @EnvironmentObject var pageSettings: PageSettings
             
    var body: some View {
        
        ZStack {
            
            Image(uiImage: pageSettings.filteredBackgroundImage!)
                .resizable()
                .edgesIgnoringSafeArea(.all)
                .scaledToFit()
            
                //.scaledToFill()
             
            

         
            

            
        }
        .background(Color.white)
        .onTapGesture {
   
                
                //comeback
                print("Page Properties Off - PV")
                pageSettings.resetViewer()
                optionSettings.skipScrollingX = true
                optionSettings.skipScrollingY = true
                optionSettings.showPropertiesView=0
                optionSettings.showPagePropertiesView=0
                optionSettings.pagePropertiesHeight=95
                appSettings.zoomingOrScrollX = "zoomIn"
                appSettings.zoomFactor = appSettings.zoomFactor * 1.0/0.999

                
            //})
        }
        .clipShape(Rectangle())
        //.gesture(pressGesture)

    }
    
    
}
