//
//  Copyright © 2022 James Boo. All rights reserved.
//



import SwiftUI
@available(iOS 15.0, *)
struct TriangleKaleidoscopePropertiesViewX: View {
    @EnvironmentObject var appSettings: AppSettings
    @ObservedObject var fx: TriangleKaleidoscopeFX = TriangleKaleidoscopeFX()
    var parent: FilterPropertiesViewX

    var body: some View {

        Section(header: Text("Options")){
            
            
            HStack{
                Text("Point X")
                Spacer()
                Text(String(format: "%.2f", fx.pointX))
            }

            Slider(value: $fx.pointX, in: 0...Float(fx.size.width), onEditingChanged: {editing in
                applyFilter(editing)
            })
                .onChange(of: fx.pointX) { newValue in
                    applyFilter()
                }

            HStack{
                Text("Point Y")
                Spacer()
                Text(String(format: "%.2f", fx.pointY))
            }


            Slider(value: $fx.pointY, in: 0...Float(fx.size.height), onEditingChanged: {editing in
                applyFilter(editing)
            })
                .onChange(of: fx.pointY) { newValue in
                    applyFilter()
            }
            
            HStack{
                Text("Size")
                Spacer()
                Text(String(format: "%.2f", fx.tksize))
            }
            
   
            Slider(value: $fx.tksize, in: 0...1000, onEditingChanged: {editing in
                applyFilter(editing)
            })
                .onChange(of: fx.tksize) { newValue in
                    applyFilter()
                }
            //revisit
            HStack{
                Text("Rotation")
                Spacer()
                Text(String(format: "%.2f", fx.rotation))
            }

            Slider(value: $fx.rotation, in: 0...2*3.14, onEditingChanged: {editing in
                applyFilter(editing)
            })
                .onChange(of: fx.rotation) { newValue in
                    applyFilter()
                }

            HStack{
                Text("Decay")
                Spacer()
                Text(String(format: "%.2f", fx.decay))
            }

            Slider(value: $fx.decay, in: 0...1, onEditingChanged: {editing in
                applyFilter(editing)
            })
                .onChange(of: fx.decay) { newValue in
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
    func setupViewModel()
    {
        //colorControlsFX.brightness=

    }
}

