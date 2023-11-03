//
//  Copyright © 2022 James Boo. All rights reserved.
//


import SwiftUI

@available(iOS 15.0, *)
struct PhotoToolbarViewX: View {
    @Environment(\.colorScheme) var colorScheme
    @EnvironmentObject var appSettings: AppSettings
    @EnvironmentObject var optionSettings: OptionSettings

    @EnvironmentObject var pageSettings: PageSettings

    @State private var showingAlert = false

    @State var measurementUnit : String = "Inches"

    var body: some View {
        //ANCHISES
        /*
        if pageSettings.filters.currentNodeType() == "Photo" {
            //ANCHISES
            //Spacer()

            //SelectPhotoButtonViewX()
            //    .environmentObject(optionSettings)
            //    .environmentObject(pageSettings)
            
            Spacer()
            
            PresetsButtonViewX()
                .environmentObject(appSettings)
                .environmentObject(optionSettings)
                .environmentObject(pageSettings)
        }
        */

        Spacer()
     
        
        DynamicToolbarViewX()
            .environmentObject(appSettings)
            .environmentObject(optionSettings)
            .environmentObject(pageSettings)
        
          
        Spacer()

        /*
        FiltersButtonViewX()
            .environmentObject(appSettings)
            .environmentObject(optionSettings)
            .environmentObject(pageSettings)
            .padding(.top,5)

        Spacer()
         */

    }

}

class ImageSaverX: NSObject {

    func writeToPhotoAlbum(image: UIImage) {
        UIImageWriteToSavedPhotosAlbum(image, self, #selector(saveError), nil)
    }
               
    @objc func saveError(_ image: UIImage, didFinishSavingWithError error: Error?, contextInfo: UnsafeRawPointer) {
        //print("Save finished!")
    }
}

class SetupAnimation {
        
        public var appSettings : AppSettings
        public var pageSettings : PageSettings
        public var currentTime : Double = 0
        public var initialTime : Double = 0
        public var isRunning : Bool = false
        
        init( pageSettings : PageSettings,appSettings : AppSettings)
        {
            self.pageSettings = pageSettings
            self.appSettings = appSettings

        }
        
        func createDisplayLink() {
            
            
            let displaylink = CADisplayLink(target: self, selector: #selector(step))
            
            displaylink.add(to: .current, forMode: RunLoop.Mode.default)
            
            //isRunning = true
           
        }
        
        @objc func step(displaylink: CADisplayLink) {
            
            
            currentTime = displaylink.timestamp
            if (initialTime==0)
            {
                initialTime=currentTime
                return
                
            }
            let elapsed = (currentTime - initialTime)
            
            if ((elapsed>=Double(appSettings.videoDuration)) || (pageSettings.isStopped)) //10 seconds
            {
                displaylink.remove(from: .current, forMode: RunLoop.Mode.default)
                
                isRunning = false
                pageSettings.isStopped = true
                
                return
                
            }
            
            pageSettings.timeElapsed = elapsed
            timeElapsedX=elapsed

            //main function to apply the filter repeatedly
            pageSettings.applyFilters()
           
        }
        
    }
