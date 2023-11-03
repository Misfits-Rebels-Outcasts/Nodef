//
//  Copyright © 2022 James Boo. All rights reserved.
//


import SwiftUI


@available(iOS 15.0, *)
struct TemperatureAndTintPropertiesViewX: View, NodeProperties {

    @ObservedObject var fx: TemperatureAndTintFX = TemperatureAndTintFX()
    var parent: FilterPropertiesViewX?
    var body: some View {

        Section(header: Text("Neutral")){
            Group
            {
                HStack{
                    Text("Neutral Temperature")
                    Spacer()
                    Text(String(format: "%.2f", fx.neutralTemperature))
                }
                
                Slider(value: $fx.neutralTemperature, in: 6500-6500...6500+5500, onEditingChanged: {editing in
                    applyFilter(editing)
                })
                    .onChange(of: fx.neutralTemperature) { oldValue, newValue in
                        applyFilter()
                    }
                
                HStack{
                    Text("Neutral Tint")
                    Spacer()
                    Text(String(format: "%.2f", fx.neutralTint))
                }
                
                Slider(value: $fx.neutralTint, in: -100...100, onEditingChanged: {editing in
                    applyFilter(editing)
                })
                    .onChange(of: fx.neutralTint) { oldValue, newValue in
                        applyFilter()
                    }
            }
        }
        
        Section(header: Text("Target Neutral")){
            Group
            {
                HStack{
                    Text("Target Neutral Temperature")
                    Spacer()
                    Text(String(format: "%.2f", fx.targetNeutralTemperature))
                }
                
                Slider(value: $fx.targetNeutralTemperature, in: 6500-6500...6500+5500, onEditingChanged: {editing in
                    applyFilter(editing)
                })
                    .onChange(of: fx.targetNeutralTemperature) { oldValue, newValue in
                        applyFilter()
                    }
                
                HStack{
                    Text("Target Neutral Tint")
                    Spacer()
                    Text(String(format: "%.2f", fx.targetNeutralTint))
                }
                
                Slider(value: $fx.targetNeutralTint, in: -100...100, onEditingChanged: {editing in
                    applyFilter(editing)
                })
                    .onChange(of: fx.targetNeutralTint) { oldValue, newValue in
                        applyFilter()
                    }
            }
        }
    
/*
        Section(header: Text("Options")){
            
            
          
           
           
        }
        .onAppear(perform: setupViewModel)
 */
        //Section(header: Text(""), footer: Text("")){
        //}
    }
    

    
    func setupViewModel()
    {
        //colorControlsFX.brightness=

    }
}

