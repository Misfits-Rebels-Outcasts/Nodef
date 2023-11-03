//
//  Copyright © 2022-2023 James Boo. All rights reserved.
//

import SwiftUI
import AVKit
@available(macOS 12.0, *)
@available(iOS 15.0, *)
struct VideoDesignViewX: View {
    @Environment(\.verticalSizeClass) var verticalSizeClass: UserInterfaceSizeClass?
    @Environment(\.horizontalSizeClass) var horizontalSizeClass: UserInterfaceSizeClass?
    
    @EnvironmentObject var appSettings: AppSettings
    @EnvironmentObject var optionSettings: OptionSettings
    @EnvironmentObject var pageSettings: PageSettings

    var body: some View {
        GeometryReader { geometry in
            VStack(spacing:0){
        
                switch pageSettings.loadState {
                    case .unknown:
                    EmptyView()
      
                    case .loading:
                        VStack(){
                            Rectangle().background(.white)
                                .frame(height: 1,alignment: .leading)
                            Spacer()
                            //Text("Generating").foregroundColor(.white)
                            ProgressView().colorInvert()
                            Spacer()
                        }.frame(height: horizontalSizeClass == .regular && verticalSizeClass == .regular ?
                            appSettings.HRulerWidthRegular*72.0+geometry.size.height :
                            appSettings.HRulerWidth*72.0+geometry.size.height,
                            alignment: .leading)
                        .background(.black)
                    case .loaded(_):
                        //if pageSettings.filters.getCurrentNode()!.videoStatus=="Completed" {
                        //if pageSettings.filters.propertiesNode!.videoStatus=="Completed" {
                        //if displayNode().videoStatus=="Completed" {
                    if pageSettings.filters.propertiesNode != nil {
                        if pageSettings.filters.propertiesNode!.videoStatus=="Completed" {
                            VStack{
                                Rectangle().background(.white)
                                    .frame(height: 1,alignment: .leading)
                                Spacer()
                                VideoPlayer(player: pageSettings.avPlayer)
                                    .environmentObject(pageSettings)
                                    .border(Color.black, width: 0)
                                Spacer()
                            }.frame(height: horizontalSizeClass == .regular && verticalSizeClass == .regular ?
                                    appSettings.HRulerWidthRegular*72.0+geometry.size.height :
                                    appSettings.HRulerWidth*72.0+geometry.size.height,
                                    alignment: .leading)
                            .background(.black)
                             
                        } else {
                            VStack{
                                Rectangle().background(.white)
                                    .frame(height: 1,alignment: .leading)
                                Spacer()
                                ZStack{
                                   //videoPreviewImage
                                    Image(uiImage: pageSettings.filteredBackgroundImage!)
                                        .resizable()
                                        .scaledToFit()
                                        .border(Color.black, width: 0)
                                
                                    VStack{
                                        HStack {
                                            Image(systemName: "photo.artframe").foregroundColor(.white)
                                            Text("Preview").foregroundColor(.white)
                                        }.padding(5)
                                    }.background(.black).opacity(0.5).cornerRadius(5)
                                }
                                Spacer()
                            }
                            .frame(height: horizontalSizeClass == .regular && verticalSizeClass == .regular ?
                                appSettings.HRulerWidthRegular*72.0+geometry.size.height :
                                appSettings.HRulerWidth*72.0+geometry.size.height,
                                alignment: .leading)
                            .background(.black)
                           
                        }
                    } else {
                        if pageSettings.filters.getCurrentNode()!.videoStatus=="Completed" {
                            VStack{
                                Rectangle().background(.white)
                                    .frame(height: 1,alignment: .leading)
                                Spacer()
                                VideoPlayer(player: pageSettings.avPlayer)
                                    .environmentObject(pageSettings)
                                    .border(Color.black, width: 0)
                                Spacer()
                            }.frame(height: horizontalSizeClass == .regular && verticalSizeClass == .regular ?
                                    appSettings.HRulerWidthRegular*72.0+geometry.size.height :
                                    appSettings.HRulerWidth*72.0+geometry.size.height,
                                    alignment: .leading)
                            .background(.black)
                             
                        } else {
                            VStack{
                                Rectangle().background(.white)
                                    .frame(height: 1,alignment: .leading)
                                Spacer()
                                ZStack{
                                   //videoPreviewImage
                                    Image(uiImage: pageSettings.filteredBackgroundImage!)
                                        .resizable()
                                        .scaledToFit()
                                        .border(Color.black, width: 0)
                                
                                    VStack{
                                        HStack {
                                            Image(systemName: "photo.artframe").foregroundColor(.white)
                                            Text("Preview").foregroundColor(.white)
                                        }.padding(5)
                                    }.background(.black).opacity(0.5).cornerRadius(5)
                                }
                                Spacer()
                            }
                            .frame(height: horizontalSizeClass == .regular && verticalSizeClass == .regular ?
                                appSettings.HRulerWidthRegular*72.0+geometry.size.height :
                                appSettings.HRulerWidth*72.0+geometry.size.height,
                                alignment: .leading)
                            .background(.black)
                           
                        }
                    }
                   
                     case .failed:
                        HStack(spacing:0){
                            Spacer()
                            Text("Import failed")
                            Spacer()
                        }
                }
                
    

            }
            .onAppear {
                pageSettings.size = geometry.size
                print(pageSettings.size)
                print("test")
            }

        }
       
    }
    /*
    func displayNode() -> FilterX {
        print("displayNode")
        if pageSettings.filters.propertiesNode != nil{
            print("propertiesNotNull",pageSettings.filters.propertiesNode!.videoStatus)
            return pageSettings.filters.propertiesNode!
        }
        print(pageSettings.filters.getCurrentNode()!.type)
        print(pageSettings.filters.getCurrentNode()!.videoStatus)

        return pageSettings.filters.getCurrentNode()!
    }
    
    func displayNodeStatus() -> String {
        print("displayNode")
        if pageSettings.filters.propertiesNode != nil{
            print("propertiesNotNull",pageSettings.filters.propertiesNode!.videoStatus)
            return pageSettings.filters.propertiesNode!.videoStatus
        }
        print(pageSettings.filters.getCurrentNode()!.type)
        print(pageSettings.filters.getCurrentNode()!.videoStatus)

        return pageSettings.filters.getCurrentNode()!.videoStatus
    }
     */
}
