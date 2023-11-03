//
//  Copyright © 2022 James Boo. All rights reserved.
//


import SwiftUI
@available(iOS 15.0, *)
struct CircularWrapPropertiesViewX: View, NodeProperties {

    @ObservedObject var fx: CircularWrapFX = CircularWrapFX()
    var parent: FilterPropertiesViewX?

    var body: some View {

        Section(header: Text("Options")){
            
            HStack{
                Text("Center X")
                Spacer()
                Text(String(format: "%.2f", fx.centerX))
            }
                   
            /*
            Slider(value: $fx.centerX, in: 0...fx.size.width )
                .onChange(of: fx.centerX) { newValue in
                    applyFilter()
                }
             */
            Slider(value: $fx.centerX, in: 0...fx.size.width, onEditingChanged: {editing in
                applyFilter(editing)
            })
                .onChange(of: fx.centerX) {  oldValue, newValue in
                    applyFilter()
                }


            HStack{
                Text("Center Y")
                Spacer()
                Text(String(format: "%.2f", fx.centerY))
            }

            /*
            Slider(value: $fx.centerY, in: 0...fx.size.height )
                .onChange(of: fx.centerY) { newValue in
                    applyFilter()
            }
             */
            Slider(value: $fx.centerY, in: 0...fx.size.height, onEditingChanged: {editing in
                applyFilter(editing)
            })
                .onChange(of: fx.centerY) {  oldValue, newValue in
                    applyFilter()
            }


            HStack{
                Text("Radius")
                Spacer()
                Text(String(format: "%.2f", fx.radius))
            }
            
            /*
            Slider(value: $fx.radius, in: 0...500 )
                .onChange(of: fx.radius) { newValue in
                    applyFilter()
                }
             */
            Slider(value: $fx.radius, in: 0...500, onEditingChanged: {editing in
                applyFilter(editing)
            })
                .onChange(of: fx.radius) {  oldValue, newValue in
                    applyFilter()
                }

            HStack{
                Text("Angle")
                Spacer()
                Text(String(format: "%.0f", round(fx.angle * 180/Float.pi)))
            }
            
            /*
            Slider(value: $fx.angle, in: 0...2*3.14 )
                .onChange(of: fx.angle) { newValue in
                    applyFilter()
                }
            */
            Slider(value: $fx.angle, in: 0...2*3.14, onEditingChanged: {editing in
                applyFilter(editing)
            })
                .onChange(of: fx.angle) {  oldValue, newValue in
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

