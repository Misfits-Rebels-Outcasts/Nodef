//
//  Copyright © 2022 James Boo. All rights reserved.
//


import SwiftUI
@available(iOS 15.0, *)
struct GlassLozengePropertiesViewX: View, NodeProperties {
 
    
    @ObservedObject var fx: GlassLozengeFX = GlassLozengeFX()
    var parent: FilterPropertiesViewX?

    var body: some View {

        Section(header: Text("Image Lens Portion")){
            
            Group{
                HStack{
                    Text("Point 1 - X")
                    Spacer()
                    Text(String(format: "%.2f", fx.pointX0))
                }
                        
                Slider(value: $fx.pointX0, in: 0...Float(fx.size.width), onEditingChanged: {editing in
                    applyFilter(editing)
                })
                    .onChange(of: fx.pointX0) { oldValue, newValue in
                        applyFilter()
                    }
                HStack{
                    Text("Point 1 - Y")
                    Spacer()
                    Text(String(format: "%.2f", fx.pointY0))
                }
       
                Slider(value: $fx.pointY0, in: 0...Float(fx.size.height), onEditingChanged: {editing in
                    applyFilter(editing)
                })
                    .onChange(of: fx.pointY0) { oldValue, newValue in
                        applyFilter()
                    }
            }
        
            Group{
                HStack{
                    Text("Point 2 - X")
                    Spacer()
                    Text(String(format: "%.2f", fx.pointX1))
                }
                        
                Slider(value: $fx.pointX1, in: 0...Float(fx.size.width), onEditingChanged: {editing in
                    applyFilter(editing)
                })
                    .onChange(of: fx.pointX1) { oldValue, newValue in
                        applyFilter()
                    }
                HStack{
                    Text("Point 2 - Y")
                    Spacer()
                    Text(String(format: "%.2f", fx.pointY1))
                }
                
                Slider(value: $fx.pointY1, in: 0...Float(fx.size.height), onEditingChanged: {editing in
                    applyFilter(editing)
                })
                    .onChange(of: fx.pointY1) { oldValue, newValue in
                        applyFilter()
                }

            }
                        
        }
        Section(header: Text("Options")){
            
            HStack{
                Text("Radius")
                Spacer()
                Text(String(format: "%.2f", fx.radius))
            }

            Slider(value: $fx.radius, in: 0...1000, onEditingChanged: {editing in
                applyFilter(editing)
            })
                .onChange(of: fx.radius) { oldValue, newValue in
                    applyFilter()
                }
            
            HStack{
                Text("Refraction")
                Spacer()
                Text(String(format: "%.2f", fx.refraction))
            }

            Slider(value: $fx.refraction, in: 0...5, onEditingChanged: {editing in
                applyFilter(editing)
            })
                .onChange(of: fx.refraction) { oldValue, newValue in
                    applyFilter()
                }
            
           
        }
        .onAppear(perform: setupViewModel)
        //Section(header: Text(""), footer: Text("")){
        //}
    }
    

    

    func setupViewModel()
    {
        //colorControlsFX.brightness=

    }
}

