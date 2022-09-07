//
//  Copyright © 2022 James Boo. All rights reserved.
//


import SwiftUI
@available(iOS 15.0, *)
struct SpotColorPropertiesViewX: View {
    @Environment(\.verticalSizeClass) var verticalSizeClass: UserInterfaceSizeClass?
    @Environment(\.horizontalSizeClass) var horizontalSizeClass: UserInterfaceSizeClass?
    @EnvironmentObject var appSettings: AppSettings
  
    
    @ObservedObject var fx: SpotColorFX = SpotColorFX()
    var parent: FilterPropertiesViewX

    var body: some View {

        Section(header: Text("Color 1")){
            
            HStack{
                Text("Center Color")
                Spacer()
                
                ColorPicker("", selection: $fx.centerColorx1, supportsOpacity: false)
                  .onChange(of: fx.centerColorx1) { newValue in
                      fx.centerColor1=CIColor(color: UIColor(newValue))
                      parent.applyFilter()
                  }.frame(width:100, height:30, alignment: .trailing)
            }
            
            HStack{
                Text("Replacement Color")
                Spacer()
                
                ColorPicker("", selection: $fx.replacementColorx1, supportsOpacity: false)
                  .onChange(of: fx.replacementColorx1) { newValue in
                      fx.replacementColor1=CIColor(color: UIColor(newValue))
                      parent.applyFilter()
                  }.frame(width:100, height:30, alignment: .trailing)
            }
            
            HStack{
                Text("Closeness")
                Spacer()
                Text(String(format: "%.2f", fx.closeness1))
            }

            Slider(value: $fx.closeness1, in: 0...0.5, onEditingChanged: {editing in
                applyFilter(editing)
            })
                .onChange(of: fx.closeness1) { newValue in
                    applyFilter()
                }
            
            HStack{
                Text("Contrast")
                Spacer()
                Text(String(format: "%.2f", fx.contrast1))
            }

            Slider(value: $fx.contrast1, in: 0...1, onEditingChanged: {editing in
                applyFilter(editing)
            })
                .onChange(of: fx.contrast1) { newValue in
                    applyFilter()
                }

        }
        .onAppear(perform: setupViewModel)
        
        Section(header: Text("Color 2")){
            
            HStack{
                Text("Center Color")
                Spacer()
                
                ColorPicker("", selection: $fx.centerColorx2, supportsOpacity: false)
                  .onChange(of: fx.centerColorx2) { newValue in
                      fx.centerColor2=CIColor(color: UIColor(newValue))
                      parent.applyFilter()
                  }.frame(width:100, height:30, alignment: .trailing)
            }
            
            HStack{
                Text("Replacement Color")
                Spacer()
                
                ColorPicker("", selection: $fx.replacementColorx2, supportsOpacity: false)
                  .onChange(of: fx.replacementColorx2) { newValue in
                      fx.replacementColor2=CIColor(color: UIColor(newValue))
                      parent.applyFilter()
                  }.frame(width:100, height:30, alignment: .trailing)
            }
            
            HStack{
                Text("Closeness")
                Spacer()
                Text(String(format: "%.2f", fx.closeness2))
            }

            Slider(value: $fx.closeness2, in: 0...0.5, onEditingChanged: {editing in
                applyFilter(editing)
            })
                .onChange(of: fx.closeness2) { newValue in
                    applyFilter()
                }
            
            HStack{
                Text("Contrast")
                Spacer()
                Text(String(format: "%.2f", fx.contrast2))
            }

            Slider(value: $fx.contrast2, in: 0...1, onEditingChanged: {editing in
                applyFilter(editing)
            })
                .onChange(of: fx.contrast2) { newValue in
                    applyFilter()
                }

        }
        
        Section(header: Text("Color 3")){
            
            HStack{
                Text("Center Color")
                Spacer()
                
                ColorPicker("", selection: $fx.centerColorx3, supportsOpacity: false)
                  .onChange(of: fx.centerColorx3) { newValue in
                      fx.centerColor3=CIColor(color: UIColor(newValue))
                      parent.applyFilter()
                  }.frame(width:100, height:30, alignment: .trailing)
            }
            
            HStack{
                Text("Replacement Color")
                Spacer()
                
                ColorPicker("", selection: $fx.replacementColorx3, supportsOpacity: false)
                  .onChange(of: fx.replacementColorx3) { newValue in
                      fx.replacementColor3=CIColor(color: UIColor(newValue))
                      parent.applyFilter()
                  }.frame(width:100, height:30, alignment: .trailing)
            }
            
            HStack{
                Text("Closeness")
                Spacer()
                Text(String(format: "%.2f", fx.closeness3))
            }

            Slider(value: $fx.closeness3, in: 0...0.5, onEditingChanged: {editing in
                applyFilter(editing)
            })
                .onChange(of: fx.closeness3) { newValue in
                    applyFilter()
                }
            
            HStack{
                Text("Contrast")
                Spacer()
                Text(String(format: "%.2f", fx.contrast3))
            }

            Slider(value: $fx.contrast3, in: 0...1, onEditingChanged: {editing in
                applyFilter(editing)
            })
                .onChange(of: fx.contrast3) { newValue in
                    applyFilter()
                }

        }
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

