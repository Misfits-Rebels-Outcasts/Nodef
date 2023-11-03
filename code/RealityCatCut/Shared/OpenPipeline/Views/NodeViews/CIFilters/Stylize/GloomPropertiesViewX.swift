//
//  Copyright © 2022 James Boo. All rights reserved.
//



import SwiftUI


@available(iOS 15.0, *)
struct GloomPropertiesViewX: View, NodeProperties {

    
    @ObservedObject var fx: GloomFX = GloomFX()
    var parent: FilterPropertiesViewX?
    
    var body: some View {

        Section(header: Text("Options")){
            HStack{
                Text("Radius")
                Spacer()
                Text(String(format: "%.2f", fx.radius))
            }
            
            Slider(value: $fx.radius, in: 0...100, onEditingChanged: {editing in
                applyFilter(editing)
            })
                .onChange(of: fx.radius) { oldValue, newValue in
                    applyFilter()
                }


            HStack{
                Text("Intensity")
                Spacer()
                Text(String(format: "%.2f", fx.intensity))
            }

            Slider(value: $fx.intensity, in: 0.0...1.0, onEditingChanged: {editing in
                applyFilter(editing)
            })
                .onChange(of: fx.intensity) { oldValue, newValue in
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

