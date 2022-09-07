//
//  Copyright © 2022 James Boo. All rights reserved.
//



import SwiftUI
@available(iOS 15.0, *)
struct LenticularHaloGeneratorPropertiesViewX: View {
    @Environment(\.verticalSizeClass) var verticalSizeClass: UserInterfaceSizeClass?
    @Environment(\.horizontalSizeClass) var horizontalSizeClass: UserInterfaceSizeClass?
    @EnvironmentObject var appSettings: AppSettings
  
    
    @ObservedObject var fx: LenticularHaloGeneratorFX = LenticularHaloGeneratorFX()
    var parent: FilterPropertiesViewX

    var body: some View {

        Section(header: Text("Options")){
            HStack{
                Text("Time")
                Spacer()
                Text(String(format: "%.2f", fx.time))
            }
            
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
            
            HStack{
                Text("Halo Radius")
                Spacer()
                Text(String(format: "%.2f", fx.haloRadius))
            }

            Slider(value: $fx.haloRadius, in: 0...1000, onEditingChanged: {editing in
                applyFilter(editing)
            })
                .onChange(of: fx.haloRadius) { newValue in
                    //print("id",fx.id)
                    applyFilter()
                }


            Group {
                HStack{
                    Text("Halo Width")
                    Spacer()
                    Text(String(format: "%.2f", fx.haloWidth))
                }
 
                Slider(value: $fx.haloWidth, in: 0...300, onEditingChanged: {editing in
                    applyFilter(editing)
                })
                    .onChange(of: fx.haloWidth) { newValue in
                        //print("id",fx.id)
                        applyFilter()
                    }

                HStack{
                    Text("Halo Overlap")
                    Spacer()
                    Text(String(format: "%.2f", fx.haloOverlap))
                }
                

                Slider(value: $fx.haloOverlap, in: 0...1, onEditingChanged: {editing in
                    applyFilter(editing)
                })
                    .onChange(of: fx.haloOverlap) { newValue in
                        //print("id",fx.id)
                        applyFilter()
                    }

                HStack{
                    Text("Striation Strength")
                    Spacer()
                    Text(String(format: "%.2f", fx.striationStrength))
                }
                

                Slider(value: $fx.striationStrength, in: 0...3, onEditingChanged: {editing in
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


                //revisit time 0..1?
                Slider(value: $fx.time, in: 0...1, onEditingChanged: {editing in
                    applyFilter(editing)
                })
                    .onChange(of: fx.time) { newValue in
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
    
    func setupViewModel()
    {
        //colorControlsFX.brightness=

    }
}

