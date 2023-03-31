//
//  Copyright © 2022 James Boo. All rights reserved.
//


import SwiftUI
@available(iOS 15.0, *)
struct Convolution5X5PropertiesViewX: View {
    @Environment(\.verticalSizeClass) var verticalSizeClass: UserInterfaceSizeClass?
    @Environment(\.horizontalSizeClass) var horizontalSizeClass: UserInterfaceSizeClass?
    @EnvironmentObject var appSettings: AppSettings
    //@EnvironmentObject var shapes: ShapesX
    
    @ObservedObject var fx: Convolution5X5FX = Convolution5X5FX()
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
    @State private var w10: String=""
    
    @State private var w11: String=""
    @State private var w12: String=""
    @State private var w13: String=""
    @State private var w14: String=""
    @State private var w15: String=""
    @State private var w16: String=""
    @State private var w17: String=""
    @State private var w18: String=""
    @State private var w19: String=""

    @State private var w20: String=""
    @State private var w21: String=""
    @State private var w22: String=""
    @State private var w23: String=""
    @State private var w24: String=""
    @State private var w25: String=""

    @State private var bias: String=""
    
    var body: some View {

        Section(header: Text("Matrix Row 1")){
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
            }
        }
        
        Section(header: Text("Matrix Row 2")){
            Group
            {
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
                
                HStack{
                    Text("w10")
                    Spacer()
                    TextField("w10", text: $w10,
                        onEditingChanged: { editing in
                    }).frame(width: 150)
                        .foregroundColor(Color.gray).fixedSize().multilineTextAlignment(.trailing)
                        .onChange(of: w10) { newValue in
                            fx.w10=Float(newValue) ?? 0.0
                            applyFilter(false)
                        }
                }
            }
        }
        Section(header: Text("Matrix Row 3")){
            Group
            {
                HStack{
                    Text("w11")
                    Spacer()
                    TextField("w11", text: $w11,
                        onEditingChanged: { editing in
                    }).frame(width: 150)
                        .foregroundColor(Color.gray).fixedSize().multilineTextAlignment(.trailing)
                        .onChange(of: w11) { newValue in
                            fx.w11=Float(newValue) ?? 0.0
                            applyFilter(false)
                        }
                }
                HStack{
                    Text("w12")
                    Spacer()
                    TextField("w12", text: $w12,
                        onEditingChanged: { editing in
                    }).frame(width: 150)
                        .foregroundColor(Color.gray).fixedSize().multilineTextAlignment(.trailing)
                        .onChange(of: w12) { newValue in
                            fx.w12=Float(newValue) ?? 0.0
                            applyFilter(false)
                        }
                }
                HStack{
                    Text("w13")
                    Spacer()
                    TextField("w13", text: $w13,
                        onEditingChanged: { editing in
                    }).frame(width: 150)
                        .foregroundColor(Color.gray).fixedSize().multilineTextAlignment(.trailing)
                        .onChange(of: w13) { newValue in
                            fx.w13=Float(newValue) ?? 0.0
                            applyFilter(false)
                        }
                }
                HStack{
                    Text("w14")
                    Spacer()
                    TextField("w14", text: $w14,
                        onEditingChanged: { editing in
                    }).frame(width: 150)
                        .foregroundColor(Color.gray).fixedSize().multilineTextAlignment(.trailing)
                        .onChange(of: w14) { newValue in
                            fx.w14=Float(newValue) ?? 0.0
                            applyFilter(false)
                        }
                }
                HStack{
                    Text("w15")
                    Spacer()
                    TextField("w15", text: $w15,
                        onEditingChanged: { editing in
                    }).frame(width: 150)
                        .foregroundColor(Color.gray).fixedSize().multilineTextAlignment(.trailing)
                        .onChange(of: w15) { newValue in
                            fx.w15=Float(newValue) ?? 0.0
                            applyFilter(false)
                        }
                }
                
            }
        }
        Section(header: Text("Matrix Row 4")){
            Group
            {

                HStack{
                    Text("w16")
                    Spacer()
                    TextField("w16", text: $w16,
                        onEditingChanged: { editing in
                    }).frame(width: 150)
                        .foregroundColor(Color.gray).fixedSize().multilineTextAlignment(.trailing)
                        .onChange(of: w16) { newValue in
                            fx.w16=Float(newValue) ?? 0.0
                            applyFilter(false)
                        }
                }
                
                HStack{
                    Text("w17")
                    Spacer()
                    TextField("w17", text: $w17,
                        onEditingChanged: { editing in
                    }).frame(width: 150)
                        .foregroundColor(Color.gray).fixedSize().multilineTextAlignment(.trailing)
                        .onChange(of: w17) { newValue in
                            fx.w17=Float(newValue) ?? 0.0
                            applyFilter(false)
                        }
                }
                HStack{
                    Text("w18")
                    Spacer()
                    TextField("w18", text: $w18,
                        onEditingChanged: { editing in
                    }).frame(width: 150)
                        .foregroundColor(Color.gray).fixedSize().multilineTextAlignment(.trailing)
                        .onChange(of: w18) { newValue in
                            fx.w18=Float(newValue) ?? 0.0
                            applyFilter(false)
                        }
                }
                HStack{
                    Text("w19")
                    Spacer()
                    TextField("w19", text: $w19,
                        onEditingChanged: { editing in
                    }).frame(width: 150)
                        .foregroundColor(Color.gray).fixedSize().multilineTextAlignment(.trailing)
                        .onChange(of: w19) { newValue in
                            fx.w19=Float(newValue) ?? 0.0
                            applyFilter(false)
                        }
                }
                HStack{
                    Text("w20")
                    Spacer()
                    TextField("w20", text: $w20,
                        onEditingChanged: { editing in
                    }).frame(width: 150)
                        .foregroundColor(Color.gray).fixedSize().multilineTextAlignment(.trailing)
                        .onChange(of: w20) { newValue in
                            fx.w20=Float(newValue) ?? 0.0
                            applyFilter(false)
                        }
                }
            }
        }
        Section(header: Text("Matrix Row 5")){
            Group{
                
                HStack{
                    Text("w21")
                    Spacer()
                    TextField("w21", text: $w21,
                        onEditingChanged: { editing in
                    }).frame(width: 150)
                        .foregroundColor(Color.gray).fixedSize().multilineTextAlignment(.trailing)
                        .onChange(of: w21) { newValue in
                            fx.w21=Float(newValue) ?? 0.0
                            applyFilter(false)
                        }
                }
                HStack{
                    Text("w22")
                    Spacer()
                    TextField("w22", text: $w22,
                        onEditingChanged: { editing in
                    }).frame(width: 150)
                        .foregroundColor(Color.gray).fixedSize().multilineTextAlignment(.trailing)
                        .onChange(of: w22) { newValue in
                            fx.w22=Float(newValue) ?? 0.0
                            applyFilter(false)
                        }
                }
                HStack{
                    Text("w23")
                    Spacer()
                    TextField("w23", text: $w23,
                        onEditingChanged: { editing in
                    }).frame(width: 150)
                        .foregroundColor(Color.gray).fixedSize().multilineTextAlignment(.trailing)
                        .onChange(of: w23) { newValue in
                            fx.w23=Float(newValue) ?? 0.0
                            applyFilter(false)
                        }
                }
                HStack{
                    Text("w24")
                    Spacer()
                    TextField("w24", text: $w24,
                        onEditingChanged: { editing in
                    }).frame(width: 150)
                        .foregroundColor(Color.gray).fixedSize().multilineTextAlignment(.trailing)
                        .onChange(of: w24) { newValue in
                            fx.w24=Float(newValue) ?? 0.0
                            applyFilter(false)
                        }
                }
                HStack{
                    Text("w25")
                    Spacer()
                    TextField("w25", text: $w25,
                        onEditingChanged: { editing in
                    }).frame(width: 150)
                        .foregroundColor(Color.gray).fixedSize().multilineTextAlignment(.trailing)
                        .onChange(of: w25) { newValue in
                            fx.w25=Float(newValue) ?? 0.0
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

        w10=String(format: "%.8f", fx.w10)
        w11=String(format: "%.8f", fx.w11)
        w12=String(format: "%.8f", fx.w12)
        w13=String(format: "%.8f", fx.w13)
        w14=String(format: "%.8f", fx.w14)
        w15=String(format: "%.8f", fx.w15)
        w16=String(format: "%.8f", fx.w16)
        w17=String(format: "%.8f", fx.w17)
        w18=String(format: "%.8f", fx.w18)
        w19=String(format: "%.8f", fx.w19)

        w20=String(format: "%.8f", fx.w20)
        w21=String(format: "%.8f", fx.w21)
        w22=String(format: "%.8f", fx.w22)
        w23=String(format: "%.8f", fx.w23)
        w24=String(format: "%.8f", fx.w24)
        w25=String(format: "%.8f", fx.w25)

        bias=String(format: "%.8f", fx.bias)

    }
}

