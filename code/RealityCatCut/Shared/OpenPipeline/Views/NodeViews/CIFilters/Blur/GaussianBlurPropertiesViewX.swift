//
//  Copyright © 2022 James Boo. All rights reserved.
//


import SwiftUI
@available(iOS 15.0, *)
struct GaussianBlurPropertiesViewX: View, NodeProperties {

    @ObservedObject var gaussianBlurFX: GaussianBlurFX = GaussianBlurFX()
    var parent: FilterPropertiesViewX?

    var body: some View {

        Section(header: Text("Options")){
            HStack{
                Text("Radius")
                Spacer()
                Text(String(format: "%.2f", gaussianBlurFX.radius))
            }
            
        
            Slider(value: $gaussianBlurFX.radius, in: 0...100, onEditingChanged: {editing in
                applyFilter(editing)
            })            
                .onChange(of: gaussianBlurFX.radius) { oldvalue, newValue in
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

