//
//  Copyright © 2022 James Boo. All rights reserved.
//


import SwiftUI
@available(iOS 15.0, *)
struct SpherePropertiesViewX: View, NodeProperties {


 
    @ObservedObject var fx: SphereFX = SphereFX()
    var parent: FilterPropertiesViewX?

    var body: some View {
        
        Section(header: Text("Object")){
            HStack{
                Text("Radius")
                Spacer()
                Text(String(format: "%.2f", fx.radius))
            }
            
            Slider(value: $fx.radius, in: 0.01...2, onEditingChanged: {editing in
                applyFilter(editing)
            })
            .onChange(of: fx.radius) { oldValue, newValue in
     
                applyFilter()
            }
        }
        
        Section(header: Text("Options")){
            HStack{
                Text("Metallic")
                Spacer()
                Text(String(format: "%.2f", fx.metallic))
            }
            
            Slider(value: $fx.metallic, in: 0...1, onEditingChanged: {editing in
                applyFilter(editing)
            })
            .onChange(of: fx.metallic) { oldValue, newValue in
                //print("id",fx.id)
                applyFilter()
            }
            
            HStack{
                Text("Roughness")
                Spacer()
                Text(String(format: "%.2f", fx.roughness))
            }
            
            Slider(value: $fx.roughness, in: 0...1, onEditingChanged: {editing in
                applyFilter(editing)
            })
            .onChange(of: fx.roughness) { oldValue, newValue in
                //print("id",fx.id)
                applyFilter()
            }
        }
        
        TransformPropertiesViewX(fx:fx, parent: parent)
            //.environmentObject(appSettings)
  
    }

   
    func setupViewModel()
    {
       

    }
}

