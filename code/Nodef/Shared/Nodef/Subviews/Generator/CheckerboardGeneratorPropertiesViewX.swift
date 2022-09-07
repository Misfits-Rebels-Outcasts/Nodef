//
//  Copyright © 2022 James Boo. All rights reserved.
//


import SwiftUI
@available(iOS 15.0, *)
struct CheckerboardGeneratorPropertiesViewX: View {
    @Environment(\.verticalSizeClass) var verticalSizeClass: UserInterfaceSizeClass?
    @Environment(\.horizontalSizeClass) var horizontalSizeClass: UserInterfaceSizeClass?
    @EnvironmentObject var appSettings: AppSettings


    var colors=["black","blue","clear","cyan","gray","green","magenta","red","yellow","white"]
    
    @ObservedObject var fx: CheckerboardGeneratorFX = CheckerboardGeneratorFX()
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
            Slider(value: $fx.centerX, in: 0...fx.size.width , onEditingChanged: {editing in
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

            /*
            Picker("Color 1", selection: $fx.colorStr0) {
                ForEach(colors, id: \.self) {
          
                        Text($0)
                }
            }
            .onChange(of: fx.colorStr0) { newValue in
                fx.color0=getColor(newValue: newValue)
                applyFilter()
            }
            */
            HStack{
                Text("Color 1")
                Spacer()
                ColorPicker("", selection: $fx.colorx0, supportsOpacity: false)
                  .onChange(of: fx.colorx0) { newValue in
                      fx.color0=CIColor(color: UIColor(newValue))
                      parent.applyFilter()
                  }.frame(width:100, height:30, alignment: .trailing)
            }
            HStack{
                Text("Color 2")
                Spacer()
                ColorPicker("", selection: $fx.colorx1, supportsOpacity: false)
                  .onChange(of: fx.colorx1) { newValue in
                      fx.color1=CIColor(color: UIColor(newValue))
                      parent.applyFilter()
                  }.frame(width:100, height:30, alignment: .trailing)
            }
            
            /*
            Picker("Color 2", selection: $fx.colorStr1) {
                ForEach(colors, id: \.self) {
          
                        Text($0)
                }
            }
            .onChange(of: fx.colorStr1) { newValue in
                fx.color1=getColor(newValue: newValue)
                applyFilter()
            }
            */
            
            HStack{
                Text("Sharpness")
                Spacer()
                Text(String(format: "%.2f", fx.sharpness))
            }
            /*
            Slider(value: $fx.sharpness, in: 0...1 )
                .onChange(of: fx.sharpness) { newValue in
                    //print("id",fx.id)
                    applyFilter()
                }
             */
            Slider(value: $fx.sharpness, in: 0...1, onEditingChanged: {editing in
                applyFilter(editing)
            })
                .onChange(of: fx.sharpness) { newValue in
                    //print("id",fx.id)
                    applyFilter()
                }

            HStack{
                Text("Width")
                Spacer()
                Text(String(format: "%.2f", fx.width))
            }
            
            /*
            Slider(value: $fx.width, in: 0...800 )
                .onChange(of: fx.width) { newValue in
                    //print("id",fx.id)
                    applyFilter()
                }
             */
            Slider(value: $fx.width, in: 0...800, onEditingChanged: {editing in
                applyFilter(editing)
            })
                .onChange(of: fx.width) { newValue in
                    //print("id",fx.id)
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

