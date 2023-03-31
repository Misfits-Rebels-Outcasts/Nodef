//
//  Copyright © 2022 James Boo. All rights reserved.
//

import SwiftUI

@available(iOS 15.0, *)


@available(iOS 15.0, *)
struct FiltersEditViewX: View {
    
    @Environment(\.verticalSizeClass) var verticalSizeClass: UserInterfaceSizeClass?
    @Environment(\.horizontalSizeClass) var horizontalSizeClass: UserInterfaceSizeClass?
  
     
    @EnvironmentObject var pageSettings: PageSettings
    @EnvironmentObject var optionSettings: OptionSettings
    @EnvironmentObject var shapes: ShapesX
    //@EnvironmentObject var store: Store
    
    //@ObservedObject var imagePropertiesViewModel: ImagePropertiesViewModel
    @ObservedObject var filtersPropertiesViewModel: FiltersPropertiesViewModel
    
    @Environment(\.editMode) private var editMode
    
    //https://www.ioscreator.com/tutorials/swiftui-add-rows-list-tutorial
    //https://www.hackingwithswift.com/quick-start/swiftui/how-to-push-a-new-view-when-a-list-row-is-tapped

    
    var body: some View {
        
        Group{
            Section(header: Text("Add Shader Effects Node")){
                HStack {
                    Picker("Shader Type", selection: $filtersPropertiesViewModel.selectedShaderType) {
                        ForEach(FilterNames.GetShaderType(), id: \.self) {
                            Text($0)
                        }
                    }.labelsHidden()
                    .pickerStyle(MenuPickerStyle())
                    
                    Spacer()
                    Button {
                        self.filtersPropertiesViewModel.filters.add(filterHolder: createFilter(selectedFilter: filtersPropertiesViewModel.selectedShaderType))

                        DispatchQueue.main.async(execute: {
                            self.filtersPropertiesViewModel.objectWillChange.send()
                        })
                        self.applyFilter()
                    } label: {
                        Image(systemName: "plus")
                    }
                   
                }
            }.disabled(editMode?.wrappedValue.isEditing == true)
            
            Section(header: Text("Add Filter Node")){
                    HStack {
                        Picker("Node Type", selection: $filtersPropertiesViewModel.selectedFilterType) {
                            if appType == "N" {
                                ForEach(FilterNames.GetMonoFilterType(), id: \.self) {
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
                            if filtersPropertiesViewModel.selectedFilterType=="Read Image"
                            {
                                let fxHolder = createFilter(selectedFilter: filtersPropertiesViewModel.selectedFilterType)
                                
                                self.filtersPropertiesViewModel.filters.add(filterHolder: fxHolder)
                                self.filtersPropertiesViewModel.objectWillChange.send()
                                self.applyFilter()
                                
                                if filtersPropertiesViewModel is BackgroundFiltersPropertiesViewModel
                                {
                                    pageSettings.readFX=(fxHolder.filter as! ReadImageFX)
                                }
                                else if filtersPropertiesViewModel is ImageFiltersPropertiesViewModel
                                {
                                    self.shapes.shapeList.forEach
                                    {
                                        if $0.isSelected == true {
                                            
                                            let selectedImage = $0 as! ImageX
                                            selectedImage.readFX=(fxHolder.filter as! ReadImageFX)

                                      }
                                    }
                                }
                                
                                optionSettings.action = "ReadPhoto"
                                optionSettings.showPropertiesSheet = true
                            }
                            else{
                                
                                self.filtersPropertiesViewModel.filters.add(filterHolder: createFilter(selectedFilter: filtersPropertiesViewModel.selectedFilterType))
                                DispatchQueue.main.async(execute: {
                                    self.filtersPropertiesViewModel.objectWillChange.send()
                                })
                                self.applyFilter()
                            }
                        } label: {
                            Image(systemName: "plus")
                        }
                    

                    }
                }.disabled(editMode?.wrappedValue.isEditing == true)
                .onAppear(perform: setupViewModel)
            
                Section(header: Text("Add Composite Filter Node")){
                    HStack {
                        Picker("Composite Type", selection: $filtersPropertiesViewModel.selectedBlendFilterType) {
                            ForEach(FilterNames.GetBlendFilterType(), id: \.self) {
                                Text($0)
                            }
                        }.labelsHidden()
                        .pickerStyle(MenuPickerStyle())
                        
                        Spacer()
                        Button {
                            self.filtersPropertiesViewModel.filters.add(filterHolder: createFilter(selectedFilter: filtersPropertiesViewModel.selectedBlendFilterType))

                            DispatchQueue.main.async(execute: {
                                self.filtersPropertiesViewModel.objectWillChange.send()
                            })
                            self.applyFilter()
                        } label: {
                            Image(systemName: "plus")
                        }
                       
                    }
                }.disabled(editMode?.wrappedValue.isEditing == true)

        }.disabled(
            filterNodesExceeded()
        )

        
    }
    
  

    func applyFilter() {
        if filtersPropertiesViewModel is BackgroundFiltersPropertiesViewModel
        {
            pageSettings.applyFilters()
        }
        else if filtersPropertiesViewModel is ImageFiltersPropertiesViewModel
        {
            self.shapes.shapeList.forEach
            {
                if $0.isSelected == true {
                    
                    let selectedImage = $0 as! ImageX
                    selectedImage.applyFilter()
                    
                }
            }
        }
    }
    
    func createFilter(selectedFilter: String)->FilterXHolder
    {
        print("createFilter",selectedFilter)

        let filterXHolder=filtersPropertiesViewModel.filters.getFilterWithHolder(selectedFilter)
        
        if filtersPropertiesViewModel is BackgroundFiltersPropertiesViewModel
        {
            filterXHolder.filter.size=CGSize(width: pageSettings.backgroundImage!.size.width,height: pageSettings.backgroundImage!.size.height)
        }
        else if filtersPropertiesViewModel is ImageFiltersPropertiesViewModel
        {
            self.shapes.shapeList.forEach
            {
                if $0.isSelected == true {
                    
                    let selectedImage = $0 as! ImageX
                    filterXHolder.filter.size=CGSize(width: selectedImage.image.size.width,height: selectedImage.image.size.height)

              }
            }
        }
        return filterXHolder
    }

    func filterNodesExceeded() -> Bool {
        
        if filtersPropertiesViewModel is BackgroundFiltersPropertiesViewModel
        {
            /*
            if store.purchasedSubscriptions.count <= 0 &&
                pageSettings.filters.filterList.count > 20
            {
                return true
            }
             */
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

