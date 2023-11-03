//
//  Copyright © 2022 James Boo. All rights reserved.
//


import SwiftUI
@available(iOS 15.0, *)
struct OptionsZoomToolbarViewX: View {
    @Environment(\.colorScheme) var colorScheme
    @EnvironmentObject var appSettings: AppSettings
    @EnvironmentObject var optionSettings: OptionSettings
    @EnvironmentObject var pageSettings: PageSettings
    @State private var showingAlert = false

    @State var measurementUnit : String = "Inches"
    
    var body: some View {
   
        Button(action: {
            appSettings.zoomingOrScrollX = "zoomOut"
            appSettings.zoomingOrScrollY = "zoomOut"
            
            appSettings.zoomFactor = appSettings.zoomFactor - appSettings.zoomFactor * 0.1
            print(appSettings.zoomFactor)
            appSettings.zoomFactor  = appSettings.zoomFactor < 0.05 ? 0.05 : appSettings.zoomFactor
        }) {

            Image(systemName: "minus.magnifyingglass")
                //.font(.system(size: 18))
                .foregroundColor(colorScheme == .dark ? Color(UIColor(red: 0.9569, green: 0.9569, blue: 0.9569, alpha: 0.5) ) : Color.black)
        }.disabled(!pageSettings.isStopped).opacity(!pageSettings.isStopped ? 0.2 : 1.0)
        
        Button(action: {
            appSettings.zoomingOrScrollX = "zoomIn"
            appSettings.zoomingOrScrollY = "zoomIn"
            appSettings.zoomFactor = appSettings.zoomFactor + appSettings.zoomFactor * 0.1
            appSettings.zoomFactor  = appSettings.zoomFactor > 1.0 ? 1.0 : appSettings.zoomFactor
        }) {

            Image(systemName: "plus.magnifyingglass")
                //.font(.system(size: 18))
                .foregroundColor(colorScheme == .dark ? Color(UIColor(red: 0.9569, green: 0.9569, blue: 0.9569, alpha: 0.5) ) : Color.black)
        }.disabled(!pageSettings.isStopped).opacity(!pageSettings.isStopped ? 0.2 : 1.0)
     
    }

}
