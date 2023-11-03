//
//  Copyright © 2022 James Boo. All rights reserved.
//


import SwiftUI
@available(iOS 15.0, *)

struct ColorChannelsPropertiesViewX: View, NodeProperties {
    

    @ObservedObject var fx: ColorChannelsFX = ColorChannelsFX()
    var parent: FilterPropertiesViewX?

    var body: some View {

        Section(header: Text("Options")){
            HStack{
                Text("Red")
                Spacer()
                Text(String(format: "%.2f", fx.rAmount))
            }
            
            Slider(value: $fx.rAmount, in: 0...1, onEditingChanged: {editing in
                applyFilter(editing)
            })
                .onChange(of: fx.rAmount) {  oldValue, newValue in
                    applyFilter()
                }
            
            HStack{
                Text("Green")
                Spacer()
                Text(String(format: "%.2f", fx.gAmount))
            }
            
            Slider(value: $fx.gAmount, in: 0...1, onEditingChanged: {editing in
                applyFilter(editing)
            })
                .onChange(of: fx.gAmount) {  oldValue, newValue in
                    applyFilter()
                }
            
            HStack{
                Text("Blue")
                Spacer()
                Text(String(format: "%.2f", fx.bAmount))
            }
            
            Slider(value: $fx.bAmount, in: 0...1, onEditingChanged: {editing in
                applyFilter(editing)
            })
                .onChange(of: fx.bAmount) {  oldValue, newValue in
                    applyFilter()
                }
            
            HStack{
                Text("Alpha")
                Spacer()
                Text(String(format: "%.2f", fx.aAmount))
            }
            
            Slider(value: $fx.aAmount, in: 0...1, onEditingChanged: {editing in
                applyFilter(editing)
            })
                .onChange(of: fx.aAmount) {  oldValue, newValue in
                    applyFilter()
                }
        
        }

    }
    


}

