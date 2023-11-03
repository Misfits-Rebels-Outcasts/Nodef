//
//  Copyright © 2022 James Boo. All rights reserved.
//


import SwiftUI

@available(iOS 15.0, *)
struct PresetsViewX: View {
    @EnvironmentObject var appSettings: AppSettings
    @EnvironmentObject var optionSettings: OptionSettings
    @EnvironmentObject var pageSettings: PageSettings

    
    var body: some View {
        //OptimizeCode
        //NavigationView {
            
        Form{
    

            Section(header: Text("Photo Effects"), footer: Text("Color Effects such as Chrome, Transfer, Process, Fade, and more")){
                VStack (alignment: .leading)
                {
                    PresetsRowViewX(presetType: "Photo Effects")
                        .environmentObject(appSettings)
                        .environmentObject(pageSettings)
                }
            }
           
            Section(header: Text("Original"), footer: Text("Tap on a Preset above to apply filters to the image. You can further customize the filters in the Filter Node Editor (f).")){
                VStack (alignment: .leading)
                {
                    PresetsRowViewX(presetType: "Original")
                        .environmentObject(appSettings)
                        .environmentObject(pageSettings)
                }
            }

            Section(header: Text(""), footer: Text("")){
            }
        }
        .navigationTitle("Presets")
        .navigationBarTitleDisplayMode(.inline)
        .toolbar {
            
            ToolbarItem(placement: .navigationBarTrailing) {
                    Button("Done") {

                        Singleton.onPagePropertiesOff(pageSettings, optionSettings, appSettings)
                    }
            }
            
            ToolbarItem(placement: .navigationBarLeading) {
                    Button("Edit") {
                        optionSettings.showPagePropertiesView=1
                        optionSettings.pagePropertiesHeight = UIScreen.main.bounds.height >= 1024 ? UIScreen.main.bounds.height*0.46 : 400
                        optionSettings.selectedItem="Add"
                        optionSettings.objectWillChange.send()
                        
                    }
            }
            /*
            ToolbarItem(placement: .cancellationAction) {
                    Button("Cancel") {
                        optionSettings.showPropertiesView=0 //set back to 0
                    }
            }
             */
            /*
            Button("Done") {
                optionSettings.showPropertiesView=0 //set back to 0
            }*/
        }
        //}//NavigationView

    }
    
    func initAll()
    {

    }
}
