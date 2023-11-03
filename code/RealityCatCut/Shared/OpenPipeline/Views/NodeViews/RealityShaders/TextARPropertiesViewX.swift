//
//  Copyright © 2022 James Boo. All rights reserved.
//


import SwiftUI
@available(iOS 15.0, *)
struct TextARPropertiesViewX: View, NodeProperties {

 
    @ObservedObject var fx: TextFX = TextFX()
    var parent: FilterPropertiesViewX?
    var textAlignmentTypes = [
        "Left",
        "Center",
        "Right",
        ]
    var body: some View {
        
        Section(header: Text("Text")){
                                
            HStack{
                                        
                TextField("Text", text: $fx.text, onEditingChanged: {editing in
                    applyFilter(editing)
                })
                    .foregroundColor(Color.gray)
                    .onChange(of: fx.text) { oldValue, newValue in
                        applyFilter()
                    }
            }
            
      
        }
        
        Section(header: Text("Object")){
            /*
            Picker("Text Type", selection: $fx.alignment) {
                ForEach(textAlignmentTypes, id: \.self) {
                    
                    Text($0).font(.custom($0, size: 17.0))
                    
                }
            }
            .onChange(of: fx.alignment) { newValue
                in                
                applyFilter()
            }
            */
            HStack{
                Text("Font Size")
                Spacer()
                Text(String(format: "%.2f", fx.fontSize))
            }
            
            Slider(value: $fx.fontSize, in: 0.05...2, onEditingChanged: {editing in
                applyFilter(editing)
            })
            .onChange(of: fx.fontSize) { oldValue, newValue in
     
                applyFilter()
            }
            
            HStack{
                Text("Depth")
                Spacer()
                Text(String(format: "%.2f", fx.extrusionDepth))
            }
            
            Slider(value: $fx.extrusionDepth, in: 0.01...2, onEditingChanged: {editing in
                applyFilter(editing)
            })
            .onChange(of: fx.extrusionDepth) { oldValue, newValue in
     
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

