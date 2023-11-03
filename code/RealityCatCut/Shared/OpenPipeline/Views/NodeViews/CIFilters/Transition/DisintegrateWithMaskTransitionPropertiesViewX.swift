//
//  Copyright © 2022 James Boo. All rights reserved.
//



import SwiftUI
@available(iOS 15.0, *)
struct DisintegrateWithMaskTransitionPropertiesViewX: View, NodeProperties {
    
    @ObservedObject var fx: DisintegrateWithMaskTransitionFX = DisintegrateWithMaskTransitionFX()
    @ObservedObject var filterPropertiesViewModel: FilterPropertiesViewModel
    @ObservedObject var filtersPropertiesViewModel: FiltersPropertiesViewModel

    var parent: FilterPropertiesViewX?

    var body: some View {

        Section(header: Text("Options")){
                  
            HStack{
                Text("Time")
                Spacer()
                Text(String(format: "%.2f", fx.time))
            }

            Slider(value: $fx.time, in: 0...1, onEditingChanged: {editing in
                applyFilter(editing)
            })
                .onChange(of: fx.time) { oldValue, newValue in
                    applyFilter()
                }
            
            HStack{
                Text("Shadow Radius")
                Spacer()
                Text(String(format: "%.2f", fx.shadowRadius))
            }

            Slider(value: $fx.shadowRadius, in: 0...50, onEditingChanged: {editing in
                applyFilter(editing)
            })
                .onChange(of: fx.shadowRadius) { oldValue, newValue in
                    applyFilter()
                }
            
            HStack{
                Text("Shadow Density")
                Spacer()
                Text(String(format: "%.2f", fx.shadowDensity))
            }

            Slider(value: $fx.shadowDensity, in: 0...1, onEditingChanged: {editing in
                applyFilter(editing)
            })
                .onChange(of: fx.shadowDensity) { oldValue, newValue in
                    applyFilter()
                }
            
            HStack{
                Text("Shadow Offset X")
                Spacer()
                Text(String(format: "%.2f", fx.shadowOffsetX))
            }

            Slider(value: $fx.shadowOffsetX, in: -10...10, onEditingChanged: {editing in
                applyFilter(editing)
            })
                .onChange(of: fx.shadowOffsetX) { oldValue, newValue in
                    applyFilter()
                }
            
            HStack{
                Text("Shadow Offset Y")
                Spacer()
                Text(String(format: "%.2f", fx.shadowOffsetY))
            }

            Slider(value: $fx.shadowOffsetY, in: -10...10, onEditingChanged: {editing in
                applyFilter(editing)
            })
                .onChange(of: fx.shadowOffsetY) { oldValue, newValue in
                    applyFilter()
                }
                   
        }
        .onAppear(perform: setupViewModel)
        //ANCHISES
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
        
        Section(header: Text("Target Image Node"), footer: Text("Select a Node to use as the Target Image. The original image is used by default."))
        {
            NavigationLink
            {
                NodeSelectionViewX(nodeType:"target", numNodes: fx.nodeIndex,
                                   filterPropertiesViewModel: filterPropertiesViewModel,
                                   filtersPropertiesViewModel: filtersPropertiesViewModel)
                    //.environmentObject(pageSettings)
            } label: {
                HStack{
                    Text("Node")
                    Spacer()
                    if fx.targetImageAlias == ""{
                        Text("Preceding").foregroundColor(Color.gray)
                    }
                    else{
                        Text("Node "+fx.targetImageAlias).foregroundColor(Color.gray)
                    }
                    
                }
            }
            HStack{
                Text("Node Number")
                Spacer()
                if fx.targetImageAlias == ""{
                    Text(String(fx.nodeIndex-1))
                }
                else{
                    Text(fx.targetImageAlias)
                }
            }
             
        }
        
        Section(header: Text("Mask Image Node"), footer: Text("Select a Node to use as the Mask Image. The original image is used by default."))
        {
            NavigationLink
            {
                NodeSelectionViewX(nodeType:"DisintegrateWithMaskTransitionFX", numNodes: fx.nodeIndex,
                                   filterPropertiesViewModel: filterPropertiesViewModel,
                                   filtersPropertiesViewModel: filtersPropertiesViewModel)
                    //.environmentObject(pageSettings)
            } label: {
                HStack{
                    Text("Node")
                    Spacer()
                    if fx.inputMaskImageAlias == ""{
                        Text("Preceding").foregroundColor(Color.gray)
                    }
                    else{
                        Text("Node "+fx.inputMaskImageAlias).foregroundColor(Color.gray)
                    }
                    
                }
            }
            HStack{
                Text("Node Number")
                Spacer()
                if fx.inputMaskImageAlias == ""{
                    Text(String(fx.nodeIndex-1))
                }
                else{
                    Text(fx.inputMaskImageAlias)
                }
            }
             
        }
        */
        //Section(header: Text(""), footer: Text("")){
        //}
    }
    


    func setupViewModel()
    {
        //colorControlsFX.brightness=

    }
}

