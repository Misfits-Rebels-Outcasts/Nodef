//
//  Copyright © 2022-2023 James Boo. All rights reserved.
//

import SwiftUI
import CoreImage
import CoreImage.CIFilterBuiltins
import UniformTypeIdentifiers

@available(iOS 15.0, *)

struct PipelineMainViewX: View {
    @AppStorage("isOnboarding") var isOnboarding: String?
    
    @Environment(\.colorScheme) var colorScheme
    @EnvironmentObject var optionSettings: OptionSettings
    @EnvironmentObject var appSettings: AppSettings
    @EnvironmentObject var pageSettings: PageSettings
 
    
    var body: some View {
        
        if isOnboarding == nil || isOnboarding=="OnBoarding" {
            OnBoardingView()
        }
        else if isOnboarding=="OnDigitalCompositing" {
            OnCompositingView()
        }
        else if isOnboarding=="OnBlending" {
            OnBlendingView()
        }
        else if isOnboarding=="OnTrim" {
            OnTrimView()
        }
        else {
            NavigationView {

            ZStack {
                VStack {
                    if pageSettings.filters.currentNodeType() == "AR" {
                        RealityDesignViewX()
                            .edgesIgnoringSafeArea(optionSettings.showingAR ? [.all] : [.bottom])
                            .environmentObject(optionSettings)
                            .environmentObject(pageSettings)
                            .environmentObject(appSettings)
                            .overlay(optionSettings.showingAR == true ?
                                     RealityCaptureViewX()
                                        .environmentObject(optionSettings)
                                        .environmentObject(pageSettings)
                                : nil)
                        /*Vision Pro Support Issue
                         Info.plsit
                         Required device capabities
                         Item 0 Still Camera
                            .overlay(optionSettings.showingAR == true ?
                                     RealityCaptureViewX()
                                        .environmentObject(optionSettings)
                                        .environmentObject(pageSettings)
                                : nil)
                        */
                    }
                    //ANCHISES
                    else if pageSettings.filters.currentNodeType() == "Video" {
                        
                        VideoDesignViewX()
                            .edgesIgnoringSafeArea([.bottom])
                            .environmentObject(optionSettings)
                            .environmentObject(pageSettings)
                            .environmentObject(appSettings)
                     

                    }
                    else
                    {
                        PhotoDesignViewX()
                            .environmentObject(optionSettings)
                            .environmentObject(pageSettings)
                            .environmentObject(appSettings)
                    }
                    
                    if optionSettings.showingAR == false {
                        PipelineMainPropertiesViewX()
                            .environmentObject(optionSettings)
                            .environmentObject(pageSettings)
                            .environmentObject(appSettings)
                    }
                     
                }

            }
            .withHostingWindow { window in
                #if targetEnvironment(macCatalyst)
                if let titlebar = window?.windowScene?.titlebar {
                    titlebar.titleVisibility = .hidden
                    titlebar.toolbar = nil
                }
                #endif
            }
            //ANCHISES
            .navigationTitle(optionSettings.showingAR ? "" : "^Cat Cut v0.1")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                /*
                if pageSettings.filters.currentNodeType() == "Photo" {
                    ToolbarItemGroup(placement: .navigationBarLeading) {
                        OptionsZoomToolbarViewX()
                    }
                }
                 */
                /*
                ToolbarItemGroup(placement: .bottomBar) {
                    HStack{
                        Spacer()
                        PhotoToolbarViewX()
                        .environmentObject(appSettings)
                        .environmentObject(optionSettings)
                        .environmentObject(pageSettings)
                           
                        Spacer()
                    }
                }
            */
                if optionSettings.showingAR == false {
                    ToolbarItemGroup(placement: .navigationBarTrailing) {
                        

                        VideoPageToolbarViewX()
                            .environmentObject(optionSettings)
                            .environmentObject(pageSettings)
                            .environmentObject(appSettings)
                            .disabled(!pageSettings.isStopped).opacity(!pageSettings.isStopped ? 0.2 : 1.0)

                    }
                    
                     
                }
             
            }
            .ignoresSafeArea(.container, edges: [.bottom])
            } //navigationview
            .navigationViewStyle(.stack)
            //.navigationViewStyle(StackNavigationViewStyle())
            .onAppear(perform: initAll)
            .alert(isPresented: $optionSettings.showingAlertMessage) {
                Alert(title: Text("Status"), message: Text(optionSettings.alertMessage!), dismissButton: .default(Text("OK")))
            }
            .sheet(isPresented: $optionSettings.showPropertiesSheet, onDismiss: dismissSheet) {

                PipelineMainSheetViewX()
                    .environmentObject(appSettings)
                    .environmentObject(optionSettings)
                    .environmentObject(pageSettings)

            } //sheet
            .textFieldAlert(isPresented: $optionSettings.showAlert) { () -> TextFieldAlert in
                TextFieldAlert(title: "Saving Document",
                               message: "Please specify document name.",
                               labelContent:optionSettings.jsonLabelStringForSave,
                               text: $optionSettings.enteredSaveFileName,
                               saveSuccess: $optionSettings.showingAlertMessage,
                               existingLabelExist: $optionSettings.existingLabelExist,
                               alertMessage: $optionSettings.alertMessage)
            }
            .fileImporter(
                isPresented: $optionSettings.isImporting,
                allowedContentTypes: [UTType.json],
                allowsMultipleSelection: false
            ) {
                result in
                importFile(result)
            }
            /*
            .fileExporter(
                isPresented: $optionSettings.isExporting,
                document: optionSettings.labelDocument,
                contentType: UTType.json,
                defaultFilename: appType=="B" ? "Label" : "NodeFilters"
            ) {
                result in
                exportFile(result)
            }
             */
        }
                

        
    } //body

    func exportFile(_ result: Result<Foundation.URL, Error>)
    {
        optionSettings.showingAlertMessage = true
        if case .success = result {
            optionSettings.alertMessage="Document exported successfully."
            print("Success!")
        } else {

            optionSettings.alertMessage="An error has occured while exporting document. Please try again or contact us."
            print("Something went wrong…")
        }
    }

    func importFile(_ result: Result<[Foundation.URL], Error>)
    {
           do {
               guard let selectedFile: URL = try result.get().first else { return }
               guard selectedFile.startAccessingSecurityScopedResource() else { return }
               guard let message = String(data: try Data(contentsOf: selectedFile), encoding: .utf8) else { return }
               let docAction = DocumentAction(pageSettings: pageSettings)
               docAction.load(jsonLabelStr: message)
               //ANCHISES
               //pageSettings.backgroundImage = ImageUtil.downSizeImage(mode: appSettings.mode,imageRes: appSettings.imageRes,shaderDownScale: appSettings.shaderDownScale,image: pageSettings.originalBackgroundImage)
               
               pageSettings.backgroundImage = ImageUtil.getImageWithOrientation(image: pageSettings.originalBackgroundImage)
               
               pageSettings.filteredBackgroundImage = pageSettings.backgroundImage
               
               optionSettings.showAlert = false
               optionSettings.showPropertiesSheet = false
               
               let hRatio=UIScreen.main.bounds.size.height/(pageSettings.labelHeight*appSettings.dpi)
               let wRatio=UIScreen.main.bounds.size.width/(pageSettings.labelWidth*appSettings.dpi)
               var smallRatio = hRatio > wRatio ? wRatio*0.8 : hRatio*0.8
               smallRatio = smallRatio < 0.05 ? 0.05 : smallRatio
               smallRatio = smallRatio > 1 ? 1 : smallRatio
               print("apply photo zoom ratio",smallRatio)
               appSettings.zoomFactor=smallRatio

               selectedFile.stopAccessingSecurityScopedResource()
               optionSettings.showingAlertMessage = true
               optionSettings.alertMessage="Document imported successfully."
               appSettings.dpi=pageSettings.dpi

           } catch {
               print(error.localizedDescription)
               optionSettings.showingAlertMessage = true
               optionSettings.alertMessage="An error has occured while importing document - Invalid Document File."
           }
    }
    
    func dismissSheet()
    {
        Singleton.onPagePropertiesOff(pageSettings, optionSettings, appSettings)
        //ANCHISES
        //add code to resevet viewer to current node.
        pageSettings.applyFilters()
        //pageSettings.updateAVPlayer()
    }
    
    func initLabel() {
 
    }
    
    func initPage() {
        
        let defaults = UserDefaults.standard
        if let unitstring = defaults.string(forKey: "resolution"), !unitstring.isEmpty {
   
            appSettings.imageRes = unitstring
        }
        else{
   
            defaults.set(appSettings.imageRes, forKey: "resolution")
        }
        
        if let modestring = defaults.string(forKey: "mode"), !modestring.isEmpty {
   
            appSettings.mode = modestring
        }
        else{

            defaults.set(appSettings.mode, forKey: "mode")
        }
        
        if let durationstring = defaults.string(forKey: "duration"), !durationstring.isEmpty {
    
            appSettings.videoDuration = (durationstring as NSString).floatValue
        }
        else{

            defaults.set(appSettings.videoDuration, forKey: "duration")
        }
        
        if let fpsstring = defaults.string(forKey: "fps"), !fpsstring.isEmpty {
      
            appSettings.videoFPS = (fpsstring as NSString).floatValue
        }
        else{
 
            defaults.set(appSettings.videoFPS, forKey: "fps")
        }
                
        //let filePath = Bundle.main.url(forResource: "Zermatt", withExtension: "jpg")!

    }

    func initAll()
    {
        initLabel()
        initPage()
        
        let hRatio=UIScreen.main.bounds.size.height/(pageSettings.labelHeight*appSettings.dpi)
        let wRatio=UIScreen.main.bounds.size.width/(pageSettings.labelWidth*appSettings.dpi)
        var smallRatio = hRatio > wRatio ? wRatio*0.8 : hRatio*0.8
        smallRatio = smallRatio < 0.05 ? 0.05 : smallRatio
        smallRatio = smallRatio > 1 ? 1 : smallRatio
        
        _ = Timer.scheduledTimer(withTimeInterval: 0.1, repeats: false) { timer in
            appSettings.zoomFactor = smallRatio
            
        }
        
    }
}



