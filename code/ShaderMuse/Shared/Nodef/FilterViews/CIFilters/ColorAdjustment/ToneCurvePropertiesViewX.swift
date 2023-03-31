//
//  Copyright © 2022 James Boo. All rights reserved.
//



import SwiftUI


@available(iOS 15.0, *)
struct ToneCurvePropertiesViewX: View {
    @Environment(\.verticalSizeClass) var verticalSizeClass: UserInterfaceSizeClass?
    @Environment(\.horizontalSizeClass) var horizontalSizeClass: UserInterfaceSizeClass?
    @EnvironmentObject var appSettings: AppSettings
    //@EnvironmentObject var pageSettings: PageSettings
    //@EnvironmentObject var shapes: ShapesX
    
    @ObservedObject var fx: ToneCurveFX = ToneCurveFX()
    var parent: FilterPropertiesViewX
    var body: some View {

        Section(header: Text("Point 0")){
            
            HStack{
                Text("Point X0")
                Spacer()
                Text(String(format: "%.2f", fx.pointX0))
            }
                        
            Slider(value: $fx.pointX0, in: 0...1, onEditingChanged: {editing in
                applyFilter(editing)
            })
                .onChange(of: fx.pointX0) { newValue in
                    applyFilter()
                }

            HStack{
                Text("Point Y0")
                Spacer()
                Text(String(format: "%.2f", fx.pointY0))
            }

            Slider(value: $fx.pointY0, in: 0...1 , onEditingChanged: {editing in
                applyFilter(editing)
            })
                .onChange(of: fx.pointY0) { newValue in
                    applyFilter()
                }


        }
        
        
        Section(header: Text("Point 1")){
            
            HStack{
                Text("Point X1")
                Spacer()
                Text(String(format: "%.2f", fx.pointX1))
            }
                        
            Slider(value: $fx.pointX1, in: 0...1, onEditingChanged: {editing in
                applyFilter(editing)
            })
                .onChange(of: fx.pointX1) { newValue in
                    applyFilter()
                }

            HStack{
                Text("Point Y1")
                Spacer()
                Text(String(format: "%.2f", fx.pointY1))
            }

            Slider(value: $fx.pointY1, in: 0...1 , onEditingChanged: {editing in
                applyFilter(editing)
            })
                .onChange(of: fx.pointY1) { newValue in
                    applyFilter()
                }


        }
        
        Section(header: Text("Point 2")){
            
            HStack{
                Text("Point X2")
                Spacer()
                Text(String(format: "%.2f", fx.pointX2))
            }
                        
            Slider(value: $fx.pointX2, in: 0...1, onEditingChanged: {editing in
                applyFilter(editing)
            })
                .onChange(of: fx.pointX2) { newValue in
                    applyFilter()
                }

            HStack{
                Text("Point Y2")
                Spacer()
                Text(String(format: "%.2f", fx.pointY2))
            }

            Slider(value: $fx.pointY2, in: 0...1 , onEditingChanged: {editing in
                applyFilter(editing)
            })
                .onChange(of: fx.pointY2) { newValue in
                    applyFilter()
                }


        }
        
        Section(header: Text("Point 3")){
            
            HStack{
                Text("Point X3")
                Spacer()
                Text(String(format: "%.2f", fx.pointX3))
            }
                        
            Slider(value: $fx.pointX3, in: 0...1, onEditingChanged: {editing in
                applyFilter(editing)
            })
                .onChange(of: fx.pointX3) { newValue in
                    applyFilter()
                }

            HStack{
                Text("Point Y3")
                Spacer()
                Text(String(format: "%.2f", fx.pointY3))
            }

            Slider(value: $fx.pointY3, in: 0...1 , onEditingChanged: {editing in
                applyFilter(editing)
            })
                .onChange(of: fx.pointY3) { newValue in
                    applyFilter()
                }


        }
        
        Section(header: Text("Point 4")){
            
            HStack{
                Text("Point X4")
                Spacer()
                Text(String(format: "%.2f", fx.pointX4))
            }
                        
            Slider(value: $fx.pointX4, in: 0...1, onEditingChanged: {editing in
                applyFilter(editing)
            })
                .onChange(of: fx.pointX4) { newValue in
                    applyFilter()
                }

            HStack{
                Text("Point Y4")
                Spacer()
                Text(String(format: "%.2f", fx.pointY4))
            }

            Slider(value: $fx.pointY4, in: 0...1 , onEditingChanged: {editing in
                applyFilter(editing)
            })
                .onChange(of: fx.pointY4) { newValue in
                    applyFilter()
                }

        }
        
        //.onAppear(perform: setupViewModel)
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

