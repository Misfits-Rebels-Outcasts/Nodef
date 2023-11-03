//
//  Copyright © 2022 James Boo. All rights reserved.
//


import SwiftUI
@available(iOS 15.0, *)
struct BoxPropertiesViewX: View, NodeProperties {
 
    @ObservedObject var fx: BoxFX = BoxFX()
    var parent: FilterPropertiesViewX?

    var body: some View {
        
        Section(header: Text("Object")){
            HStack{
                Text("Width")
                Spacer()
                Text(String(format: "%.2f", fx.width))
            }
            
            Slider(value: $fx.width, in: 0.01...2, onEditingChanged: {editing in
                applyFilter(editing)
            })
            .onChange(of: fx.width) { oldValue, newValue in
     
                applyFilter()
            }
            HStack{
                Text("Height")
                Spacer()
                Text(String(format: "%.2f", fx.height))
            }
            
            Slider(value: $fx.height, in: 0.01...2, onEditingChanged: {editing in
                applyFilter(editing)
            })
            .onChange(of: fx.height) { oldValue, newValue in
     
                applyFilter()
            }
            HStack{
                Text("Depth")
                Spacer()
                Text(String(format: "%.2f", fx.depth))
            }
            
            Slider(value: $fx.depth, in: 0.01...2, onEditingChanged: {editing in
                applyFilter(editing)
            })
            .onChange(of: fx.depth) { oldValue, newValue in
     
                applyFilter()
            }
            
            HStack{
                Text("Corner Radius")
                Spacer()
                Text(String(format: "%.2f", fx.cornerRadius))
            }
            
            Slider(value: $fx.cornerRadius, in: 0.01...1, onEditingChanged: {editing in
                applyFilter(editing)
            })
            .onChange(of: fx.cornerRadius) { oldValue, newValue in
     
                applyFilter()
            }
            
            Toggle("Split Faces", isOn: $fx.splitFaces.animation())
                .onChange(of: fx.splitFaces) { oldValue, newValue in
         
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

