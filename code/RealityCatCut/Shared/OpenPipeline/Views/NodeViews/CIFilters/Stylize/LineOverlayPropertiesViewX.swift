//
//  Copyright © 2022 James Boo. All rights reserved.
//


import SwiftUI
@available(iOS 15.0, *)
struct LineOverlayPropertiesViewX: View, NodeProperties {

    
    @ObservedObject var fx: LineOverlayFX = LineOverlayFX()
    var parent: FilterPropertiesViewX?

    var body: some View {

        Section(header: Text("Options")){
            
            //revisit
            HStack{
                Text("Noise Level")
                Spacer()
                Text(String(format: "%.2f", fx.nRNoiseLevel))
            }

            Slider(value: $fx.nRNoiseLevel, in: 0...2, onEditingChanged: {editing in
                applyFilter(editing)
            })
                .onChange(of: fx.nRNoiseLevel) { oldValue, newValue in
                    applyFilter()
                }
            
            HStack{
                Text("Sharpness")
                Spacer()
                Text(String(format: "%.2f", fx.nRSharpness))
            }

            Slider(value: $fx.nRSharpness, in: 0...2, onEditingChanged: {editing in
                applyFilter(editing)
            })
                .onChange(of: fx.nRSharpness) { oldValue, newValue in
                    applyFilter()
                }
            
            HStack{
                Text("Edge Intensity")
                Spacer()
                Text(String(format: "%.2f", fx.edgeIntensity))
            }

            Slider(value: $fx.edgeIntensity, in: 0...200.0, onEditingChanged: {editing in
                applyFilter(editing)
            })
                .onChange(of: fx.edgeIntensity) { oldValue, newValue in
                    applyFilter()
                }
            
            HStack{
                Text("Threshold")
                Spacer()
                Text(String(format: "%.2f", fx.threshold))
            }

            Slider(value: $fx.threshold, in: 0...1.0, onEditingChanged: {editing in
                applyFilter(editing)
            })
                .onChange(of: fx.threshold) { oldValue, newValue in
                    applyFilter()
                }
            
            
            HStack{
                Text("Contrast")
                Spacer()
                Text(String(format: "%.2f", fx.contrast))
            }

            Slider(value: $fx.contrast, in: 0.25...200.0, onEditingChanged: {editing in
                applyFilter(editing)
            })
                .onChange(of: fx.contrast) { oldValue, newValue in
                    applyFilter()
                }
            
                  /*
                   inputNRNoiseLevel
                   Optional(0.0)
                   nil
                   nil
                   inputNRSharpness
                   Optional(0.0)
                   Optional(2.0)
                   nil
                   inputEdgeIntensity
                   Optional(0.0)
                   Optional(200.0)
                   Optional(1.0)
                   inputThreshold
                   Optional(0.0)
                   Optional(1.0)
                   nil
                   inputContrast
                   Optional(0.25)
                   Optional(200.0)
                   Optional(50.0)
                   
            HStack{
                Text("Strands")
                Spacer()
                Text(String(format: "%.2f", fx.strands))
            }

            Slider(value: $fx.strands, in: 0...100, onEditingChanged: {editing in
                applyFilter(editing)
            })
                .onChange(of: fx.strands) { newValue in
                    applyFilter()
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

