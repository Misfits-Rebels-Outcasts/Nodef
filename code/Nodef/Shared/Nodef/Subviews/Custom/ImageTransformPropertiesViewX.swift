//
//  Copyright © 2022 James Boo. All rights reserved.
//


import SwiftUI


@available(iOS 15.0, *)
struct ImageTransformPropertiesViewX: View {
    @Environment(\.verticalSizeClass) var verticalSizeClass: UserInterfaceSizeClass?
    @Environment(\.horizontalSizeClass) var horizontalSizeClass: UserInterfaceSizeClass?
    @EnvironmentObject var appSettings: AppSettings
    //@EnvironmentObject var pageSettings: PageSettings
    //@EnvironmentObject var shapes: ShapesX
    
    @ObservedObject var fx: ReadImageFX = ReadImageFX()
    var parent: FilterPropertiesViewX
    var body: some View {
        
        Section(header: Text("Read Image")){
            Button("Select Image")
            {
                parent.pageSettings.readFX=fx
                parent.readImage()
            }
        }
        
        Section(header: Text("Translate")){
            HStack{
                Text("X")
                Spacer()
                Text(String(format: "%.2f", fx.tx))
            }
                        
            Slider(value: $fx.tx, in: (0-Float(fx.size.width))...Float(fx.size.width), onEditingChanged: {editing in
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


            Slider(value: $fx.ty, in: (0-Float(fx.size.height))...Float(fx.size.height), onEditingChanged: {editing in
                applyFilter(editing)
            })
                .onChange(of: fx.ty) { newValue in
                    applyFilter()
            }
                
        }
        
        Section(header: Text("Scale")){
            HStack{
                Text("Scale X")
                Spacer()
                Text(String(format: "%.2f", fx.a))
            }
                        
            Slider(value: $fx.a, in: 0.1...5, onEditingChanged: {editing in
                applyFilter(editing)
            })
                .onChange(of: fx.a) { newValue in
                    applyFilter()
                }
            HStack{
                Text("Scale Y")
                Spacer()
                Text(String(format: "%.2f", fx.d))
            }
                        
            Slider(value: $fx.d, in: 0.1...5, onEditingChanged: {editing in
                applyFilter(editing)
            })
                .onChange(of: fx.d) { newValue in
                    applyFilter()
                }
                
        }


        /*
        Section(header: Text("Options")){

            Text("Browse")
                
        }
        .onAppear(perform: setupViewModel)
*/
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

