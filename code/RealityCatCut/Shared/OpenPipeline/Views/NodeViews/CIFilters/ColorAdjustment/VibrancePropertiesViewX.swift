//
//  Copyright © 2022 James Boo. All rights reserved.
//


import SwiftUI


@available(iOS 15.0, *)
struct VibrancePropertiesViewX: View, NodeProperties {

    @ObservedObject var fx: VibranceFX = VibranceFX()
    var parent: FilterPropertiesViewX?
    var body: some View {

        Section(header: Text("Options")){
            HStack{
                Text("Amount")
                Spacer()
                Text(String(format: "%.2f", fx.amount))
            }
            

            Slider(value: $fx.amount, in: -1...1, onEditingChanged: {editing in
                applyFilter(editing)
            })
                .onChange(of: fx.amount) { oldValue, newValue in
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

