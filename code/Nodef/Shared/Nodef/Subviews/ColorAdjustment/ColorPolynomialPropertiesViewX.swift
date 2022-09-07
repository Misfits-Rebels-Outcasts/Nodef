//
//  Copyright © 2022 James Boo. All rights reserved.
//


import SwiftUI


@available(iOS 15.0, *)
struct ColorPolynomialPropertiesViewX: View {
    @Environment(\.verticalSizeClass) var verticalSizeClass: UserInterfaceSizeClass?
    @Environment(\.horizontalSizeClass) var horizontalSizeClass: UserInterfaceSizeClass?
    @EnvironmentObject var appSettings: AppSettings
    //@EnvironmentObject var pageSettings: PageSettings
    //@EnvironmentObject var shapes: ShapesX
    
    @ObservedObject var fx: ColorPolynomialFX = ColorPolynomialFX()
    var parent: FilterPropertiesViewX
    var body: some View {

        Section(header: Text("Red Coefficients")){
            Group
            {
                HStack{
                    Text("X")
                    Spacer()
                    Text(String(format: "%.2f", fx.rx))
                }
                
                Slider(value: $fx.rx, in: 0...1, onEditingChanged: {editing in
                    applyFilter(editing)
                })
                    .onChange(of: fx.rx) { newValue in
                        applyFilter()
                    }
                
                HStack{
                    Text("Y")
                    Spacer()
                    Text(String(format: "%.2f", fx.ry))
                }
                
                Slider(value: $fx.ry, in: 0...1, onEditingChanged: {editing in
                    applyFilter(editing)
                })
                    .onChange(of: fx.ry) { newValue in
                        applyFilter()
                    }

                HStack{
                    Text("Z")
                    Spacer()
                    Text(String(format: "%.2f", fx.rz))
                }
                
                Slider(value: $fx.rz, in: 0...1, onEditingChanged: {editing in
                    applyFilter(editing)
                })
                    .onChange(of: fx.rz) { newValue in
                        applyFilter()
                    }
                
                HStack{
                    Text("W")
                    Spacer()
                    Text(String(format: "%.2f", fx.rw))
                }
                
                Slider(value: $fx.rw, in: 0...1, onEditingChanged: {editing in
                    applyFilter(editing)
                })
                    .onChange(of: fx.rw) { newValue in
                        applyFilter()
                    }
            }

        }
        
        Section(header: Text("Green Coefficients")){
            Group
            {
                HStack{
                    Text("X")
                    Spacer()
                    Text(String(format: "%.2f", fx.gx))
                }
                
                Slider(value: $fx.gx, in: 0...1, onEditingChanged: {editing in
                    applyFilter(editing)
                })
                    .onChange(of: fx.gx) { newValue in
                        applyFilter()
                    }
                
                HStack{
                    Text("Y")
                    Spacer()
                    Text(String(format: "%.2f", fx.gy))
                }
                
                Slider(value: $fx.gy, in: 0...1, onEditingChanged: {editing in
                    applyFilter(editing)
                })
                    .onChange(of: fx.gy) { newValue in
                        applyFilter()
                    }

                HStack{
                    Text("Z")
                    Spacer()
                    Text(String(format: "%.2f", fx.gz))
                }
                
                Slider(value: $fx.gz, in: 0...1, onEditingChanged: {editing in
                    applyFilter(editing)
                })
                    .onChange(of: fx.gz) { newValue in
                        applyFilter()
                    }
                
                HStack{
                    Text("W")
                    Spacer()
                    Text(String(format: "%.2f", fx.gw))
                }
                
                Slider(value: $fx.gw, in: 0...1, onEditingChanged: {editing in
                    applyFilter(editing)
                })
                    .onChange(of: fx.gw) { newValue in
                        applyFilter()
                    }
            }

        }
        
        Section(header: Text("Blue Coefficients")){
            Group
            {
                HStack{
                    Text("X")
                    Spacer()
                    Text(String(format: "%.2f", fx.bx))
                }
                
                Slider(value: $fx.bx, in: 0...1, onEditingChanged: {editing in
                    applyFilter(editing)
                })
                    .onChange(of: fx.bx) { newValue in
                        applyFilter()
                    }
                
                HStack{
                    Text("Y")
                    Spacer()
                    Text(String(format: "%.2f", fx.by))
                }
                
                Slider(value: $fx.by, in: 0...1, onEditingChanged: {editing in
                    applyFilter(editing)
                })
                    .onChange(of: fx.by) { newValue in
                        applyFilter()
                    }

                HStack{
                    Text("Z")
                    Spacer()
                    Text(String(format: "%.2f", fx.bz))
                }
                
                Slider(value: $fx.bz, in: 0...1, onEditingChanged: {editing in
                    applyFilter(editing)
                })
                    .onChange(of: fx.bz) { newValue in
                        applyFilter()
                    }
                
                HStack{
                    Text("W")
                    Spacer()
                    Text(String(format: "%.2f", fx.bw))
                }
                
                Slider(value: $fx.bw, in: 0...1, onEditingChanged: {editing in
                    applyFilter(editing)
                })
                    .onChange(of: fx.bw) { newValue in
                        applyFilter()
                    }
            }
            
        }
        
        Section(header: Text("Alpha Coefficients")){
            Group
            {
                HStack{
                    Text("X")
                    Spacer()
                    Text(String(format: "%.2f", fx.ax))
                }
                
                Slider(value: $fx.ax, in: 0...1, onEditingChanged: {editing in
                    applyFilter(editing)
                })
                    .onChange(of: fx.ax) { newValue in
                        applyFilter()
                    }
                
                HStack{
                    Text("Y")
                    Spacer()
                    Text(String(format: "%.2f", fx.ay))
                }
                
                Slider(value: $fx.ay, in: 0...1, onEditingChanged: {editing in
                    applyFilter(editing)
                })
                    .onChange(of: fx.ay) { newValue in
                        applyFilter()
                    }

                HStack{
                    Text("Z")
                    Spacer()
                    Text(String(format: "%.2f", fx.az))
                }
                
                Slider(value: $fx.az, in: 0...1, onEditingChanged: {editing in
                    applyFilter(editing)
                })
                    .onChange(of: fx.az) { newValue in
                        applyFilter()
                    }
                
                HStack{
                    Text("W")
                    Spacer()
                    Text(String(format: "%.2f", fx.aw))
                }
                
                Slider(value: $fx.aw, in: 0...1, onEditingChanged: {editing in
                    applyFilter(editing)
                })
                    .onChange(of: fx.aw) { newValue in
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
            //if appSettings.imageRes == "Standard Resolution"
            //{
                //parent.applyFilter()
            //}
        }
        else{
            parent.applyFilter()
        }
    }
    
    func applyFilter() {
        if appSettings.imageRes == "Standard Resolution"
        {
            parent.applyFilter()
        }
    }
    
    func setupViewModel()
    {
        //colorControlsFX.brightness=

    }
}

