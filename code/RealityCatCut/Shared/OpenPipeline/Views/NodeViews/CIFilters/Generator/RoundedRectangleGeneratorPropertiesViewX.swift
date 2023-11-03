//
//  Copyright © 2022 James Boo. All rights reserved.
//


import SwiftUI
@available(iOS 15.0, *)
struct RoundedRectangleGeneratorPropertiesViewX: View, NodeProperties {

    
    @ObservedObject var fx: RoundedRectangleGeneratorFX = RoundedRectangleGeneratorFX()
    var parent: FilterPropertiesViewX?

    var body: some View {
        Section(header: Text("Extent")){
            
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
                    .onChange(of: fx.y) { oldValue, newValue in
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
                    .onChange(of: fx.extentWidth) { oldValue, newValue in
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
        
        Section(header: Text("Options")){

            HStack{
                Text("Color")
                Spacer()
                
                ColorPicker("", selection: $fx.colorx, supportsOpacity: true)
                  .onChange(of: fx.colorx) { oldValue, newValue in
#if targetEnvironment(macCatalyst)
                      fx.color=CIColor(cgColor: newValue.cgColor!)
#else
                      fx.color=CIColor(color: UIColor(newValue))
#endif
                      applyFilter()
                  }.frame(width:100, height:30, alignment: .trailing)
            }
            
            HStack{
                Text("Background Color")
                Spacer()
                
                ColorPicker("", selection: $fx.backgroundColorx, supportsOpacity: true)
                  .onChange(of: fx.backgroundColorx) { oldValue, newValue in
#if targetEnvironment(macCatalyst)
                      fx.backgroundColor=CIColor(cgColor: newValue.cgColor!)
#else
                      fx.backgroundColor=CIColor(color: UIColor(newValue))
#endif
                      applyFilter()
                  }.frame(width:100, height:30, alignment: .trailing)
            }
            
            HStack{
                Text("Radius")
                Spacer()
                Text(String(format: "%.2f", fx.radius))
            }
                                
            Slider(value: $fx.radius, in: 0...100 , onEditingChanged: {editing in
                applyFilter(editing)
            })
                .onChange(of: fx.radius) { oldValue, ewValue in
                    applyFilter()
                }
            
        }
        /*
        Section(header: Text("Translate")){
            HStack{
                Text("X")
                Spacer()
                Text(String(format: "%.2f", fx.tx))
            }
                        
            Slider(value: $fx.tx, in: 0...Float(fx.size.width)-5, onEditingChanged: {editing in
                applyFilter(editing)
            })
                .onChange(of: fx.tx) { newValue in
                    applyFilter()
                }
           HStack{
                Text("Y")
                Spacer()
                Text(String(format: "%.2f", fx.ty))
            }


            Slider(value: $fx.ty, in: 0...Float(fx.size.height)-5, onEditingChanged: {editing in
                applyFilter(editing)
            })
                .onChange(of: fx.ty) { newValue in
                    applyFilter()
            }
                
        }
         */
        
     
    }

    
    func setupViewModel()
    {
        //colorControlsFX.brightness=

    }
}

