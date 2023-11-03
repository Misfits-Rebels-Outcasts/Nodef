//
//  Copyright © 2022 James Boo. All rights reserved.
//



import SwiftUI


@available(iOS 15.0, *)
struct EdgesPropertiesViewX: View, NodeProperties {

    
    @ObservedObject var fx: EdgesFX = EdgesFX()
    var parent: FilterPropertiesViewX?
    
    var body: some View {

        Section(header: Text("Options")){
            HStack{
                Text("Intensity")
                Spacer()
                Text(String(format: "%.2f", fx.intensity))
            }
            
            Slider(value: $fx.intensity, in: 0...10, onEditingChanged: {editing in
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

