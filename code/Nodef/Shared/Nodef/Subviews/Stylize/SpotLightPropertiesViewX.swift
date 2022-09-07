//
//  Copyright © 2022 James Boo. All rights reserved.
//



import SwiftUI
@available(iOS 15.0, *)
struct SpotLightPropertiesViewX: View {
    @Environment(\.verticalSizeClass) var verticalSizeClass: UserInterfaceSizeClass?
    @Environment(\.horizontalSizeClass) var horizontalSizeClass: UserInterfaceSizeClass?
    @EnvironmentObject var appSettings: AppSettings
  
    
    @ObservedObject var fx: SpotLightFX = SpotLightFX()
    var parent: FilterPropertiesViewX

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
                .onChange(of: fx.lightPositionX) { newValue in
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
                .onChange(of: fx.lightPositionY) { newValue in
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
                .onChange(of: fx.lightPositionZ) { newValue in
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
                .onChange(of: fx.lightPointsAtX) { newValue in
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
                .onChange(of: fx.lightPointsAtY) { newValue in
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
                .onChange(of: fx.lightPointsAtZ) { newValue in
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
                .onChange(of: fx.brightness) { newValue in
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
                .onChange(of: fx.concentration) { newValue in
                    applyFilter()
                }
            HStack{
                Text("Color")
                Spacer()
                
                ColorPicker("", selection: $fx.colorx, supportsOpacity: false)
                  .onChange(of: fx.colorx) { newValue in
                      fx.color=CIColor(color: UIColor(newValue))
                      parent.applyFilter()
                  }.frame(width:100, height:30, alignment: .trailing)
            }
            
        }

        
        //.onAppear(perform: setupViewModel)
        //Section(header: Text(""), footer: Text("")){
        //}
    }
    
    func applyFilter(_ editing: Bool) {
        print(editing,appSettings.imageRes)
        if editing == true
        {
            //if appSettings.imageRes == "Standard Resolution"
            //{
                //parent.applyFilter()
            //}
        }
        else{
            parent.applyFilter()
        }
    }
    
    func applyFilter() {
        if appSettings.imageRes == "Standard Resolution"
        {
            parent.applyFilter()
        }
    }

    func setupViewModel()
    {
        //colorControlsFX.brightness=

    }
}

