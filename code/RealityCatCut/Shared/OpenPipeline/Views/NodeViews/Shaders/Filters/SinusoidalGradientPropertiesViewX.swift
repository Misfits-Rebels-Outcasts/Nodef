//
//  Copyright © 2022 James Boo. All rights reserved.
//



import SwiftUI
@available(iOS 15.0, *)
struct SinusoidalGradientPropertiesViewX: View, NodeProperties {

    
    @ObservedObject var fx: SinusoidalGradientFX = SinusoidalGradientFX()
    var parent: FilterPropertiesViewX?

    var body: some View {

        Section(header: Text("Gradient 1")){
            
            HStack{
                Text("Color 1")
                Spacer()
                
                ColorPicker("", selection: $fx.gradient0Colorx0, supportsOpacity: true)
                  .onChange(of: fx.gradient0Colorx0) { oldValue, newValue in
#if targetEnvironment(macCatalyst)
                      fx.gradient0Color0=CIColor(cgColor: newValue.cgColor!)
#else
                      fx.gradient0Color0=CIColor(color: UIColor(newValue))
#endif
                      applyFilter()
                  }.frame(width:100, height:30, alignment: .trailing)
            }
            HStack{
                Text("Color 2")
                Spacer()
                
                ColorPicker("", selection: $fx.gradient0Colorx1, supportsOpacity: true)
                  .onChange(of: fx.gradient0Colorx1) { oldValue, newValue in
#if targetEnvironment(macCatalyst)
                      fx.gradient0Color1=CIColor(cgColor: newValue.cgColor!)
#else
                      fx.gradient0Color1=CIColor(color: UIColor(newValue))
#endif
                      applyFilter()
                  }.frame(width:100, height:30, alignment: .trailing)
            }
            HStack{
                Text("Angle")
                Spacer()
                Text(String(format: "%.0f", fx.gradient0Angle))
            }

            Slider(value: $fx.gradient0Angle, in: 0...180, onEditingChanged: {editing in
                applyFilter(editing)
            })
                .onChange(of: fx.gradient0Angle) { oldValue, newValue in
                    applyFilter()
                }
            
            HStack{
                Text("Center Shift")
                Spacer()
                Text(String(format: "%.0f", fx.gradient0CenterShift))
            }

            Slider(value: $fx.gradient0CenterShift, in: 0...1, onEditingChanged: {editing in
                applyFilter(editing)
            })
                .onChange(of: fx.gradient0CenterShift) { oldValue, newValue in
                    applyFilter()
                }
            /*
            HStack{
                Text("Range Type")
                Spacer()
                Text(String(format: "%.0f", fx.gradient0RangeType))
            }

            Slider(value: $fx.gradient0RangeType, in: 0...2, step: 1, onEditingChanged: {editing in
                applyFilter(editing)
            })
                .onChange(of: fx.gradient0RangeType) { newValue in
                    applyFilter()
                }
             */
        }
        .onAppear(perform: setupViewModel)
        
        Section(header: Text("Gradient 2")){
            

            HStack{
                Text("Color 1")
                Spacer()
                
                ColorPicker("", selection: $fx.gradient1Colorx0, supportsOpacity: true)
                  .onChange(of: fx.gradient1Colorx0) { oldValue, newValue in
#if targetEnvironment(macCatalyst)
                      fx.gradient1Color0=CIColor(cgColor: newValue.cgColor!)
#else
                      fx.gradient1Color0=CIColor(color: UIColor(newValue))
#endif
                      applyFilter()
                  }.frame(width:100, height:30, alignment: .trailing)
            }
            HStack{
                Text("Color 2")
                Spacer()
                
                ColorPicker("", selection: $fx.gradient1Colorx1, supportsOpacity: true)
                  .onChange(of: fx.gradient1Colorx1) { oldValue, newValue in
#if targetEnvironment(macCatalyst)
                      fx.gradient1Color1=CIColor(cgColor: newValue.cgColor!)
#else
                      fx.gradient1Color1=CIColor(color: UIColor(newValue))
#endif
                      applyFilter()
                  }.frame(width:100, height:30, alignment: .trailing)
            }
            HStack{
                Text("Angle")
                Spacer()
                Text(String(format: "%.0f", fx.gradient1Angle))
            }

            Slider(value: $fx.gradient1Angle, in: 0...180, onEditingChanged: {editing in
                applyFilter(editing)
            })
                .onChange(of: fx.gradient1Angle) { oldValue, newValue in
                    applyFilter()
                }
            
            
            HStack{
                Text("Center Shift")
                Spacer()
                Text(String(format: "%.0f", fx.gradient1CenterShift))
            }

            Slider(value: $fx.gradient1CenterShift, in: 0...1, onEditingChanged: {editing in
                applyFilter(editing)
            })
                .onChange(of: fx.gradient1CenterShift) { oldValue, newValue in
                    applyFilter()
                }
            /*
            HStack{
                Text("Range Type")
                Spacer()
                Text(String(format: "%.0f", fx.gradient1RangeType))
            }

            Slider(value: $fx.gradient1RangeType, in: 0...2, step: 1, onEditingChanged: {editing in
                applyFilter(editing)
            })
                .onChange(of: fx.gradient1RangeType) { newValue in
                    applyFilter()
                }
             */
        }

        Section(header: Text("Mix")){
            
            HStack{
                Text("Amount")
                Spacer()
                Text(String(format: "%.2f", fx.amount))
            }
            
            Slider(value: $fx.amount, in: 0...1, onEditingChanged: {editing in
                applyFilter(editing)
            })
                .onChange(of: fx.amount) { oldValue, newValue in
                    applyFilter()
                }
        }
        //Section(header: Text(""), footer: Text("")){
        //}
    }
    

    
    func setupViewModel()
    {
        //colorControlsFX.brightness=

    }
}

