//
//  Copyright © 2022 James Boo. All rights reserved.
//



import SwiftUI
@available(iOS 15.0, *)
struct VignetteEffectPropertiesViewX: View, NodeProperties {


    
    @ObservedObject var fx: VignetteEffectFX = VignetteEffectFX()
    var parent: FilterPropertiesViewX?

    var body: some View {

        Section(header: Text("Options")){
            
            HStack{
                Text("Center X")
                Spacer()
                Text(String(format: "%.2f", fx.centerX))
            }
                        
            Slider(value: $fx.centerX, in: 0...fx.size.width , onEditingChanged: {editing in
                applyFilter(editing)
            })
                .onChange(of: fx.centerX) { oldValue, newValue in
                    applyFilter()
                }

            HStack{
                Text("Center Y")
                Spacer()
                Text(String(format: "%.2f", fx.centerY))
            }
   
            Slider(value: $fx.centerY, in: 0...fx.size.height, onEditingChanged: {editing in
                applyFilter(editing)
            })
                .onChange(of: fx.centerY) { oldValue, newValue in
                    applyFilter()
                }

            HStack{
                Text("Intensity")
                Spacer()
                Text(String(format: "%.2f", fx.intensity))
            }

            Slider(value: $fx.intensity, in: -1...1, onEditingChanged: {editing in
                applyFilter(editing)
            })
                .onChange(of: fx.intensity) { oldValue, newValue in

                    applyFilter()
                }

            HStack{
                Text("Radius")
                Spacer()
                Text(String(format: "%.2f", fx.radius))
            }

            Slider(value: $fx.radius, in: 0...2000, onEditingChanged: {editing in
                applyFilter(editing)
            })
                .onChange(of: fx.radius) { oldValue, newValue in

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

