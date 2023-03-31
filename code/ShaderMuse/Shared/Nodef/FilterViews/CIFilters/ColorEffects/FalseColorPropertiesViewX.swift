//
//  Copyright © 2022 James Boo. All rights reserved.
//



import SwiftUI
@available(iOS 15.0, *)
struct FalseColorPropertiesViewX: View {
    @Environment(\.verticalSizeClass) var verticalSizeClass: UserInterfaceSizeClass?
    @Environment(\.horizontalSizeClass) var horizontalSizeClass: UserInterfaceSizeClass?
    @EnvironmentObject var appSettings: AppSettings
    //@EnvironmentObject var shapes: ShapesX

    var colors=["black","blue","clear","cyan","gray","green","magenta","red","yellow","white"]
    
    @ObservedObject var fx: FalseColorFX = FalseColorFX()
    var parent: FilterPropertiesViewX

    var body: some View {

        Section(header: Text("Options")){
            
            HStack{
                Text("Color 1")
                Spacer()
                
                ColorPicker("", selection: $fx.colorx0, supportsOpacity: true)
                  .onChange(of: fx.colorx0) { newValue in

#if targetEnvironment(macCatalyst)
                      fx.color0=CIColor(cgColor: newValue.cgColor!)
#else
                      fx.color0=CIColor(color: UIColor(newValue))
#endif
                      parent.applyFilter()
                  }.frame(width:100, height:30, alignment: .trailing)
            }
            HStack{
                Text("Color 2")
                Spacer()
                ColorPicker("", selection: $fx.colorx1, supportsOpacity: true)
                  .onChange(of: fx.colorx1) { newValue in

#if targetEnvironment(macCatalyst)
                      fx.color1=CIColor(cgColor: newValue.cgColor!)
#else
                      fx.color1=CIColor(color: UIColor(newValue))
#endif
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
            //if appSettings.imageRes != "High Resolution"
            //{
                //parent.applyFilter()
            //}
        }
        else{
            parent.applyFilter()
        }
    }
    
    func applyFilter() {
        if appSettings.imageRes != "High Resolution"
        {
            parent.applyFilter()
        }
    }
  
    func setupViewModel()
    {
        //colorControlsFX.brightness=

    }
}

