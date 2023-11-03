//
//  Copyright © 2022 James Boo. All rights reserved.
//



import SwiftUI
@available(iOS 15.0, *)
struct MotionBlurPropertiesViewX: View, NodeProperties {

    @ObservedObject var fx: MotionBlurFX = MotionBlurFX()
    var parent: FilterPropertiesViewX?

    var body: some View {

        Section(header: Text("Options")){
            
            HStack{
                Text("Radius")
                Spacer()
                Text(String(format: "%.2f", fx.radius))
            }
            /*
            Slider(value: $fx.radius, in: 0...100 )
                .onChange(of: fx.radius) { newValue in
                    applyFilter()
                }
             */
            Slider(value: $fx.radius, in: 0...100, onEditingChanged: {editing in
                applyFilter(editing)
            })
                .onChange(of: fx.radius) { oldValue, newValue in
                    applyFilter()
                }

            HStack{
                Text("Angle")
                Spacer()
                Text(String(format: "%.0f", round(fx.angle * 180/Float.pi)))
            }
            
            /*
            Slider(value: $fx.angle, in: 0...2*3.14 ) //revisit
                .onChange(of: fx.angle) { newValue in
                    applyFilter()
                }
             */
            Slider(value: $fx.angle, in: 0...2*3.14, onEditingChanged: {editing in
                applyFilter(editing)
            })
                .onChange(of: fx.angle) { oldValue, newValue in
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

