//
//  Copyright © 2022 James Boo. All rights reserved.
//



import SwiftUI
@available(iOS 15.0, *)
struct ModTransitionPropertiesViewX: View, NodeProperties {

    
    @ObservedObject var fx: ModTransitionFX = ModTransitionFX()
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
                    //print("id",fx.id)
                    applyFilter()
                }
            
            HStack{
                Text("Angle")
                Spacer()
                Text(String(format: "%.0f", round(fx.angle * 180/Float.pi)))
            }
            
            Slider(value: $fx.angle, in: 0...2*3.14, onEditingChanged: {editing in
                applyFilter(editing)
            })
                .onChange(of: fx.angle) { oldValue, newValue in
                    //print("id",fx.id)
                    applyFilter()
                }
            HStack{
                Text("Radius")
                Spacer()
                Text(String(format: "%.2f", fx.radius))
            }
            
            Slider(value: $fx.radius, in: 0...200, onEditingChanged: {editing in
                applyFilter(editing)
            })
                .onChange(of: fx.radius) { oldValue, newValue in
                    //print("id",fx.id)
                    applyFilter()
                }
            
            HStack{
                Text("Compression")
                Spacer()
                Text(String(format: "%.2f", fx.compression))
            }
            
            Slider(value: $fx.compression, in: 100...800, onEditingChanged: {editing in
                applyFilter(editing)
            })
                .onChange(of: fx.compression) { oldValue, newValue in
                    //print("id",fx.id)
                    applyFilter()
                }
            
        }
        .onAppear(perform: setupViewModel)
        
        Section(header: Text("Center")){
            
            Group{
                HStack{
                    Text("X")
                    Spacer()
                    Text(String(format: "%.2f", fx.centerX))
                }
                            
                Slider(value: $fx.centerX, in: 0...Float(fx.size.width), onEditingChanged: {editing in
                    applyFilter(editing)
                })
                    .onChange(of: fx.centerX) { oldValue, newValue in
                        applyFilter()
                    }

                HStack{
                    Text("Y")
                    Spacer()
                    Text(String(format: "%.2f", fx.centerY))
                }

                Slider(value: $fx.centerY, in: 0...Float(fx.size.height) , onEditingChanged: {editing in
                    applyFilter(editing)
                })
                    .onChange(of: fx.centerY) { oldValue, newValue in
                        applyFilter()
                    }

            }
        }
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
        */
        //Section(header: Text(""), footer: Text("")){
        //}
    }
    


    func setupViewModel()
    {
        //colorControlsFX.brightness=

    }
}

