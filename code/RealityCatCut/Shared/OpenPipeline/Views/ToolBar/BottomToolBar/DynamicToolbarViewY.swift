//
//  Copyright © 2022 James Boo. All rights reserved.
//


import SwiftUI

@available(iOS 15.0, *)

struct DynamicToolbarViewY: View {
    @Environment(\.colorScheme) var colorScheme
    @EnvironmentObject var appSettings: AppSettings
    @EnvironmentObject var optionSettings: OptionSettings
    @EnvironmentObject var pageSettings: PageSettings
        
    var body: some View {
        
        if (pageSettings.filters.currentNodeType() == "Video") {
            Menu{
                FiltersButtonViewX()
                    .environmentObject(appSettings)
                    .environmentObject(optionSettings)
                    .environmentObject(pageSettings)
                
                SaveVideoPhotoButtonViewX()
                    .environmentObject(appSettings)
                    .environmentObject(optionSettings)
                    .environmentObject(pageSettings)
                 
                GenerateVideoButtonViewX()
                    .environmentObject(appSettings)
                    .environmentObject(optionSettings)
                    .environmentObject(pageSettings)
                
                if pageSettings.filters.getCurrentNode()?.videoStatus=="Completed" {
                    SaveVideoButtonViewX()
                        .environmentObject(appSettings)
                        .environmentObject(optionSettings)
                        .environmentObject(pageSettings)
                }
            }
            label: {

                Image(systemName: "pencil.and.outline")
                    .font(.system(size: 28))
                    .foregroundColor(colorScheme == .dark ? Color(UIColor(red: 0.9569, green: 0.9569, blue: 0.9569, alpha: 0.5) ) : Color.black)
            }
            .opacity(pageSettings.isBusy() ? 0.5 : 1.0)
            .disabled(pageSettings.isBusy() ? true : false)
        } else if (pageSettings.filters.currentNodeType() == "Photo") {
            if pageSettings.filters.gotShaderEffects() {
                if pageSettings.isStopped {
                    ShaderPlayerToolbarViewY()
                        .environmentObject(appSettings)
                        .environmentObject(optionSettings)
                        .environmentObject(pageSettings)
                }
                else {
                    StopButtonViewX()
                        .environmentObject(appSettings)
                        .environmentObject(pageSettings)
                }
            } else {
                ShaderNoEffectsToolbarViewY()
                    .environmentObject(appSettings)
                    .environmentObject(optionSettings)
                    .environmentObject(pageSettings)
            }
        }
        else if (pageSettings.filters.currentNodeType() == "AR") {
            if pageSettings.filters.gotShaderEffects() {
                if pageSettings.isStopped {
                    ARPlayerToolbarViewY()
                        .environmentObject(optionSettings)
                        .environmentObject(pageSettings)
                }
                else {
                    StopButtonViewX()
                        .environmentObject(appSettings)
                        .environmentObject(pageSettings)
                }
           
            } else {
                ARNoEffectsToolbarViewY()
                    .environmentObject(appSettings)
                    .environmentObject(optionSettings)
                    .environmentObject(pageSettings)
            }
        }
        
    }

}

struct ARPlayerToolbarViewY: View {
    @Environment(\.colorScheme) var colorScheme
    @EnvironmentObject var optionSettings: OptionSettings
    @EnvironmentObject var pageSettings: PageSettings
    @EnvironmentObject var appSettings: AppSettings

    var body: some View {
        
        Menu{
            if pageSettings.filters.gotShaderEffects() {
                FiltersButtonViewX()
                    .environmentObject(appSettings)
                    .environmentObject(optionSettings)
                    .environmentObject(pageSettings)
                
                //ANCHISES
                GenerateShaderVideoButtonViewX()
                    .environmentObject(appSettings)
                    .environmentObject(optionSettings)
                    .environmentObject(pageSettings)
                /*
                if pageSettings.filters.generatedVideoURL != nil {
                    PreviewButtonX()
                        .environmentObject(appSettings)
                        .environmentObject(pageSettings)
                }
                */
            }
            
            ARButtonX()
                .environmentObject(appSettings)
                .environmentObject(optionSettings)
                .environmentObject(pageSettings)
        }
        label: {
            //#if targetEnvironment(macCatalyst)
            //Text("Video")
            //#else
            Image(systemName: "play")
                .font(.system(size: 28))
                .foregroundColor(colorScheme == .dark ? Color(UIColor(red: 0.9569, green: 0.9569, blue: 0.9569, alpha: 0.5) ) : Color.black)
            //#endif
        }
     
    }
}

struct ShaderPlayerToolbarViewY: View {
    @Environment(\.colorScheme) var colorScheme
    @EnvironmentObject var appSettings: AppSettings
    @EnvironmentObject var optionSettings: OptionSettings
    @EnvironmentObject var pageSettings: PageSettings

    var body: some View {
        if pageSettings.isStopped{
            Menu{
                FiltersButtonViewX()
                    .environmentObject(appSettings)
                    .environmentObject(optionSettings)
                    .environmentObject(pageSettings)
                
                PreviewButtonX()
                    .environmentObject(appSettings)
                    .environmentObject(pageSettings)
                //ANCHISES
                SaveShaderVideoButtonViewX()
                    .environmentObject(appSettings)
                    .environmentObject(optionSettings)
                    .environmentObject(pageSettings)
                
                SharePhotoButtonViewX()
                    .environmentObject(pageSettings)
                
                SaveVideoPhotoButtonViewX()
                    .environmentObject(optionSettings)
                    .environmentObject(pageSettings)
                
            }
            label: {
                //#if targetEnvironment(macCatalyst)
                //Text("Video")
                //#else
                Image(systemName: "play")
                    .font(.system(size: 28))
                    .foregroundColor(colorScheme == .dark ? Color(UIColor(red: 0.9569, green: 0.9569, blue: 0.9569, alpha: 0.5) ) : Color.black)
                //#endif
            }
                                                            
        }
        else {
            StopButtonViewX()
                .environmentObject(pageSettings)
        }
        
    }
}
struct ARNoEffectsToolbarViewY: View {
    
    @Environment(\.colorScheme) var colorScheme
    @EnvironmentObject var optionSettings: OptionSettings
    @EnvironmentObject var pageSettings: PageSettings
    @EnvironmentObject var appSettings: AppSettings

    var body: some View {
        
        Menu{
            FiltersButtonViewX()
                .environmentObject(appSettings)
                .environmentObject(optionSettings)
                .environmentObject(pageSettings)
            
            ARButtonX()
                .environmentObject(optionSettings)
                .environmentObject(pageSettings)
        }
        label: {
            //#if targetEnvironment(macCatalyst)
            //Text("Video")
            //#else
            Image(systemName: "play")
                .font(.system(size: 28))
                .foregroundColor(colorScheme == .dark ? Color(UIColor(red: 0.9569, green: 0.9569, blue: 0.9569, alpha: 0.5) ) : Color.black)
            //#endif
        }
     
    }
}

struct ShaderNoEffectsToolbarViewY: View {
    
    @Environment(\.colorScheme) var colorScheme
    @EnvironmentObject var appSettings: AppSettings
    @EnvironmentObject var optionSettings: OptionSettings
    @EnvironmentObject var pageSettings: PageSettings
        
    var body: some View {
        Menu {
            
            FiltersButtonViewX()
                .environmentObject(appSettings)
                .environmentObject(optionSettings)
                .environmentObject(pageSettings)
            
            SharePhotoWithResButtonViewX()
                .environmentObject(appSettings)
                .environmentObject(pageSettings)

            SavePhotoButtonViewX()
                .environmentObject(optionSettings)
                .environmentObject(pageSettings)
            
        }
        label: {
            Image(systemName: "pencil.and.outline")
                               .font(.system(size: 28))
                               .foregroundColor(colorScheme == .dark ? Color(UIColor(red: 0.9569, green: 0.9569, blue: 0.9569, alpha: 0.5) ) : Color.black)
                          
            
        }
        .opacity(pageSettings.isBusy() ? 0.5 : 1.0)
        .disabled(pageSettings.isBusy() ? true : false)
    }
    
    
}



