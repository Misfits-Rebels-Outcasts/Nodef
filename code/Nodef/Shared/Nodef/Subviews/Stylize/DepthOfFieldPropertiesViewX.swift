//
//  Copyright © 2022 James Boo. All rights reserved.
//



import SwiftUI
@available(iOS 15.0, *)
struct DepthOfFieldPropertiesViewX: View {
    @Environment(\.verticalSizeClass) var verticalSizeClass: UserInterfaceSizeClass?
    @Environment(\.horizontalSizeClass) var horizontalSizeClass: UserInterfaceSizeClass?
    @EnvironmentObject var appSettings: AppSettings
  
    
    @ObservedObject var fx: DepthOfFieldFX = DepthOfFieldFX()
    var parent: FilterPropertiesViewX

    var body: some View {

        //revisit unable to simulate depth of field
        Section(header: Text("Focused Region"), footer: Text("The focused region of the image stretches in a line between Point 1 and Point 2.")){
        HStack{
            Text("Point 1 - X")
            Spacer()
            Text(String(format: "%.2f", fx.pointX0))
        }
         
        Slider(value: $fx.pointX0, in: 0...Float(fx.size.width), onEditingChanged: {editing in
            applyFilter(editing)
        })
            .onChange(of: fx.pointX0) { newValue in
                applyFilter()
            }

        HStack{
            Text("Point 1 - Y")
            Spacer()
            Text(String(format: "%.2f", fx.pointY0))
        }
         
        Slider(value: $fx.pointY0, in: 0...Float(fx.size.height), onEditingChanged: {editing in
            applyFilter(editing)
        })
            .onChange(of: fx.pointY0) { newValue in
                applyFilter()
            }

            HStack{
                Text("Point 2 - X")
                Spacer()
                Text(String(format: "%.2f", fx.pointX1))
            }
             
            Slider(value: $fx.pointX1, in: 0...Float(fx.size.width), onEditingChanged: {editing in
                applyFilter(editing)
            })
                .onChange(of: fx.pointX1) { newValue in
                    applyFilter()
                }

            HStack{
                Text("Point 2 - Y")
                Spacer()
                Text(String(format: "%.2f", fx.pointY1))
            }
             
            Slider(value: $fx.pointY1, in: 0...Float(fx.size.height), onEditingChanged: {editing in
                applyFilter(editing)
            })
                .onChange(of: fx.pointY1) { newValue in
                    applyFilter()
                }
            
        }
        
        Section(header: Text("Options")){
            HStack{
                Text("Saturation")
                Spacer()
                Text(String(format: "%.2f", fx.saturation))
            }

            Slider(value: $fx.saturation, in: 0...10, onEditingChanged: {editing in
                applyFilter(editing)
            })
                .onChange(of: fx.saturation) { newValue in
                    applyFilter()
                }
            
            HStack{
                Text("Unsharp Mask Radius")
                Spacer()
                Text(String(format: "%.2f", fx.unsharpMaskRadius))
            }

            Slider(value: $fx.unsharpMaskRadius, in: 0...10, onEditingChanged: {editing in
                applyFilter(editing)
            })
                .onChange(of: fx.unsharpMaskRadius) { newValue in
                    applyFilter()
                }
            
            HStack{
                Text("Unsharp Mask Intensity")
                Spacer()
                Text(String(format: "%.2f", fx.unsharpMaskIntensity))
            }

            Slider(value: $fx.unsharpMaskIntensity, in: 0...10, onEditingChanged: {editing in
                applyFilter(editing)
            })
                .onChange(of: fx.unsharpMaskIntensity) { newValue in
                    applyFilter()
                }
            
            HStack{
                Text("Radius")
                Spacer()
                Text(String(format: "%.2f", fx.radius))
            }

            Slider(value: $fx.radius, in: 0...30, onEditingChanged: {editing in
                applyFilter(editing)
            })
                .onChange(of: fx.radius) { newValue in
                    applyFilter()
                }
                  /*
                   inputSaturation
                   Optional(0.0)
                   Optional(10.0)
                   Optional(1.5)
                   inputUnsharpMaskRadius
                   Optional(0.0)
                   Optional(10.0)
                   Optional(2.5)
                   inputUnsharpMaskIntensity
                   Optional(0.0)
                   Optional(10.0)
                   Optional(0.5)
                   inputRadius
                   Optional(0.0)
                   Optional(30.0)
                   Optional(6.0)
                   
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

