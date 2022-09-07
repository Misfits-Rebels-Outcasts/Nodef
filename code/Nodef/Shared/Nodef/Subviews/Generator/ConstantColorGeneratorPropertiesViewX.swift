//
//  Copyright © 2022 James Boo. All rights reserved.
//


import SwiftUI
@available(iOS 15.0, *)
struct ConstantColorGeneratorPropertiesViewX: View {
    @Environment(\.verticalSizeClass) var verticalSizeClass: UserInterfaceSizeClass?
    @Environment(\.horizontalSizeClass) var horizontalSizeClass: UserInterfaceSizeClass?
    @EnvironmentObject var appSettings: AppSettings
  

    @ObservedObject var fx: ConstantColorGeneratorFX = ConstantColorGeneratorFX()
    var parent: FilterPropertiesViewX

    var body: some View {

        Section(header: Text("Options")){

            HStack{
                Text("Color")
                Spacer()
                ColorPicker("", selection: $fx.colorx, supportsOpacity: false)
                  .onChange(of: fx.colorx) { newValue in
                      fx.color=CIColor(color: UIColor(newValue))
                      parent.applyFilter()
                  }.frame(width:100, height:30, alignment: .trailing)
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

