//
//  Copyright © 2022 James Boo. All rights reserved.
//


import SwiftUI
@available(iOS 15.0, *)
struct TortiseShellPropertiesViewX: View, NodeProperties {

    @EnvironmentObject var appSettings: AppSettings

    @ObservedObject var fx: TortiseShellVoronoiFX = TortiseShellVoronoiFX()
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

                }
/*
            HStack{
                Text("Color")
                Spacer()
                ColorPicker("", selection: $fx.colorx, supportsOpacity: true)
                  .onChange(of: fx.colorx) { newValue in
                    #if targetEnvironment(macCatalyst)
                      fx.color=CIColor(cgColor: newValue.cgColor!)
                    #else
                      fx.color=CIColor(color: UIColor(newValue))
                    #endif
                      parent.applyFilter()
                  }.frame(width:100, height:30, alignment: .trailing)
            }
  */
        }
        .onAppear(perform: setupViewModel)

    }

    func setupViewModel()
    {

    }
}

