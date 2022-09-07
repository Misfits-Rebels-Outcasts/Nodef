//
//  Copyright © 2022 James Boo. All rights reserved.
//


import SwiftUI


@available(iOS 15.0, *)
struct MixPropertiesViewX: View {
    @Environment(\.verticalSizeClass) var verticalSizeClass: UserInterfaceSizeClass?
    @Environment(\.horizontalSizeClass) var horizontalSizeClass: UserInterfaceSizeClass?
    @EnvironmentObject var appSettings: AppSettings
    //@EnvironmentObject var pageSettings: PageSettings
    //@EnvironmentObject var shapes: ShapesX
    
    @ObservedObject var fx: MixFX = MixFX()
    var parent: FilterPropertiesViewX
    var body: some View {

        Section(header: Text("Options")){
            HStack{
                Text("Amount")
                Spacer()
                Text(String(format: "%.2f", fx.amount))
            }
            

            Slider(value: $fx.amount, in: 0.0...1.0, onEditingChanged: {editing in
                applyFilter(editing)
            })
                .onChange(of: fx.amount) { newValue in
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

