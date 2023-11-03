//
//  Copyright © 2022 James Boo. All rights reserved.
//


import SwiftUI

@available(iOS 15.0, *)

struct PreviewButtonX: View {
    @Environment(\.colorScheme) var colorScheme
    @EnvironmentObject var appSettings: AppSettings
    @EnvironmentObject var pageSettings: PageSettings

    var body: some View {
                
        Button(action: {
            timeElapsedX = 0.0
            pageSettings.isStopped = false;
            let animation = SetupAnimation(pageSettings: pageSettings, appSettings: appSettings)
               animation.createDisplayLink()
            /*
            if pageSettings.filters.lastNodeType() == "AR" {
                pageSettings.filters.generatedVideoURL=nil
            }
            else { //shader effects
                let animation = SetupAnimation(pageSettings: pageSettings, appSettings: appSettings)
                   animation.createDisplayLink()
            }
             */
        }, label: {
            Image(systemName: "play")
                .font(.system(size: 28))
                .foregroundColor(colorScheme == .dark ? Color(UIColor(red: 0.9569, green: 0.9569, blue: 0.9569, alpha: 0.5) ) : Color.black)
            
            //Label("Preview",systemImage: "play")


        }).foregroundColor(.black)
        
    }

}
