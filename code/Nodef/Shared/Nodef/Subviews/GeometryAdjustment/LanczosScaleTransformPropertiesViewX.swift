//
//  Copyright © 2022 James Boo. All rights reserved.
//


import SwiftUI


@available(iOS 15.0, *)
struct LanczosScaleTransformPropertiesViewX: View {
    @Environment(\.verticalSizeClass) var verticalSizeClass: UserInterfaceSizeClass?
    @Environment(\.horizontalSizeClass) var horizontalSizeClass: UserInterfaceSizeClass?
    @EnvironmentObject var appSettings: AppSettings
    //@EnvironmentObject var pageSettings: PageSettings
    //@EnvironmentObject var shapes: ShapesX
    
    @ObservedObject var fx: LanczosScaleTransformFX = LanczosScaleTransformFX()
    var parent: FilterPropertiesViewX
    var body: some View {

        Section(header: Text("Options")){
            HStack{
                Text("Scale")
                Spacer()
                Text(String(format: "%.2f", fx.scale))
            }
            
            Slider(value: $fx.scale, in: 0.1...1.5, onEditingChanged: {editing in
                applyFilter(editing)
            })
                .onChange(of: fx.scale) { newValue in
                    applyFilter()
                }


            HStack{
                Text("Aspect Ratio")
                Spacer()
                Text(String(format: "%.2f", fx.aspectRatio))
            }

            Slider(value: $fx.aspectRatio, in: 0.1...2.0,
                   onEditingChanged: {editing in
                    applyFilter(editing)
                })
                .onChange(of: fx.aspectRatio) { newValue in
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

