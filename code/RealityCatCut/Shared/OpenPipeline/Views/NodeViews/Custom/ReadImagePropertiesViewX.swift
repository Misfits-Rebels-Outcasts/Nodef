//
//  Copyright © 2022-2023 James Boo. All rights reserved.
//


import SwiftUI
import PhotosUI

struct ReadImagePropertiesViewX: View, NodeProperties {
    
    @ObservedObject var fx: ReadImageFX = ReadImageFX()
    var parent: FilterPropertiesViewX?
    @State var imageSelection: PhotosPickerItem?
    var body: some View {
        
        Section(header: Text("Read Image")){
        
            PhotosPicker(selection: $fx.imageSelection,
                         matching: .images) {
                Text("Select Image")
               
            }
            
             .onChange(of: fx.imageSelection) {
                 oldItem, newItem in
                 fx.imageState = .loading
                 Task {
                     if let nodeImageX = try await
                            fx.imageSelection?.loadTransferable(type: NodeImageX.self) {
                         
                         let renderer = ImageRenderer(content: nodeImageX.image)

                         if let uiImg = renderer.uiImage {
                             //Phoebus comeback
                             let orientImage = ImageUtil.getImageWithOrientation(image: uiImg)!
                             fx.inputImage=orientImage
                             fx.setupProperties(parent!.pageSettings.filters)
                             //parent!.pageSettings.applyReadPhoto(uiImage:orientImage)
                             //setCanvas is require as change image
                             parent!.pageSettings.setCanvas(image: orientImage, dpi: 1000)
                             parent!.pageSettings.filters.initNodeIndex()
                             //initNodeIndex can possibly set up the parent itself
                             //then the above setupProperties may not be required?
                             parent!.appSettings.resetZoom(parent!.pageSettings.labelWidth, parent!.pageSettings.labelHeight)
                             parent!.pageSettings.applyFilters()
                         }
                         

                     }
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
        Section(header: Text("Still Image Video")){
            HStack{
                Text("Duration in Seconds")
                Spacer()
                Text(String(format: "%.0f", fx.durationSeconds))
            }
                        
            Slider(value: $fx.durationSeconds, in: 0...15, onEditingChanged: {editing in
                
                fx.durationValue=fx.durationSeconds*fx.durationTimeScale
                fx.duration=CMTimeMake(value: Int64(fx.durationValue), timescale: Int32(fx.durationTimeScale))
                parent?.pageSettings.filters.initNodeIndex()
                applyFilter(editing)
                
            })
                .onChange(of: fx.duration.seconds) { oldValue, newValue in
                    
                    fx.durationValue=fx.durationSeconds*fx.durationTimeScale
                    fx.duration=CMTimeMake(value: Int64(fx.durationValue), timescale: Int32(fx.durationTimeScale))
                    fx.videoStatus="Not Started"
                    parent?.pageSettings.filters.initNodeIndex()
                    applyFilter()
                    
                }

        }
    }
    

    func setupViewModel()
    {
        fx.imageSelection=nil
    }
}

