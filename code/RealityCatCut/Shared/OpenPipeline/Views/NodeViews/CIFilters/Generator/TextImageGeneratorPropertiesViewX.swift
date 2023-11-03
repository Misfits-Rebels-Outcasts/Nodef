//
//  Copyright © 2022 James Boo. All rights reserved.
//


import SwiftUI
@available(iOS 15.0, *)
struct TextImageGeneratorPropertiesViewX: View, NodeProperties {

    
    @ObservedObject var fx: TextImageGeneratorFX = TextImageGeneratorFX()
    var parent: FilterPropertiesViewX?

    var body: some View {
        Section(header: Text("Text")){
            TextEditor(text: $fx.text)
                .foregroundColor(Color.gray)
                .onChange(of: fx.text) { oldValue, newValue in
                    applyFilter()
                }
                .frame(maxWidth: .infinity, maxHeight: 300, alignment: .topLeading)

        }
        
        Section(header: Text("Options")){

            Picker("Font Name", selection: $fx.fontName) {
                ForEach(nodefFontNames, id: \.self) {
                    Text($0).font(.custom($0, size: 17.0))
                    
                }
            }
            .onChange(of: fx.fontName) { oldValue, newValue in
                applyFilter()
            }
            
            HStack{
                Text("Font Size")
                Spacer()
                Text(String(format: "%.2f", fx.fontSize))
            }
                                
            //Slider(value: $fx.fontSize, in: 2...144 , onEditingChanged: {editing in
            //Slider(value: $fx.fontSize, in: 2...288 , onEditingChanged:
            Slider(value: $fx.fontSize, in: 2...2160 , onEditingChanged:
            {editing in
                applyFilter(editing)
            })
                .onChange(of: fx.fontSize) { oldValue, newValue in
                    applyFilter()
                }

            HStack{
                Text("Scale Factor")
                Spacer()
                Text(String(format: "%.2f", fx.scaleFactor))
            }
                                
            Slider(value: $fx.scaleFactor, in: 1...20, onEditingChanged: {editing in
                applyFilter(editing)
            })
                .onChange(of: fx.scaleFactor) { oldValue, newValue in
                    applyFilter()
                }
            
            HStack{
                Text("Color")
                Spacer()
                
                ColorPicker("", selection: $fx.colorx, supportsOpacity: true)
                  .onChange(of: fx.colorx) { oldValue, newValue in
#if targetEnvironment(macCatalyst)
                      fx.color=CIColor(cgColor: newValue.cgColor!)
#else
                      fx.color=CIColor(color: UIColor(newValue))
#endif
                      applyFilter()
                  }.frame(width:100, height:30, alignment: .trailing)
            }
            
            HStack{
                Text("Background Color")
                Spacer()
                
                ColorPicker("", selection: $fx.backgroundColorx, supportsOpacity: true)
                  .onChange(of: fx.backgroundColorx) { oldValue, newValue in
#if targetEnvironment(macCatalyst)
                      fx.backgroundColor=CIColor(cgColor: newValue.cgColor!)
#else
                      fx.backgroundColor=CIColor(color: UIColor(newValue))
#endif
                      applyFilter()
                  }.frame(width:100, height:30, alignment: .trailing)
            }
            
            
            
        }
        Section(header: Text("Location")){
            HStack{
                Text("X")
                Spacer()
                Text(String(format: "%.2f", fx.tx))
            }
                        
            Slider(value: $fx.tx, in: 0...Float(fx.size.width)-5, onEditingChanged: {editing in
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


            Slider(value: $fx.ty, in: 0...Float(fx.size.height)-5, onEditingChanged: {editing in
                applyFilter(editing)
            })
                .onChange(of: fx.ty) { oldValue, newValue in
                    applyFilter()
            }
                
        }

        
     
    }

    
    func setupViewModel()
    {
        //colorControlsFX.brightness=

    }
}

