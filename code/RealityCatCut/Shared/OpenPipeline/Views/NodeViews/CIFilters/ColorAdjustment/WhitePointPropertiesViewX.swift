//
//  Copyright © 2022 James Boo. All rights reserved.
//


import SwiftUI
@available(iOS 15.0, *)
struct WhitePointPropertiesViewX: View, NodeProperties {


    @ObservedObject var fx: WhitePointAdjustFX = WhitePointAdjustFX()
    var parent: FilterPropertiesViewX?

    var body: some View {

        Section(header: Text("Options")){
            
            
            HStack{
                Text("Color")
                Spacer()
                ColorPicker("", selection: $fx.colorx, supportsOpacity: true)
                  .onChange(of: fx.colorx) { oldValue, newValue in
#if targetEnvironment(macCatalyst)
                      fx.color=CIColor(cgColor: newValue.cgColor!)
#else
                      fx.color=CIColor(color: UIColor(newValue))
#endif
                      applyFilter()
                  }.frame(width:100, height:30, alignment: .trailing)
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

