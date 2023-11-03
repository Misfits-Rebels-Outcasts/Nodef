//
//  Copyright © 2022 James Boo. All rights reserved.
//


import SwiftUI


@available(iOS 15.0, *)
struct ImageTransformPropertiesViewX: View, NodeProperties {

    
    @ObservedObject var fx: ReadImageFX = ReadImageFX()
    var parent: FilterPropertiesViewX?
    var body: some View {
        
        Section(header: Text("Read Image")){
            Button("Select Image")
            {
                if let gotParent = parent {
                    gotParent.readImage(fx: fx)
                }
            }
        }
        
        Section(header: Text("Translate")){
            HStack{
                Text("X")
                Spacer()
                Text(String(format: "%.2f", fx.tx))
            }
                        
            Slider(value: $fx.tx, in: (0-Float(fx.size.width))...Float(fx.size.width), onEditingChanged: {editing in
                applyFilter(editing)
            })
                .onChange(of: fx.tx) { oldValue, newValue in
                    applyFilter()
                }
           HStack{
                Text("Y")
                Spacer()
                Text(String(format: "%.2f", fx.ty))
            }


            Slider(value: $fx.ty, in: (0-Float(fx.size.height))...Float(fx.size.height), onEditingChanged: {editing in
                applyFilter(editing)
            })
                .onChange(of: fx.ty) { oldValue, newValue in
                    applyFilter()
            }
                
        }
        
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


        /*
        Section(header: Text("Options")){

            Text("Browse")
                
        }
        .onAppear(perform: setupViewModel)
*/
    }
    

    
    func setupViewModel()
    {
        //colorControlsFX.brightness=

    }
}

