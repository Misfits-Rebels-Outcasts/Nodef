//
//  Copyright © 2022 James Boo. All rights reserved.
//


import SwiftUI

@available(iOS 15.0, *)
struct ExposureAdjustPropertiesViewX: View {
    @Environment(\.verticalSizeClass) var verticalSizeClass: UserInterfaceSizeClass?
    @Environment(\.horizontalSizeClass) var horizontalSizeClass: UserInterfaceSizeClass?
    @EnvironmentObject var appSettings: AppSettings
    @ObservedObject var fx: ExposureAdjustFX = ExposureAdjustFX()
    var parent: FilterPropertiesViewX

    var body: some View {

        Section(header: Text("Options")){
            HStack{
                Text("EV")
                Spacer()
                Text(String(format: "%.2f", fx.ev))
            }
            
            /*
            Slider(value: $fx.ev, in: -10...10 )
                .onChange(of: fx.ev) { newValue in
                    //print("id",colorControlsFX.id)
                    applyFilter()
                }
             */
            Slider(value: $fx.ev, in: -10...10 , onEditingChanged: {editing in
                print(editing)
                applyFilter(editing)
            })
                .onChange(of: fx.ev) { newValue in
                    //print("id",colorControlsFX.id)
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

