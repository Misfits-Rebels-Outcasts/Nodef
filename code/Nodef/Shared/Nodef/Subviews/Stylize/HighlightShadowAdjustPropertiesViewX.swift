//
//  Copyright © 2022 James Boo. All rights reserved.
//


import SwiftUI


@available(iOS 15.0, *)
struct HighlightShadowAdjustPropertiesViewX: View {
    @Environment(\.verticalSizeClass) var verticalSizeClass: UserInterfaceSizeClass?
    @Environment(\.horizontalSizeClass) var horizontalSizeClass: UserInterfaceSizeClass?
    @EnvironmentObject var appSettings: AppSettings
    //@EnvironmentObject var pageSettings: PageSettings
    //@EnvironmentObject var shapes: ShapesX
    
    @ObservedObject var fx: HighlightShadowAdjustFX = HighlightShadowAdjustFX()
    var parent: FilterPropertiesViewX
    var body: some View {

        Section(header: Text("Options")){
            HStack{
                Text("Highlight Amount")
                
                Spacer()
                Text(String(format: "%.2f", fx.highlightAmount))
            }
            //revisit no range provided bby apple
            Slider(value: $fx.highlightAmount, in: -1.0...1.0, onEditingChanged: {editing in
                applyFilter(editing)
            })
                .onChange(of: fx.highlightAmount) { newValue in
                    applyFilter()
                }

            HStack{
                Text("Radius")
                
                Spacer()
                Text(String(format: "%.2f", fx.radius))
            }
          
            Slider(value: $fx.radius, in: 0...100, onEditingChanged: {editing in
                applyFilter(editing)
            })
                .onChange(of: fx.radius) { newValue in
                    applyFilter()
                }
            
            HStack{
                Text("Shadow Amount")
                Spacer()
                Text(String(format: "%.2f", fx.shadowAmount))
            }

            Slider(value: $fx.shadowAmount, in: -1.0...1.0, onEditingChanged: {editing in
                applyFilter(editing)
            })
                .onChange(of: fx.shadowAmount) { newValue in
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

