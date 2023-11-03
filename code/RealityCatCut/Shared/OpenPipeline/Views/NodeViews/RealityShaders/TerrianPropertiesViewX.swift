//
//  Copyright © 2022 James Boo. All rights reserved.
//


import SwiftUI
@available(iOS 15.0, *)
struct TerrianPropertiesViewX: View, NodeProperties {
 
    @ObservedObject var fx: TerrianFX = TerrianFX()
    var parent: FilterPropertiesViewX?

    var body: some View {
        
        Section(header: Text("Object")){
            HStack{
                Text("Width - Number of Cells")
                Spacer()
                Text(String(format: "%.2f", fx.numCellsWidth))
            }
            
            Slider(value: $fx.numCellsWidth, in: 8...128, onEditingChanged: {editing in
                applyFilter(editing)
            })
            .onChange(of: fx.numCellsWidth) { oldValue, newValue in
     
                applyFilter()
            }
            HStack{
                Text("Height - Number of Cells")
                Spacer()
                Text(String(format: "%.2f", fx.numCellsHeight))
            }
            
            Slider(value: $fx.numCellsHeight, in: 8...128, onEditingChanged: {editing in
                applyFilter(editing)
            })
            .onChange(of: fx.numCellsHeight) { oldValue, newValue in
     
                applyFilter()
            }
            HStack{
                Text("Cell Size")
                Spacer()
                Text(String(format: "%.2f", fx.cellSize))
            }
            
            Slider(value: $fx.cellSize, in: 0.01...1.0, onEditingChanged: {editing in
                applyFilter(editing)
            })
            .onChange(of: fx.cellSize) { oldValue, newValue in
     
                applyFilter()
            }
            HStack{
                Text("Height")
                Spacer()
                Text(String(format: "%.2f", fx.height))
            }
            
            Slider(value: $fx.height, in: 0.01...1.0, onEditingChanged: {editing in
                applyFilter(editing)
            })
            .onChange(of: fx.height) { oldValue, newValue in
     
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

