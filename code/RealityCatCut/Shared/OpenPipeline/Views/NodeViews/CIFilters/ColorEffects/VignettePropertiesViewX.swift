//
//  Copyright © 2022 James Boo. All rights reserved.
//


import SwiftUI
@available(iOS 15.0, *)
struct VignettePropertiesViewX: View, NodeProperties {

    var colors=["black","blue","clear","cyan","gray","green","magenta","red","yellow","white"]
    
    @ObservedObject var fx: VignetteFX = VignetteFX()
    var parent: FilterPropertiesViewX?

    var body: some View {

        Section(header: Text("Options")){
            
 
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

            Slider(value: $fx.radius, in: 0...2, onEditingChanged: {editing in
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

