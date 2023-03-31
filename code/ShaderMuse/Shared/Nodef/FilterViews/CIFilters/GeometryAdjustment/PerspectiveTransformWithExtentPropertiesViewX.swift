//
//  Copyright © 2022 James Boo. All rights reserved.
//



import SwiftUI
@available(iOS 15.0, *)
struct PerspectiveTransformWithExtentPropertiesViewX: View {
    @Environment(\.verticalSizeClass) var verticalSizeClass: UserInterfaceSizeClass?
    @Environment(\.horizontalSizeClass) var horizontalSizeClass: UserInterfaceSizeClass?
    @EnvironmentObject var appSettings: AppSettings
    //@EnvironmentObject var shapes: ShapesX
    
    @ObservedObject var fx: PerspectiveTransformWithExtentFX = PerspectiveTransformWithExtentFX()
    var parent: FilterPropertiesViewX

    var body: some View {

        Section(header: Text("Portion of Image to apply transform")){
            HStack{
                Text("X")
                Spacer()
                Text(String(format: "%.2f", fx.x))
            }
            .onAppear(perform: setupViewModel)
            
            Slider(value: $fx.x, in: 0...Float(fx.size.width), onEditingChanged: {editing in
                applyFilter(editing)
            })
                .onChange(of: fx.x) { newValue in
                    applyFilter()
                }

            HStack{
                Text("Y")
                Spacer()
                Text(String(format: "%.2f", fx.y))
            }

            Slider(value: $fx.y, in: 0...Float(fx.size.height) , onEditingChanged: {editing in
                applyFilter(editing)
            })
                .onChange(of: fx.y) { newValue in
                    applyFilter()
                }

            HStack{
                Text("Width")
                Spacer()
                Text(String(format: "%.2f", fx.extentWidth))
            }
                        
            Slider(value: $fx.extentWidth, in: 0...Float(fx.size.width), onEditingChanged: {editing in
                applyFilter(editing)
            })
                .onChange(of: fx.extentWidth) { newValue in
                    applyFilter()
                }
            
            HStack{
                Text("Height")
                Spacer()
                Text(String(format: "%.2f", fx.extentHeight))
            }
                        
            Slider(value: $fx.extentHeight, in: 0...Float(fx.size.width), onEditingChanged: {editing in
                applyFilter(editing)
            })
                .onChange(of: fx.extentHeight) { newValue in
                    applyFilter()
                }
        }
        Section(header: Text("Top Left")){
            HStack{
                Text("X")
                Spacer()
                Text(String(format: "%.2f", fx.topLeftX))
            }

            Slider(value: $fx.topLeftX, in: 0...Float(fx.size.width), onEditingChanged: {editing in
                applyFilter(editing)
            })
                .onChange(of: fx.topLeftX) { newValue in
                    applyFilter()
                }
            
            HStack{
                Text("Y")
                Spacer()
                Text(String(format: "%.2f", fx.topLeftY))
            }
            Slider(value: $fx.topLeftY, in: 0...Float(fx.size.height), onEditingChanged: {editing in
                applyFilter(editing)
            })
                .onChange(of: fx.topLeftY) { newValue in
                    applyFilter()
                }
        }

        Section(header: Text("Top Right")){
            HStack{
                Text("X")
                Spacer()
                Text(String(format: "%.2f", fx.topRightX))
            }

            Slider(value: $fx.topRightX, in: 0...Float(fx.size.width), onEditingChanged: {editing in
                applyFilter(editing)
            })
                .onChange(of: fx.topRightX) { newValue in
                    applyFilter()
                }
            HStack{
                Text("Y")
                Spacer()
                Text(String(format: "%.2f", fx.topRightY))
            }
            Slider(value: $fx.topRightY, in: 0...Float(fx.size.height), onEditingChanged: {editing in
                applyFilter(editing)
            })
                .onChange(of: fx.topRightY) { newValue in
                    applyFilter()
                }
        }
        
        Section(header: Text("Bottom Left")){
            HStack{
                Text("X")
                Spacer()
                Text(String(format: "%.2f", fx.bottomLeftX))
            }

            Slider(value: $fx.bottomLeftX, in: 0...Float(fx.size.width), onEditingChanged: {editing in
                applyFilter(editing)
            })
                .onChange(of: fx.bottomLeftX) { newValue in
                    applyFilter()
                }

            HStack{
                Text("Y")
                Spacer()
                Text(String(format: "%.2f", fx.bottomLeftY))
            }
            Slider(value: $fx.bottomLeftY, in: 0...Float(fx.size.height), onEditingChanged: {editing in
                applyFilter(editing)
            })
                .onChange(of: fx.bottomLeftY) { newValue in
                    applyFilter()
                }
        }
        
        Section(header: Text("Bottom Right")){
            HStack{
                Text("X")
                Spacer()
                Text(String(format: "%.2f", fx.bottomRightX))
            }

            Slider(value: $fx.bottomRightX, in: 0...Float(fx.size.width), onEditingChanged: {editing in
                applyFilter(editing)
            })
                .onChange(of: fx.bottomRightX) { newValue in
                    applyFilter()
                }

            HStack{
                Text("Y")
                Spacer()
                Text(String(format: "%.2f", fx.bottomRightY))
            }
            Slider(value: $fx.bottomRightY, in: 0...Float(fx.size.height), onEditingChanged: {editing in
                applyFilter(editing)
            })
                .onChange(of: fx.bottomRightY) { newValue in
                    applyFilter()
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

