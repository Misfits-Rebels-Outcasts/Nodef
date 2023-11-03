//
//  Copyright © 2022 James Boo. All rights reserved.
//


import SwiftUI


@available(iOS 15.0, *)
struct LanczosScaleTransformPropertiesViewX: View, NodeProperties {

    
    @ObservedObject var fx: LanczosScaleTransformFX = LanczosScaleTransformFX()
    var parent: FilterPropertiesViewX?
    var body: some View {

        Section(header: Text("Options")){
            HStack{
                Text("Scale")
                Spacer()
                Text(String(format: "%.2f", fx.scale))
            }
            
            Slider(value: $fx.scale, in: 0.1...1.5, onEditingChanged: {editing in
                applyFilter(editing)
            })
                .onChange(of: fx.scale) { oldValue, newValue in
                    applyFilter()
                }


            HStack{
                Text("Aspect Ratio")
                Spacer()
                Text(String(format: "%.2f", fx.aspectRatio))
            }

            Slider(value: $fx.aspectRatio, in: 0.1...2.0,
                   onEditingChanged: {editing in
                    applyFilter(editing)
                })
                .onChange(of: fx.aspectRatio) { oldValue, newValue in
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

