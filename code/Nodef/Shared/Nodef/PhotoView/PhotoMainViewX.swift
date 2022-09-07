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

    //@EnvironmentObject var store: Store

    var body: some View {
        NavigationView {

        ZStack {

            VStack {

                     
                PhotoDesignViewX()
                    .environmentObject(optionSettings)
                    .environmentObject(pageSettings)
                    .environmentObject(dataSettings)
                    .environmentObject(appSettings)
                    //.environmentObject(shapes)
                      
                
                PhotoMainPropertiesViewX()
                    .environmentObject(optionSettings)
                    .environmentObject(pageSettings)
                    .environmentObject(dataSettings)
                    .environmentObject(appSettings)
                    //.environmentObject(shapes)
                    //.environmentObject(store)
                 
            }

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
                    //.environmentObject(shapes)

            }
            ToolbarItemGroup(placement: .navigationBarTrailing) {
                OptionsZoomToolbarViewX()
            }
        }
        .ignoresSafeArea(.container, edges: [.bottom])
        } //navigationview
        .navigationViewStyle(StackNavigationViewStyle())
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
                //.environmentObject(shapes)
                //.environmentObject(store)
                
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
        ) { result in
            do {
                guard let selectedFile: URL = try result.get().first else { return }
                guard selectedFile.startAccessingSecurityScopedResource() else { return }
                guard let message = String(data: try Data(contentsOf: selectedFile), encoding: .utf8) else { return }
                let labelAction = LabelAction(pageSettings: pageSettings, dataSettings: dataSettings)
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
        optionSettings.action = "Design"
    }
    
    func initLabel() {
        //shapes.shapeList=[ShapeX]()
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
        let filePath = Bundle.main.url(forResource: "Vincent_van_Gogh_-_Sunflowers_-_VGM_F458", withExtension: "jpg")!

        if (appSettings.imageRes=="Standard Resolution")
        {        
            print("size",ImageUtil.sizeForImage(at: filePath))
            let downsampledImage = ImageUtil.downsample(imageAt: filePath, to: UIScreen.main.bounds.size, scale: UIScreen.main.scale)
            pageSettings.applyPhoto(uiImage: downsampledImage!, dpi:appSettings.dpi)
        }
        else
        {
            if let data = try? Data(contentsOf: filePath) {
                var uiImage = UIImage(data: data)
                 
                pageSettings.applyPhoto(uiImage: uiImage!, dpi:appSettings.dpi)
            }
        }
        
        pageSettings.generateLabels()


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


