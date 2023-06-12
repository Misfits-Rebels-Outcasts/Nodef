//
//  Copyright © 2022 James Boo. All rights reserved.
//


import SwiftUI

//Open Photo Effects
//Photo Filters & Animation

@available(iOS 15.0, *)
struct FilterPropertiesViewX: View {
    //@Environment(\.presentationMode) var presentationMode
    /*
    @Environment(\.dismiss) private var dismiss
    
    @Environment(\.verticalSizeClass) var verticalSizeClass: UserInterfaceSizeClass?
    @Environment(\.horizontalSizeClass) var horizontalSizeClass: UserInterfaceSizeClass?
    @EnvironmentObject var appSettings: AppSettings
    @EnvironmentObject var optionSettings: OptionSettings
    @EnvironmentObject var pageSettings: PageSettings
    
    @StateObject var filterPropertiesViewModel: FilterPropertiesViewModel
    @ObservedObject var filtersPropertiesViewModel: FiltersPropertiesViewModel
*/
    //var parent: FiltersViewX
    
    
    //var vImage: UIImage?
    
    @ObservedObject var pageSettings: PageSettings
    
    var body: some View {
        
        
        Form{

             Text("Node Number")

        }
    }
    
    func setupViewModel()
    {
        
        //filterPropertiesViewModel.filterXHolder.filter.objectWillChange.send()
        //selectedFilterType=filterPropertiesViewModel.filter.type
        //self.colorControlsFX = filterPropertiesViewModel.filter as! ColorControlsFX
    }
    
    func readImage(fx: FilterX) {
        //if filtersPropertiesViewModel is BackgroundFiltersPropertiesViewModel
        //{
            pageSettings.readFX=(fx as! ReadImageFX)
        //}
 
        
        //optionSettings.action = "ReadPhoto"
        //optionSettings.showPropertiesSheet = true
    }
    
    func applyFilter() {
        pageSettings.applyFilters()
        /*
        DispatchQueue.main.async {
            do {
                pageSettings.applyFilters()
            }
        }
         */
        
        /*
        print("Number of Filters Count",FilterNames.GetFilterType().count)
        if filtersPropertiesViewModel is BackgroundFiltersPropertiesViewModel
        {
            DispatchQueue.main.async {
                do {
                    pageSettings.applyFilters()
                }
            }

        }
       */
        
    }

}


