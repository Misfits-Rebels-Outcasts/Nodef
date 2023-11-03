//
//  Copyright © 2022 James Boo. All rights reserved.
//



import SwiftUI
@available(iOS 15.0, *)
struct FlashTransitionPropertiesViewX: View, NodeProperties {

    
    @ObservedObject var fx: FlashTransitionFX = FlashTransitionFX()
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
                Text("Color")
                Spacer()
                
                ColorPicker("", selection: $fx.colorx, supportsOpacity: true)
                  .onChange(of: fx.colorx) { oldValue, newValue in
#if targetEnvironment(macCatalyst)
                      fx.color=CIColor(cgColor: newValue.cgColor!)
#else
                      fx.color=CIColor(color: UIColor(newValue))
#endif
                      applyFilter()
                  }.frame(width:100, height:30, alignment: .trailing)
            }
            Group{
                HStack{
                    Text("Max Striation Radius")
                    Spacer()
                    Text(String(format: "%.2f", fx.maxStriationRadius))
                }
                
                Slider(value: $fx.maxStriationRadius, in: 0...10, onEditingChanged: {editing in
                    applyFilter(editing)
                })
                    .onChange(of: fx.maxStriationRadius) { oldValue, newValue in
                        //print("id",fx.id)
                        applyFilter()
                    }
                
                
                HStack{
                    Text("Striation Strength")
                    Spacer()
                    Text(String(format: "%.2f", fx.striationStrength))
                }
                
                Slider(value: $fx.striationStrength, in: 0...3, onEditingChanged: {editing in
                    applyFilter(editing)
                })
                    .onChange(of: fx.striationStrength) { oldValue, newValue in
                        //print("id",fx.id)
                        applyFilter()
                    }
                
                HStack{
                    Text("Striation Contrast")
                    Spacer()
                    Text(String(format: "%.2f", fx.striationContrast))
                }
                
                Slider(value: $fx.striationContrast, in: 0...5, onEditingChanged: {editing in
                    applyFilter(editing)
                })
                    .onChange(of: fx.striationContrast) { oldValue, newValue in
                        //print("id",fx.id)
                        applyFilter()
                    }
                
                HStack{
                    Text("Fade Threshold")
                    Spacer()
                    Text(String(format: "%.2f", fx.fadeThreshold))
                }
                
                Slider(value: $fx.fadeThreshold, in: 0...1, onEditingChanged: {editing in
                    applyFilter(editing)
                })
                    .onChange(of: fx.fadeThreshold) { oldValue, newValue in
                        //print("id",fx.id)
                        applyFilter()
                    }
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
                            
                Slider(value: $fx.extentHeight, in: 0...Float(fx.size.width), onEditingChanged: {editing in
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
        */
        //Section(header: Text(""), footer: Text("")){
        //}
    }
    

    func setupViewModel()
    {
        //colorControlsFX.brightness=

    }
}

