//
//  Copyright © 2022 James Boo. All rights reserved.
//


import SwiftUI
@available(iOS 15.0, *)
struct CheckerboardGeneratorPropertiesViewX: View, NodeProperties {

    @ObservedObject var fx: CheckerboardGeneratorFX = CheckerboardGeneratorFX()
    var parent: FilterPropertiesViewX?

    var body: some View {

        Section(header: Text("Options")){
            
            
            HStack{
                Text("Center X")
                Spacer()
                Text(String(format: "%.2f", fx.centerX))
            }
                        

            Slider(value: $fx.centerX, in: 0...fx.size.width , onEditingChanged: {editing in
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
 
            Slider(value: $fx.centerY, in: 0...fx.size.height, onEditingChanged: {editing in
                applyFilter(editing)
            })
                .onChange(of: fx.centerY) {  oldValue, newValue in
                    applyFilter()
                }

            HStack{
                Text("Color 1")
                Spacer()
                ColorPicker("", selection: $fx.colorx0, supportsOpacity: false)
                  .onChange(of: fx.colorx0) {  oldValue, newValue in
#if targetEnvironment(macCatalyst)
                      fx.color0=CIColor(cgColor: newValue.cgColor!)
#else
                      fx.color0=CIColor(color: UIColor(newValue))
#endif
                      applyFilter()
                  }.frame(width:100, height:30, alignment: .trailing)
            }
            HStack{
                Text("Color 2")
                Spacer()
                ColorPicker("", selection: $fx.colorx1, supportsOpacity: true)
                  .onChange(of: fx.colorx1) {  oldValue, newValue in
#if targetEnvironment(macCatalyst)
                      fx.color1=CIColor(cgColor: newValue.cgColor!)
#else
                      fx.color1=CIColor(color: UIColor(newValue))
#endif
                      applyFilter()
                  }.frame(width:100, height:30, alignment: .trailing)
            }

            
            HStack{
                Text("Sharpness")
                Spacer()
                Text(String(format: "%.2f", fx.sharpness))
            }
 
            Slider(value: $fx.sharpness, in: 0...1, onEditingChanged: {editing in
                applyFilter(editing)
            })
                .onChange(of: fx.sharpness) {  oldValue, newValue in
    
                    applyFilter()
                }

            HStack{
                Text("Width")
                Spacer()
                Text(String(format: "%.2f", fx.width))
            }
            
 
            Slider(value: $fx.width, in: 0...800, onEditingChanged: {editing in
                applyFilter(editing)
            })
                .onChange(of: fx.width) {  oldValue, newValue in
                    //print("id",fx.id)
                    applyFilter()
                }


        }
        .onAppear(perform: setupViewModel)
 
    }

    
    func setupViewModel()
    {
        //colorControlsFX.brightness=

    }
}

