//
//  Copyright © 2022 James Boo. All rights reserved.
//


import SwiftUI


@available(iOS 15.0, *)
struct OpacityPropertiesViewX: View, NodeProperties {

    
    @ObservedObject var fx: OpacityFX = OpacityFX()
    var parent: FilterPropertiesViewX?
    
    var body: some View {

        Section(header: Text("Options")){
            HStack{
                Text("Opacity")
                Spacer()
                Text(String(format: "%.2f", fx.aw))
            }
            

            Slider(value: $fx.aw, in: 0.0...1.0, onEditingChanged: {editing in
                applyFilter(editing)
            })
                .onChange(of: fx.aw) { oldValue, newValue in
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

