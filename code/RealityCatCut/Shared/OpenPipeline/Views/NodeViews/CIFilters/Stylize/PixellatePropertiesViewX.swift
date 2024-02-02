//
//  Copyright © 2022 James Boo. All rights reserved.
//


import SwiftUI


@available(iOS 15.0, *)
struct PixellatePropertiesViewX: View, NodeProperties {

    
    @ObservedObject var fx: PixellateFX = PixellateFX()
    var parent: FilterPropertiesViewX?
    
    var body: some View {

        Section(header: Text("Options")){
            HStack{
                Text("Scale")
                Spacer()
                Text(String(format: "%.2f", fx.scale))
            }
            
            Slider(value: $fx.scale, in: 1...100, onEditingChanged: {editing in
                applyFilter(editing)
            })
                .onChange(of: fx.scale) { oldValue, newValue in
                    applyFilter()
                }

            HStack{
                Text("Center X")
                Spacer()
                Text(String(format: "%.2f", fx.centerX))
            }
 
            Slider(value: $fx.centerX, in: 0...Float(fx.size.width), onEditingChanged: {editing in
                applyFilter(editing)
            })
                .onChange(of: fx.centerX) { oldValue, newValue in
                    applyFilter()
                }

            HStack{
                Text("Center Y")
                Spacer()
                Text(String(format: "%.2f", fx.centerY))
            }
   
            Slider(value: $fx.centerY, in: 0...Float(fx.size.height) , onEditingChanged: {editing in
                applyFilter(editing)
            })
                .onChange(of: fx.centerY) { oldValue, newValue in
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
