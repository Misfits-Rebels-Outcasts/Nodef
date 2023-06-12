//
//  Copyright © 2022 James Boo. All rights reserved.
//


import SwiftUI
import ContactsUI

@available(iOS 15.0, *)


    
              
@available(iOS 15.0, *)
struct PhotoPageToolbarViewX: View {
    @Environment(\.colorScheme) var colorScheme
    @EnvironmentObject var appSettings: AppSettings
    @EnvironmentObject var optionSettings: OptionSettings
    @EnvironmentObject var pageSettings: PageSettings
    @State private var showingAlert = false

    @State var measurementUnit : String = "Inches"

    var body: some View {
        Menu {

            Link(destination: URL(string: "https://www.photorealityar.com/photocurves.html")!) {
                HStack{
                    Text("Photo Curves Help")
                    Image(systemName: "questionmark")
                        .font(.largeTitle)

                }
            }
            
            Menu {
                Link(destination: URL(string: "https://github.com/Misfits-Rebels-Outcasts/Photo-Curves")!) {
                    HStack{
                        Text("Photo Curves")
                        Image(systemName: "circle.hexagonpath")
                            .font(.largeTitle)

                    }
                }
                   
                Link(destination: URL(string: "https://www.photorealityar.com")!) {
                    HStack{
                        Text("Part of Photo Reality AR")
                        Image(systemName: "circle.hexagonpath")
                            .font(.largeTitle)

                    }
                }
                                                    
            }
            label: {
                Label("Open Source", systemImage: "network")
            }
        
        }
        label: {
            VStack {
                
                Image(systemName: "doc")
                    .foregroundColor(colorScheme == .dark ? Color(UIColor(red: 0.9569, green: 0.9569, blue: 0.9569, alpha: 0.5) ) : Color.black)
            }
        }.id(UUID()).disabled(!pageSettings.isStopped).opacity(!pageSettings.isStopped ? 0.2 : 1.0)
             
    }

    func offProperties()
    {
        pageSettings.resetViewer()
        optionSettings.showPropertiesView=0
        optionSettings.showPagePropertiesView=0
        optionSettings.pagePropertiesHeight=95
        appSettings.zoomFactor = appSettings.zoomFactor * 1.0/0.999
    }
}
