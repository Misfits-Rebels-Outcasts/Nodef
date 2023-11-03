//
//  Copyright © 2022 James Boo. All rights reserved.
//


import SwiftUI


@available(iOS 15.0, *)
struct RotatePropertiesViewX: View, NodeProperties {
 
    
    @ObservedObject var fx: RotateFX = RotateFX()
    var parent: FilterPropertiesViewX?
    
    
    var body: some View {

        Section(header: Text("Rotate")){
            HStack{
                Text("Angle")
                Spacer()
                Text(String(format: "%.0f", round(fx.angle * 180/Float.pi)))
            }
                        
            Slider(value: $fx.angle, in: (0-3.14)...3.14, onEditingChanged: {editing in
                applyFilter(editing)
            })
                .onChange(of: fx.angle) { oldValue, newValue in
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

