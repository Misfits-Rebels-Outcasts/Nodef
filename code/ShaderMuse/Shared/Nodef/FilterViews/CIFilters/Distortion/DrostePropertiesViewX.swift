//
//  Copyright © 2022 James Boo. All rights reserved.
//


import SwiftUI
@available(iOS 15.0, *)
struct DrostePropertiesViewX: View {
    @Environment(\.verticalSizeClass) var verticalSizeClass: UserInterfaceSizeClass?
    @Environment(\.horizontalSizeClass) var horizontalSizeClass: UserInterfaceSizeClass?
    @EnvironmentObject var appSettings: AppSettings
    //@EnvironmentObject var shapes: ShapesX


    
    @ObservedObject var fx: DrosteFX = DrosteFX()
    var parent: FilterPropertiesViewX

    var body: some View {

        Section(header: Text("Inset")){
            Group{
                HStack{
                    Text("Point 1 - X")
                    Spacer()
                    Text(String(format: "%.2f", fx.insetPointX0))
                }
                            


                Slider(value: $fx.insetPointX0, in: 0...Float(fx.size.height), onEditingChanged: {editing in
                    applyFilter(editing)
                })
                    .onChange(of: fx.insetPointX0) { newValue in
                        applyFilter()
                    }

                HStack{
                    Text("Point 1 - Y")
                    Spacer()
                    Text(String(format: "%.2f", fx.insetPointY0))
                }
                

                Slider(value: $fx.insetPointY0, in: 0...Float(fx.size.height), onEditingChanged: {editing in
                    applyFilter(editing)
                })
                    .onChange(of: fx.insetPointY0) { newValue in
                        applyFilter()
                    }

                HStack{
                    Text("Point 2 - X")
                    Spacer()
                    Text(String(format: "%.2f", fx.insetPointX1))
                }
       
                Slider(value: $fx.insetPointX1, in: 0...Float(fx.size.width), onEditingChanged: {editing in
                    applyFilter(editing)
                })
                    .onChange(of: fx.insetPointX1) { newValue in
                        applyFilter()
                    }

                HStack{
                    Text("Point 2 - Y")
                    Spacer()
                    Text(String(format: "%.2f", fx.insetPointY1))
                }

                Slider(value: $fx.insetPointY1, in: 0...Float(fx.size.height), onEditingChanged: {editing in
                    applyFilter(editing)
                })
                    .onChange(of: fx.insetPointY1) { newValue in
                        applyFilter()
                    }
            }
            
        }
        
        Section(header: Text("Options")){
            
            HStack{
                Text("Strands")
                Spacer()
                Text(String(format: "%.2f", fx.strands))
            }

            Slider(value: $fx.strands, in: -2...2, onEditingChanged: {editing in
                applyFilter(editing)
            })
                .onChange(of: fx.strands) { newValue in
                    applyFilter()
                }
        
            HStack{
                Text("Periodicity")
                Spacer()
                Text(String(format: "%.2f", fx.periodicity))
            }

            Slider(value: $fx.periodicity, in: 1...5, onEditingChanged: {editing in
                applyFilter(editing)
            })
                .onChange(of: fx.periodicity) { newValue in
                    applyFilter()
                }
            HStack{
                Text("Rotation")
                Spacer()
                Text(String(format: "%.0f", round(fx.rotation * 180/Float.pi)))
            }

            Slider(value: $fx.rotation, in: 0...2*3.14, onEditingChanged: {editing in
                applyFilter(editing)
            })
                .onChange(of: fx.rotation) { newValue in
                    applyFilter()
                }
            HStack{
                Text("Zoom")
                Spacer()
                Text(String(format: "%.2f", fx.zoom))
            }

            Slider(value: $fx.zoom, in: 0...5, onEditingChanged: {editing in
                applyFilter(editing)
            })
                .onChange(of: fx.strands) { newValue in
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

