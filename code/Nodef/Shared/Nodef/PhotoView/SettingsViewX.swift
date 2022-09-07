//
//  Copyright © 2022 James Boo. All rights reserved.
//


import SwiftUI

@available(iOS 15.0, *)
struct SettingsViewX: View {
    @Environment(\.verticalSizeClass) var verticalSizeClass: UserInterfaceSizeClass?
    @Environment(\.horizontalSizeClass) var horizontalSizeClass: UserInterfaceSizeClass?
  

    @EnvironmentObject var appSettings: AppSettings

    var resUnits = ["Standard Resolution","High Resolution"]
    var hStr="When set to High Resolution, the imported image will not be downsampled. Filter properties will not be applied real-time to prevent overusage of resources. The High Resolution mode is only available in the Subscribed version."
    var sStr="When set to Standard Resolution, the imported image will be optimized and downsampled for your device. All Filter Properties will be applied real-time."

    var body: some View {
        
        NavigationView {
            Form {
                Section(header: Text("Image Quality"), footer: Text(appSettings.imageRes == "Standard Resolution" ? sStr : hStr)){
                    Picker("Resolution", selection: $appSettings.imageRes) {
                        ForEach(resUnits, id: \.self) {
                            Text($0)
                        }
                    }
                    .onChange(of: appSettings.imageRes) { newValue in
                        let defaults = UserDefaults.standard
                        print("Setting:",appSettings.imageRes)
                        defaults.set(appSettings.imageRes, forKey: "resolution")
                        
                    } .pickerStyle(.segmented)
                }
            }
            .navigationTitle("Settings")
            .navigationBarTitleDisplayMode(.inline)
        }
    }
    
    
    func setupViewModel()
    {
    }
}

