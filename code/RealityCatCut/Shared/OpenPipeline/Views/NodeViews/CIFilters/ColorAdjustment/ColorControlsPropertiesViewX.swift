//
//  Copyright © 2022 James Boo. All rights reserved.
//


import SwiftUI


@available(iOS 15.0, *)
struct ColorControlsPropertiesViewX: View, NodeProperties {

    
    @ObservedObject var colorControlsFX: ColorControlsFX = ColorControlsFX()
    var parent: FilterPropertiesViewX?
    var body: some View {

        Section(header: Text("Options")){
            HStack{
                Text("Brightness")
                Spacer()
                Text(String(format: "%.2f", colorControlsFX.brightness))
            }
            
            /*
             Slider(value: $colorControlsFX.brightness, in: -1...1 )
                .onChange(of: colorControlsFX.brightness) { newValue in
                    print("id",colorControlsFX.id)
                    applyFilter()
                }
             */
            Slider(value: $colorControlsFX.brightness, in: -1...1, onEditingChanged: {editing in
                applyFilter(editing)
            })
                .onChange(of: colorControlsFX.brightness) {  oldValue, newValue in
                    applyFilter()
                }


            HStack{
                Text("Contrast")
                Spacer()
                Text(String(format: "%.2f", colorControlsFX.contrast))
            }
            /*
            Slider(value: $colorControlsFX.contrast, in: 0.25...4 )
                .onChange(of: colorControlsFX.contrast) { newValue in
                applyFilter()
            }
             */
            Slider(value: $colorControlsFX.contrast, in: 0.25...4, onEditingChanged: {editing in
                applyFilter(editing)
            })
                .onChange(of: colorControlsFX.contrast) {  oldValue, newValue in
                    applyFilter()
                }

            HStack{
                Text("Saturation")
                Spacer()
                Text(String(format: "%.2f", colorControlsFX.saturation))
            }
            /*
            Slider(value: $colorControlsFX.saturation, in: 0...2 )
                .onChange(of: colorControlsFX.saturation) { newValue in
                    applyFilter()
                }
             */
            Slider(value: $colorControlsFX.saturation, in: 0...2, onEditingChanged: {editing in
                applyFilter(editing)
            })
                .onChange(of: colorControlsFX.saturation) {  oldValue, newValue in
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

