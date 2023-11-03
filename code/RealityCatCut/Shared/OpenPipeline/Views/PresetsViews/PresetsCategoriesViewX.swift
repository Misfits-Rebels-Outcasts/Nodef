//
//  Copyright © 2022 James Boo. All rights reserved.
//


import SwiftUI

@available(iOS 15.0, *)
struct PresetsCategoriesViewX: View {
    //@EnvironmentObject var appSettings: AppSettings
    //@EnvironmentObject var optionSettings: OptionSettings
    @EnvironmentObject var pageSettings: PageSettings


    
    var body: some View {
        //HStack{
            //Text("Presets:")
            ScrollView(.horizontal, showsIndicators: false) {
                HStack{
      
                    Button("Photo Effects"){
                        print("Photo Effects")
                        pageSettings.presets = PresetsX(presetType: "Photo Effects")
                    }
                    .lineLimit(1)
                    .font(.system(size: 16))//.padding(.top,15)
                    .padding([.leading,.trailing],7)
                    
                    Button("Distortion"){
                        print("Distortion")
                        pageSettings.presets = PresetsX(presetType: "Photo Effects")
                    }
                    .lineLimit(1)
                    .font(.system(size: 16))//.padding(.top,15)
                    .padding([.leading,.trailing],7)
                    Button("Composite"){
                        print("Blur")
                        pageSettings.presets = PresetsX(presetType: "Blur")
                    }
                    .lineLimit(1)
                    .font(.system(size: 16))//.padding(.top,15)
                    .padding([.leading,.trailing],7)
                    
                }//.padding(.leading,10)
            }.onAppear(perform: initAll)
        //}//.background(.red)
       
    }
    
    func initAll()
    {

    }
}
