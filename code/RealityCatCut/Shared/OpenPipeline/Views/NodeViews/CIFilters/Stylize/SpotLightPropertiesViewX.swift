//
//  Copyright © 2022 James Boo. All rights reserved.
//



import SwiftUI
@available(iOS 15.0, *)
struct SpotLightPropertiesViewX: View, NodeProperties {

    
    @ObservedObject var fx: SpotLightFX = SpotLightFX()
    var parent: FilterPropertiesViewX?

    var body: some View {

        Section(header: Text("Light Position")){
                  
            HStack{
                Text("X")
                Spacer()
                Text(String(format: "%.2f", fx.lightPositionX))
            }

            Slider(value: $fx.lightPositionX, in: 0...Float(fx.size.width), onEditingChanged: {editing in
                applyFilter(editing)
            })
                .onChange(of: fx.lightPositionX) { oldValue, newValue in
                    applyFilter()
                }
            
            HStack{
                Text("Y")
                Spacer()
                Text(String(format: "%.2f", fx.lightPositionY))
            }

            Slider(value: $fx.lightPositionY, in: 0...Float(fx.size.width), onEditingChanged: {editing in
                applyFilter(editing)
            })
                .onChange(of: fx.lightPositionY) { oldValue, newValue in
                    applyFilter()
                }
            
            HStack{
                Text("Z")
                Spacer()
                Text(String(format: "%.2f", fx.lightPositionZ))
            }

            Slider(value: $fx.lightPositionZ, in: (0.0)...(3000.0), onEditingChanged: {editing in
                applyFilter(editing)
            })
                .onChange(of: fx.lightPositionZ) { oldValue, newValue in
                    applyFilter()
                }
                   
        }
        
        Section(header: Text("Light Points At")){
                  
            HStack{
                Text("X")
                Spacer()
                Text(String(format: "%.2f", fx.lightPointsAtX))
            }

            Slider(value: $fx.lightPointsAtX, in: 0...Float(fx.size.width), onEditingChanged: {editing in
                applyFilter(editing)
            })
                .onChange(of: fx.lightPointsAtX) { oldValue, newValue in
                    applyFilter()
                }
            
            HStack{
                Text("Y")
                Spacer()
                Text(String(format: "%.2f", fx.lightPointsAtY))
            }

            Slider(value: $fx.lightPointsAtY, in: 0...Float(fx.size.width), onEditingChanged: {editing in
                applyFilter(editing)
            })
                .onChange(of: fx.lightPointsAtY) { oldValue, newValue in
                    applyFilter()
                }
            
            HStack{
                Text("Z")
                Spacer()
                Text(String(format: "%.2f", fx.lightPointsAtZ))
            }

            Slider(value: $fx.lightPointsAtZ, in: (0.0)...(3000.0), onEditingChanged: {editing in
                applyFilter(editing)
            })
                .onChange(of: fx.lightPointsAtZ) { oldValue, newValue in
                    applyFilter()
                }
                   
        }
        Section(header: Text("Options")){
                  
            HStack{
                Text("Brightness")
                Spacer()
                Text(String(format: "%.2f", fx.brightness))
            }

            Slider(value: $fx.brightness, in: 0...10, onEditingChanged: {editing in
                applyFilter(editing)
            })
                .onChange(of: fx.brightness) { oldValue, newValue in
                    applyFilter()
                }
            HStack{
                Text("Concentration")
                Spacer()
                Text(String(format: "%.2f", fx.concentration))
            }

            Slider(value: $fx.concentration, in: 0...1.5, onEditingChanged: {editing in
                applyFilter(editing)
            })
                .onChange(of: fx.concentration) { oldValue, newValue in
                    applyFilter()
                }
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
            
        }

        
        //.onAppear(perform: setupViewModel)
        //Section(header: Text(""), footer: Text("")){
        //}
    }
    


    func setupViewModel()
    {
        //colorControlsFX.brightness=

    }
}

