//
//  Copyright © 2022 James Boo. All rights reserved.
//


import SwiftUI

@available(iOS 15.0, *)
struct PipelineMainPropertiesViewX: View {
    @Environment(\.verticalSizeClass) var verticalSizeClass: UserInterfaceSizeClass?
    @Environment(\.horizontalSizeClass) var horizontalSizeClass: UserInterfaceSizeClass?


    @Environment(\.colorScheme) var colorScheme

    @EnvironmentObject var optionSettings: OptionSettings
    @EnvironmentObject var appSettings: AppSettings
    @EnvironmentObject var pageSettings: PageSettings

    var body: some View {
        VStack{

            if optionSettings.showPagePropertiesView == 1
            {

                    FiltersViewX(filtersPropertiesViewModel: BackgroundFiltersPropertiesViewModel(pageSettings: pageSettings))
                                   .environmentObject(appSettings)
                                   .environmentObject(optionSettings)
                                   .environmentObject(pageSettings)

            }
            else if optionSettings.showPagePropertiesView == 2
            {

                NavigationView {
                    PresetsViewX()
                        .environmentObject(pageSettings)                    
                        .environmentObject(appSettings)
                        .environmentObject(optionSettings)
                }
                .navigationViewStyle(.stack)
                  
            }

            else
            {

                VStack (alignment: .leading)
                {

                    //ANCHISES
                    
                    let keyWindow = UIApplication.shared.connectedScenes
                            .filter({$0.activationState == .foregroundActive})
                            .compactMap({$0 as? UIWindowScene})
                            .first?.windows
                            .filter({$0.isKeyWindow}).first
                    
                    //if UIApplication.shared.keyWindow!.safeAreaInsets.bottom > 0 {
                    if keyWindow != nil && keyWindow!.safeAreaInsets.bottom > 0 {
                          HStack{
                     
                            PhotoToolbarViewX()
                            .environmentObject(appSettings)
                            .environmentObject(optionSettings)
                            .environmentObject(pageSettings)
                               
                            //.environmentObject(dataSettings)
                            //.environmentObject(shapes)

                          }.padding([.top, .bottom],5)


                    }
                    else{
                        //support device with buttons
                        #if targetEnvironment(macCatalyst)
                                            
                        HStack{
                          PhotoToolbarViewX()
                          .environmentObject(appSettings)
                          .environmentObject(optionSettings)
                          .environmentObject(pageSettings)
                          //.environmentObject(dataSettings)
                          //.environmentObject(shapes)

                        }
                        .padding(EdgeInsets(top: 15, leading: 0, bottom: 0, trailing: 0))
                        
                        
                        #else
                            HStack{
                              PhotoToolbarViewX()
                              .environmentObject(appSettings)
                              .environmentObject(optionSettings)
                              .environmentObject(pageSettings)
                              //.environmentObject(dataSettings)
                              //.environmentObject(shapes)
                            }.padding([.top, .bottom],5)
                        //.padding([.top],15)
                        #endif
                     
                    }

         
                }
               
                
            }
        
        }.onAppear(perform: setupViewModel)
        .frame(height: optionSettings.pagePropertiesHeight) //so as to extend beyond the bottomn toolbar
        
    }
    
    func generatePresets()
    {
        let type="Photo Effects"
        print("test",type)
    }
    
    func setupViewModel()
    {
        optionSettings.selectedItem="Add"
        

    }

}
