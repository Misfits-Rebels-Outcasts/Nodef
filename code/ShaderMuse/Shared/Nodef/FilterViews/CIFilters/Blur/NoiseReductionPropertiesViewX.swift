//
//  Copyright © 2022 James Boo. All rights reserved.
//


import SwiftUI
@available(iOS 15.0, *)
struct NoiseReductionPropertiesViewX: View {
    //@Environment(\.verticalSizeClass) var verticalSizeClass: UserInterfaceSizeClass?
    //@Environment(\.horizontalSizeClass) var horizontalSizeClass: UserInterfaceSizeClass?
    @EnvironmentObject var appSettings: AppSettings
    @ObservedObject var fx: NoiseReductionFX = NoiseReductionFX()
    var parent: FilterPropertiesViewX

    var body: some View {

        Section(header: Text("Options")){
            HStack{
                Text("Noise Level")
                Spacer()
                Text(String(format: "%.2f", fx.noiseLevel))
            }
            
            /*
            Slider(value: $fx.noiseLevel, in: 0...1 ) //revisit
                .onChange(of: fx.noiseLevel) { newValue in
                    applyFilter()
                }
             */
            
            Slider(value: $fx.noiseLevel, in: 0...1, onEditingChanged: {editing in
                applyFilter(editing)
            })
                .onChange(of: fx.noiseLevel) { newValue in
                    applyFilter()
                }

            HStack{
                Text("Sharpness")
                Spacer()
                Text(String(format: "%.2f", fx.sharpness))
            }
            
            /*
            Slider(value: $fx.sharpness, in: 0...2 )
                .onChange(of: fx.sharpness) { newValue in
                    applyFilter()
                }
             */
            Slider(value: $fx.sharpness, in: 0...2, onEditingChanged: {editing in
                applyFilter(editing)
            })
                .onChange(of: fx.sharpness) { newValue in
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
    func setupViewModel()
    {
        //colorControlsFX.brightness=

    }
}

