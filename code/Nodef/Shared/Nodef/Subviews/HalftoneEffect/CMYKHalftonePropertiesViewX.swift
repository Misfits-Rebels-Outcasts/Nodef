//
//  Copyright © 2022 James Boo. All rights reserved.
//


import SwiftUI
@available(iOS 15.0, *)
struct CMYKHalftonePropertiesViewX: View {
    //@Environment(\.verticalSizeClass) var verticalSizeClass: UserInterfaceSizeClass?
    //@Environment(\.horizontalSizeClass) var horizontalSizeClass: UserInterfaceSizeClass?
    @EnvironmentObject var appSettings: AppSettings
    @ObservedObject var fx: CMYKHalftoneFX = CMYKHalftoneFX()
    var parent: FilterPropertiesViewX

    var body: some View {

        Section(header: Text("Options")){
            
            HStack{
                Text("Center X")
                Spacer()
                Text(String(format: "%.2f", fx.centerX))
            }
                       
            /*
            Slider(value: $fx.centerX, in: 0...fx.size.width )
                .onChange(of: fx.centerX) { newValue in
                    applyFilter()
                }
             */
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

            /*
            Slider(value: $fx.centerY, in: 0...fx.size.height )
                .onChange(of: fx.centerY) { newValue in
                    applyFilter()
            }
             */
            Slider(value: $fx.centerY, in: 0...Float(fx.size.height), onEditingChanged: {editing in
                applyFilter(editing)
            })
                .onChange(of: fx.centerY) { newValue in
                    applyFilter()
            }

            Group{
                HStack{
                    Text("Width")
                    Spacer()
                    Text(String(format: "%.2f", fx.width))
                }
                /*
                Slider(value: $fx.width, in: 0...100 )
                    .onChange(of: fx.width) { newValue in
                        applyFilter()
                    }
                 */
                Slider(value: $fx.width, in: 0...100, onEditingChanged: {editing in
                    applyFilter(editing)
                })
                    .onChange(of: fx.width) { newValue in
                        applyFilter()
                    }

                HStack{
                    Text("Angle")
                    Spacer()
                    Text(String(format: "%.0f", round(fx.angle * 180/Float.pi)))
                }

                /*
                Slider(value: $fx.angle, in: 0...2*3.14) //revisit
                    .onChange(of: fx.angle) { newValue in
                        applyFilter()
                    }
                 */

                Slider(value: $fx.angle, in: 0...2*3.14, onEditingChanged: {editing in
                    applyFilter(editing)
                })
                    .onChange(of: fx.angle) { newValue in
                        applyFilter()
                    }

                HStack{
                    Text("Sharpness")
                    Spacer()
                    Text(String(format: "%.2f", fx.sharpness))
                }
                
                /*
                Slider(value: $fx.sharpness, in: 0...1 )
                    .onChange(of: fx.sharpness) { newValue in
                        applyFilter()
                    }
                 */
                Slider(value: $fx.sharpness, in: 0...1, onEditingChanged: {editing in
                    applyFilter(editing)
                })
                    .onChange(of: fx.sharpness) { newValue in
                        applyFilter()
                    }

                HStack{
                    Text("GCR")
                    Spacer()
                    Text(String(format: "%.2f", fx.GCR))
                }
                
                /*
                Slider(value: $fx.GCR, in: 0...1 )
                    .onChange(of: fx.GCR) { newValue in
                        applyFilter()
                    }
                 */
                Slider(value: $fx.GCR, in: 0...1, onEditingChanged: {editing in
                    applyFilter(editing)
                })
                    .onChange(of: fx.GCR) { newValue in
                        applyFilter()
                    }
                


                HStack{
                    Text("UCR")
                    Spacer()
                    Text(String(format: "%.2f", fx.UCR))
                }
                /*
                Slider(value: $fx.UCR, in: 0...1 )
                    .onChange(of: fx.UCR) { newValue in
                        applyFilter()
                    }
                 */
                Slider(value: $fx.UCR, in: 0...1, onEditingChanged: {editing in
                    applyFilter(editing)
                })
                    .onChange(of: fx.UCR) { newValue in
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

