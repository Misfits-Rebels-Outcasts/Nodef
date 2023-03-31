//
//  Copyright © 2022 James Boo. All rights reserved.
//


import SwiftUI
@available(iOS 15.0, *)
struct CircleSplashDistortionPropertiesViewX: View {
    //@Environment(\.verticalSizeClass) var verticalSizeClass: UserInterfaceSizeClass?
    //@Environment(\.horizontalSizeClass) var horizontalSizeClass: UserInterfaceSizeClass?
    @EnvironmentObject var appSettings: AppSettings
    @ObservedObject var fx: CircleSplashDistortionFX = CircleSplashDistortionFX()
    var parent: FilterPropertiesViewX

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
            Slider(value: $fx.centerX, in: 0...fx.size.width, onEditingChanged: {editing in
                applyFilter(editing)
            })
                .onChange(of: fx.centerX) { newValue in
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
            Slider(value: $fx.centerY, in: 0...fx.size.height, onEditingChanged: {editing in
                applyFilter(editing)
            })
                .onChange(of: fx.centerY) { newValue in
                    applyFilter()
            }

            HStack{
                Text("Radius")
                Spacer()
                Text(String(format: "%.2f", fx.radius))
            }
            
            /*
            Slider(value: $fx.radius, in: 0...1000 )
                .onChange(of: fx.radius) { newValue in
                    applyFilter()
                }
             */
            Slider(value: $fx.radius, in: 0...1000, onEditingChanged: {editing in
                applyFilter(editing)
            })
                .onChange(of: fx.radius) { newValue in
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

