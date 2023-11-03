//
//  Copyright © 2022 James Boo. All rights reserved.
//


import SwiftUI

@available(iOS 15.0, *)
struct PresetsRowViewX: View {
    @EnvironmentObject var appSettings: AppSettings
    //@EnvironmentObject var optionSettings: OptionSettings
    @EnvironmentObject var pageSettings: PageSettings


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
                                        //ANCHISES to be revisited
                                        Image(uiImage:preset.applyFilters(image: pageSettings.thumbImage)).resizable().scaledToFit()
                                            .onTapGesture()
                                        {
                                            //ANCHISES
                                            //vat temImg=pageSettings.filters.filterList[0]
                                            let startNode=pageSettings.filters.filterList[0].filter
                                            if startNode is ReadImageFX {
                                                //Phoebus why not just use riFX?
                                                let riFX = startNode as! ReadImageFX
                                                pageSettings.filters=preset
                                                riFX.setupProperties(pageSettings.filters)
                                                //setCanvas is required in this case
                                                pageSettings.setCanvas(image: riFX.inputImage!, dpi:1000)
                                                pageSettings.filters.initNodeIndex()
                                                pageSettings.filters.compensatePresets()
                                                pageSettings.applyFilters()

                                                /*
                                                let riFX = startNode as! ReadImageFX
                                                
                                                pageSettings.filters=preset
                                                let newRIFX = pageSettings.filters.filterList[0].filter as! ReadImageFX
                                                newRIFX.inputImage=riFX.inputImage
                                                newRIFX.setupProperties(pageSettings.filters)
     
                                                pageSettings.setCanvas(image: newRIFX.inputImage!, dpi:1000)
                                                pageSettings.filters.initNodeIndex()
                                                pageSettings.filters.compensatePresets()
                                                pageSettings.applyFilters()
                                                */
                                            }
                                            
                                           
                

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
