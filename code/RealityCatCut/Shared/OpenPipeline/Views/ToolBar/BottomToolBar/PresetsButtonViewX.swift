//
//  Copyright © 2022 James Boo. All rights reserved.
//


import SwiftUI

@available(iOS 15.0, *)

struct PresetsButtonViewX: View {
    
    @Environment(\.colorScheme) var colorScheme
    @EnvironmentObject var appSettings: AppSettings
    @EnvironmentObject var optionSettings: OptionSettings
    @EnvironmentObject var pageSettings: PageSettings

    var body: some View {
                
        Button(action: {
            //OptimizeCode
#if targetEnvironment(macCatalyst)
            print("Device: macCatalyst")
#else
        if UIDevice.current.model == "iPad" {

                print("Device: iPad")

          }else{
              pageSettings.resetViewer()
              optionSettings.showPropertiesView=0
              optionSettings.showPagePropertiesView=0
              optionSettings.pagePropertiesHeight=95
              appSettings.zoomFactor = appSettings.zoomFactor * 1.0/0.999
              optionSettings.action = "Presets"
              optionSettings.showPropertiesSheet = true
              return
          }
#endif

            print("show presets")
            //optionSettings.showPropertiesView = 7
            optionSettings.showPagePropertiesView=2
            optionSettings.pagePropertiesHeight = UIScreen.main.bounds.height >= 1024 ? UIScreen.main.bounds.height*0.46 : 400
            optionSettings.selectedItem="Add"
            optionSettings.objectWillChange.send()
            //optionSettings.objectWillChange.send()
            
            _ = Timer.scheduledTimer(withTimeInterval: 0.1, repeats: false) { timer in
                print("Timer fired!")
                appSettings.zoomFactor = appSettings.zoomFactor * 0.999
            }
            
            
        }) {
            Image(systemName: "camera.filters") //wand.and.stars
                .font(.system(size: 28))
                .foregroundColor(colorScheme == .dark ? Color(UIColor(red: 0.9569, green: 0.9569, blue: 0.9569, alpha: 0.5) ) : Color.black)//.padding([.leading,.trailing], 15)//.background(.blue)
        }.disabled(!pageSettings.isStopped).opacity(!pageSettings.isStopped ? 0.2 : 1.0)
        
    }

}
