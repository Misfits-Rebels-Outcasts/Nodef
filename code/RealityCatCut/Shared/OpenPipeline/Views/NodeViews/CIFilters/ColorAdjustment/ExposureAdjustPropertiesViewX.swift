//
//  Copyright © 2022 James Boo. All rights reserved.
//


import SwiftUI

@available(iOS 15.0, *)
struct ExposureAdjustPropertiesViewX: View, NodeProperties {

    @ObservedObject var fx: ExposureAdjustFX = ExposureAdjustFX()
    var parent: FilterPropertiesViewX?

    var body: some View {

        Section(header: Text("Options")){
            HStack{
                Text("EV")
                Spacer()
                Text(String(format: "%.2f", fx.ev))
            }
            
            /*
            Slider(value: $fx.ev, in: -10...10 )
                .onChange(of: fx.ev) { newValue in
                    //print("id",colorControlsFX.id)
                    applyFilter()
                }
             */
            Slider(value: $fx.ev, in: -10...10 , onEditingChanged: {editing in
                print(editing)
                applyFilter(editing)
            })
                .onChange(of: fx.ev) {  oldValue, newValue in
                    //print("id",colorControlsFX.id)
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

