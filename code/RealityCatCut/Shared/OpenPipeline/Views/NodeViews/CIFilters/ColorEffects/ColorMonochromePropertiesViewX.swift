//
//  Copyright © 2022-2023 James Boo. All rights reserved.
//

import SwiftUI
@available(iOS 15.0, *)

struct ColorMonochromePropertiesViewX: View, NodeProperties {



    @ObservedObject var fx: ColorMonochromeFX = ColorMonochromeFX()
    var parent: FilterPropertiesViewX?

    var body: some View {

        Section(header: Text("Options")){

            HStack{
                Text("Color")
                Spacer()
                ColorPicker("", selection: $fx.colorx, supportsOpacity: true)
                  .onChange(of: fx.colorx) {  oldValue, newValue in
#if targetEnvironment(macCatalyst)
                      fx.color=CIColor(cgColor: newValue.cgColor!)
#else
                      fx.color=CIColor(color: UIColor(newValue))
#endif
                      applyFilter()
                  }.frame(width:100, height:30, alignment: .trailing)
            }
            
            HStack{
                Text("Intensity")
                Spacer()
                Text(String(format: "%.2f", fx.intensity))
            }

            Slider(value: $fx.intensity, in: 0...1,
                   onEditingChanged: {editing in
                //editing is passed in once when start and once when stop
                applyFilter(editing)
            })
                .onChange(of: fx.intensity) {  oldValue, newValue in
                    //every change will be called
                    //so during high res
                    //ignore all changes and only use the above when stopped
                    applyFilter()
                }
             
             
        }
        .onAppear(perform: setupViewModel)

    }
    /*
    func applyFilter(_ editing: Bool) {
        
        editing == true ? applyFilter("start",parent) : applyFilter("stop",parent)

    }
    
    func applyFilter() {
        
        applyFilter("change",parent)

    }
     */
    
    /*
    func applyFilter(_ editing: Bool) {
        
        print("Slider Moving:"+String(editing))
        applyFilter(editing,parent)
       
    }
    
    func applyFilter() {
        print("Slider Change:"+appSettings.mode)
        applyFilter(appSettings.mode,appSettings.imageRes,parent)
    }
     */
    

    func setupViewModel()
    {

    }
}


