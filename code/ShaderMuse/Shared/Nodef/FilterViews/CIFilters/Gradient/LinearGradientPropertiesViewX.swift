//
//  Copyright © 2022 James Boo. All rights reserved.
//



import SwiftUI
@available(iOS 15.0, *)
struct LinearGradientPropertiesViewX: View {
    @Environment(\.verticalSizeClass) var verticalSizeClass: UserInterfaceSizeClass?
    @Environment(\.horizontalSizeClass) var horizontalSizeClass: UserInterfaceSizeClass?
    @EnvironmentObject var appSettings: AppSettings
    //@EnvironmentObject var shapes: ShapesX

    var colors=["black","blue","clear","cyan","gray","green","magenta","red","yellow","white"]
    
    @ObservedObject var fx: LinearGradientFX = LinearGradientFX()
    var parent: FilterPropertiesViewX

    var body: some View {

        Section(header: Text("Options")){
            
            
            HStack{
                Text("Point 1 - X")
                Spacer()
                Text(String(format: "%.2f", fx.pointX0))
            }
                        
            /*
            Slider(value: $fx.pointX0, in: 0...fx.size.width )
                .onChange(of: fx.pointX0) { newValue in
                    applyFilter()
                }
             */

            Slider(value: $fx.pointX0, in: 0...Float(fx.size.width), onEditingChanged: {editing in
                applyFilter(editing)
            })
                .onChange(of: fx.pointX0) { newValue in
                    applyFilter()
                }

            HStack{
                Text("Point 1 - Y")
                Spacer()
                Text(String(format: "%.2f", fx.pointY0))
            }
            
            /*
            Slider(value: $fx.pointY0, in: 0...fx.size.height )
                .onChange(of: fx.pointY0) { newValue in
                    applyFilter()
                }
             */
            Slider(value: $fx.pointY0, in: 0...Float(fx.size.height), onEditingChanged: {editing in
                applyFilter(editing)
            })
                .onChange(of: fx.pointY0) { newValue in
                    applyFilter()
                }

            HStack{
                Text("Point 2 - X")
                Spacer()
                Text(String(format: "%.2f", fx.pointX1))
            }
                    
            /*
            Slider(value: $fx.pointX1, in: 0...fx.size.width )
                .onChange(of: fx.pointX1) { newValue in
                    applyFilter()
                }
             */
            Slider(value: $fx.pointX1, in: 0...Float(fx.size.width), onEditingChanged: {editing in
                applyFilter(editing)
            })
                .onChange(of: fx.pointX1) { newValue in
                    applyFilter()
                }

            HStack{
                Text("Point 2 - Y")
                Spacer()
                Text(String(format: "%.2f", fx.pointY1))
            }
            /*
            Slider(value: $fx.pointY1, in: 0...fx.size.height )
                .onChange(of: fx.pointY1) { newValue in
                    applyFilter()
                }
             */
            Slider(value: $fx.pointY1, in: 0...Float(fx.size.height), onEditingChanged: {editing in
                applyFilter(editing)
            })
                .onChange(of: fx.pointY1) { newValue in
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
                Text("Color 1")
                Spacer()
                
                ColorPicker("", selection: $fx.colorx0, supportsOpacity: true)
                  .onChange(of: fx.colorx0) { newValue in
#if targetEnvironment(macCatalyst)
                      fx.color0=CIColor(cgColor: newValue.cgColor!)
#else
                      fx.color0=CIColor(color: UIColor(newValue))
#endif
                      parent.applyFilter()
                  }.frame(width:100, height:30, alignment: .trailing)
            }
            HStack{
                Text("Color 2")
                Spacer()
                ColorPicker("", selection: $fx.colorx1, supportsOpacity: true)
                  .onChange(of: fx.colorx1) { newValue in
#if targetEnvironment(macCatalyst)
                      fx.color1=CIColor(cgColor: newValue.cgColor!)
#else
                      fx.color1=CIColor(color: UIColor(newValue))
#endif
                      parent.applyFilter()
                  }.frame(width:100, height:30, alignment: .trailing)
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

