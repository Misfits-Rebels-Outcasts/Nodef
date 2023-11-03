//
//  Copyright © 2022 James Boo. All rights reserved.
//


import SwiftUI

@available(iOS 15.0, *)

struct ARButtonX: View {
    
    @Environment(\.colorScheme) var colorScheme
    @EnvironmentObject var appSettings: AppSettings
    @EnvironmentObject var pageSettings: PageSettings
    @EnvironmentObject var optionSettings: OptionSettings

    var body: some View {
                
        Button(action: {
            
            /*
            optionSettings.showPagePropertiesView=3
            optionSettings.pagePropertiesHeight = UIScreen.main.bounds.height
            optionSettings.objectWillChange.send()
             */
            //optionSettings.showingAR=true
            Singleton.onLiveCamOn(showLive: true, optionSettings: optionSettings)
            
            if pageSettings.filters.gotShaderEffects() {
                timeElapsedX = 0.0
                pageSettings.isStopped = false;
                pageSettings.savingInProgress=true
                print("Saving Shader Effects Video")
                let duration = Double(appSettings.videoDuration)
                let framerate = Int32(appSettings.videoFPS)
                
                let videoSize = CGSize(width: pageSettings.labelWidth*appSettings.dpi, height:pageSettings.labelHeight*appSettings.dpi)
            
                generate(outputSize: videoSize,pageSettings: pageSettings ,optionSettings: optionSettings, duration: duration,framerate: Int32(framerate))
             
            }
             
        
         
            /*
            if Singleton.getPhotoARView().cameraMode == .ar {
                optionSettings.showingAR = false
                Singleton.getPhotoARView().cameraMode = .nonAR
            }
            
            else {
                optionSettings.showingAR = true
                Singleton.getPhotoARView().cameraMode = .ar
            }
            */

        }, label: {
            //Label("AR Camera",systemImage: "perspective")
            //Label("Augmented Reality",systemImage: "perspective")
            Image(systemName: "perspective")
                .font(.system(size: 24))
                .foregroundColor(colorScheme == .dark ? Color(UIColor(red: 0.9569, green: 0.9569, blue: 0.9569, alpha: 0.5) ) : Color.black)
            /*
            Image(systemName: "perspective")
                .font(.system(size: 24))
                .foregroundColor(colorScheme == .dark ? Color(UIColor(red: 0.9569, green: 0.9569, blue: 0.9569, alpha: 0.5) ) : Color.black)
             */
        }).foregroundColor(.black)
    }

}
