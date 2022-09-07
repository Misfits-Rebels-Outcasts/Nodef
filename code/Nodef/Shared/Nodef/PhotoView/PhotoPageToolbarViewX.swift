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
    @EnvironmentObject var dataSettings: DataSettings

    @State private var showingAlert = false

    @State var measurementUnit : String = "Inches"
    


    
    var body: some View {
            
        Menu {
            
            Button(action: {
                
                //shapes.deSelectAll();
  
            }, label: {
                Label("Nodef Documents", systemImage: "folder")


            })
                .contextMenu {
                    
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
                        
                        let labelAction = LabelAction(pageSettings: pageSettings, dataSettings: dataSettings)
                        //adjust to add dataSettings
                        optionSettings.jsonLabelStringForSave = labelAction.generate()                        
                        optionSettings.showAlert = true
                        offProperties()
                    }) {
                        Label("Save", systemImage: "arrow.down.doc")
                    }
                    
                    Button(action: {
                        
                        //shapes.deSelectAll();

                    }, label: {
                        Label("Others", systemImage: "folder")


                    })
                        .contextMenu {
                            
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
                                
                                let labelAction = LabelAction(pageSettings: pageSettings, dataSettings: dataSettings)
                                optionSettings.labelDocument.message = labelAction.generate()
                                
                                
                                optionSettings.action = "Export"
                                optionSettings.isExporting = true
                                offProperties()
                            }) {
                                Label("Export", systemImage: "square.and.arrow.up")
                            }
                            
                        }
                    
                    


                }

            Button(action: {
                offProperties()
                //shapes.deSelectAll();
                optionSettings.action = "Settings"

                optionSettings.showPropertiesSheet = true
 
            }, label: {
                Label("Settings", systemImage: "gear")


            })

            Button(action: {
                
                //shapes.deSelectAll();
                offProperties()
            }, label: {
                Label("Help", systemImage: "questionmark.circle")


            })
                .contextMenu {
                    Button(action: {
                        
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
                  
                    Link(destination: URL(string: "https://github.com/Misfits-Rebels-Outcasts/Nodef/blob/main/documentation/PhotoFiltersHelp.md")!) {
                        HStack{
                            Text("Cookbook")
                            Image(systemName: "wand.and.stars")
                                .font(.largeTitle)

                        }
                    }
                    
                    Link(destination: URL(string: "https://github.com/Misfits-Rebels-Outcasts/Nodef/blob/main/documentation/NodeBasedCompositingOnMobile.md")!) {
                        HStack{
                            Text("Compositing on Mobile")
                            Image(systemName: "network")
                                .font(.largeTitle)

                        }
                    }
                    
                    Link(destination: URL(string: "https://github.com/Misfits-Rebels-Outcasts/Nodef/blob/main/documentation/NodePipeline.md")!) {
                        HStack{
                            Text("Node Pipeline")
                            Image(systemName: "network")
                                .font(.largeTitle)

                        }
                    }
                    
                    Link(destination: URL(string: "https://github.com/Misfits-Rebels-Outcasts/Nodef")!) {
                        HStack{
                            Text("Open Source Repo")
                            Image(systemName: "network")
                                .font(.largeTitle)

                        }
                    }
                    
                    Button(action: {
                        //shapes.deSelectAll();
                        optionSettings.action = "Subscription"
                        optionSettings.showPropertiesSheet = true
                        offProperties()
                    }) {
                        
                        Label("Subscription", systemImage: "lock.open")
                    }
                    

                    
                }

            

        }
        label: {
            VStack {
                
                Image(systemName: "doc")
                    //.font(.system(size: 18))
                    //.font(.system(size: 16))
                    .foregroundColor(colorScheme == .dark ? Color(UIColor(red: 0.9569, green: 0.9569, blue: 0.9569, alpha: 0.5) ) : Color.black)
            }
        }
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
