//
//  Copyright © 2022 James Boo. All rights reserved.
//


import SwiftUI


@available(iOS 15.0, *)
struct ScalePropertiesViewX: View, NodeProperties {

    
    @ObservedObject var fx: ScaleFX = ScaleFX()
    var parent: FilterPropertiesViewX?
    
    
    var body: some View {

        Section(header: Text("Scale")){
            HStack{
                Text("Scale X")
                Spacer()
                Text(String(format: "%.2f", fx.a))
            }
                        
            Slider(value: $fx.a, in: 0.1...5, onEditingChanged: {editing in
                applyFilter(editing)
            })
                .onChange(of: fx.a) { oldValue, newValue in
                    applyFilter()
                }
            HStack{
                Text("Scale Y")
                Spacer()
                Text(String(format: "%.2f", fx.d))
            }
                        
            Slider(value: $fx.d, in: 0.1...5, onEditingChanged: {editing in
                applyFilter(editing)
            })
                .onChange(of: fx.d) { oldValue, newValue in
                    applyFilter()
                }
                
        }
        .onAppear(perform: setupViewModel)
 
        //Section(header: Text(""), footer: Text("")){
        //}
    }
    

    
    func setupViewModel()
    {
        /*
        a=String(format: "%.8f", fx.a)
        b=String(format: "%.8f", fx.b)
        c=String(format: "%.8f", fx.c)
        d=String(format: "%.8f", fx.d)
        tx=String(format: "%.8f", fx.tx)
        ty=String(format: "%.8f", fx.ty)
         */
    }
}

