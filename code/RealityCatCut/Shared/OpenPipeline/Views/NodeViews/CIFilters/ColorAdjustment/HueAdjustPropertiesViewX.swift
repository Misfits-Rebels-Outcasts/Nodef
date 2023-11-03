//
//  Copyright © 2022 James Boo. All rights reserved.
//


import SwiftUI


@available(iOS 15.0, *)
struct HueAdjustPropertiesViewX: View, NodeProperties {

    
    @ObservedObject var fx: HueAdjustFX = HueAdjustFX()
    var parent: FilterPropertiesViewX?
    var body: some View {

        Section(header: Text("Options")){
            HStack{
                Text("Angle")
                Spacer()
                Text(String(format: "%.0f", round(fx.angle * 180/Float.pi)))
            }
            

            Slider(value: $fx.angle, in: 0...2*3.14, onEditingChanged: {editing in
                applyFilter(editing)
            })
                .onChange(of: fx.angle) { oldValue, newValue in
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

