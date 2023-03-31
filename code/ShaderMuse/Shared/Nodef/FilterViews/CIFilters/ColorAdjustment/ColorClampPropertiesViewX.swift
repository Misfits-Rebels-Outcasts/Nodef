//
//  Copyright © 2022 James Boo. All rights reserved.
//


import SwiftUI


@available(iOS 15.0, *)
struct ColorClampPropertiesViewX: View {
    @Environment(\.verticalSizeClass) var verticalSizeClass: UserInterfaceSizeClass?
    @Environment(\.horizontalSizeClass) var horizontalSizeClass: UserInterfaceSizeClass?
    @EnvironmentObject var appSettings: AppSettings
    //@EnvironmentObject var pageSettings: PageSettings
    //@EnvironmentObject var shapes: ShapesX
    
    @ObservedObject var fx: ColorClampFX = ColorClampFX()
    var parent: FilterPropertiesViewX
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
                    .onChange(of: fx.minx) { newValue in
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
                    .onChange(of: fx.miny) { newValue in
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
                    .onChange(of: fx.minz) { newValue in
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
                    .onChange(of: fx.minw) { newValue in
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
                    .onChange(of: fx.maxx) { newValue in
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
                    .onChange(of: fx.maxy) { newValue in
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
                    .onChange(of: fx.maxz) { newValue in
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
                    .onChange(of: fx.maxw) { newValue in
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
    
    func applyFilter(_ editing: Bool) {
        print(editing,appSettings.imageRes)
        if editing == true
        {
            //if appSettings.imageRes != "High Resolution"
            //{
                //parent.applyFilter()
            //}
        }
        else{
            parent.applyFilter()
        }
    }
    
    func applyFilter() {
        if appSettings.imageRes != "High Resolution"
        {
            parent.applyFilter()
        }
    }
    
    func setupViewModel()
    {
        //colorControlsFX.brightness=

    }
}

