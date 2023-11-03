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
            Menu {
                Button(action: {
                    //shapes.deSelectAll();
                    optionSettings.action = "NewLabel"
                   
                    optionSettings.showPropertiesSheet = true
                    
                    offProperties()
                    
         
                }) {
                    Label("New", systemImage: "doc.badge.plus")
                }
                
                
                Button(action: {
                    //shapes.deSelectAll();
                    optionSettings.action = "OpenLabel"
   
                    optionSettings.showPropertiesSheet = true
                    offProperties()

                }) {
                    //Label("Open Label", systemImage: "doc.badge.gearshape")
                    Label("Open", systemImage: "arrow.up.doc")
                }
                
      
                Button(action: {
                    //shapes.deSelectAll();
                    optionSettings.action = "SaveLabel"
                    
                    let docAction = DocumentAction(pageSettings: pageSettings)
                    //adjust to add dataSettings
                    optionSettings.jsonLabelStringForSave = docAction.generate()
                    optionSettings.showAlert = true
                    offProperties()
                }) {
                    Label("Save", systemImage: "arrow.down.doc")
                }
                
                Menu {
                    Button(action: {
                        print("importing")
                        //shapes.deSelectAll();
                        optionSettings.action = "Import"
                        optionSettings.isImporting = true
                        offProperties()
                    }) {
                        Label("Import", systemImage: "square.and.arrow.down")
                    }
                    
                    Button(action: {
                        print("exporting")
                        
                        let docAction = DocumentAction(pageSettings: pageSettings)
                        //optionSettings.labelDocument.message = docAction.generate()
                        
                        
                        optionSettings.action = "Export"
                        optionSettings.isExporting = true
                        offProperties()
                    }) {
                        Label("Export", systemImage: "square.and.arrow.up")
                    }
                }
                label: {
                    Label("Others", systemImage: "folder")
                }
                
            }
            label: {
                Label("Nodef Documents", systemImage: "folder")
            }
            
  
            
            Button(action: {
                offProperties()
                //shapes.deSelectAll();
                optionSettings.action = "Settings"

                optionSettings.showPropertiesSheet = true
 
            }, label: {
                Label("Settings", systemImage: "gear")

            })
            
            Menu {
              
                
                Button(action: {
                    //ANCHISES
                    /*
                    pageSettings.filters.photoARView.snapshot(saveToHDR: false) { (image) in
                      
                      // Compress the image
                      let compressedImage = UIImage(data: (image?.pngData())!)
                      // Save in the photo album
                      UIImageWriteToSavedPhotosAlbum(compressedImage!, nil, nil, nil)
                    }
                     */
                    
                    //shapes.deSelectAll();
                    optionSettings.action = "NodefHelp"
                    optionSettings.showPropertiesSheet = true
                    offProperties()
                     
                }, label: {
                    Label("Overview", systemImage: "questionmark")


                })
                
                Button(action: {
                    
                    //shapes.deSelectAll();
                    optionSettings.action = "NodefHelpPipeline"
                    optionSettings.showPropertiesSheet = true
                    offProperties()
                    
                }, label: {
                    Label("Mix Filters", systemImage: "questionmark")


                })
                
                Button(action: {
                    
                    //shapes.deSelectAll();
                    optionSettings.action = "NodefHelpViewer"
                    optionSettings.showPropertiesSheet = true
                    offProperties()
                }, label: {
                    Label("Setting the Viewer", systemImage: "questionmark")


                })
                

                
                Menu {
                    
                    Link(destination: URL(string: "https://github.com/Misfits-Rebels-Outcasts/Nodef/blob/main/documentation/NodePipeline.md")!) {
                        HStack{
                            Text("Digital Compositing Pipeline")
                            Image(systemName: "network")
                                .font(.largeTitle)

                        }
                    }

                    Link(destination: URL(string: "https://github.com/Misfits-Rebels-Outcasts/Nodef/blob/main/documentation/NodeBasedCompositingOnMobile.md")!) {
                        HStack{
                            Text("Digital Compositing on Mobile")
                            Image(systemName: "network")
                                .font(.largeTitle)

                        }
                    }
                                        
                    
                }
                label: {
                    Label("Key Ideas", systemImage: "icloud")
                }
                
                Menu {
                    
                    Link(destination: URL(string: "https://github.com/Misfits-Rebels-Outcasts/ShaderMuse")!) {
                        HStack{
                            Text("Shader Muse")
                            Image(systemName: "circle.hexagonpath")
                                .font(.largeTitle)

                        }
                    }
                                        
                    Link(destination: URL(string: "https://github.com/Misfits-Rebels-Outcasts/Nodef")!) {
                        HStack{
                            Text("Nodef Pipeline")
                            Image(systemName: "circle.hexagonpath")
                                .font(.largeTitle)

                        }
                    }
                                        
                }
                label: {
                    Label("Open Source", systemImage: "network")
                }
                
                Link(destination: URL(string: "https://github.com/Misfits-Rebels-Outcasts/Nodef/blob/main/documentation/PhotoFiltersHelp.md")!) {
                    HStack{
                        Text("Cookbook Recipes")
                        Image(systemName: "wand.and.stars")
                            .font(.largeTitle)

                    }
                }
                /*
                Button(action: {
                    shapes.deSelectAll();
                    optionSettings.action = "Subscription"
                    optionSettings.showPropertiesSheet = true
                    offProperties()
                }) {
                    
                    Label("Subscription", systemImage: "lock.open")
                }
                */
            }
            label: {
                Label("Help", systemImage: "questionmark.circle")
            }

        }
        label: {
            VStack {
                Image(systemName: "doc")
                    .foregroundColor(colorScheme == .dark ? Color(UIColor(red: 0.9569, green: 0.9569, blue: 0.9569, alpha: 0.5) ) : Color.black)
                 
            }
            /*
            #if targetEnvironment(macCatalyst)
            Text("Pipeline Document")
            #else
            VStack {
                Image(systemName: "doc")
                    .foregroundColor(colorScheme == .dark ? Color(UIColor(red: 0.9569, green: 0.9569, blue: 0.9569, alpha: 0.5) ) : Color.black)
                 
            }
            #endif
             */
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
