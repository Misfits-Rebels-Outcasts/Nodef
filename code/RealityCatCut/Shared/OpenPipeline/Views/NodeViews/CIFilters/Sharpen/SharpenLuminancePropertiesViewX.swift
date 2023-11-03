//
//  Copyright © 2022 James Boo. All rights reserved.
//


import SwiftUI
@available(iOS 15.0, *)
struct SharpenLuminancePropertiesViewX: View, NodeProperties {

    @ObservedObject var fx: SharpenLuminanceFX = SharpenLuminanceFX()
    var parent: FilterPropertiesViewX?

    var body: some View {

        Section(header: Text("Options")){
            HStack{
                Text("Radius")
                Spacer()
                Text(String(format: "%.2f", fx.radius))
            }
            /*
            Slider(value: $fx.radius, in: 0...20 )
                .onChange(of: fx.radius) { newValue in
                    applyFilter()
                }
             */
            Slider(value: $fx.radius, in: 0...20, onEditingChanged: {editing in
                applyFilter(editing)
            })
                .onChange(of: fx.radius) { oldValue, newValue in
                    applyFilter()
                }


            HStack{
                Text("Sharpness")
                Spacer()
                Text(String(format: "%.2f", fx.sharpness))
            }
            
            /*
            Slider(value: $fx.sharpness, in: 0...2 )
                .onChange(of: fx.sharpness) { newValue in
                    applyFilter()
                }
             */
            Slider(value: $fx.sharpness, in: 0...2, onEditingChanged: {editing in
                applyFilter(editing)
            })
                .onChange(of: fx.sharpness) { oldValue, newValue in
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

