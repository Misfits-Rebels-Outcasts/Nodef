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
                    .environmentObject(appSettings)
            
                PhotoMainPropertiesViewX()
                    .environmentObject(optionSettings)
                    .environmentObject(pageSettings)
                    .environmentObject(appSettings)

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
            
        .navigationTitle("Photo Curves")
        .navigationBarTitleDisplayMode(.inline)
        .toolbar {
       
            ToolbarItemGroup(placement: .navigationBarLeading) {
                
                
                PhotoPageToolbarViewX()
                    .environmentObject(optionSettings)
                    .environmentObject(pageSettings)
                    .environmentObject(appSettings)
                   

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

                //.environmentObject(store)
                
        } //sheet
        
        
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
  
    }
    

    
    func initPage() {
        
        print("initPage",UIScreen.main.bounds.size.width,UIScreen.main.bounds.size.height,UIScreen.main.scale)
        /*
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
                
         */
        //let filePath = Bundle.main.url(forResource: "Vincent_van_Gogh_-_Sunflowers_-_VGM_F458", withExtension: "jpg")!
        //causes IOSurface creation failed error in downsample
        
        //let filePath = Bundle.main.url(forResource: "VincentvanGoghSunflowers", withExtension: "jpg")!
        let filePath = Bundle.main.url(forResource: "photocurves", withExtension: "jpg")!
        
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
