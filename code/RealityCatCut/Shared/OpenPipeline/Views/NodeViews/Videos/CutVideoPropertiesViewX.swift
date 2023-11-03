//
//  Copyright © 2022-2023 James Boo. All rights reserved.
//


import SwiftUI

//ANCHISES
@available(iOS 15.0, *)
struct CutVideoPropertiesViewX: View, NodeProperties {

    @ObservedObject var fx: CutVideoFX = CutVideoFX()
    var parent: FilterPropertiesViewX?
    var body: some View {

        Section(header: Text("Timeline")){
            HStack{
                Spacer()
                
                if fx.inputA != nil {
                    if fx.inputA!.videoStatus=="Completed" {
                        VideoTimelinePropertiesX(node: fx,avPlayer: parent!.pageSettings.avPlayer!)
                            .frame(width: (parent?.filtersPropertiesViewModel.size.width)!-80, height:180, alignment: .center)

                        /*
                        if fx.setSource == false {
                            VideoTimelinePropertiesX(node: fx,avPlayer: parent!.pageSettings.avPlayer!)
                                .frame(width: (parent?.filtersPropertiesViewModel.size.width)!-80, height:180, alignment: .center)
                        }
                        else {
                            Text("Refresh the node to enable Timeline and Trimming.")
                        }
                         */
                    } else {
                        Text("Generate videos to enable Timeline and Trimming.")
                    }
                }
                
                Spacer()
            }
        }
        .onAppear(perform: setupViewModel)
        .onDisappear(perform: revertStatus)

    }
        
    func setupViewModel()
    {
        //print("appear")
        //fx.setSource=false
    }
    
    func revertStatus()
    {
        //print("revert")
        //fx.updateTimeline=false
    }
}

