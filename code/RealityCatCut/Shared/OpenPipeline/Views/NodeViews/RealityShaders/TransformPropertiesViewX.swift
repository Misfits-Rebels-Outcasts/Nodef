//
//  Copyright © 2022 James Boo. All rights reserved.
//

import SwiftUI

struct TransformPropertiesViewX: View, NodeProperties {
    
    @ObservedObject var fx: BaseEntityFX
    var parent: FilterPropertiesViewX?

    var body: some View {

        Section(header: Text("Transform - Translation")){
            
            HStack{
                Text("x")
                Spacer()
                Text(String(format: "%.2f", fx.x))
            }
            
            Slider(value: $fx.x, in: -1.0...1.0, onEditingChanged: {editing in
                applyFilter(editing)
            })
            .onChange(of: fx.x) { oldValue, newValue in
     
                applyFilter()
            }
            
            HStack{
                Text("y")
                Spacer()
                Text(String(format: "%.2f", fx.y))
            }
            
            Slider(value: $fx.y, in: -1.0...1.0, onEditingChanged: {editing in
                applyFilter(editing)
            })
            .onChange(of: fx.y) { oldValue, newValue in
     
                applyFilter()
            }
            
            HStack{
                Text("z")
                Spacer()
                Text(String(format: "%.2f", fx.z))
            }
            
            Slider(value: $fx.z, in: -1.0...1.0, onEditingChanged: {editing in
                applyFilter(editing)
            })
            .onChange(of: fx.z) { oldValue, newValue in
     
                applyFilter()
            }
            
                     
        }
        Section(header: Text("Transform - Scale")){
            HStack{
                Text("Scale (%)")
                Spacer()
                Text(String(format: "%.2f", fx.scale))
            }
            
            Slider(value: $fx.scale, in: 1.0...1000.0, onEditingChanged: {editing in
                applyFilter(editing)
            })
            .onChange(of: fx.scale) { oldValue, newValue in
     
                applyFilter()
            }
        }
        
        Section(header: Text("Transform - Rotation")){
            
            HStack{
                Text("x")
                Spacer()
                Text(String(format: "%.2f", fx.rotateX))
            }
            
            Slider(value: $fx.rotateX, in: 0...360, onEditingChanged: {editing in
                applyFilter(editing)
            })
            .onChange(of: fx.rotateX) { oldValue, newValue in
                
                applyFilter()
            }
            HStack{
                Text("y")
                Spacer()
                Text(String(format: "%.2f", fx.rotateY))
            }
            
            Slider(value: $fx.rotateY, in: 0...360, onEditingChanged: {editing in
                applyFilter(editing)
            })
            .onChange(of: fx.rotateY) { oldValue, newValue in
                
                applyFilter()
            }
            HStack{
                Text("z")
                Spacer()
                Text(String(format: "%.2f", fx.rotateZ))
            }
            
            Slider(value: $fx.rotateZ, in: 0...360, onEditingChanged: {editing in
                applyFilter(editing)
            })
            .onChange(of: fx.rotateZ) { oldValue, ewValue in
                
                applyFilter()
            }
            
        }
        Section(header: Text("Animate")){
            
            Toggle("Animate Object", isOn: $fx.animate.animation())
                .onChange(of: fx.animate) { oldValue, newValue in
         
                    applyFilter()
                }
            
        }
    }
    

    
    func setupViewModel()
    {
        

    }
    
}

