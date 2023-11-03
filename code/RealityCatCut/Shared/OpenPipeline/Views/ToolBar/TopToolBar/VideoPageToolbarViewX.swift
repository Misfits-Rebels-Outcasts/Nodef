//
//  Copyright © 2022 James Boo. All rights reserved.
//


import SwiftUI
import ContactsUI

@available(iOS 15.0, *)
struct VideoPageToolbarViewX: View {
    @AppStorage("isOnboarding") var isOnboarding: String?
    @Environment(\.colorScheme) var colorScheme
    @EnvironmentObject var appSettings: AppSettings
    @EnvironmentObject var optionSettings: OptionSettings
    @EnvironmentObject var pageSettings: PageSettings

    @State private var showingAlert = false

    @State var measurementUnit : String = "Inches"
    


    
    var body: some View {
        Menu {
            if (pageSettings.filters.currentNodeType() == "Video") {
                if pageSettings.filters.getCurrentNode()?.videoStatus=="Completed" {
                    SaveVideoButtonViewX()
                        .environmentObject(appSettings)
                        .environmentObject(optionSettings)
                        .environmentObject(pageSettings)
                    
                    SaveVideoPhotoButtonViewX()
                        .environmentObject(optionSettings)
                        .environmentObject(pageSettings)
                    
                } else {
                    SaveVideoPhotoButtonViewX()
                        .environmentObject(appSettings)
                        .environmentObject(optionSettings)
                        .environmentObject(pageSettings)
                }
            } else if (pageSettings.filters.currentNodeType() == "Photo") {
                if pageSettings.filters.gotShaderEffects() {
                    SaveShaderVideoButtonViewX()
                        .environmentObject(appSettings)
                        .environmentObject(optionSettings)
                        .environmentObject(pageSettings)
                    
                    SaveVideoPhotoButtonViewX()
                        .environmentObject(optionSettings)
                        .environmentObject(pageSettings)
                    
                } else {
                    SavePhotoButtonViewX()
                        .environmentObject(optionSettings)
                        .environmentObject(pageSettings)
                }
            } else if (pageSettings.filters.currentNodeType() == "AR") {
                //nothing
            }
            
            Menu {
                Button(action: {
                    isOnboarding="OnBoarding"
                })
                {
                    Label("^Cat Cut", systemImage: "pawprint.fill")
                             
                }
                         
                Button(action: {
                    isOnboarding="OnDigitalCompositing"
                })
                {
                    Label("Digital Compositing", systemImage: "scale.3d")
                             
                }
                
                Button(action: {
                    isOnboarding="OnBlending"
                })
                {
                    Label("Blending", systemImage: "pencil.tip.crop.circle.badge.plus")
                             
                }

                Button(action: {
                    isOnboarding="OnTrim"
                })
                {
                    Label("Read, Trim & Join", systemImage: "scissors")
                }
                
            }
            label: {
                Label("Overview", systemImage: "info")
            }
            
            Menu {
                                            
                Link(destination: URL(string: "https://photorealityar.com/videoeditorsdk.html")!) {
                    HStack{
                        Text("Video Editing Ideas")

                    }
                }
                
                
                Menu {
                    
                        Link(destination: URL(string: "https://photorealityar.com")!) {
                            HStack{
                                Text("Reality ^Cat Cut")
                            }
                        }

                        Link(destination: URL(string: "https://github.com/Misfits-Rebels-Outcasts/Nodef")!) {
                            HStack{
                                Text("Open ^Graphics Pipeline")
                        
                            }
                        }
                    
                        Link(destination: URL(string: "https://hackernoon.com/revolutionary-user-interface-design-tackling-cognitive-overload-in-graphics-software")!) {
                            HStack{
                                Text("Tackling Cognitive Overload")
                      

                            }
                        }
                    Link(destination: URL(string: "https://apps.apple.com/sg/app/pipeline-digital-compositing/id1640788489")!) {
                        HStack{
                            Text("Digital Compositing Photos App")
                  
                        }
                    }
                
                    
                    Link(destination: URL(string: "https://photorealityar.com/stablediffusioncatanimator.html")!) {
                        HStack{
                            Text("Stable Diffusion Cat Animator - AI")
                        }
                    }
                    
                    Link(destination: URL(string: "https://photorealityar.com/fruitvatar.html")!) {
                        HStack{
                            Text("Fruitvatar - AR USDZ Fruit Mesh")
                        }
                    }
                    
                    Link(destination: URL(string: "https://github.com/Misfits-Rebels-Outcasts/ShaderMuse")!) {
                        HStack{
                            Text("Mixing Filters & Shaders")
               
                        }
                    }
                    
                    Link(destination: URL(string: "https://github.com/Misfits-Rebels-Outcasts/Photo-Curves")!) {
                        HStack{
                            Text("Photo Curves")
                   
                        }
                    }

                    /*

                        Link(destination: URL(string: "https://github.com/Misfits-Rebels-Outcasts/Nodef/blob/main/documentation/NodeBasedCompositingOnMobile.md")!) {
                            HStack{
                                Text("Digital Compositing")
                     

                            }
                        }

                        Link(destination: URL(string: "https://github.com/Misfits-Rebels-Outcasts/ShaderMuse")!) {
                            HStack{
                                Text("Shader Muse Source")
                   

                            }
                        }

                        Link(destination: URL(string: "https://github.com/Misfits-Rebels-Outcasts/Photo-Curves")!) {
                            HStack{
                                Text("Photo Curves Source")
                       

                            }
                        }
                    
                        Link(destination: URL(string: "https://github.com/Misfits-Rebels-Outcasts/Nodef")!) {
                            HStack{
                                Text("Open Pipeline Source")
         
                            }
                        }
                           
                     */
                }
                label: {
                    Label("Open Source", systemImage: "network")
                }
                
            }
            label: {
                Label("Online Help", systemImage: "questionmark")
            }
            
   
            
                    /*
            Menu {
            

                Link(destination: URL(string: "https://hackernoon.com/revolutionary-user-interface-design-tackling-cognitive-overload-in-graphics-software")!) {
                    HStack{
                        Text("Tackling Cognitive Overload")
              

                    }
                }

                Link(destination: URL(string: "https://github.com/Misfits-Rebels-Outcasts/Nodef/blob/main/documentation/NodePipeline.md")!) {
                    HStack{
                        Text("Open Graphics Pipeline")
                

                    }
                }

                Link(destination: URL(string: "https://github.com/Misfits-Rebels-Outcasts/Nodef/blob/main/documentation/NodeBasedCompositingOnMobile.md")!) {
                    HStack{
                        Text("Digital Compositing")
             

                    }
                }
                                    
                
            }
            label: {
                Label("Key Ideas", systemImage: "icloud")
            }
            */
            
     
 
        }
        label: {
            VStack {
                Image(systemName: "ellipsis")
                    .foregroundColor(colorScheme == .dark ? Color(UIColor(red: 0.9569, green: 0.9569, blue: 0.9569, alpha: 0.5) ) : Color.black)

            }

        }.id(UUID()).disabled(!pageSettings.isStopped).opacity(!pageSettings.isStopped ? 0.2 : 1.0)
            .disabled(pageSettings.isBusy() ? true : false)
     
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
