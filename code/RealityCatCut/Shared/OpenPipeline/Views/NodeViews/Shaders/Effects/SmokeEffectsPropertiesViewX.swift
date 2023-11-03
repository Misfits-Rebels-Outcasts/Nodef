//
//  Copyright © 2022 James Boo. All rights reserved.
//


import SwiftUI
@available(iOS 15.0, *)
struct SmokeEffectsPropertiesViewX: View, NodeProperties {

    @EnvironmentObject var appSettings: AppSettings
    @ObservedObject var fx: SmokeEffectsFX = SmokeEffectsFX()
    var parent: FilterPropertiesViewX?

    var body: some View {

        Section(header: Text("Options")){
            HStack{
                Text("Time Elapsed*")
                Spacer()
                Text(String(format: "%.2f", fx.timeElapsed))
            }
            
            Slider(value: $fx.timeElapsed, in: 0...appSettings.videoDuration, onEditingChanged: {editing in
                if editing == false{
                    fx.regenerate=true
                    timeElapsedX = Double(fx.timeElapsed)
                    applyFilter(editing)
                }
            })
                .onChange(of: fx.timeElapsed) { oldValue, newValue in
                    //print("id",colorControlsFX.id)
                    //applyFilter()
                    //fx.regenerate=true
                    //parent.applyFilter()
                }
/*
            HStack{
                Text("Animation Type")
                Spacer()
                Text(String(format: "%.2f", fx.animType))
            }
            
            Slider(value: $fx.animType, in: 0...5, step:1, onEditingChanged: {editing in
                if editing == false{
                    fx.regenerate=true
                    applyFilter(editing)
                }
            })
                .onChange(of: fx.animType) { newValue in
                    //print("id",colorControlsFX.id)
                    //applyFilter()
                    //fx.regenerate=true
                    //parent.applyFilter()
                }
*/
        }
        .onAppear(perform: setupViewModel)
        //Section(header: Text(""), footer: Text("")){
        //}
    }

    
    func setupViewModel()
    {
        //colorControlsFX.brightness=

    }
}

