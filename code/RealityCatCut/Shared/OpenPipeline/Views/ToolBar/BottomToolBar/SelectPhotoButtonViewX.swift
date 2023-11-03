//
//  Copyright © 2022 James Boo. All rights reserved.
//


import SwiftUI

@available(iOS 15.0, *)

struct SelectPhotoButtonViewX: View {
    
    @Environment(\.colorScheme) var colorScheme
    @EnvironmentObject var optionSettings: OptionSettings
    @EnvironmentObject var pageSettings: PageSettings

    var body: some View {
                
        Button(action: {
            optionSettings.action = "SelectPhoto"
            optionSettings.square = false
            optionSettings.useCamera = false
            optionSettings.showPropertiesSheet = true
        }) {
            Image(systemName: "photo.on.rectangle.angled")
                .font(.system(size: 24))
                .foregroundColor(colorScheme == .dark ? Color(UIColor(red: 0.9569, green: 0.9569, blue: 0.9569, alpha: 0.5) ) : Color.black)
        }.disabled(!pageSettings.isStopped).opacity(!pageSettings.isStopped ? 0.2 : 1.0)
    }

}
