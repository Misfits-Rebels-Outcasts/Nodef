//
//  Copyright © 2022 James Boo. All rights reserved.
//


import SwiftUI
@available(iOS 15.0, *)
struct PerspectiveTilePropertiesViewX: View {
    @EnvironmentObject var appSettings: AppSettings
    @ObservedObject var fx: PerspectiveTileFX = PerspectiveTileFX()
    var parent: FilterPropertiesViewX

    var body: some View {

        Section(header: Text("Options")){
   
            Group{
                HStack{
                    Text("Top Left X")
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
                    Text("Top Left Y")
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
            
            Group{
                HStack{
                    Text("Top Right X")
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
                    Text("Top Right Y")
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


            Group
            {
                HStack{
                    Text("Bottom Right X")
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
                    Text("Bottom Right Y")
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
            
            Group{
                HStack{
                    Text("Bottom Left X")
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
                    Text("Bottom Left Y")
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
    func setupViewModel()
    {
        //colorControlsFX.brightness=

    }
}

