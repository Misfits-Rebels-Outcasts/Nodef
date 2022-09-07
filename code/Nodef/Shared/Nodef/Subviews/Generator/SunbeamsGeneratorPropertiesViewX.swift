//
//  Copyright © 2022 James Boo. All rights reserved.
//


import SwiftUI
@available(iOS 15.0, *)
struct SunbeamsGeneratorPropertiesViewX: View {
    @Environment(\.verticalSizeClass) var verticalSizeClass: UserInterfaceSizeClass?
    @Environment(\.horizontalSizeClass) var horizontalSizeClass: UserInterfaceSizeClass?
    @EnvironmentObject var appSettings: AppSettings
  

    
    @ObservedObject var fx: SunbeamsGeneratorFX = SunbeamsGeneratorFX()
    var parent: FilterPropertiesViewX

    var body: some View {

        Section(header: Text("Options")){
            
            HStack{
                Text("Time")
                Spacer()
                Text(String(format: "%.2f", fx.time))
            }
            
            //revisit time 0..1?
            Slider(value: $fx.time, in: 0...1, onEditingChanged: {editing in
                applyFilter(editing)
            })
                .onChange(of: fx.time) { newValue in
    
                    applyFilter()
                }
            
            Group{
                HStack{
                    Text("Center X")
                    Spacer()
                    Text(String(format: "%.2f", fx.centerX))
                }
                            
       
                Slider(value: $fx.centerX, in: 0...Float(fx.size.width), onEditingChanged: {editing in
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
          
                Slider(value: $fx.centerY, in: 0...Float(fx.size.height), onEditingChanged: {editing in
                    applyFilter(editing)
                })
                    .onChange(of: fx.centerY) { newValue in
                        applyFilter()
                    }

         
                HStack{
                    Text("Color")
                    Spacer()
                    ColorPicker("", selection: $fx.colorx, supportsOpacity: false)
                      .onChange(of: fx.colorx) { newValue in
                          fx.color=CIColor(color: UIColor(newValue))
                          parent.applyFilter()
                      }.frame(width:100, height:30, alignment: .trailing)
                }
                
                //revisit all properties min max
                HStack{
                    Text("Sun Radius")
                    Spacer()
                    Text(String(format: "%.2f", fx.sunRadius))
                }
           
                Slider(value: $fx.sunRadius, in: 0...800, onEditingChanged: {editing in
                    applyFilter(editing)
                })
                    .onChange(of: fx.sunRadius) { newValue in
                        //print("id",fx.id)
                        applyFilter()
                    }
            }
            


            Group {
        
                HStack{
                    Text("Max Striation Radius")
                    Spacer()
                    Text(String(format: "%.2f", fx.maxStriationRadius))
                }
                
                Slider(value: $fx.maxStriationRadius, in: 0...10, onEditingChanged: {editing in
                    applyFilter(editing)
                })
                    .onChange(of: fx.maxStriationRadius) { newValue in
                        //print("id",fx.id)
                        applyFilter()
                    }
                
                HStack{
                    Text("Striation Strength")
                    Spacer()
                    Text(String(format: "%.2f", fx.striationStrength))
                }
                

                Slider(value: $fx.striationStrength, in: 0...3.0, onEditingChanged: {editing in
                    applyFilter(editing)
                })
                    .onChange(of: fx.striationStrength) { newValue in
                        //print("id",fx.id)
                        applyFilter()
                    }

                HStack{
                    Text("Striation Contrast")
                    Spacer()
                    Text(String(format: "%.2f", fx.striationContrast))
                }
                
                Slider(value: $fx.striationContrast, in: 0...5, onEditingChanged: {editing in
                    applyFilter(editing)
                })
                    .onChange(of: fx.striationContrast) { newValue in
                        //print("id",fx.id)
                        applyFilter()
                    }



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

