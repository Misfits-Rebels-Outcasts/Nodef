//
//  Copyright © 2022 James Boo. All rights reserved.
//


import SwiftUI


@available(iOS 15.0, *)
struct ColorPolynomialPropertiesViewX: View, NodeProperties {

    
    @ObservedObject var fx: ColorPolynomialFX = ColorPolynomialFX()
    var parent: FilterPropertiesViewX?
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
                    .onChange(of: fx.rx) {  oldValue, newValue in
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
                    .onChange(of: fx.ry) {  oldValue, newValue in
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
                    .onChange(of: fx.rz) {  oldValue, newValue in
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
                    .onChange(of: fx.rw) {  oldValue, newValue in
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
                    .onChange(of: fx.gx) {  oldValue, newValue in
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
                    .onChange(of: fx.gy) {  oldValue, newValue in
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
                    .onChange(of: fx.gz) {  oldValue, newValue in
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
                    .onChange(of: fx.gw) {  oldValue, newValue in
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
                    .onChange(of: fx.bx) {  oldValue, newValue in
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
                    .onChange(of: fx.by) {  oldValue, newValue in
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
                    .onChange(of: fx.bz) {  oldValue, newValue in
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
                    .onChange(of: fx.bw) {  oldValue, newValue in
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
                    .onChange(of: fx.ax) {  oldValue, newValue in
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
                    .onChange(of: fx.ay) {  oldValue, newValue in
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
                    .onChange(of: fx.az) {  oldValue, newValue in
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
                    .onChange(of: fx.aw) {  oldValue, newValue in
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

