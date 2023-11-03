//
//  Copyright © 2022 James Boo. All rights reserved.
//

import SwiftUI

@available(iOS 15.0, *)
struct FiltersEditViewX: View {
    
    @EnvironmentObject var pageSettings: PageSettings
    @EnvironmentObject var optionSettings: OptionSettings

    @ObservedObject var filtersPropertiesViewModel: FiltersPropertiesViewModel
    
    @Environment(\.editMode) private var editMode

    var body: some View {
        
        Group{
          
            //ANCHISES
            Section(header: Text("Add Step")){
                    HStack {
                        //ANCHISES
                        Picker("Type", selection: $filtersPropertiesViewModel.selectedFilterType) {
                            //ANCHISES
                            //ForEach(FilterNames.GetMonoFilterType(), id: \.self) {
                            //    Text($0)
                            //}
                            if appType == "N" {
                                
                                ForEach(FilterNames.GetFilterType(), id: \.self) {
                                    Text($0)
                                }
                                
                            } else if appType == "B" {
                                ForEach(FilterNames.GetLabelMonoFilterType(), id: \.self) {
                                    Text($0)
                                }
                            }
                            
                        }.labelsHidden()
                        .pickerStyle(MenuPickerStyle())
                        Spacer()
                        
                        Button {
                            //ANCHISES
                            createNewNode()
                      
                        } label: {
                            Image(systemName: "plus")
                        }
            
               

                    }
                    Text(getNodeDescription()).font(.system(.subheadline).weight(.light))
                }.disabled(editMode?.wrappedValue.isEditing == true)
                .onAppear(perform: setupViewModel)
            
        
        }.disabled(
            filterNodesExceeded()
        )

        /*
        Section(header: Text("Step Description")){
            Text(getNodeDescription()).font(.system(.subheadline).weight(.light))
        }
         */
        
    }
   
    func getNodeDescription()->String {
        let type=filtersPropertiesViewModel.selectedFilterType
        let nodeHolder=self.filtersPropertiesViewModel.filters.getFilterWithHolder(type)
        return nodeHolder.filter.desc
    }
    //ANCHISES
    func createNewNode() {
        

        
        let type=filtersPropertiesViewModel.selectedFilterType
        let node=self.filtersPropertiesViewModel.filters.add(type)
        
        if node is ReadImageFX {
            let readImageFX=node as! ReadImageFX
            let img = readImageFX.inputImage!
            //Phoebus comeback make setCanas as part of add
            pageSettings.setCanvas(image: img, dpi: 1000)
        }
        else if node is ReadVideoFX {
            let readVideoFX=node as! ReadVideoFX
            //Phoebus comeback what about loaded part of add as well?
            pageSettings.loadState = .loaded(MovieX(url: readVideoFX.assetURL1))
        }

        self.filtersPropertiesViewModel.objectWillChange.send()
        self.applyFilter()
        
    }
    

    func applyFilter() {
        
        filtersPropertiesViewModel.applyFilters()
        
    }
    
    //ANCHISES-deprecated setupsize is now handled within add itself
    func createFilter(selectedFilter: String)->FilterXHolder
    {
        return filtersPropertiesViewModel.createFilter(selectedFilter: selectedFilter)
  
    }

    func filterNodesExceeded() -> Bool {
        
        if filtersPropertiesViewModel is BackgroundFiltersPropertiesViewModel
        {

            if pageSettings.filters.filterList.count > 20
            {
                return true
            }

        }
        else if filtersPropertiesViewModel is ImageFiltersPropertiesViewModel
        {
            if filtersPropertiesViewModel.filters.filterList.count > 3
            {
                return true
            }
        }
        return false
    }

    func setupViewModel()
    {


    }

     
}

