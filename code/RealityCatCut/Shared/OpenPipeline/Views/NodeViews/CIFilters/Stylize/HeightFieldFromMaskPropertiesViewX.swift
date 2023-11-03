//
//  Copyright © 2022 James Boo. All rights reserved.
//


import SwiftUI
@available(iOS 15.0, *)
struct HeightFieldFromMaskPropertiesViewX: View, NodeProperties {

    
    @ObservedObject var fx: HeightFieldFromMaskFX = HeightFieldFromMaskFX()
    var parent: FilterPropertiesViewX?

    var body: some View {

        Section(header: Text("Options")){
                  
            HStack{
                Text("Radius")
                Spacer()
                Text(String(format: "%.2f", fx.radius))
            }

            Slider(value: $fx.radius, in: 0...10, onEditingChanged: {editing in
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

