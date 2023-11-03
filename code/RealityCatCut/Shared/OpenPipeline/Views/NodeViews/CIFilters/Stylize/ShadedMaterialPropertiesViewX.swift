//
//  Copyright © 2022 James Boo. All rights reserved.
//


import SwiftUI
@available(iOS 15.0, *)
struct ShadedMaterialPropertiesViewX: View, NodeProperties {
 
    
    @ObservedObject var fx: ShadedMaterialFX = ShadedMaterialFX()
    @ObservedObject var filterPropertiesViewModel: FilterPropertiesViewModel
    @ObservedObject var filtersPropertiesViewModel: FiltersPropertiesViewModel
    var parent: FilterPropertiesViewX?

    var body: some View {

        Section(header: Text("Options")){
                  
            HStack{
                Text("Scale")
                Spacer()
                Text(String(format: "%.2f", fx.scale))
            }

            Slider(value: $fx.scale, in: 0.5...200, onEditingChanged: {editing in
                applyFilter(editing)
            })
                .onChange(of: fx.scale) { oldValue, newValue in
                    applyFilter()
                }
                   
        }
        /*
        Section(header: Text("Input Image Node"), footer: Text("Select a Node to use as the Input Image. The preceding Node is used by default."))
        {
            NavigationLink
            {
                NodeSelectionViewX(nodeType:"input", numNodes: fx.nodeIndex,
                                   filterPropertiesViewModel: filterPropertiesViewModel,
                                   filtersPropertiesViewModel: filtersPropertiesViewModel)
                    //.environmentObject(pageSettings)
            } label: {
                HStack{
                    Text("Node")
                    Spacer()
                    if fx.inputImageAlias == ""{
                        Text("Preceding").foregroundColor(Color.gray)
                    }
                    else{
                        Text("Node "+fx.inputImageAlias).foregroundColor(Color.gray)
                    }
                    
                }
            }
            HStack{
                Text("Node Number")
                Spacer()
                if fx.inputImageAlias == ""{
                    Text(String(fx.nodeIndex-1))
                }
                else{
                    Text(fx.inputImageAlias)
                }
            }
        }
                 
        Section(header: Text("Shading Image Node"), footer: Text("Select a Node to use as the Input Mask Image. The preceding Node is used by default."))
        {
            NavigationLink
            {
                NodeSelectionViewX(nodeType:"ShadedMaterialFX", numNodes: fx.nodeIndex,
                                   filterPropertiesViewModel: filterPropertiesViewModel,
                                   filtersPropertiesViewModel: filtersPropertiesViewModel)
                    //.environmentObject(pageSettings)
            } label: {
                HStack{
                    Text("Node")
                    Spacer()
                    if fx.inputShadingImageAlias == ""{
                        Text("Preceding").foregroundColor(Color.gray)
                    }
                    else{
                        Text("Node "+fx.inputShadingImageAlias).foregroundColor(Color.gray)
                    }
                    
                }
            }
            HStack{
                Text("Node Number")
                Spacer()
                if (filterPropertiesViewModel.filterXHolder.filter is ShadedMaterialFX)
                {
                    if (filterPropertiesViewModel.filterXHolder.filter as! ShadedMaterialFX).inputShadingImageAlias == ""{
                        Text(String(fx.nodeIndex-1))
                    }
                    else{
                        Text(fx.inputShadingImageAlias)
                    }
                }
            }
             
        }
        .onAppear(perform: setupViewModel)
         */
        //Section(header: Text(""), footer: Text("")){
        //}
    }
    

    func setupViewModel()
    {
        //colorControlsFX.brightness=

    }
}

