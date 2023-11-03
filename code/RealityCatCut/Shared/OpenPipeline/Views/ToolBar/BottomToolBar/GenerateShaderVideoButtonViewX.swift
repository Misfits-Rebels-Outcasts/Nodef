//
//  Copyright © 2022 James Boo. All rights reserved.
//


import SwiftUI

@available(iOS 15.0, *)

struct GenerateShaderVideoButtonViewX: View {
    @Environment(\.colorScheme) var colorScheme
    @EnvironmentObject var appSettings: AppSettings
    @EnvironmentObject var pageSettings: PageSettings
    @EnvironmentObject var optionSettings: OptionSettings

    var body: some View {
                
        Button(action: {
           
                timeElapsedX = 0.0
                pageSettings.isStopped = false;
                pageSettings.savingInProgress=true
                print("Saving Shader Effects Video")
                let duration = Double(appSettings.videoDuration)
                let framerate = Int32(appSettings.videoFPS)
                
                let videoSize = CGSize(width: pageSettings.labelWidth*appSettings.dpi, height:pageSettings.labelHeight*appSettings.dpi)
            
                generate(outputSize: videoSize,pageSettings: pageSettings ,optionSettings: optionSettings, duration: duration,framerate: Int32(framerate))
            
            
            }, label: {
            //Label("Preview with Effects",systemImage: "video")

                Image(systemName: "video.badge.checkmark")
                    .font(.system(size: 28))
                    .foregroundColor(colorScheme == .dark ? Color(UIColor(red: 0.9569, green: 0.9569, blue: 0.9569, alpha: 0.5) ) : Color.black)
                    .padding(.top,5)

        }).foregroundColor(.black).disabled(!pageSettings.isStopped)

        
    }

}
