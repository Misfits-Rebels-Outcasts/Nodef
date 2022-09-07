//
//  Copyright © 2022 James Boo. All rights reserved.
//



import SwiftUI
@available(iOS 15.0, *)
struct PDF417BarcodeGeneratorPropertiesViewX: View {
    @Environment(\.verticalSizeClass) var verticalSizeClass: UserInterfaceSizeClass?
    @Environment(\.horizontalSizeClass) var horizontalSizeClass: UserInterfaceSizeClass?
    @EnvironmentObject var appSettings: AppSettings
  
    
    @ObservedObject var fx: PDF417BarcodeGeneratorFX = PDF417BarcodeGeneratorFX()
    var parent: FilterPropertiesViewX

    var body: some View {

        Section(header: Text("Options")){
                  /*
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

