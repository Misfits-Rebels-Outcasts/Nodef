//
//  Copyright © 2022 James Boo. All rights reserved.
//


import SwiftUI

@available(iOS 15.0, *)
struct PresetsRowViewX: View {
    @EnvironmentObject var appSettings: AppSettings
    //@EnvironmentObject var optionSettings: OptionSettings
    @EnvironmentObject var pageSettings: PageSettings
    //@EnvironmentObject var dataSettings: DataSettings
    //@EnvironmentObject var shapes: ShapesX

    var presetType :String = "Photo Effects"
    var body: some View {
        VStack (alignment: .leading){            
            ScrollView(.horizontal, showsIndicators: false) {
                HStack() {
                    
                    //ForEach(pageSettings.presets.presetsList){
                    ForEach(pageSettings.getPresets(presetType: presetType).presetsList){
                        preset in
                        
                        ZStack{
                            VStack{
                                VStack{
                                    ZStack{
                                        Image(uiImage:preset.applyFilters(image: pageSettings.thumbImage)).resizable().scaledToFit()
                                            .onTapGesture()
                                        {
                                            print("apply presets")
                                            pageSettings.filters=preset

                                            
                                            pageSettings.applyPhoto(uiImage: pageSettings.backgroundImage!, dpi:appSettings.dpi)
                                            print("apply presets size",pageSettings.filters.size)
                                            //this will recenter all
                                            pageSettings.filters.compensatePresets()
                                            
                                            pageSettings.applyFilters()

                                        }.background(.white)

                                    }.border(Color.white, width: 0)
                                        .background(.black)
                                }.frame(width: 130, height: 130, alignment: .center).padding(EdgeInsets(top: 5, leading: 0, bottom: 5, trailing: 0))
                                    .background(Color(red: 0.949, green: 0.949, blue: 0.97, opacity: 0.5))
                            }
                            Text(preset.presetName)
                                .padding(EdgeInsets(top: 0, leading: 2, bottom: 0, trailing: 2))
                                  .foregroundColor(Color.black)
                                  .background(.white)
                                  .font(.system(size: 14, weight: .light))
                                  .offset(x: 0, y: 50)
                                  //.blendMode(.screen)

                            

                        }

                        }
                    
                }
            }.padding(EdgeInsets(top: 5, leading: 5, bottom: 5, trailing: 0))
        }.background(.white)//.background(Color(red: 0.949, green: 0.949, blue: 0.97, opacity: 1.0))//.background(.black)
            .onAppear(perform: initAll)
    }
    
    func initAll()
    {

    }
}
