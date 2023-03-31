//
//  Copyright © 2022 James Boo. All rights reserved.
//


import SwiftUI
@available(iOS 15.0, *)
struct CircleGeneratorPropertiesViewX: View {
    @Environment(\.verticalSizeClass) var verticalSizeClass: UserInterfaceSizeClass?
    @Environment(\.horizontalSizeClass) var horizontalSizeClass: UserInterfaceSizeClass?
    @EnvironmentObject var appSettings: AppSettings
    
    @ObservedObject var fx: CircleGeneratorFX = CircleGeneratorFX()
    var parent: FilterPropertiesViewX

    var body: some View {
        
        Section(header: Text("Options")){

            HStack{
                Text("X")
                Spacer()
                Text(String(format: "%.2f", fx.x))
            }
                        
            Slider(value: $fx.x, in: 0...Float(fx.size.width), onEditingChanged: {editing in
                applyFilter(editing)
            })
                .onChange(of: fx.x) { newValue in
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
                .onChange(of: fx.y) { newValue in
                    applyFilter()
                }

            
            HStack{
                Text("Color")
                Spacer()
                
                ColorPicker("", selection: $fx.colorx, supportsOpacity: true)
                  .onChange(of: fx.colorx) { newValue in
#if targetEnvironment(macCatalyst)
                      fx.color=CIColor(cgColor: newValue.cgColor!)
#else
                      fx.color=CIColor(color: UIColor(newValue))
#endif
                      parent.applyFilter()
                  }.frame(width:100, height:30, alignment: .trailing)
            }
            
            HStack{
                Text("Background Color")
                Spacer()
                
                ColorPicker("", selection: $fx.backgroundColorx, supportsOpacity: true)
                  .onChange(of: fx.backgroundColorx) { newValue in
#if targetEnvironment(macCatalyst)
                      fx.backgroundColor=CIColor(cgColor: newValue.cgColor!)
#else
                      fx.backgroundColor=CIColor(color: UIColor(newValue))
#endif
                      parent.applyFilter()
                  }.frame(width:100, height:30, alignment: .trailing)
            }
            
            HStack{
                Text("Radius")
                Spacer()
                Text(String(format: "%.2f", fx.radius))
            }
                                
            Slider(value: $fx.radius, in: 0...Float(fx.size.height < fx.size.width ? fx.size.height : fx.size.width), onEditingChanged: {editing in
                applyFilter(editing)
            })
                .onChange(of: fx.radius) { newValue in
                    applyFilter()
                }
            
        }
        
    }
    func applyFilter(_ editing: Bool) {
        print(editing,appSettings.imageRes)
        if editing == true
        {
            //if appSettings.imageRes != "High Resolution"
            //{
                //parent.applyFilter()
            //}
        }
        else{
            parent.applyFilter()
        }
    }
    
    func applyFilter() {
        if appSettings.imageRes != "High Resolution"
        {
            parent.applyFilter()
        }
    }
    
    func setupViewModel()
    {
        //colorControlsFX.brightness=

    }
}

