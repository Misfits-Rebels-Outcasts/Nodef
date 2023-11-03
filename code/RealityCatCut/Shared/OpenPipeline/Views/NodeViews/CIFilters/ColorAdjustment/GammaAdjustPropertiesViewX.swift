//
//  Copyright © 2022 James Boo. All rights reserved.
//


import SwiftUI


@available(iOS 15.0, *)
struct GammaAdjustPropertiesViewX: View, NodeProperties {

    
    @ObservedObject var fx: GammaAdjustFX = GammaAdjustFX()
    var parent: FilterPropertiesViewX?
    var body: some View {

        Section(header: Text("Options")){
            HStack{
                Text("Power")
                Spacer()
                Text(String(format: "%.2f", fx.power))
            }
            

            Slider(value: $fx.power, in: 0.25...4, onEditingChanged: {editing in
                applyFilter(editing)
            })
                .onChange(of: fx.power) { oldValue, newValue in
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

