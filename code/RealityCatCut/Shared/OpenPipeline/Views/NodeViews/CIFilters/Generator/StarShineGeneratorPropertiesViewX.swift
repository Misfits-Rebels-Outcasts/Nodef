//
//  Copyright © 2022 James Boo. All rights reserved.
//



import SwiftUI
@available(iOS 15.0, *)
struct StarShineGeneratorPropertiesViewX: View, NodeProperties {


    @ObservedObject var fx: StarShineGeneratorFX = StarShineGeneratorFX()
    var parent: FilterPropertiesViewX?

    var body: some View {

        Section(header: Text("Options")){
            
            Group{
                HStack{
                    Text("Center X")
                    Spacer()
                    Text(String(format: "%.2f", fx.centerX))
                }
                            

                Slider(value: $fx.centerX, in: 0...Float(fx.size.width), onEditingChanged: {editing in
                    applyFilter(editing)
                })
                    .onChange(of: fx.centerX) { oldValue, newValue in
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
                    .onChange(of: fx.centerY) { oldValue, newValue in
                        applyFilter()
                    }


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
                
                HStack{
                    Text("Radius")
                    Spacer()
                    Text(String(format: "%.2f", fx.radius))
                }
             
                
                Slider(value: $fx.radius, in: 0...100, onEditingChanged: {editing in
                    applyFilter(editing)
                })
                    .onChange(of: fx.radius) { oldValue, newValue in
                        //print("id",fx.id)
                        applyFilter()
                    }

            }
            
            Group
            {
                HStack{
                    Text("Cross Scale")
                    Spacer()
                    Text(String(format: "%.2f", fx.crossScale))
                }
             
                
                Slider(value: $fx.crossScale, in: 0...100, onEditingChanged: {editing in
                    applyFilter(editing)
                })
                    .onChange(of: fx.crossScale) { oldValue, newValue in
                        //print("id",fx.id)
                        applyFilter()
                    }

                
                HStack{
                    Text("Cross Angle")
                    Spacer()
                    Text(String(format: "%.0f", round(fx.crossAngle * 180/Float.pi)))
                }
             
                Slider(value: $fx.crossAngle, in: 0...2*3.14, onEditingChanged: {editing in
                    applyFilter(editing)
                })
                    .onChange(of: fx.crossAngle) { oldValue, newValue in
                        applyFilter()
                    }

                HStack{
                    Text("Cross Opacity")
                    Spacer()
                    Text(String(format: "%.2f", fx.crossOpacity))
                }
             
                Slider(value: $fx.crossOpacity, in: -8.0...0.0, onEditingChanged: {editing in
                    applyFilter(editing)
                })
                    .onChange(of: fx.crossOpacity) { oldValue, newValue in
                        applyFilter()
                    }

                //revisit all min max here
                HStack{
                    Text("Cross Width")
                    Spacer()
                    Text(String(format: "%.2f", fx.crossWidth))
                }
             
                Slider(value: $fx.crossWidth, in: 0.5...10, onEditingChanged: {editing in
                    applyFilter(editing)
                })
                    .onChange(of: fx.crossWidth) { oldValue, newValue in
                        applyFilter()
                    }
                
                HStack{
                    Text("Epsilon")
                    Spacer()
                    Text(String(format: "%.2f", fx.epsilon))
                }
             
                Slider(value: $fx.epsilon, in: -8.0...0.0, onEditingChanged: {editing in
                    applyFilter(editing)
                })
                    .onChange(of: fx.epsilon) { oldValue, newValue in
                        applyFilter()
                    }

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

