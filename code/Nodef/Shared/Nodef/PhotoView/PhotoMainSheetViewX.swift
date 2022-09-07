//
//  Copyright © 2022 James Boo. All rights reserved.
//


import SwiftUI

@available(iOS 15.0, *)
struct PhotoMainSheetViewX: View {
    @EnvironmentObject var optionSettings: OptionSettings
    @EnvironmentObject var appSettings: AppSettings
    @EnvironmentObject var pageSettings: PageSettings
    @EnvironmentObject var dataSettings: DataSettings

    //@EnvironmentObject var store: Store
    
    var body: some View {

        if optionSettings.action == "SelectPhoto" {

                PhotoPHImagePicker(didFinishPicking: {didSelectItems in
                           
            })
                .environmentObject(appSettings)
                .environmentObject(optionSettings)
                //.environmentObject(shapes)
                .environmentObject(pageSettings)
                //.environmentObject(store)


        }
        else if optionSettings.action == "ReadPhoto" {

            ReadPHImagePicker(didFinishPicking: {didSelectItems in
                           
            })
                .environmentObject(appSettings)
                .environmentObject(optionSettings)
                //.environmentObject(shapes)
                .environmentObject(pageSettings)
                //.environmentObject(store)
        }
        else if optionSettings.action == "NodefHelpViewer"
        {
            HelpViewerViewX()
        }
        else if optionSettings.action == "NodefHelpPipeline"
        {
            HelpPipelineViewX()
        }
        else if optionSettings.action == "NodefHelp"
        {
            HelpViewX()
            
        }
        else if optionSettings.action == "NewLabel"
        {
        
        PhotoPHImagePicker(didFinishPicking: {didSelectItems in
            
            let size=CGSize(width: pageSettings.filters.size.width, height:pageSettings.filters.size.height)
            let boundsCenter=CIVector(x:size.width/2.0,y:size.height/2.0)
            
            pageSettings.filters=FiltersX()
            pageSettings.filters.size=size
            pageSettings.filters.boundsCenter=boundsCenter
            let filterXHolder = FilterXHolder()
            filterXHolder.filter=ColorControlsFX()
            pageSettings.filters.add(filterHolder: filterXHolder)
            pageSettings.filters.reassignAllBounds()
            pageSettings.applyFilters()
     
            
        })
            .environmentObject(appSettings)
            .environmentObject(optionSettings)
            //.environmentObject(shapes)
            .environmentObject(pageSettings)
            //.environmentObject(store)
        }
        
        else if optionSettings.action == "OpenLabel"
        {
            
            FilesViewX(filesViewModel: FilesViewModel())
                .environmentObject(appSettings)
                .environmentObject(optionSettings)
                .environmentObject(pageSettings)
                .environmentObject(dataSettings)
                //.environmentObject(shapes)
             
        }
        else if optionSettings.action == "Subscription"
        {
            //StoreView().environmentObject(store)
        }
        else if optionSettings.action == "Settings"
        {
            SettingsViewX()
                .environmentObject(appSettings)
                //.environmentObject(store)
        }

    }
}
