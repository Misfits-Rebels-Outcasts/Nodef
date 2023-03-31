//
//  Copyright © 2022 James Boo. All rights reserved.
//


import SwiftUI


@available(iOS 15.0, *)
struct TranslatePropertiesViewX: View {
    @Environment(\.verticalSizeClass) var verticalSizeClass: UserInterfaceSizeClass?
    @Environment(\.horizontalSizeClass) var horizontalSizeClass: UserInterfaceSizeClass?
    @EnvironmentObject var appSettings: AppSettings
    //@EnvironmentObject var pageSettings: PageSettings
    //@EnvironmentObject var shapes: ShapesX
    
    @ObservedObject var fx: TranslateFX = TranslateFX()
    var parent: FilterPropertiesViewX
    
    /*
    @State private var a: String=""
    @State private var b: String=""
    @State private var c: String=""
    @State private var d: String=""
    @State private var tx: String=""
    @State private var ty: String=""
     */
    
    var body: some View {

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
        /*
        a=String(format: "%.8f", fx.a)
        b=String(format: "%.8f", fx.b)
        c=String(format: "%.8f", fx.c)
        d=String(format: "%.8f", fx.d)
        tx=String(format: "%.8f", fx.tx)
        ty=String(format: "%.8f", fx.ty)
         */
    }
}

