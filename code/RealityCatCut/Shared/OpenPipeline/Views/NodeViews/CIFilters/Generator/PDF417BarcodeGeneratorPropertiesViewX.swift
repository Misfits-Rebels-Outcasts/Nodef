//
//  Copyright © 2022 James Boo. All rights reserved.
//



import SwiftUI
@available(iOS 15.0, *)
struct PDF417BarcodeGeneratorPropertiesViewX: View, NodeProperties {

    
    @ObservedObject var fx: PDF417BarcodeGeneratorFX = PDF417BarcodeGeneratorFX()
    var parent: FilterPropertiesViewX?

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
    


    func setupViewModel()
    {
        //colorControlsFX.brightness=

    }
}

