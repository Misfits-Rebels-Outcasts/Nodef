//
//  Copyright © 2022 James Boo. All rights reserved.
//


import SwiftUI
@available(iOS 15.0, *)
struct ColorPosterizePropertiesViewX: View, NodeProperties {


    
    @ObservedObject var fx: ColorPosterizeFX = ColorPosterizeFX()
    var parent: FilterPropertiesViewX?

    var body: some View {

        Section(header: Text("Options")){
            
 
            HStack{
                Text("Levels")
                Spacer()
                Text(String(format: "%.2f", fx.levels))
            }

            Slider(value: $fx.levels, in: 2...30, onEditingChanged: {editing in
                applyFilter(editing)
            })
                .onChange(of: fx.levels) { oldValue, newValue in

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

