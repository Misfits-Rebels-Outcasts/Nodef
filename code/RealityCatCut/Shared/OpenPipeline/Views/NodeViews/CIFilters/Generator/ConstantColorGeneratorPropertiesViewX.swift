//
//  Copyright © 2022 James Boo. All rights reserved.
//


import SwiftUI
@available(iOS 15.0, *)
struct ConstantColorGeneratorPropertiesViewX: View, NodeProperties {


    @ObservedObject var fx: ConstantColorGeneratorFX = ConstantColorGeneratorFX()
    var parent: FilterPropertiesViewX?

    var body: some View {

        Section(header: Text("Options")){

            HStack{
                Text("Color")
                Spacer()
                ColorPicker("", selection: $fx.colorx, supportsOpacity: true)
                  .onChange(of: fx.colorx) { oldValue, newValue in
#if targetEnvironment(macCatalyst)
                      fx.color=CIColor(cgColor: newValue.cgColor!)
#else
                      fx.color=CIColor(color: UIColor(newValue))
#endif
                      applyFilter()
                  }.frame(width:100, height:30, alignment: .trailing)
            }
             
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

