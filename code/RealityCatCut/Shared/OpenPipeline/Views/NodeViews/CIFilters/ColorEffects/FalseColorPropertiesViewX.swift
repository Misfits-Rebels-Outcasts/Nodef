//
//  Copyright © 2022 James Boo. All rights reserved.
//



import SwiftUI
@available(iOS 15.0, *)
struct FalseColorPropertiesViewX: View, NodeProperties {


    var colors=["black","blue","clear","cyan","gray","green","magenta","red","yellow","white"]
    
    @ObservedObject var fx: FalseColorFX = FalseColorFX()
    var parent: FilterPropertiesViewX?

    var body: some View {

        Section(header: Text("Options")){
            
            HStack{
                Text("Color 1")
                Spacer()
                
                ColorPicker("", selection: $fx.colorx0, supportsOpacity: true)
                  .onChange(of: fx.colorx0) {  oldValue, newValue in

#if targetEnvironment(macCatalyst)
                      fx.color0=CIColor(cgColor: newValue.cgColor!)
#else
                      fx.color0=CIColor(color: UIColor(newValue))
#endif
                      applyFilter()
                  }.frame(width:100, height:30, alignment: .trailing)
            }
            HStack{
                Text("Color 2")
                Spacer()
                ColorPicker("", selection: $fx.colorx1, supportsOpacity: true)
                  .onChange(of: fx.colorx1) {  oldValue, newValue in

#if targetEnvironment(macCatalyst)
                      fx.color1=CIColor(cgColor: newValue.cgColor!)
#else
                      fx.color1=CIColor(color: UIColor(newValue))
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

