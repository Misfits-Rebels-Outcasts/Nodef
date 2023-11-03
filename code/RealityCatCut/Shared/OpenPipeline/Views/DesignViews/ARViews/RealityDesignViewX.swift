//
//  Copyright © 2022-2023 James Boo. All rights reserved.
//

import SwiftUI
@available(macOS 12.0, *)
@available(iOS 15.0, *)
struct RealityDesignViewX: View {
    @Environment(\.verticalSizeClass) var verticalSizeClass: UserInterfaceSizeClass?
    @Environment(\.horizontalSizeClass) var horizontalSizeClass: UserInterfaceSizeClass?
    
    @EnvironmentObject var appSettings: AppSettings
    @EnvironmentObject var optionSettings: OptionSettings
    @EnvironmentObject var pageSettings: PageSettings

    var body: some View {
        GeometryReader { geometry in
            VStack(spacing:0){

                PhotoARContainerView()
                    .frame(height: horizontalSizeClass == .regular && verticalSizeClass == .regular ?
                            appSettings.HRulerWidthRegular*72.0+geometry.size.height :
                            appSettings.HRulerWidth*72.0+geometry.size.height,
                           alignment: .leading)
                    .padding(0)
                    .environmentObject(pageSettings)
                    .onTapGesture {
                        
                            Singleton.onPagePropertiesOff(pageSettings, optionSettings, appSettings)
                             
                    }
            }
        }
       
    }
}
