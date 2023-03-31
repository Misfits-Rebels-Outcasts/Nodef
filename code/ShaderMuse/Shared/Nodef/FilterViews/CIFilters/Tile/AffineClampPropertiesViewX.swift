//
//  Copyright © 2022 James Boo. All rights reserved.
//



import SwiftUI
@available(iOS 15.0, *)
struct AffineClampPropertiesViewX: View {
    @Environment(\.verticalSizeClass) var verticalSizeClass: UserInterfaceSizeClass?
    @Environment(\.horizontalSizeClass) var horizontalSizeClass: UserInterfaceSizeClass?
    @EnvironmentObject var appSettings: AppSettings
    //@EnvironmentObject var shapes: ShapesX
    
    @ObservedObject var fx: AffineClampFX = AffineClampFX()
    var parent: FilterPropertiesViewX
    @State private var a: String=""
    @State private var b: String=""
    @State private var c: String=""
    @State private var d: String=""
    @State private var tx: String=""
    @State private var ty: String=""
    var body: some View {

        Section(header: Text("Affine Transform")){
            HStack{
                Text("a")
                Spacer()
                TextField("a", text: $a,
                    onEditingChanged: { editing in
                }).frame(width: 150)
                    .foregroundColor(Color.gray).fixedSize().multilineTextAlignment(.trailing)
                    .onChange(of: a) { newValue in
                        var parseValue = Double(newValue) ?? 0.0
                        //parseValue = parseValue < 0.0 ? 0.0 : parseValue
                        fx.a=parseValue
                        applyFilter(false)
                    }
            }.onAppear(perform: setupViewModel)
            HStack{
                Text("b")
                Spacer()
                TextField("b", text: $b,
                    onEditingChanged: { editing in
                }).frame(width: 150)
                    .foregroundColor(Color.gray).fixedSize().multilineTextAlignment(.trailing)
                    .onChange(of: b) { newValue in
                        var parseValue = Double(newValue) ?? 0.0
                        //parseValue = parseValue < 0.0 ? 0.0 : parseValue
                        fx.b=parseValue
                        applyFilter(false)
                    }
            }
            HStack{
                Text("c")
                Spacer()
                TextField("c", text: $c,
                    onEditingChanged: { editing in
                }).frame(width: 150)
                    .foregroundColor(Color.gray).fixedSize().multilineTextAlignment(.trailing)
                    .onChange(of: c) { newValue in
                        var parseValue = Double(newValue) ?? 0.0
                        //parseValue = parseValue < 0.0 ? 0.0 : parseValue
                        fx.c=parseValue
                        applyFilter(false)
                    }
            }
            HStack{
                Text("d")
                Spacer()
                TextField("d", text: $d,
                    onEditingChanged: { editing in
                }).frame(width: 150)
                    .foregroundColor(Color.gray).fixedSize().multilineTextAlignment(.trailing)
                    .onChange(of: d) { newValue in
                        var parseValue = Double(newValue) ?? 0.0
                        //parseValue = parseValue < 0.0 ? 0.0 : parseValue
                        fx.d=parseValue
                        applyFilter(false)
                    }
            }
            HStack{
                Text("tx")
                Spacer()
                TextField("tx", text: $tx,
                    onEditingChanged: { editing in
                }).frame(width: 150)
                    .foregroundColor(Color.gray).fixedSize().multilineTextAlignment(.trailing)
                    .onChange(of: tx) { newValue in
                        var parseValue = Double(newValue) ?? 0.0
                        //parseValue = parseValue < 0.0 ? 0.0 : parseValue
                        fx.tx=parseValue
                        applyFilter(false)
                    }
            }
            HStack{
                Text("ty")
                Spacer()
                TextField("ty", text: $ty,
                    onEditingChanged: { editing in
                }).frame(width: 150)
                    .foregroundColor(Color.gray).fixedSize().multilineTextAlignment(.trailing)
                    .onChange(of: ty) { newValue in
                        var parseValue = Double(newValue) ?? 0.0
                        //-parseValue = parseValue < 0.0 ? 0.0 : parseValue
                        fx.ty=parseValue
                        applyFilter(false)
                    }
            }

                
        }
        
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
        a=String(format: "%.8f", fx.a)
        b=String(format: "%.8f", fx.b)
        c=String(format: "%.8f", fx.c)
        d=String(format: "%.8f", fx.d)
        tx=String(format: "%.8f", fx.tx)
        ty=String(format: "%.8f", fx.ty)
    }
}

