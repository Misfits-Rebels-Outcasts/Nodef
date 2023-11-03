//
//  Copyright © 2022 James Boo. All rights reserved.
//



import SwiftUI
@available(iOS 15.0, *)
struct PageCurlTransitionPropertiesViewX: View, NodeProperties {

    
    @ObservedObject var fx: PageCurlTransitionFX = PageCurlTransitionFX()
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
            
            Slider(value: $fx.radius, in: 0...400, onEditingChanged: {editing in
                applyFilter(editing)
            })
                .onChange(of: fx.radius) { oldValue, newValue in
                    //print("id",fx.id)
                    applyFilter()
                }
            
            
        }
        .onAppear(perform: setupViewModel)
        
        Section(header: Text("Extent")){
            
            Group{
                HStack{
                    Text("X")
                    Spacer()
                    Text(String(format: "%.2f", fx.x))
                }
                            
                Slider(value: $fx.x, in: 0...Float(fx.size.width), onEditingChanged: {editing in
                    applyFilter(editing)
                })
                    .onChange(of: fx.x) { oldValue, newValue in
                        applyFilter()
                    }

                HStack{
                    Text("Y")
                    Spacer()
                    Text(String(format: "%.2f", fx.y))
                }

                Slider(value: $fx.y, in: 0...Float(fx.size.height) , onEditingChanged: {editing in
                    applyFilter(editing)
                })
                    .onChange(of: fx.y) { oldValue, newValue in
                        applyFilter()
                    }

                HStack{
                    Text("Width")
                    Spacer()
                    Text(String(format: "%.2f", fx.extentWidth))
                }
                            
                Slider(value: $fx.extentWidth, in: 0...Float(fx.size.width), onEditingChanged: {editing in
                    applyFilter(editing)
                })
                    .onChange(of: fx.extentWidth) { oldValue, newValue in
                        applyFilter()
                    }
                
                HStack{
                    Text("Height")
                    Spacer()
                    Text(String(format: "%.2f", fx.extentHeight))
                }
                            
                Slider(value: $fx.extentHeight, in: 0...Float(fx.size.height), onEditingChanged: {editing in
                    applyFilter(editing)
                })
                    .onChange(of: fx.extentHeight) { oldValue, newValue in
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
        
        Section(header: Text("Backside Image Node"), footer: Text("Select a Node to use as the Backside Image. The original image is used by default."))
        {
            NavigationLink
            {
                NodeSelectionViewX(nodeType:"PageCurlTransitionFX-backside", numNodes: fx.nodeIndex,
                                   filterPropertiesViewModel: filterPropertiesViewModel,
                                   filtersPropertiesViewModel: filtersPropertiesViewModel)
                    //.environmentObject(pageSettings)
            } label: {
                HStack{
                    Text("Node")
                    Spacer()
                    if fx.inputBacksideImageAlias == ""{
                        Text("Preceding").foregroundColor(Color.gray)
                    }
                    else{
                        Text("Node "+fx.inputBacksideImageAlias).foregroundColor(Color.gray)
                    }
                    
                }
            }
            
            HStack{
                Text("Node Number")
                Spacer()
                if fx.inputBacksideImageAlias == ""{
                    Text(String(fx.nodeIndex-1))
                }
                else{
                    Text(fx.inputBacksideImageAlias)
                }
            }
             
        }
        
        Section(header: Text("Shading Image Node"), footer: Text("Select a Node to use as the Shading Image. The original image is used by default."))
        {
            NavigationLink
            {
                NodeSelectionViewX(nodeType:"PageCurlTransitionFX-shading", numNodes: fx.nodeIndex,
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
                if fx.inputShadingImageAlias == ""{
                    Text(String(fx.nodeIndex-1))
                }
                else{
                    Text(fx.inputShadingImageAlias)
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

