//
//  Copyright © 2022 James Boo. All rights reserved.
//


import SwiftUI


@available(iOS 15.0, *)
struct ColorClampPropertiesViewX: View, NodeProperties {

    
    @ObservedObject var fx: ColorClampFX = ColorClampFX()
    var parent: FilterPropertiesViewX?
    var body: some View {

        Section(header: Text("Min Vector")){
            Group
            {
                HStack{
                    Text("Red")
                    Spacer()
                    Text(String(format: "%.2f", fx.minx))
                }
                
                Slider(value: $fx.minx, in: 0...1, onEditingChanged: {editing in
                    applyFilter(editing)
                })
                    .onChange(of: fx.minx) { oldValue, newValue in
                        applyFilter()
                    }
                
                HStack{
                    Text("Green")
                    Spacer()
                    Text(String(format: "%.2f", fx.miny))
                }
                
                Slider(value: $fx.miny, in: 0...1, onEditingChanged: {editing in
                    applyFilter(editing)
                })
                    .onChange(of: fx.miny) { oldValue, newValue in
                        applyFilter()
                    }

                HStack{
                    Text("Blue")
                    Spacer()
                    Text(String(format: "%.2f", fx.minz))
                }
                
                Slider(value: $fx.minz, in: 0...1, onEditingChanged: {editing in
                    applyFilter(editing)
                })
                    .onChange(of: fx.minz) { oldValue, newValue in
                        applyFilter()
                    }
                
                HStack{
                    Text("Alpha")
                    Spacer()
                    Text(String(format: "%.2f", fx.minw))
                }
                
                Slider(value: $fx.minw, in: 0...1, onEditingChanged: {editing in
                    applyFilter(editing)
                })
                    .onChange(of: fx.minw) { oldValue, newValue in
                        applyFilter()
                    }
            }

        }
        
        Section(header: Text("Max Vector")){
            Group
            {
                HStack{
                    Text("Red")
                    Spacer()
                    Text(String(format: "%.2f", fx.maxx))
                }
                
                Slider(value: $fx.maxx, in: 0...1, onEditingChanged: {editing in
                    applyFilter(editing)
                })
                    .onChange(of: fx.maxx) { oldValue, newValue in
                        applyFilter()
                    }
                
                HStack{
                    Text("Green")
                    Spacer()
                    Text(String(format: "%.2f", fx.maxy))
                }
                
                Slider(value: $fx.maxy, in: 0...1, onEditingChanged: {editing in
                    applyFilter(editing)
                })
                    .onChange(of: fx.maxy) { oldValue, newValue in
                        applyFilter()
                    }

                HStack{
                    Text("Blue")
                    Spacer()
                    Text(String(format: "%.2f", fx.maxz))
                }
                
                Slider(value: $fx.maxz, in: 0...1, onEditingChanged: {editing in
                    applyFilter(editing)
                })
                    .onChange(of: fx.maxz) { oldValue, newValue in
                        applyFilter()
                    }
                
                HStack{
                    Text("Alpha")
                    Spacer()
                    Text(String(format: "%.2f", fx.maxw))
                }
                
                Slider(value: $fx.maxw, in: 0...1, onEditingChanged: {editing in
                    applyFilter(editing)
                })
                    .onChange(of: fx.maxw) { oldValue, newValue in
                        applyFilter()
                    }
            }

        }
/*
        Section(header: Text("Options")){
            
            
          
           
           
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

