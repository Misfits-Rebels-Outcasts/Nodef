//
//  Copyright © 2022 James Boo. All rights reserved.
//



import SwiftUI
@available(iOS 15.0, *)
struct Convolution9HorizontalPropertiesViewX: View {
    @Environment(\.verticalSizeClass) var verticalSizeClass: UserInterfaceSizeClass?
    @Environment(\.horizontalSizeClass) var horizontalSizeClass: UserInterfaceSizeClass?
    @EnvironmentObject var appSettings: AppSettings
    //@EnvironmentObject var shapes: ShapesX
    
    @ObservedObject var fx: Convolution9HorizontalFX = Convolution9HorizontalFX()
    var parent: FilterPropertiesViewX
    @State private var w1: String=""
    @State private var w2: String=""
    @State private var w3: String=""
    @State private var w4: String=""
    @State private var w5: String=""
    @State private var w6: String=""
    @State private var w7: String=""
    @State private var w8: String=""
    @State private var w9: String=""
    @State private var bias: String=""
    var body: some View {


        Section(header: Text("Horizontal 9 Matrix")){
            Group
            {
                HStack{
                    Text("w1")
                    Spacer()
                    TextField("w1", text: $w1,
                        onEditingChanged: { editing in
                    }).frame(width: 150)
                        .foregroundColor(Color.gray).fixedSize().multilineTextAlignment(.trailing)
                        .onChange(of: w1) { newValue in
                            fx.w1=Float(newValue) ?? 0.0
                            applyFilter(false)
                        }
                }
                .onAppear(perform: setupViewModel)
                HStack{
                    Text("w2")
                    Spacer()
                    TextField("w2", text: $w2,
                        onEditingChanged: { editing in
                    }).frame(width: 150)
                        .foregroundColor(Color.gray).fixedSize().multilineTextAlignment(.trailing)
                        .onChange(of: w2) { newValue in
                            fx.w2=Float(newValue) ?? 0.0
                            applyFilter(false)
                        }
                }
                HStack{
                    Text("w3")
                    Spacer()
                    TextField("w3", text: $w3,
                        onEditingChanged: { editing in
                    }).frame(width: 150)
                        .foregroundColor(Color.gray).fixedSize().multilineTextAlignment(.trailing)
                        .onChange(of: w3) { newValue in
                            fx.w3=Float(newValue) ?? 0.0
                            applyFilter(false)
                        }
                }
                
            }
            Group
            {
                HStack{
                    Text("w4")
                    Spacer()
                    TextField("w4", text: $w4,
                        onEditingChanged: { editing in
                    }).frame(width: 150)
                        .foregroundColor(Color.gray).fixedSize().multilineTextAlignment(.trailing)
                        .onChange(of: w4) { newValue in
                            fx.w4=Float(newValue) ?? 0.0
                            applyFilter(false)
                        }
                }
                HStack{
                    Text("w5")
                    Spacer()
                    TextField("w5", text: $w5,
                        onEditingChanged: { editing in
                    }).frame(width: 150)
                        .foregroundColor(Color.gray).fixedSize().multilineTextAlignment(.trailing)
                        .onChange(of: w5) { newValue in
                            fx.w5=Float(newValue) ?? 0.0
                            applyFilter(false)
                        }
                }
                HStack{
                    Text("w6")
                    Spacer()
                    TextField("w6", text: $w6,
                        onEditingChanged: { editing in
                    }).frame(width: 150)
                        .foregroundColor(Color.gray).fixedSize().multilineTextAlignment(.trailing)
                        .onChange(of: w6) { newValue in
                            fx.w6=Float(newValue) ?? 0.0
                            applyFilter(false)
                        }
                }
            }
            Group
            {
                HStack{
                    Text("w7")
                    Spacer()
                    TextField("w7", text: $w7,
                        onEditingChanged: { editing in
                    }).frame(width: 150)
                        .foregroundColor(Color.gray).fixedSize().multilineTextAlignment(.trailing)
                        .onChange(of: w7) { newValue in
                            fx.w7=Float(newValue) ?? 0.0
                            applyFilter(false)
                        }
                }
                HStack{
                    Text("w8")
                    Spacer()
                    TextField("w8", text: $w8,
                        onEditingChanged: { editing in
                    }).frame(width: 150)
                        .foregroundColor(Color.gray).fixedSize().multilineTextAlignment(.trailing)
                        .onChange(of: w8) { newValue in
                            fx.w8=Float(newValue) ?? 0.0
                            applyFilter(false)
                        }
                }
                HStack{
                    Text("w9")
                    Spacer()
                    TextField("w9", text: $w9,
                        onEditingChanged: { editing in
                    }).frame(width: 150)
                        .foregroundColor(Color.gray).fixedSize().multilineTextAlignment(.trailing)
                        .onChange(of: w9) { newValue in
                            fx.w9=Float(newValue) ?? 0.0
                            applyFilter(false)
                        }
                }
            }
        }
      
        
        HStack{
            Text("bias")
            Spacer()
            TextField("bias", text: $bias,
                onEditingChanged: { editing in
            }).frame(width: 150)
                .foregroundColor(Color.gray).fixedSize().multilineTextAlignment(.trailing)
                .onChange(of: bias) { newValue in
                    fx.bias=Float(newValue) ?? 0.0
                    applyFilter(false)
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
        w1=String(format: "%.8f", fx.w1)
        w2=String(format: "%.8f", fx.w2)
        w3=String(format: "%.8f", fx.w3)
        w4=String(format: "%.8f", fx.w4)
        w5=String(format: "%.8f", fx.w5)
        w6=String(format: "%.8f", fx.w6)
        w7=String(format: "%.8f", fx.w7)
        w8=String(format: "%.8f", fx.w8)
        w9=String(format: "%.8f", fx.w9)
        bias=String(format: "%.8f", fx.bias)

    }
}

