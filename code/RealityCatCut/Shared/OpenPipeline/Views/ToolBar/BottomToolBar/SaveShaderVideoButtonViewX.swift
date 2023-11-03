//
//  Copyright © 2022 James Boo. All rights reserved.
//


import SwiftUI

@available(iOS 15.0, *)

//ANCHISES
struct SaveShaderVideoButtonViewX: View {
    
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
            
                build(outputSize: videoSize,pageSettings: pageSettings ,optionSettings: optionSettings, duration: duration,framerate: Int32(framerate))
            
            }, label: {
            Label("Save Video",systemImage: "arrow.down.left.video")

        }).foregroundColor(.black).disabled(!pageSettings.isStopped)

        
    }

}
