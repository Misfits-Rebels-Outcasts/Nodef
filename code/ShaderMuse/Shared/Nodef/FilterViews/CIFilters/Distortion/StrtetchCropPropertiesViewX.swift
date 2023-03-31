//
//  Copyright © 2022 James Boo. All rights reserved.
//


import SwiftUI
@available(iOS 15.0, *)
struct StretchCropPropertiesViewX: View {
    @Environment(\.verticalSizeClass) var verticalSizeClass: UserInterfaceSizeClass?
    @Environment(\.horizontalSizeClass) var horizontalSizeClass: UserInterfaceSizeClass?
    @EnvironmentObject var appSettings: AppSettings
    //@EnvironmentObject var shapes: ShapesX
    
    @ObservedObject var fx: StretchCropFX = StretchCropFX()
    var parent: FilterPropertiesViewX

    var body: some View {

        Section(header: Text("Output Image Size")){
            
            Group{
                HStack{
                    Text("Width")
                    Spacer()
                    Text(String(format: "%.2f", fx.cropWidth))
                }
                        
                Slider(value: $fx.cropWidth, in: 0...Float(5*fx.size.width), onEditingChanged: {editing in
                    applyFilter(editing)
                })
                    .onChange(of: fx.cropWidth) { newValue in
                        applyFilter()
                    }
                HStack{
                    Text("Height")
                    Spacer()
                    Text(String(format: "%.2f", fx.cropHeight))
                }
       
                Slider(value: $fx.cropHeight, in: 0...Float(5*fx.size.height), onEditingChanged: {editing in
                    applyFilter(editing)
                })
                    .onChange(of: fx.cropHeight) { newValue in
                        applyFilter()
                    }
            }
        
                        
        }
        
        Section(header: Text("Crop Amount"), footer: Text("This value determines if, and how much, cropping should be used to achieve the target size. If the value is 0, the image is stretched but not cropped. If the value is 1, the image is cropped but not stretched. Values in-between use stretching and cropping proportionally.")){
            
            HStack{
                Text("Crop Amount")
                Spacer()
                Text(String(format: "%.2f", fx.cropAmount))
            }

            Slider(value: $fx.cropAmount, in: 0...1, onEditingChanged: {editing in
                applyFilter(editing)
            })
                .onChange(of: fx.cropAmount) { newValue in
                    applyFilter()
                }
        }
        Section(header: Text("Center Stretch"), footer: Text("A value of 0 causes the center of the image to maintain its original aspect ratio. A value of 1 causes the image to be stretched uniformly.")){
            HStack{
                Text("Center Stretch Amount")
                Spacer()
                Text(String(format: "%.2f", fx.centerStretchAmount))
            }

            Slider(value: $fx.centerStretchAmount, in: 0...1, onEditingChanged: {editing in
                applyFilter(editing)
            })
                .onChange(of: fx.centerStretchAmount) { newValue in
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

