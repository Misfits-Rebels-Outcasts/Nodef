//
//  Copyright © 2022 James Boo. All rights reserved.
//


import SwiftUI
@available(iOS 15.0, *)
struct QRCodeGeneratorPropertiesViewX: View {
    @Environment(\.verticalSizeClass) var verticalSizeClass: UserInterfaceSizeClass?
    @Environment(\.horizontalSizeClass) var horizontalSizeClass: UserInterfaceSizeClass?
    @EnvironmentObject var appSettings: AppSettings
    //@EnvironmentObject var shapes: ShapesX

    var qrErrorLevel = ["L","M","Q","H"]
    
    @ObservedObject var fx: QRCodeGeneratorFX = QRCodeGeneratorFX()
    var parent: FilterPropertiesViewX

    var body: some View {
        Section(header: Text("Input")){
            TextEditor(text: $fx.message)
                .foregroundColor(Color.gray)
                .onChange(of: fx.message) { newValue in
                    parent.applyFilter()
                }
                .frame(maxWidth: .infinity, maxHeight: 300, alignment: .topLeading)

        }
        
        Section(header: Text("Error Level")){
            Picker("Error Level", selection: $fx.correctionLevel) {
                ForEach(qrErrorLevel, id: \.self) {
                    Text($0)                    
                }
            }
            .onChange(of: fx.correctionLevel) { newValue in
                parent.applyFilter()
            }
        }
        
        /*
        Section(header: Text("Options")){
            
            
            HStack{
                Text("Center X")
                Spacer()
                Text(String(format: "%.2f", fx.centerX))
            }
                        
            Slider(value: $fx.centerX, in: 0...fx.size.width , onEditingChanged: {editing in
                applyFilter(editing)
            })
                .onChange(of: fx.centerX) { newValue in
                    applyFilter()
                }


        }
        .onAppear(perform: setupViewModel)
         */
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

