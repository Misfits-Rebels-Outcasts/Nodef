//
//  Copyright © 2022 James Boo. All rights reserved.
//



import SwiftUI
@available(iOS 15.0, *)
struct AreaMaximumAlphaPropertiesViewX: View, NodeProperties {

    
    @ObservedObject var fx: AreaMaximumAlphaFX = AreaMaximumAlphaFX()
    var parent: FilterPropertiesViewX?

    var body: some View {

        Section(header: Text("Region of Interest")){
            
            Group{
                HStack{
                    Text("X")
                    Spacer()
                    Text(String(format: "%.2f", fx.x))
                }
                            
                Slider(value: $fx.x, in: 0...Float(fx.size.width), onEditingChanged: {editing in
                    applyFilter(editing)
                })
                    .onChange(of: fx.x) { oldValue, newValue in
                        applyFilter()
                    }

                HStack{
                    Text("Y")
                    Spacer()
                    Text(String(format: "%.2f", fx.y))
                }

                Slider(value: $fx.y, in: 0...Float(fx.size.height) , onEditingChanged: {editing in
                    applyFilter(editing)
                })
                    .onChange(of: fx.y) {  oldValue, newValue in
                        applyFilter()
                    }

                HStack{
                    Text("Width")
                    Spacer()
                    Text(String(format: "%.2f", fx.extentWidth))
                }
                            
                Slider(value: $fx.extentWidth, in: 0...Float(fx.size.width), onEditingChanged: {editing in
                    applyFilter(editing)
                })
                    .onChange(of: fx.extentWidth) {  oldValue, newValue in
                        applyFilter()
                    }
                
                HStack{
                    Text("Height")
                    Spacer()
                    Text(String(format: "%.2f", fx.extentHeight))
                }
                            
                Slider(value: $fx.extentHeight, in: 0...Float(fx.size.height), onEditingChanged: {editing in
                    applyFilter(editing)
                })
                    .onChange(of: fx.extentHeight) { oldValue, newValue in
                        applyFilter()
                    }

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

