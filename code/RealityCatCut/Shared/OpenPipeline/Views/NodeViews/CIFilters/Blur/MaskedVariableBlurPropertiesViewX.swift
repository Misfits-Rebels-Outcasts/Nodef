//
//  Copyright © 2022 James Boo. All rights reserved.
//


import SwiftUI


@available(iOS 15.0, *)
struct MaskedVariableBlurPropertiesViewX: View, NodeProperties {

    @ObservedObject var fx: MaskedVariableBlurFX = MaskedVariableBlurFX()
    @ObservedObject var filterPropertiesViewModel: FilterPropertiesViewModel
    @ObservedObject var filtersPropertiesViewModel: FiltersPropertiesViewModel

    
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
                    //print("id",fx.id)
                    applyFilter()
                }
            
             
        }
  
    }
    

    
    func setupViewModel()
    {
        //colorControlsFX.brightness=

    }
}

