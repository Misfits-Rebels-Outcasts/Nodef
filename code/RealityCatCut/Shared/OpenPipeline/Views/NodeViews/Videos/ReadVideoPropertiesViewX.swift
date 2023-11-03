//
//  Copyright © 2022-2023 James Boo. All rights reserved.
//


import SwiftUI
import PhotosUI

//ANCHISES
@available(iOS 15.0, *)
struct ReadVideoPropertiesViewX: View, NodeProperties {

    @ObservedObject var fx: ReadVideoFX = ReadVideoFX()
    var parent: FilterPropertiesViewX?
    @State var selectedItem: PhotosPickerItem?
    var body: some View {
       
            Section(header: Text("Read Video")){
                PhotosPicker(selection: $selectedItem,
                             matching: .videos) {
                    Text("Select Video")
                }
                             .onChange(of: selectedItem) {
                                 oldItem, newItem in
                                 
                                 parent!.optionSettings.showPropertiesSheet = false
                                 Singleton.onPagePropertiesOff(parent!.pageSettings, parent!.optionSettings, parent!.appSettings)
                                 
                                 parent!.pageSettings.loadState = .loading
                                 fx.parent?.setPropertiesNode(fx: nil)
                                 fx.duration=CMTimeMake(value: Int64(1),timescale: Int32(600))
                                 
                                 Task {
                                     
                                                            
                                     if let movie = try await
                                            selectedItem?.loadTransferable(type: MovieX.self) {
                                         
                                         parent!.pageSettings.loadState = .loaded(MovieX(url: fx.assetURL1))
                                        
                                         fx.assetURL1=movie.url
                                         await fx.setupVideoProperties(url: fx.assetURL1)
                                         print(fx.duration)
                                         fx.parent?.clearVideoStatus(x: fx.nodeIndex)
                                         fx.updateTimeline=true
                                         parent?.pageSettings.filters.initNodeIndex()
                                        
                                         await parent?.applyFilterAsync()

                                       
                                     }
                                 }
                             }
            }
            
            Section(header: Text("Timeline")){
         
                HStack{
                    Spacer()
                    VideoTimelinePropertiesX(node: fx,avPlayer: parent!.pageSettings.avPlayer!)
                        .frame(width: (parent?.filtersPropertiesViewModel.size.width)!-80, height:180, alignment: .center)
                    Spacer()
                }
                 
            }
            
        
    }
        
    func setupViewModel()
    {

    }
}

