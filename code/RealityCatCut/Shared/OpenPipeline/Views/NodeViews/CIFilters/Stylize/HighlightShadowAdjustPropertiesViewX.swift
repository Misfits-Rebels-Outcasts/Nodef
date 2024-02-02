//
//  Copyright © 2022 James Boo. All rights reserved.
//


import SwiftUI


@available(iOS 15.0, *)
struct HighlightShadowAdjustPropertiesViewX: View, NodeProperties {

    
    @ObservedObject var fx: HighlightShadowAdjustFX = HighlightShadowAdjustFX()
    var parent: FilterPropertiesViewX?
    
    var body: some View {

        Section(header: Text("Options")){
            HStack{
                Text("Highlight Amount")
                
                Spacer()
                Text(String(format: "%.2f", fx.highlightAmount))
            }
            //revisit no range provided bby apple
            Slider(value: $fx.highlightAmount, in: -1.0...1.0, onEditingChanged: {editing in
                applyFilter(editing)
            })
                .onChange(of: fx.highlightAmount) { oldValue, newValue in
                    applyFilter()
                }

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
                Text("Shadow Amount")
                Spacer()
                Text(String(format: "%.2f", fx.shadowAmount))
            }

            Slider(value: $fx.shadowAmount, in: -1.0...1.0, onEditingChanged: {editing in
                applyFilter(editing)
            })
                .onChange(of: fx.shadowAmount) { oldValue, newValue in
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
