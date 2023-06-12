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

    //@EnvironmentObject var store: Store

    //@State private var selectionx:Int? = 1
    //@State private var selectedItem: String? = "Add"
    var body: some View {
        VStack{
    
            if optionSettings.showPagePropertiesView == 1
            {

             
                NavigationView {
                    Form{
                        //Test Switch
                        
                        ToneCurvePropertiesViewX(fx:pageSettings.filters.filterList[0].filter as! ToneCurveFX, parent: FilterPropertiesViewX(pageSettings:pageSettings)
                            
                        )
                            .environmentObject(appSettings)
                            .environmentObject(pageSettings)
                         
                        /*
                        TortiseShellPropertiesViewX(fx:pageSettings.filters.filterList[0].filter as! TortiseShellVoronoiFX, parent: nil)
                            .environmentObject(appSettings)
                            .environmentObject(pageSettings)
                         */
                    }
                    .navigationBarTitleDisplayMode(.inline).navigationBarTitle("Curve Properties")
                    .toolbar {
                        
                        ToolbarItem(placement: .navigationBarTrailing) {
                            Button("Done") {
                                
                                print("Page Properties Off")
                                pageSettings.resetViewer()
                                optionSettings.showPropertiesView=0
                                optionSettings.showPagePropertiesView=0
                                optionSettings.pagePropertiesHeight=95
                                appSettings.zoomFactor = appSettings.zoomFactor * 1.0/0.999
                            }
                        }
                    }
                }.navigationViewStyle(.stack)
          
            }

            else
            {

                VStack (alignment: .leading)
                {


                    if UIApplication.shared.keyWindow!.safeAreaInsets.bottom > 0 {
                        HStack{
                            PhotoToolbarViewX()
                            .environmentObject(appSettings)
                            .environmentObject(optionSettings)
                            .environmentObject(pageSettings)

                        }.padding([.top, .bottom],5)


                    }
                    else{
                        //support device with buttons
                        HStack{
                          PhotoToolbarViewX()
                          .environmentObject(appSettings)
                          .environmentObject(optionSettings)
                          .environmentObject(pageSettings)
    
                      }.padding([.top],15)
                    }

         
                }
               
                
            }
        
        }.onAppear(perform: setupViewModel)
   
           .frame(height: optionSettings.pagePropertiesHeight) //so as to extend beyond the bottomn toolbar
        
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
