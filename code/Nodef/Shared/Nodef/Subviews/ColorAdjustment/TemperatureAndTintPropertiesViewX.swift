//
//  Copyright © 2022 James Boo. All rights reserved.
//


import SwiftUI


@available(iOS 15.0, *)
struct TemperatureAndTintPropertiesViewX: View {
    @Environment(\.verticalSizeClass) var verticalSizeClass: UserInterfaceSizeClass?
    @Environment(\.horizontalSizeClass) var horizontalSizeClass: UserInterfaceSizeClass?
    @EnvironmentObject var appSettings: AppSettings
    //@EnvironmentObject var pageSettings: PageSettings
    //@EnvironmentObject var shapes: ShapesX
    
    @ObservedObject var fx: TemperatureAndTintFX = TemperatureAndTintFX()
    var parent: FilterPropertiesViewX
    var body: some View {

        Section(header: Text("Neutral")){
            Group
            {
                HStack{
                    Text("Neutral Temperature")
                    Spacer()
                    Text(String(format: "%.2f", fx.neutralTemperature))
                }
                
                Slider(value: $fx.neutralTemperature, in: 6500-6500...6500+5500, onEditingChanged: {editing in
                    applyFilter(editing)
                })
                    .onChange(of: fx.neutralTemperature) { newValue in
                        applyFilter()
                    }
                
                HStack{
                    Text("Neutral Tint")
                    Spacer()
                    Text(String(format: "%.2f", fx.neutralTint))
                }
                
                Slider(value: $fx.neutralTint, in: -100...100, onEditingChanged: {editing in
                    applyFilter(editing)
                })
                    .onChange(of: fx.neutralTint) { newValue in
                        applyFilter()
                    }
            }
        }
        
        Section(header: Text("Target Neutral")){
            Group
            {
                HStack{
                    Text("Target Neutral Temperature")
                    Spacer()
                    Text(String(format: "%.2f", fx.targetNeutralTemperature))
                }
                
                Slider(value: $fx.targetNeutralTemperature, in: 6500-6500...6500+5500, onEditingChanged: {editing in
                    applyFilter(editing)
                })
                    .onChange(of: fx.targetNeutralTemperature) { newValue in
                        applyFilter()
                    }
                
                HStack{
                    Text("Target Neutral Tint")
                    Spacer()
                    Text(String(format: "%.2f", fx.targetNeutralTint))
                }
                
                Slider(value: $fx.targetNeutralTint, in: -100...100, onEditingChanged: {editing in
                    applyFilter(editing)
                })
                    .onChange(of: fx.targetNeutralTint) { newValue in
                        applyFilter()
                    }
            }
        }
    
/*
        Section(header: Text("Options")){
            
            
          
           
           
        }
        .onAppear(perform: setupViewModel)
 */
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

