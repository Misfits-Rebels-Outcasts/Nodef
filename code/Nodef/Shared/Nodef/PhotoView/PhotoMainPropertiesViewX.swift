//
//  Copyright © 2022 James Boo. All rights reserved.
//


import SwiftUI

@available(iOS 15.0, *)
struct PhotoMainPropertiesViewX: View {
    @Environment(\.verticalSizeClass) var verticalSizeClass: UserInterfaceSizeClass?
    @Environment(\.horizontalSizeClass) var horizontalSizeClass: UserInterfaceSizeClass?
   
    /*
    init()
    {
        print("PhotoMainPropertiesViewX init")
        print(optionSettings.showPagePropertiesView)
    }
     */
    @EnvironmentObject var optionSettings: OptionSettings
    @EnvironmentObject var appSettings: AppSettings
    @EnvironmentObject var pageSettings: PageSettings

    @EnvironmentObject var dataSettings: AppSettings
    //@EnvironmentObject var store: Store

    //@State private var selectionx:Int? = 1
    //@State private var selectedItem: String? = "Add"
    var body: some View {
        VStack{
           
            if optionSettings.showPagePropertiesView == 1
            {
                
                NavigationView {

                    FiltersViewX(filtersPropertiesViewModel: BackgroundFiltersPropertiesViewModel(pageSettings: pageSettings))
                                   .environmentObject(appSettings)
                                   .environmentObject(optionSettings)
                                   .environmentObject(pageSettings)
                                   //.environmentObject(store)
                                   //.environmentObject(dataSettings)
                                   //.environmentObject(shapes)
                     
                                   
                }.navigationViewStyle(.stack)
     
            }
            else if optionSettings.showPagePropertiesView == 2
            {

                NavigationView {
                    PresetsViewX()
                        .environmentObject(pageSettings)                    
                        .environmentObject(appSettings)
                        .environmentObject(optionSettings)
                }.navigationViewStyle(.stack)
                  
            }
            else
            {
                /*
                VStack (alignment: .leading)
                {
                    HStack{
                        PhotoToolbarViewX()
                        .environmentObject(appSettings)
                        .environmentObject(optionSettings)
                        .environmentObject(pageSettings)
                        .environmentObject(dataSettings)
                        .environmentObject(shapes)

                    }.frame(height: horizontalSizeClass == .regular && verticalSizeClass == .regular ? 85 : 85)
                        
                }.frame(height: horizontalSizeClass == .regular && verticalSizeClass == .regular ? 85 : 85)
                */
                VStack (alignment: .leading)
                {
                    //Form{
                        //PresetsCategoriesViewX()
                        //    .environmentObject(pageSettings)
                        /*
                        Section(header: Text("Photo Effects"), footer: Text("")){
                            PresetsViewX()
                        }
                        Section(header: Text("Blur"), footer: Text("")){
                            PresetsViewX()
                        }
                         */
                    //PresetsCategoriesViewX()
                    //    .environmentObject(pageSettings)

                    if UIApplication.shared.keyWindow!.safeAreaInsets.bottom > 0 {
                        HStack{
                            PhotoToolbarViewX()
                            .environmentObject(appSettings)
                            .environmentObject(optionSettings)
                            .environmentObject(pageSettings)
                            .environmentObject(dataSettings)
                            //.environmentObject(shapes)

                        }.padding([.top, .bottom],5)


                    }
                    else{
                        //support device with buttons
                        HStack{
                          PhotoToolbarViewX()
                          .environmentObject(appSettings)
                          .environmentObject(optionSettings)
                          .environmentObject(pageSettings)
                          .environmentObject(dataSettings)
                          //.environmentObject(shapes)

                      }.padding([.top],15)
                    }
                
                        
                        //Section(header: Text(""), footer: Text("")){
                        //}

                    //}

     
                    
                    //.frame(height: horizontalSizeClass == .regular && verticalSizeClass == .regular ? 85 : 85)
                    //.frame(height: horizontalSizeClass == .regular && verticalSizeClass == .regular ? 300 : 300)
         
                }//.frame(height: 300)
               
                
            }
            
            //Spacer() //for toolbar push up
        }.onAppear(perform: setupViewModel)
   
           .frame(height: optionSettings.pagePropertiesHeight) //so as to extend beyond the bottomn toolbar

        //.frame(height: (optionSettings.showPagePropertiesView != 0 ? propertiesHeight-10 :
        //               (horizontalSizeClass == .regular && verticalSizeClass == .regular ? 220 : 220))) //so as to extend beyond the bottomn toolbar

        
        
    }
    
    func generatePresets()
    {
        var type="Photo Effects"
        print("test",type)
        //pageSettings.presets = PresetsX(presetType: type)
    }
    
    func setupViewModel()
    {
        optionSettings.selectedItem="Add"
    }

}
