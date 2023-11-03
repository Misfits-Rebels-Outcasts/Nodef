//
//  Copyright © 2022 James Boo. All rights reserved.
//


import SwiftUI

@available(iOS 15.0, *)

struct SavePhotoButtonViewX: View {
    @Environment(\.colorScheme) var colorScheme
    @EnvironmentObject var optionSettings: OptionSettings
    @EnvironmentObject var pageSettings: PageSettings

    var body: some View {
                
        Button(action: {
            
            ImageSaverX().writeToPhotoAlbum(image: pageSettings.filteredBackgroundImage!)
            optionSettings.showingAlertMessage=true
            optionSettings.alertMessage="Image saved successfully."
    
        }, label: {
            /*
            Image(systemName: "square.and.arrow.down")
                .font(.system(size: 28))
                .foregroundColor(colorScheme == .dark ? Color(UIColor(red: 0.9569, green: 0.9569, blue: 0.9569, alpha: 0.5) ) : Color.black)
             */
            Label("Save Photo",systemImage: "square.and.arrow.down")

        }).foregroundColor(.black).disabled(!pageSettings.isStopped)
        
    }

}
