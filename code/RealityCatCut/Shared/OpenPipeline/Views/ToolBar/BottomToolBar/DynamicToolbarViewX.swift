//
//  Copyright © 2022 James Boo. All rights reserved.
//


import SwiftUI

@available(iOS 15.0, *)

struct DynamicToolbarViewX: View {
    @Environment(\.colorScheme) var colorScheme
    @EnvironmentObject var appSettings: AppSettings
    @EnvironmentObject var optionSettings: OptionSettings
    @EnvironmentObject var pageSettings: PageSettings


    var body: some View {
        
        if (pageSettings.filters.currentNodeType() == "Video") {
            Group {
                /*
                if pageSettings.filters.getCurrentNode()?.videoStatus=="Completed" {
                    SaveVideoButtonViewX()
                        .environmentObject(appSettings)
                        .environmentObject(optionSettings)
                        .environmentObject(pageSettings)
                } else {
                    SaveVideoPhotoButtonViewX()
                        .environmentObject(appSettings)
                        .environmentObject(optionSettings)
                        .environmentObject(pageSettings)
                }
                Spacer()
                 */
                
                FiltersButtonViewX()
                    .environmentObject(appSettings)
                    .environmentObject(optionSettings)
                    .environmentObject(pageSettings)
           
                /*
                Spacer()
                
                GenerateVideoButtonViewX()
                    .environmentObject(appSettings)
                    .environmentObject(optionSettings)
                    .environmentObject(pageSettings)
                */
   
            }
            .opacity(pageSettings.isBusy() ? 0.5 : 1.0)
            .disabled(pageSettings.isBusy() ? true : false)
            
            

        } else if (pageSettings.filters.currentNodeType() == "Photo") {
            HStack {
                Spacer()
                Button(action: {
                    appSettings.zoomingOrScrollX = "zoomOut"
                    appSettings.zoomingOrScrollY = "zoomOut"
                    
                    appSettings.zoomFactor = appSettings.zoomFactor - appSettings.zoomFactor * 0.1
                    print(appSettings.zoomFactor)
                    appSettings.zoomFactor  = appSettings.zoomFactor < 0.05 ? 0.05 : appSettings.zoomFactor
                }) {

                    Image(systemName: "minus.magnifyingglass")
                        .font(.system(size: 28))
                        .foregroundColor(colorScheme == .dark ? Color(UIColor(red: 0.9569, green: 0.9569, blue: 0.9569, alpha: 0.5) ) : Color.black)
                }.disabled(!pageSettings.isStopped).opacity(!pageSettings.isStopped ? 0.2 : 1.0)
                
                Spacer()
                
                if pageSettings.filters.gotShaderEffects() {
                    if pageSettings.isStopped {
                        Group {
                            /*
                            SaveShaderVideoButtonViewX()
                                .environmentObject(appSettings)
                                .environmentObject(optionSettings)
                                .environmentObject(pageSettings)
                            */
                            /*
                            SaveVideoPhotoButtonViewX()
                                .environmentObject(optionSettings)
                                .environmentObject(pageSettings)
                            Spacer()
                             */
                            FiltersButtonViewX()
                                .environmentObject(appSettings)
                                .environmentObject(optionSettings)
                                .environmentObject(pageSettings)
                            Spacer()
                            PreviewButtonX()
                                .environmentObject(appSettings)
                                .environmentObject(pageSettings)
                            
                            /*
                             SharePhotoButtonViewX()
                                 .environmentObject(pageSettings)
                             

                             */

                        }
                    }
                    else {
                        //Spacer()
                        //Spacer()
                        StopButtonViewX()
                            .environmentObject(pageSettings)
                    }
                } else {
                    /*
                    SavePhotoButtonViewX()
                        .environmentObject(optionSettings)
                        .environmentObject(pageSettings)
                    Spacer()
                     */
                    FiltersButtonViewX()
                        .environmentObject(appSettings)
                        .environmentObject(optionSettings)
                        .environmentObject(pageSettings)
                    /*
                    SharePhotoWithResButtonViewX()
                        .environmentObject(appSettings)
                        .environmentObject(pageSettings)
                     

                    */
                }
                Spacer()
                Button(action: {
                    appSettings.zoomingOrScrollX = "zoomIn"
                    appSettings.zoomingOrScrollY = "zoomIn"
                    appSettings.zoomFactor = appSettings.zoomFactor + appSettings.zoomFactor * 0.1
                    appSettings.zoomFactor  = appSettings.zoomFactor > 1.0 ? 1.0 : appSettings.zoomFactor
                }) {

                    Image(systemName: "plus.magnifyingglass")
                        .font(.system(size: 28))
                        .foregroundColor(colorScheme == .dark ? Color(UIColor(red: 0.9569, green: 0.9569, blue: 0.9569, alpha: 0.5) ) : Color.black)
                }.disabled(!pageSettings.isStopped).opacity(!pageSettings.isStopped ? 0.2 : 1.0)
                Spacer()

            }
         
            
        }
        else if (pageSettings.filters.currentNodeType() == "AR") {
            if pageSettings.filters.gotShaderEffects() {
                if pageSettings.isStopped {
                   
               
                    ARButtonX()
                        .environmentObject(optionSettings)
                        .environmentObject(pageSettings)
                    Spacer()
                    FiltersButtonViewX()
                        .environmentObject(appSettings)
                        .environmentObject(optionSettings)
                        .environmentObject(pageSettings)
                    Spacer()
                    GenerateShaderVideoButtonViewX()
                        .environmentObject(appSettings)
                        .environmentObject(optionSettings)
                        .environmentObject(pageSettings)

                }
                else {
                    //Spacer()
                    
                    StopButtonViewX()
                        .environmentObject(appSettings)
                        .environmentObject(pageSettings)
                }
           
            } else {
                ARButtonX()
                    .environmentObject(optionSettings)
                    .environmentObject(pageSettings)
                Spacer()
                FiltersButtonViewX()
                    .environmentObject(appSettings)
                    .environmentObject(optionSettings)
                    .environmentObject(pageSettings)
               

       
                
            }
            
        }
        
    }

}
