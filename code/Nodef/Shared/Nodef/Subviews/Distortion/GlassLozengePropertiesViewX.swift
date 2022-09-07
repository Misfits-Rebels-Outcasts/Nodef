//
//  Copyright © 2022 James Boo. All rights reserved.
//


import SwiftUI
@available(iOS 15.0, *)
struct GlassLozengePropertiesViewX: View {
    @Environment(\.verticalSizeClass) var verticalSizeClass: UserInterfaceSizeClass?
    @Environment(\.horizontalSizeClass) var horizontalSizeClass: UserInterfaceSizeClass?
    @EnvironmentObject var appSettings: AppSettings
  
    
    @ObservedObject var fx: GlassLozengeFX = GlassLozengeFX()
    var parent: FilterPropertiesViewX

    var body: some View {

        Section(header: Text("Image Lens Portion")){
            
            Group{
                HStack{
                    Text("Point 1 - X")
                    Spacer()
                    Text(String(format: "%.2f", fx.pointX0))
                }
                        
                Slider(value: $fx.pointX0, in: 0...Float(fx.size.width), onEditingChanged: {editing in
                    applyFilter(editing)
                })
                    .onChange(of: fx.pointX0) { newValue in
                        applyFilter()
                    }
                HStack{
                    Text("Point 1 - Y")
                    Spacer()
                    Text(String(format: "%.2f", fx.pointY0))
                }
       
                Slider(value: $fx.pointY0, in: 0...Float(fx.size.height), onEditingChanged: {editing in
                    applyFilter(editing)
                })
                    .onChange(of: fx.pointY0) { newValue in
                        applyFilter()
                    }
            }
        
            Group{
                HStack{
                    Text("Point 2 - X")
                    Spacer()
                    Text(String(format: "%.2f", fx.pointX1))
                }
                        
                Slider(value: $fx.pointX1, in: 0...Float(fx.size.width), onEditingChanged: {editing in
                    applyFilter(editing)
                })
                    .onChange(of: fx.pointX1) { newValue in
                        applyFilter()
                    }
                HStack{
                    Text("Point 2 - Y")
                    Spacer()
                    Text(String(format: "%.2f", fx.pointY1))
                }
                
                Slider(value: $fx.pointY1, in: 0...Float(fx.size.height), onEditingChanged: {editing in
                    applyFilter(editing)
                })
                    .onChange(of: fx.pointY1) { newValue in
                        applyFilter()
                }

            }
                        
        }
        Section(header: Text("Options")){
            
            HStack{
                Text("Radius")
                Spacer()
                Text(String(format: "%.2f", fx.radius))
            }

            Slider(value: $fx.radius, in: 0...1000, onEditingChanged: {editing in
                applyFilter(editing)
            })
                .onChange(of: fx.radius) { newValue in
                    applyFilter()
                }
            
            HStack{
                Text("Refraction")
                Spacer()
                Text(String(format: "%.2f", fx.refraction))
            }

            Slider(value: $fx.refraction, in: 0...5, onEditingChanged: {editing in
                applyFilter(editing)
            })
                .onChange(of: fx.refraction) { newValue in
                    applyFilter()
                }
            
           
        }
        .onAppear(perform: setupViewModel)
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

