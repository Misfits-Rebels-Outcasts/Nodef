//
//  Copyright © 2022 James Boo. All rights reserved.
//



import SwiftUI
@available(iOS 15.0, *)
struct FourfoldTranslatedTilePropertiesViewX: View, NodeProperties {

    @ObservedObject var fx: FourfoldTranslatedTileFX = FourfoldTranslatedTileFX()
    var parent: FilterPropertiesViewX?

    var body: some View {

        Section(header: Text("Options")){
            
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


            Slider(value: $fx.centerY, in: 0...Float(fx.size.height), onEditingChanged: {editing in
                applyFilter(editing)
            })
                .onChange(of: fx.centerY) { oldValue, newValue in
                    applyFilter()
            }

            //revisit
            HStack{
                Text("Angle")
                Spacer()
                Text(String(format: "%.0f", round(fx.angle * 180/Float.pi)))
            }

            Slider(value: $fx.angle, in: 0...2*3.14, onEditingChanged: {editing in
                applyFilter(editing)
            })
                .onChange(of: fx.angle) { oldValue, newValue in
                    applyFilter()
                }

            //revisit
            HStack{
                Text("Acute Angle")
                Spacer()
                Text(String(format: "%.0f", round(fx.acuteAngle * 180/Float.pi)))
            }

            Slider(value: $fx.acuteAngle, in: 0...2*3.14, onEditingChanged: {editing in
                applyFilter(editing)
            })
                .onChange(of: fx.acuteAngle) { oldValue, newValue in
                    applyFilter()
                }
            
            HStack{
                Text("Width")
                Spacer()
                Text(String(format: "%.2f", fx.width))
            }
            
   
            Slider(value: $fx.width, in: 1...200, onEditingChanged: {editing in
                applyFilter(editing)
            })
                .onChange(of: fx.width) { oldValue, newValue in
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

