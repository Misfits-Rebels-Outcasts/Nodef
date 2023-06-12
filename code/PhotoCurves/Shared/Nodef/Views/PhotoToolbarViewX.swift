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
        Spacer()

        Button(action: {
            optionSettings.action = "SelectPhoto"
            optionSettings.square = false
            optionSettings.useCamera = false
            optionSettings.showPropertiesSheet = true
        }) {
            Image(systemName: "photo.on.rectangle.angled")
                .font(.system(size: 24))
                .foregroundColor(colorScheme == .dark ? Color(UIColor(red: 0.9569, green: 0.9569, blue: 0.9569, alpha: 0.5) ) : Color.black)
            //Label("Select Photo", systemImage: "photo")
        }.disabled(!pageSettings.isStopped).opacity(!pageSettings.isStopped ? 0.2 : 1.0)
                
        Spacer()
        Button(action: {
            print("show filters")
            //optionSettings.showPropertiesView = 7
            optionSettings.showPagePropertiesView=1
           
            optionSettings.pagePropertiesHeight = UIScreen.main.bounds.height >= 1024 ? UIScreen.main.bounds.height*0.46 : 400
            optionSettings.selectedItem="Add"
            optionSettings.objectWillChange.send()
            
            
            let timerX = Timer.scheduledTimer(withTimeInterval: 0.1, repeats: false) { timer in
                print("Timer fired!")
                appSettings.zoomFactor = appSettings.zoomFactor * 0.999
            }

            //optionSettings.objectWillChange.send()
        }) {
            Image(systemName: "point.topleft.down.curvedto.point.bottomright.up") //wand.and.stars
                .font(.system(size: 24))
                .foregroundColor(colorScheme == .dark ? Color(UIColor(red: 0.9569, green: 0.9569, blue: 0.9569, alpha: 0.5) ) : Color.black).padding([.leading,.trailing], 15)//.background(.blue)
        }.disabled(!pageSettings.isStopped).opacity(!pageSettings.isStopped ? 0.2 : 1.0)
        Spacer()

        Button(action: {
            
            ImageSaverX().writeToPhotoAlbum(image: pageSettings.filteredBackgroundImage!)
            optionSettings.showingAlertMessage=true
            optionSettings.alertMessage="Image saved successfully."
            
        }, label: {
            Image(systemName: "arrow.down")
                .font(.system(size: 23))
                .foregroundColor(colorScheme == .dark ? Color(UIColor(red: 0.9569, green: 0.9569, blue: 0.9569, alpha: 0.5) ) : Color.black)
            
        }).foregroundColor(.black)//.disabled(!pageSettings.isStopped)
        
        
        /*
        Menu{
            Button(action: {
                
                ImageSaverX().writeToPhotoAlbum(image: pageSettings.filteredBackgroundImage!)
                optionSettings.showingAlertMessage=true
                optionSettings.alertMessage="Image saved successfully."
                
            }, label: {
                Label("Save Photo",systemImage: "arrow.down")
                Image(systemName: "arrow.down")
                    .font(.system(size: 24))
                
            }).foregroundColor(.black)//.disabled(!pageSettings.isStopped)
            
            Button(action: {
                timeElapsedX = 0.0
                pageSettings.isStopped = false;
                let animation = SetupAnimation(pageSettings: pageSettings, appSettings: appSettings)
                   animation.createDisplayLink()

            }, label: {
                Label("Preview",systemImage: "play")


            }).foregroundColor(.black)

        }
        label: {
   
            Image(systemName: "play")
                .font(.system(size: 23))
                .foregroundColor(colorScheme == .dark ? Color(UIColor(red: 0.9569, green: 0.9569, blue: 0.9569, alpha: 0.5) ) : Color.black)
                             
        }
         */
        Spacer()

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
