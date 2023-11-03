//
//  Copyright © 2022 James Boo. All rights reserved.
//



import SwiftUI
@available(iOS 15.0, *)
struct Code128BarcodeGeneratorPropertiesViewX: View, NodeProperties {

    
    @ObservedObject var fx: Code128BarcodeGeneratorFX = Code128BarcodeGeneratorFX()
    var parent: FilterPropertiesViewX?

    var body: some View {
        Section(header: Text("Input")){
            TextEditor(text: $fx.message)
                .foregroundColor(Color.gray)
                .onChange(of: fx.message) {  oldValue, newValue in
                    applyFilter()
                }
                .frame(maxWidth: .infinity, maxHeight: 300, alignment: .topLeading)

        }
        
        
        Section(header: Text("Options")){
            
            HStack{
                Text("Quiet Space")
                Spacer()
                Text(String(format: "%.2f", fx.quietSpace))
            }
                        
            Slider(value: $fx.quietSpace, in: 0...20.0 , onEditingChanged: {editing in
                applyFilter(editing)
            })
                .onChange(of: fx.quietSpace) {  oldValue, newValue in
                    applyFilter()
                }


        }
        .onAppear(perform: setupViewModel)
         
        //Section(header: Text(""), footer: Text("")){
        //}
    }

    
    func getColor(newValue: String)->CIColor
    {
        var fxcolor:CIColor = .blue
        if newValue == "black"
        {
            fxcolor=CIColor.black
        }
        else if newValue == "blue"
        {
            fxcolor=CIColor.blue
        }
        else if newValue == "clear"
        {
            fxcolor=CIColor.clear
        }
        else if newValue == "cyan"
        {
            fxcolor=CIColor.cyan
        }
        else if newValue == "gray"
        {
            fxcolor=CIColor.gray
        }
        else if newValue == "green"
        {
            fxcolor=CIColor.green
        }
        else if newValue == "magenta"
        {
            fxcolor=CIColor.magenta
        }
        else if newValue == "red"
        {
            fxcolor=CIColor.red
        }
        else if newValue == "yellow"
        {
            fxcolor=CIColor.yellow
        }
        else if newValue == "white"
        {
            fxcolor=CIColor.white
        }
        
        return fxcolor
    }
    func setupViewModel()
    {
        //colorControlsFX.brightness=

    }
}

