//
//  Copyright © 2022 James Boo. All rights reserved.
//


import SwiftUI
@available(iOS 15.0, *)
struct ColorCubePropertiesViewX: View, NodeProperties {

    
    @ObservedObject var fx: ColorCubeFX = ColorCubeFX()
    var parent: FilterPropertiesViewX?

    var body: some View {

        Section(header: Text("Options")){
            HStack{
                Text("Remove Color")
                Spacer()
                ColorPicker("", selection: $fx.colorx, supportsOpacity: true)
                  .onChange(of: fx.colorx) {  oldValue, newValue in
#if targetEnvironment(macCatalyst)
                      fx.color=CIColor(cgColor: newValue.cgColor!)
#else
                      fx.color=CIColor(color: UIColor(newValue))
#endif
                      fx.colorChange=true
                      applyFilter()
                  }.frame(width:100, height:30, alignment: .trailing)
            }
            
            HStack{
                Text("Closeness")
                Spacer()
                Text(String(format: "%.2f", fx.closeness))
            }

            Slider(value: $fx.closeness, in: 0...0.4, onEditingChanged: {editing in
                if editing == false{
                    fx.colorChange=true
                    applyFilter(editing)
                }
            })
                .onChange(of: fx.closeness) {  oldValue, newValue in

                    //applyFilter()
                }
 /*
            HStack{
                Text("Hue Radians")
                Spacer()
                Text(String(format: "%.2f", fx.hueRadian))
            }

            Slider(value: $fx.hueRadian, in: 0...2*3.14, onEditingChanged: {editing in
                if editing == false{
                    fx.colorChange=true
                    applyFilter(editing)
                }
            })
                .onChange(of: fx.hueRadian) { newValue in

                    //applyFilter()
                }
*/
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

