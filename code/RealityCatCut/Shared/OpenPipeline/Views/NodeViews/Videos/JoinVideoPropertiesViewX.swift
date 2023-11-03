//
//  Copyright © 2022-2023 James Boo. All rights reserved.
//


import SwiftUI

//ANCHISES
@available(iOS 15.0, *)
struct JoinVideoPropertiesViewX: View, NodeProperties {

    @ObservedObject var fx: JoinVideoFX = JoinVideoFX()
    var parent: FilterPropertiesViewX?
    var body: some View {

        Section(header: Text("Timeline")){
            HStack{
                Spacer()
                
                VideoTimelinePropertiesX(node: fx,avPlayer: parent!.pageSettings.avPlayer!)
                    .frame(width: (parent?.filtersPropertiesViewModel.size.width)!-80, height:180, alignment: .center)
                
                Spacer()
            }
        }
        .onAppear(perform: setupViewModel)
    
    }
        
    func setupViewModel()
    {

    }
}

