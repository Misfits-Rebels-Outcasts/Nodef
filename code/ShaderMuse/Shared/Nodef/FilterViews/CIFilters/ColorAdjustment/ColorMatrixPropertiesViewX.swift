//
//  Copyright © 2022 James Boo. All rights reserved.
//


import SwiftUI


@available(iOS 15.0, *)
struct ColorMatrixPropertiesViewX: View {
    @Environment(\.verticalSizeClass) var verticalSizeClass: UserInterfaceSizeClass?
    @Environment(\.horizontalSizeClass) var horizontalSizeClass: UserInterfaceSizeClass?
    @EnvironmentObject var appSettings: AppSettings
    //@EnvironmentObject var pageSettings: PageSettings
    //@EnvironmentObject var shapes: ShapesX
    
    @ObservedObject var fx: ColorMatrixFX = ColorMatrixFX()
    var parent: FilterPropertiesViewX
    var body: some View {

        Section(header: Text("Red Vector")){
            Group
            {
                HStack{
                    Text("R-Vector X")
                    Spacer()
                    Text(String(format: "%.2f", fx.rx))
                }
                
                Slider(value: $fx.rx, in: -1...1, onEditingChanged: {editing in
                    applyFilter(editing)
                })
                    .onChange(of: fx.rx) { newValue in
                        applyFilter()
                    }
                
                HStack{
                    Text("R-Vector Y")
                    Spacer()
                    Text(String(format: "%.2f", fx.ry))
                }
                
                Slider(value: $fx.ry, in: -1...1, onEditingChanged: {editing in
                    applyFilter(editing)
                })
                    .onChange(of: fx.ry) { newValue in
                        applyFilter()
                    }

                HStack{
                    Text("R-Vector Z")
                    Spacer()
                    Text(String(format: "%.2f", fx.rz))
                }
                
                Slider(value: $fx.rz, in: -1...1, onEditingChanged: {editing in
                    applyFilter(editing)
                })
                    .onChange(of: fx.rz) { newValue in
                        applyFilter()
                    }
                
                HStack{
                    Text("R-Vector W")
                    Spacer()
                    Text(String(format: "%.2f", fx.rw))
                }
                
                Slider(value: $fx.rw, in: -1...1, onEditingChanged: {editing in
                    applyFilter(editing)
                })
                    .onChange(of: fx.rw) { newValue in
                        applyFilter()
                    }
            }

        }
        
        Section(header: Text("Green Vector")){
            Group
            {
                HStack{
                    Text("G-Vector X")
                    Spacer()
                    Text(String(format: "%.2f", fx.gx))
                }
                
                Slider(value: $fx.gx, in: -1...1, onEditingChanged: {editing in
                    applyFilter(editing)
                })
                    .onChange(of: fx.gx) { newValue in
                        applyFilter()
                    }
                
                HStack{
                    Text("G-Vector Y")
                    Spacer()
                    Text(String(format: "%.2f", fx.gy))
                }
                
                Slider(value: $fx.gy, in: -1...1, onEditingChanged: {editing in
                    applyFilter(editing)
                })
                    .onChange(of: fx.gy) { newValue in
                        applyFilter()
                    }

                HStack{
                    Text("G-Vector Z")
                    Spacer()
                    Text(String(format: "%.2f", fx.gz))
                }
                
                Slider(value: $fx.gz, in: -1...1, onEditingChanged: {editing in
                    applyFilter(editing)
                })
                    .onChange(of: fx.gz) { newValue in
                        applyFilter()
                    }
                
                HStack{
                    Text("G-Vector W")
                    Spacer()
                    Text(String(format: "%.2f", fx.gw))
                }
                
                Slider(value: $fx.gw, in: -1...1, onEditingChanged: {editing in
                    applyFilter(editing)
                })
                    .onChange(of: fx.gw) { newValue in
                        applyFilter()
                    }
            }

        }
        
        Section(header: Text("Blue Vector")){
            Group
            {
                HStack{
                    Text("B-Vector X")
                    Spacer()
                    Text(String(format: "%.2f", fx.bx))
                }
                
                Slider(value: $fx.bx, in: -1...1, onEditingChanged: {editing in
                    applyFilter(editing)
                })
                    .onChange(of: fx.bx) { newValue in
                        applyFilter()
                    }
                
                HStack{
                    Text("B-Vector Y")
                    Spacer()
                    Text(String(format: "%.2f", fx.by))
                }
                
                Slider(value: $fx.by, in: -1...1, onEditingChanged: {editing in
                    applyFilter(editing)
                })
                    .onChange(of: fx.by) { newValue in
                        applyFilter()
                    }

                HStack{
                    Text("B-Vector Z")
                    Spacer()
                    Text(String(format: "%.2f", fx.bz))
                }
                
                Slider(value: $fx.bz, in: -1...1, onEditingChanged: {editing in
                    applyFilter(editing)
                })
                    .onChange(of: fx.bz) { newValue in
                        applyFilter()
                    }
                
                HStack{
                    Text("B-Vector W")
                    Spacer()
                    Text(String(format: "%.2f", fx.bw))
                }
                
                Slider(value: $fx.bw, in: -1...1, onEditingChanged: {editing in
                    applyFilter(editing)
                })
                    .onChange(of: fx.bw) { newValue in
                        applyFilter()
                    }
            }
            
        }
        
        Section(header: Text("Alpha Vector")){
            Group
            {
                HStack{
                    Text("A-Vector X")
                    Spacer()
                    Text(String(format: "%.2f", fx.ax))
                }
                
                Slider(value: $fx.ax, in: -1...1, onEditingChanged: {editing in
                    applyFilter(editing)
                })
                    .onChange(of: fx.ax) { newValue in
                        applyFilter()
                    }
                
                HStack{
                    Text("A-Vector Y")
                    Spacer()
                    Text(String(format: "%.2f", fx.ay))
                }
                
                Slider(value: $fx.ay, in: -1...1, onEditingChanged: {editing in
                    applyFilter(editing)
                })
                    .onChange(of: fx.ay) { newValue in
                        applyFilter()
                    }

                HStack{
                    Text("A-Vector Z")
                    Spacer()
                    Text(String(format: "%.2f", fx.az))
                }
                
                Slider(value: $fx.az, in: -1...1, onEditingChanged: {editing in
                    applyFilter(editing)
                })
                    .onChange(of: fx.az) { newValue in
                        applyFilter()
                    }
                
                HStack{
                    Text("A-Vector W")
                    Spacer()
                    Text(String(format: "%.2f", fx.aw))
                }
                
                Slider(value: $fx.aw, in: -1...1, onEditingChanged: {editing in
                    applyFilter(editing)
                })
                    .onChange(of: fx.aw) { newValue in
                        applyFilter()
                    }
            }
            
        }
        
        Section(header: Text("Bias Vector")){
            Group
            {
                HStack{
                    Text("Bias-Vector X")
                    Spacer()
                    Text(String(format: "%.2f", fx.biasx))
                }
                
                Slider(value: $fx.biasx, in: -1...1, onEditingChanged: {editing in
                    applyFilter(editing)
                })
                    .onChange(of: fx.biasx) { newValue in
                        applyFilter()
                    }
                
                HStack{
                    Text("Bias-Vector Y")
                    Spacer()
                    Text(String(format: "%.2f", fx.biasy))
                }
                
                Slider(value: $fx.biasy, in: -1...1, onEditingChanged: {editing in
                    applyFilter(editing)
                })
                    .onChange(of: fx.biasy) { newValue in
                        applyFilter()
                    }

                HStack{
                    Text("Bias-Vector Z")
                    Spacer()
                    Text(String(format: "%.2f", fx.biasz))
                }
                
                Slider(value: $fx.biasz, in: -1...1, onEditingChanged: {editing in
                    applyFilter(editing)
                })
                    .onChange(of: fx.biasz) { newValue in
                        applyFilter()
                    }
                
                HStack{
                    Text("Bias-Vector W")
                    Spacer()
                    Text(String(format: "%.2f", fx.biasw))
                }
                
                Slider(value: $fx.biasw, in: -1...1, onEditingChanged: {editing in
                    applyFilter(editing)
                })
                    .onChange(of: fx.biasw) { newValue in
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

