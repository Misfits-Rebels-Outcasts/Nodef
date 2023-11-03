//
//  Copyright © 2022 James Boo. All rights reserved.
//



import SwiftUI
@available(iOS 15.0, *)
struct CircularScreenPropertiesViewX: View, NodeProperties {

    @ObservedObject var fx: CircularScreenFX = CircularScreenFX()
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

            /*
            Slider(value: $fx.centerY, in: 0...fx.size.height )
                .onChange(of: fx.centerY) { newValue in
                    applyFilter()
            }
             */
            Slider(value: $fx.centerY, in: 0...Float(fx.size.height), onEditingChanged: {editing in
                applyFilter(editing)
            })
                .onChange(of: fx.centerY) { oldValue, newValue in
                    applyFilter()
            }
            HStack{
                Text("Width")
                Spacer()
                Text(String(format: "%.2f", fx.width))
            }
            
            /*
            Slider(value: $fx.width, in: 2...50 )
                .onChange(of: fx.width) { newValue in
                    applyFilter()
                }
             */
            Slider(value: $fx.width, in: 2...50, onEditingChanged: {editing in
                applyFilter(editing)
            })
                .onChange(of: fx.width) { oldValue, newValue in
                    applyFilter()
                }

            HStack{
                Text("Sharpness")
                Spacer()
                Text(String(format: "%.2f", fx.sharpness))
            }
            /*
            Slider(value: $fx.sharpness, in: 0...1 )
                .onChange(of: fx.sharpness) { newValue in
                    applyFilter()
                }
             */
            Slider(value: $fx.sharpness, in: 0...1, onEditingChanged: {editing in
                applyFilter(editing)
            })
                .onChange(of: fx.sharpness) { oldValue, newValue in
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

