//
//  Copyright © 2022 James Boo. All rights reserved.
//


import SwiftUI

@available(iOS 15.0, *)
struct FilesViewX: View {
    @Environment(\.verticalSizeClass) var verticalSizeClass: UserInterfaceSizeClass?
    @Environment(\.horizontalSizeClass) var horizontalSizeClass: UserInterfaceSizeClass?
  
    @EnvironmentObject var optionSettings: OptionSettings
    @EnvironmentObject var appSettings: AppSettings
    @EnvironmentObject var pageSettings: PageSettings
    @EnvironmentObject var dataSettings: DataSettings
    @EnvironmentObject var shapes: ShapesX
    @StateObject var filesViewModel: FilesViewModel
    @State var showFileAlert = false
    @State private var toBeDeleted: IndexSet?
    @State var showingDeleteAlert = false

    var body: some View {

        NavigationStack {
            Form {
                Section(header: Text("Tap to Open or Swipe Left to Delete")){
                    List {
                        ForEach(filesViewModel.files, id: \.self) { filename in
                            Text(filename).onTapGesture {
                                showFileAlert = true
                                print(filename)
                                filesViewModel.selectedFileName=filename
                            }.swipeActions() {
                                Button(role: .destructive) {
                                    print("delete")
                                    self.showingDeleteAlert = true
                                    filesViewModel.selectedFileName=filename
                                } label: {
                                  Label("Delete", systemImage: "trash")
                                }
                            }.alert(isPresented: self.$showingDeleteAlert) {
                                Alert(title: Text("Are you sure you want to delete this?"), message: Text(appType == "B" ? "This label will be removed permanently." : "This Document will be removed permanently."), primaryButton: .destructive(Text("Delete")) {
                                    
                                    let filename = filesViewModel.selectedFileName
                                    print(filename)
                                    if let dir = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first {
                                        
                                        let fileURL = dir.appendingPathComponent(filename)
                                        do {
                                            try FileManager.default.removeItem(at: fileURL)
                                        }
                                        catch {}
                                    }
                                    filesViewModel.files.remove(at: filesViewModel.files.firstIndex(of: filename)!)
                                }, secondaryButton: .cancel() {
                                    //self.toBeDeleted = nil
                                }
                                )
                            }
                        }
                     }
                     .font(.subheadline)
                }
            }
            .navigationTitle(appType == "B" ? "My Labels" : "My Nodef Documents")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .cancellationAction) {
                        Button("Cancel") {
                            optionSettings.showPropertiesView=0 //set back to 0
                            optionSettings.showPropertiesSheet=false
      
                        }
                }
            }
        }
        //.frame(height:290)
        .onAppear(perform: setupViewModel)
        .alert(isPresented: $showFileAlert) {
            Alert(
                 title: Text("Are you sure you want to open this?"),
                 message: Text(appType == "B" ? "Your current label will be overwritten." : "Your current Document will be overwritten."),
                 primaryButton: .default(Text("Open")) {
                     //open label
                     do {
                         // Get the document directory url
                         let documentDirectory = try FileManager.default.url(
                             for: .documentDirectory,
                             in: .userDomainMask,
                             appropriateFor: nil,
                             create: true
                         )
                         print("documentDirectory", documentDirectory.path)
                         
                         //let fileURL = documentDirectory.appendingPathComponent("label.json")
                         let fileURL = documentDirectory.appendingPathComponent(filesViewModel.selectedFileName)
                         
                         let jsonStr = try String(contentsOf: fileURL, encoding: .utf8)
                         //print(jsonStr)
                         let labelAction = LabelAction(shapes: shapes, pageSettings: pageSettings, dataSettings: dataSettings)
                         labelAction.load(jsonLabelStr: jsonStr)

                        
                
                         //import and open appSettings.dpi use the pageSttings one which is the onve saved
                         appSettings.dpi=pageSettings.dpi
                         optionSettings.showAlert = false
                         optionSettings.showPropertiesSheet = false
                         
                         //new codes
                         let hRatio=UIScreen.main.bounds.size.height/(pageSettings.labelHeight*appSettings.dpi)
                         let wRatio=UIScreen.main.bounds.size.width/(pageSettings.labelWidth*appSettings.dpi)
                         var smallRatio = hRatio > wRatio ? wRatio*0.8 : hRatio*0.8
                         smallRatio = smallRatio < 0.05 ? 0.05 : smallRatio
                         smallRatio = smallRatio > 1 ? 1 : smallRatio
                         print("apply photo zoom ratio",smallRatio)
                         appSettings.zoomFactor=smallRatio
                         
                         //original Codes
                         //appSettings.zoomFactor = horizontalSizeClass == .regular && verticalSizeClass == .regular ? 0.5 : 0.28

                     }
                     catch {
                         print(error)
                     }
                 },
                 secondaryButton: .cancel()
             )
            
        }

    }
    func share()
    {
        
    }
    
    func delete(at offsets: IndexSet) {
        
        self.toBeDeleted = offsets
        self.showingDeleteAlert = true

    }
    
    func setupViewModel()
    {
        //shapePropertiesViewModel.setupSelectedProperties()
        do {
            // Get the document directory url
            let documentDirectory = try FileManager.default.url(
                for: .documentDirectory,
                in: .userDomainMask,
                appropriateFor: nil,
                create: true
            )
            print("documentDirectory", documentDirectory.path)
            // Get the directory contents urls (including subfolders urls)
            let directoryContents = try FileManager.default.contentsOfDirectory(
                at: documentDirectory,
                includingPropertiesForKeys: nil
            )
            //print("directoryContents:", directoryContents.map { $0.localizedName ?? $0.lastPathComponent })
            for url in directoryContents {
                //print(url.localizedName ?? url.lastPathComponent)
                print(url.lastPathComponent)
                if (url.lastPathComponent != "Label.pdf")
                {
                    filesViewModel.files.append(url.lastPathComponent)
                }
            }
        }
        catch {
            print(error)
        }
    }
}

