//
//  Copyright © 2022 James Boo. All rights reserved.
//


import SwiftUI

@available(iOS 15.0, *)

struct GenerateVideoButtonViewX: View {
    @Environment(\.colorScheme) var colorScheme
    @EnvironmentObject var appSettings: AppSettings
    @EnvironmentObject var pageSettings: PageSettings
    @EnvironmentObject var optionSettings: OptionSettings

    var body: some View {
                
        Button(action: {
           
            pageSettings.generateVideo()
      
            
            }, label: {
                Image(systemName: "video.badge.checkmark")
                    .font(.system(size: 28))
                    .foregroundColor(colorScheme == .dark ? Color(UIColor(red: 0.9569, green: 0.9569, blue: 0.9569, alpha: 0.5) ) : Color.black)
                    .padding(.top,5)
                //Label("Generate Video",systemImage: "video.badge.checkmark")

        }).foregroundColor(.black).disabled(!pageSettings.isStopped)

        
    }

}
