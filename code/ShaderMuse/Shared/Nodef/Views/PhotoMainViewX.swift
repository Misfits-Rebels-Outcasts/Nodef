//
//  Copyright © 2022 James Boo. All rights reserved.
//

/*
1. when there is a scrollview, drag text issues.
 
*/
import SwiftUI
import CoreImage
import CoreImage.CIFilterBuiltins
import UniformTypeIdentifiers

@available(iOS 15.0, *)

struct PhotoMainViewX: View {
    @Environment(\.verticalSizeClass) var verticalSizeClass: UserInterfaceSizeClass?
    @Environment(\.horizontalSizeClass) var horizontalSizeClass: UserInterfaceSizeClass?
    @EnvironmentObject var optionSettings: OptionSettings
    @EnvironmentObject var appSettings: AppSettings
    @EnvironmentObject var pageSettings: PageSettings
    @EnvironmentObject var dataSettings: DataSettings
    @EnvironmentObject var shapes: ShapesX
    //@EnvironmentObject var store: Store
    
    private func binding(for shape: ShapeX) -> Binding<ShapeX> {
         guard let scrumIndex = shapes.shapeList.firstIndex(where: { $0.id == shape.id }) else {
             fatalError("Can't find scrum in array")
         }
         return $shapes.shapeList[scrumIndex]
     }
    
    var body: some View {
        NavigationView {

        ZStack {
            /*
            ContactPicker(
                showPicker: $optionSettings.showContactPicker,
                onSelectContacts: {cs in
                    dataSettings.contacts = cs
                    //go back to view contacts
                    dataSettings.setupContactsX()
                    
                })
             */
            VStack {

                     
                PhotoDesignViewX()
                    .environmentObject(optionSettings)
                    .environmentObject(pageSettings)
                    .environmentObject(dataSettings)
                    .environmentObject(appSettings)
                    .environmentObject(shapes)
                      
                
                PhotoMainPropertiesViewX()
                    .environmentObject(optionSettings)
                    .environmentObject(pageSettings)
                    .environmentObject(dataSettings)
                    .environmentObject(appSettings)
                    .environmentObject(shapes)
                    //.environmentObject(store)
                 
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
            
        .navigationTitle("Nodef")
        .navigationBarTitleDisplayMode(.inline)
        .toolbar {
       
            ToolbarItemGroup(placement: .navigationBarLeading) {
                PhotoPageToolbarViewX()
                    .environmentObject(optionSettings)
                    .environmentObject(pageSettings)
                    .environmentObject(dataSettings)
                    .environmentObject(appSettings)
                    .environmentObject(shapes)

            }
            ToolbarItemGroup(placement: .navigationBarTrailing) {
                OptionsZoomToolbarViewX()
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

            PhotoMainSheetViewX()
                .environmentObject(appSettings)
                .environmentObject(optionSettings)
                .environmentObject(pageSettings)
                .environmentObject(dataSettings)
                .environmentObject(shapes)
                //.environmentObject(store)
                
        } //sheet
        .textFieldAlert(isPresented: $optionSettings.showAlert) { () -> TextFieldAlert in
            /*
            TextFieldAlert(title: "Saving Label",
                           message: "Please specify label name.",
                           labelContent:optionSettings.jsonLabelStringForSave,
                           text: $optionSettings.enteredSaveFileName,
                           saveSuccess: $optionSettings.showingAlertMessage,
                           existingLabelExist: $optionSettings.existingLabelExist,
                           alertMessage: $optionSettings.alertMessage)
             */
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
        ) { result in
            do {
                guard let selectedFile: URL = try result.get().first else { return }
                guard selectedFile.startAccessingSecurityScopedResource() else { return }
                guard let message = String(data: try Data(contentsOf: selectedFile), encoding: .utf8) else { return }
                let labelAction = LabelAction(shapes: shapes, pageSettings: pageSettings, dataSettings: dataSettings)
                labelAction.load(jsonLabelStr: message)
                optionSettings.showAlert = false
                optionSettings.showPropertiesSheet = false
                
                //newcodes for apply zoom
                let hRatio=UIScreen.main.bounds.size.height/(pageSettings.labelHeight*appSettings.dpi)
                let wRatio=UIScreen.main.bounds.size.width/(pageSettings.labelWidth*appSettings.dpi)
                var smallRatio = hRatio > wRatio ? wRatio*0.8 : hRatio*0.8
                smallRatio = smallRatio < 0.05 ? 0.05 : smallRatio
                smallRatio = smallRatio > 1 ? 1 : smallRatio
                print("apply photo zoom ratio",smallRatio)
                appSettings.zoomFactor=smallRatio
                
                //appSettings.zoomFactor = horizontalSizeClass == .regular && verticalSizeClass == .regular ? 0.5 : 0.28

                selectedFile.stopAccessingSecurityScopedResource()
                optionSettings.showingAlertMessage = true
                //optionSettings.alertMessage="Label imported successfully."
                optionSettings.alertMessage="Document imported successfully."
                //import and open appSettings.dpi use the pageSttings one which is the onve saved
                appSettings.dpi=pageSettings.dpi

            } catch {
                print(error.localizedDescription)
                optionSettings.showingAlertMessage = true
                //optionSettings.alertMessage="An error has occured while importing label - Invalid Label File."
                optionSettings.alertMessage="An error has occured while importing document - Invalid Document File."
            }
        }        
        .fileExporter(
            isPresented: $optionSettings.isExporting,
            document: optionSettings.labelDocument,
            contentType: UTType.json,
            defaultFilename: appType=="B" ? "Label" : "NodeFilters"
        ) { result in
            optionSettings.showingAlertMessage = true
            if case .success = result {
                //optionSettings.alertMessage="Label exported successfully."
                optionSettings.alertMessage="Document exported successfully."
                print("Success!")
            } else {
                //optionSettings.alertMessage="An error has occured while exporting label. Please try again or contact us."
                optionSettings.alertMessage="An error has occured while exporting document. Please try again or contact us."
                print("Something went wrong…")
            }
        }
        
    } //body

   
    func dismissSheet()
    {
        //comeback and review ReadPhotoIssue
        //the problem it caused is in ReadPhoto
        //this occurs before handleImage in PhotoPicker causing issues.
        //commented out
        //optionSettings.action = "Design"
    }
    
    func initLabel() {
        shapes.shapeList=[ShapeX]()
    }
    

    
    func initPage() {
        
        print("initPage",UIScreen.main.bounds.size.width,UIScreen.main.bounds.size.height,UIScreen.main.scale)
        let defaults = UserDefaults.standard
        if let unitstring = defaults.string(forKey: "resolution"), !unitstring.isEmpty {
            print("Getting:",unitstring,":",appSettings.imageRes)
            appSettings.imageRes = unitstring
        }
        else{
            print("Setting:",appSettings.imageRes)
            defaults.set(appSettings.imageRes, forKey: "resolution")
        }
        
        if let modestring = defaults.string(forKey: "mode"), !modestring.isEmpty {
            print("Getting:",modestring,":",appSettings.mode)
            appSettings.mode = modestring
        }
        else{
            print("Setting:",appSettings.mode)
            defaults.set(appSettings.mode, forKey: "mode")
        }
        
        if let durationstring = defaults.string(forKey: "duration"), !durationstring.isEmpty {
            print("Getting:",durationstring,":",appSettings.videoDuration)
            appSettings.videoDuration = (durationstring as NSString).floatValue
        }
        else{
            print("Setting:",appSettings.videoDuration)
            defaults.set(appSettings.videoDuration, forKey: "duration")
        }
        
        if let fpsstring = defaults.string(forKey: "fps"), !fpsstring.isEmpty {
            print("Getting:",fpsstring,":",appSettings.videoFPS)
            appSettings.videoFPS = (fpsstring as NSString).floatValue
        }
        else{
            print("Setting:",appSettings.videoFPS)
            defaults.set(appSettings.videoFPS, forKey: "fps")
        }
                
        //let filePath = Bundle.main.url(forResource: "Vincent_van_Gogh_-_Sunflowers_-_VGM_F458", withExtension: "jpg")!
        //causes IOSurface creation failed error in downsample
        
        let filePath = Bundle.main.url(forResource: "VincentvanGoghSunflowers", withExtension: "jpg")!

        if (appSettings.mode=="Shader")
        {
            if let data = try? Data(contentsOf: filePath) {
                var originalImage = UIImage(data: data)
                let downsampledImage = ImageUtil.downsample(imageAt: filePath, to: UIScreen.main.bounds.size, scale: UIScreen.main.scale / appSettings.shaderDownScale)
                pageSettings.storeOriginalAndApplyPhoto(originalImage: originalImage!, backgroundImage: downsampledImage!, dpi:appSettings.dpi)
            }
        }
        else {
            if (appSettings.imageRes=="Standard Resolution")
            {
                if let data = try? Data(contentsOf: filePath) {
                    var originalImage = UIImage(data: data)
                    
                    let downsampledImage = ImageUtil.downsample(imageAt: filePath, to: UIScreen.main.bounds.size, scale: UIScreen.main.scale)
                    pageSettings.storeOriginalAndApplyPhoto(originalImage: originalImage!, backgroundImage: downsampledImage!, dpi:appSettings.dpi)

                }
            }
            else
            {
                if let data = try? Data(contentsOf: filePath) {
                    var originalImage = UIImage(data: data)
                    pageSettings.storeOriginalAndApplyPhoto(originalImage: originalImage!, backgroundImage: originalImage!, dpi:appSettings.dpi)
                }
            }
        }
        
        /*
        
        let heightInPoints = uiImage!.size.height
        let heightInPixels = heightInPoints * uiImage!.scale
        let widthInPoints = uiImage!.size.width
        let widthInPixels = widthInPoints * uiImage!.scale
        print("height",heightInPixels)
        print("width",widthInPixels)
                
        print("initPage:",labelTemplatesAll.count)

        pageSettings.dpi=appSettings.dpi
        pageSettings.name = "Photo Size"
        pageSettings.category = "Papers"
        pageSettings.vendor = "Standard"
        pageSettings.description = "Photo Size 1x1"
        pageSettings.type = "paper-portrait"
        
        pageSettings.pageWidth = widthInPixels/pageSettings.dpi
        pageSettings.pageHeight = heightInPixels/pageSettings.dpi
        pageSettings.labelWidth = widthInPixels/pageSettings.dpi
        pageSettings.labelHeight = heightInPixels/pageSettings.dpi
        
        pageSettings.hSpace = 0.0
        pageSettings.vSpace = 0.0
        pageSettings.numRows = 1
        pageSettings.numCols = 1
        pageSettings.leftMargin = 0.0
        pageSettings.topMargin = 0.0
         */
        pageSettings.generateLabels()

        //AAMerge
        

        
        /*
        let defaults = UserDefaults.standard
        if let unitstring = defaults.string(forKey: "units"), !unitstring.isEmpty {
            print("Getting:",unitstring,":",appSettings.dpi)
            appSettings.units = unitstring
        }
        else{
            print("Setting:",appSettings.units)
            defaults.set(appSettings.units, forKey: "units")
        }
        */

    }
    func convertStringToDictionary(text: String) -> [String:AnyObject]? {
       if let data = text.data(using: .utf8) {
           do {
               let json = try JSONSerialization.jsonObject(with: data, options: .mutableContainers) as? [String:AnyObject]
               return json
           } catch {
               print("Something went wrong")
           }
       }
       return nil
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

        print("Ratio",wRatio,hRatio)
        
        //let timer2 =
        let timer2 = Timer.scheduledTimer(withTimeInterval: 0.1, repeats: false) { timer in
            print("Timer fired!")
            //appSettings.zoomFactor = horizontalSizeClass == .regular && verticalSizeClass == .regular ? 0.5 : 0.28
//            appSettings.zoomFactor = horizontalSizeClass == .regular && verticalSizeClass == .regular ? 0.3 : 0.11
            //appSettings.zoomFactor = hRatio > wRatio ? wRatio*0.8 : hRatio*0.8
            appSettings.zoomFactor = smallRatio
            
            print(appSettings.zoomFactor)
        }
        
    }
}


extension View {
    fileprivate func withHostingWindow(_ callback: @escaping (UIWindow?) -> Void) -> some View {
        self.background(HostingWindowFinder(callback: callback))
    }
}

fileprivate struct HostingWindowFinder: UIViewRepresentable {
    var callback: (UIWindow?) -> ()

    func makeUIView(context: Context) -> UIView {
        let view = UIView()
        DispatchQueue.main.async { [weak view] in
            self.callback(view?.window)
        }
        return view
    }

    func updateUIView(_ uiView: UIView, context: Context) {
    }
}
