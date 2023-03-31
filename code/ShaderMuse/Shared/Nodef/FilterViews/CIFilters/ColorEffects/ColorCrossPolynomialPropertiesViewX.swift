//
//  Copyright © 2022 James Boo. All rights reserved.
//



import SwiftUI


@available(iOS 15.0, *)
struct ColorCrossPolynomialPropertiesViewX: View {
    @Environment(\.verticalSizeClass) var verticalSizeClass: UserInterfaceSizeClass?
    @Environment(\.horizontalSizeClass) var horizontalSizeClass: UserInterfaceSizeClass?
    @EnvironmentObject var appSettings: AppSettings
    //@EnvironmentObject var pageSettings: PageSettings
    //@EnvironmentObject var shapes: ShapesX
    
    @ObservedObject var fx: ColorCrossPolynomialFX = ColorCrossPolynomialFX()
    var parent: FilterPropertiesViewX
    var body: some View {

        Section(header: Text("Red Coefficients")){
            Group
            {
                HStack{
                    Text("W1")
                    Spacer()
                    Text(String(format: "%.2f", fx.rw1))
                }
                
                Slider(value: $fx.rw1, in: 0...1, onEditingChanged: {editing in
                    applyFilter(editing)
                })
                    .onChange(of: fx.rw1) { newValue in
                        applyFilter()
                    }

                HStack{
                    Text("W2")
                    Spacer()
                    Text(String(format: "%.2f", fx.rw2))
                }
                
                Slider(value: $fx.rw2, in: 0...1, onEditingChanged: {editing in
                    applyFilter(editing)
                })
                    .onChange(of: fx.rw2) { newValue in
                        applyFilter()
                    }
                
                HStack{
                    Text("W3")
                    Spacer()
                    Text(String(format: "%.2f", fx.rw3))
                }
                
                Slider(value: $fx.rw3, in: 0...1, onEditingChanged: {editing in
                    applyFilter(editing)
                })
                    .onChange(of: fx.rw3) { newValue in
                        applyFilter()
                    }
                
                HStack{
                    Text("W4")
                    Spacer()
                    Text(String(format: "%.2f", fx.rw4))
                }
                
                Slider(value: $fx.rw4, in: 0...1, onEditingChanged: {editing in
                    applyFilter(editing)
                })
                    .onChange(of: fx.rw4) { newValue in
                        applyFilter()
                    }
                
                HStack{
                    Text("W5")
                    Spacer()
                    Text(String(format: "%.2f", fx.rw5))
                }
                
                Slider(value: $fx.rw5, in: 0...1, onEditingChanged: {editing in
                    applyFilter(editing)
                })
                    .onChange(of: fx.rw5) { newValue in
                        applyFilter()
                    }
                

            }

            Group
            {
                HStack{
                    Text("W6")
                    Spacer()
                    Text(String(format: "%.2f", fx.rw6))
                }
                
                Slider(value: $fx.rw6, in: 0...1, onEditingChanged: {editing in
                    applyFilter(editing)
                })
                    .onChange(of: fx.rw6) { newValue in
                        applyFilter()
                    }

                HStack{
                    Text("W7")
                    Spacer()
                    Text(String(format: "%.2f", fx.rw7))
                }
                
                Slider(value: $fx.rw7, in: 0...1, onEditingChanged: {editing in
                    applyFilter(editing)
                })
                    .onChange(of: fx.rw7) { newValue in
                        applyFilter()
                    }
                
                HStack{
                    Text("W8")
                    Spacer()
                    Text(String(format: "%.2f", fx.rw8))
                }
                
                Slider(value: $fx.rw8, in: 0...1, onEditingChanged: {editing in
                    applyFilter(editing)
                })
                    .onChange(of: fx.rw8) { newValue in
                        applyFilter()
                    }
                
                HStack{
                    Text("W9")
                    Spacer()
                    Text(String(format: "%.2f", fx.rw9))
                }
                
                Slider(value: $fx.rw9, in: 0...1, onEditingChanged: {editing in
                    applyFilter(editing)
                })
                    .onChange(of: fx.rw9) { newValue in
                        applyFilter()
                    }
                
                HStack{
                    Text("Bias")
                    Spacer()
                    Text(String(format: "%.2f", fx.rb))
                }
                
                Slider(value: $fx.rb, in: 0...1, onEditingChanged: {editing in
                    applyFilter(editing)
                })
                    .onChange(of: fx.rb) { newValue in
                        applyFilter()
                    }
                

            }
        }
        
        Section(header: Text("Green Coefficients")){
            Group
            {
                HStack{
                    Text("W1")
                    Spacer()
                    Text(String(format: "%.2f", fx.gw1))
                }
                
                Slider(value: $fx.gw1, in: 0...1, onEditingChanged: {editing in
                    applyFilter(editing)
                })
                    .onChange(of: fx.gw1) { newValue in
                        applyFilter()
                    }

                HStack{
                    Text("W2")
                    Spacer()
                    Text(String(format: "%.2f", fx.gw2))
                }
                
                Slider(value: $fx.gw2, in: 0...1, onEditingChanged: {editing in
                    applyFilter(editing)
                })
                    .onChange(of: fx.gw2) { newValue in
                        applyFilter()
                    }
                
                HStack{
                    Text("W3")
                    Spacer()
                    Text(String(format: "%.2f", fx.gw3))
                }
                
                Slider(value: $fx.gw3, in: 0...1, onEditingChanged: {editing in
                    applyFilter(editing)
                })
                    .onChange(of: fx.gw3) { newValue in
                        applyFilter()
                    }
                
                HStack{
                    Text("W4")
                    Spacer()
                    Text(String(format: "%.2f", fx.gw4))
                }
                
                Slider(value: $fx.gw4, in: 0...1, onEditingChanged: {editing in
                    applyFilter(editing)
                })
                    .onChange(of: fx.gw4) { newValue in
                        applyFilter()
                    }
                
                HStack{
                    Text("W5")
                    Spacer()
                    Text(String(format: "%.2f", fx.gw5))
                }
                
                Slider(value: $fx.gw5, in: 0...1, onEditingChanged: {editing in
                    applyFilter(editing)
                })
                    .onChange(of: fx.gw5) { newValue in
                        applyFilter()
                    }
                

            }

            Group
            {
                HStack{
                    Text("W6")
                    Spacer()
                    Text(String(format: "%.2f", fx.gw6))
                }
                
                Slider(value: $fx.gw6, in: 0...1, onEditingChanged: {editing in
                    applyFilter(editing)
                })
                    .onChange(of: fx.gw6) { newValue in
                        applyFilter()
                    }

                HStack{
                    Text("W7")
                    Spacer()
                    Text(String(format: "%.2f", fx.gw7))
                }
                
                Slider(value: $fx.gw7, in: 0...1, onEditingChanged: {editing in
                    applyFilter(editing)
                })
                    .onChange(of: fx.gw7) { newValue in
                        applyFilter()
                    }
                
                HStack{
                    Text("W8")
                    Spacer()
                    Text(String(format: "%.2f", fx.gw8))
                }
                
                Slider(value: $fx.gw8, in: 0...1, onEditingChanged: {editing in
                    applyFilter(editing)
                })
                    .onChange(of: fx.gw8) { newValue in
                        applyFilter()
                    }
                
                HStack{
                    Text("W9")
                    Spacer()
                    Text(String(format: "%.2f", fx.gw9))
                }
                
                Slider(value: $fx.gw9, in: 0...1, onEditingChanged: {editing in
                    applyFilter(editing)
                })
                    .onChange(of: fx.gw9) { newValue in
                        applyFilter()
                    }
                
                HStack{
                    Text("Bias")
                    Spacer()
                    Text(String(format: "%.2f", fx.gb))
                }
                
                Slider(value: $fx.gb, in: 0...1, onEditingChanged: {editing in
                    applyFilter(editing)
                })
                    .onChange(of: fx.gb) { newValue in
                        applyFilter()
                    }
                

            }
        }
        
        Section(header: Text("Blue Coefficients")){
            Group
            {
                HStack{
                    Text("W1")
                    Spacer()
                    Text(String(format: "%.2f", fx.bw1))
                }
                
                Slider(value: $fx.bw1, in: 0...1, onEditingChanged: {editing in
                    applyFilter(editing)
                })
                    .onChange(of: fx.bw1) { newValue in
                        applyFilter()
                    }

                HStack{
                    Text("W2")
                    Spacer()
                    Text(String(format: "%.2f", fx.bw2))
                }
                
                Slider(value: $fx.bw2, in: 0...1, onEditingChanged: {editing in
                    applyFilter(editing)
                })
                    .onChange(of: fx.bw2) { newValue in
                        applyFilter()
                    }
                
                HStack{
                    Text("W3")
                    Spacer()
                    Text(String(format: "%.2f", fx.bw3))
                }
                
                Slider(value: $fx.bw3, in: 0...1, onEditingChanged: {editing in
                    applyFilter(editing)
                })
                    .onChange(of: fx.bw3) { newValue in
                        applyFilter()
                    }
                
                HStack{
                    Text("W4")
                    Spacer()
                    Text(String(format: "%.2f", fx.bw4))
                }
                
                Slider(value: $fx.bw4, in: 0...1, onEditingChanged: {editing in
                    applyFilter(editing)
                })
                    .onChange(of: fx.bw4) { newValue in
                        applyFilter()
                    }
                
                HStack{
                    Text("W5")
                    Spacer()
                    Text(String(format: "%.2f", fx.bw5))
                }
                
                Slider(value: $fx.bw5, in: 0...1, onEditingChanged: {editing in
                    applyFilter(editing)
                })
                    .onChange(of: fx.bw5) { newValue in
                        applyFilter()
                    }
                

            }

            Group
            {
                HStack{
                    Text("W6")
                    Spacer()
                    Text(String(format: "%.2f", fx.bw6))
                }
                
                Slider(value: $fx.bw6, in: 0...1, onEditingChanged: {editing in
                    applyFilter(editing)
                })
                    .onChange(of: fx.bw6) { newValue in
                        applyFilter()
                    }

                HStack{
                    Text("W7")
                    Spacer()
                    Text(String(format: "%.2f", fx.bw7))
                }
                
                Slider(value: $fx.bw7, in: 0...1, onEditingChanged: {editing in
                    applyFilter(editing)
                })
                    .onChange(of: fx.bw7) { newValue in
                        applyFilter()
                    }
                
                HStack{
                    Text("W8")
                    Spacer()
                    Text(String(format: "%.2f", fx.bw8))
                }
                
                Slider(value: $fx.bw8, in: 0...1, onEditingChanged: {editing in
                    applyFilter(editing)
                })
                    .onChange(of: fx.bw8) { newValue in
                        applyFilter()
                    }
                
                HStack{
                    Text("W9")
                    Spacer()
                    Text(String(format: "%.2f", fx.bw9))
                }
                
                Slider(value: $fx.bw9, in: 0...1, onEditingChanged: {editing in
                    applyFilter(editing)
                })
                    .onChange(of: fx.bw9) { newValue in
                        applyFilter()
                    }
                
                HStack{
                    Text("Bias")
                    Spacer()
                    Text(String(format: "%.2f", fx.bb))
                }
                
                Slider(value: $fx.bb, in: 0...1, onEditingChanged: {editing in
                    applyFilter(editing)
                })
                    .onChange(of: fx.bb) { newValue in
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

