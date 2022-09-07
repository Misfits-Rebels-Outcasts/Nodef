//
//  Copyright © 2022 James Boo. All rights reserved.
//



import SwiftUI
@available(iOS 15.0, *)
struct HistogramDisplayFilterPropertiesViewX: View {
    @Environment(\.verticalSizeClass) var verticalSizeClass: UserInterfaceSizeClass?
    @Environment(\.horizontalSizeClass) var horizontalSizeClass: UserInterfaceSizeClass?
    @EnvironmentObject var appSettings: AppSettings
  
    
    @ObservedObject var fx: HistogramDisplayFilterFX = HistogramDisplayFilterFX()
    var parent: FilterPropertiesViewX

    var body: some View {

        Section(header: Text("Options")){
            HStack{
                Text("Height")
                Spacer()
                Text(String(format: "%.2f", fx.height))
            }
                        
            Slider(value: $fx.height, in: 1...100, onEditingChanged: {editing in
                applyFilter(editing)
            })
                .onChange(of: fx.x) { newValue in
                    applyFilter()
                }
            
            HStack{
                Text("High Limit")
                Spacer()
                Text(String(format: "%.2f", fx.highLimit))
            }
                        
            Slider(value: $fx.highLimit, in: 0...1, onEditingChanged: {editing in
                applyFilter(editing)
            })
                .onChange(of: fx.x) { newValue in
                    applyFilter()
                }
            
            HStack{
                Text("Low Limit")
                Spacer()
                Text(String(format: "%.2f", fx.lowLimit))
            }
                        
            Slider(value: $fx.lowLimit, in: 0...1, onEditingChanged: {editing in
                applyFilter(editing)
            })
                .onChange(of: fx.x) { newValue in
                    applyFilter()
                }
        }
        
        Section(header: Text("Histogram Area")){
            HStack{
                Text("Count")
                Spacer()
                Text(String(format: "%.2f", fx.count))
            }
                        
            Slider(value: $fx.count, in: 1...1000, onEditingChanged: {editing in
                applyFilter(editing)
            })
                .onChange(of: fx.x) { newValue in
                    applyFilter()
                }
            
            HStack{
                Text("Scale")
                Spacer()
                Text(String(format: "%.2f", fx.scale))
            }
                        
            Slider(value: $fx.scale, in: 1...500, onEditingChanged: {editing in
                applyFilter(editing)
            })
                .onChange(of: fx.x) { newValue in
                    applyFilter()
                }
        }
        
        Section(header: Text("Region of Interest")){
            
            Group{
                HStack{
                    Text("X")
                    Spacer()
                    Text(String(format: "%.2f", fx.x))
                }
                            
                Slider(value: $fx.x, in: 0...Float(fx.size.width), onEditingChanged: {editing in
                    applyFilter(editing)
                })
                    .onChange(of: fx.x) { newValue in
                        applyFilter()
                    }

                HStack{
                    Text("Y")
                    Spacer()
                    Text(String(format: "%.2f", fx.y))
                }

                Slider(value: $fx.y, in: 0...Float(fx.size.height) , onEditingChanged: {editing in
                    applyFilter(editing)
                })
                    .onChange(of: fx.y) { newValue in
                        applyFilter()
                    }

                HStack{
                    Text("Width")
                    Spacer()
                    Text(String(format: "%.2f", fx.extentWidth))
                }
                            
                Slider(value: $fx.extentWidth, in: 0...Float(fx.size.width), onEditingChanged: {editing in
                    applyFilter(editing)
                })
                    .onChange(of: fx.extentWidth) { newValue in
                        applyFilter()
                    }
                
                HStack{
                    Text("Height")
                    Spacer()
                    Text(String(format: "%.2f", fx.extentHeight))
                }
                            
                Slider(value: $fx.extentHeight, in: 0...Float(fx.size.height), onEditingChanged: {editing in
                    applyFilter(editing)
                })
                    .onChange(of: fx.extentHeight) { newValue in
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

