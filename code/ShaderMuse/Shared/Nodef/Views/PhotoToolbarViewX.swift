//
//  Copyright © 2022 James Boo. All rights reserved.
//


import SwiftUI

@available(iOS 15.0, *)
struct PhotoToolbarViewX: View {
    @Environment(\.colorScheme) var colorScheme
    @EnvironmentObject var appSettings: AppSettings
    @EnvironmentObject var optionSettings: OptionSettings
    @EnvironmentObject var dataSettings: DataSettings
    @EnvironmentObject var pageSettings: PageSettings
    //@EnvironmentObject var shapes: ShapesX
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
            optionSettings.showPagePropertiesView=2
            optionSettings.pagePropertiesHeight = UIScreen.main.bounds.height >= 1024 ? UIScreen.main.bounds.height*0.46 : 400
            optionSettings.selectedItem="Add"
            optionSettings.objectWillChange.send()
            //optionSettings.objectWillChange.send()
            
            let timerX = Timer.scheduledTimer(withTimeInterval: 0.1, repeats: false) { timer in
                print("Timer fired!")
                appSettings.zoomFactor = appSettings.zoomFactor * 0.999
            }
            
        }) {
            Image(systemName: "camera.filters") //wand.and.stars
                .font(.system(size: 24))
                .foregroundColor(colorScheme == .dark ? Color(UIColor(red: 0.9569, green: 0.9569, blue: 0.9569, alpha: 0.5) ) : Color.black).padding([.leading,.trailing], 15)//.background(.blue)
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
            Image(systemName: "f.cursive") //wand.and.stars
                .font(.system(size: 24))
                .foregroundColor(colorScheme == .dark ? Color(UIColor(red: 0.9569, green: 0.9569, blue: 0.9569, alpha: 0.5) ) : Color.black).padding([.leading,.trailing], 15)//.background(.blue)
        }.disabled(!pageSettings.isStopped).opacity(!pageSettings.isStopped ? 0.2 : 1.0)
        Spacer()
    /*
        Menu{
            
            if (appSettings.mode == "Shader" && pageSettings.filters.gotShaderEffects())
            {

                Button(action: {
                    timeElapsedX = 0.0
                    pageSettings.isStopped = false;
                    let animation = SetupAnimation(pageSettings: pageSettings, appSettings: appSettings)
                       animation.createDisplayLink()

                }, label: {
                    Label("Preview Effects",systemImage: "play")

     
                }).foregroundColor(.black)
                
                Button(action: {
                   
                        timeElapsedX = 0.0
                        pageSettings.isStopped = false;
                        pageSettings.savingInProgress=true
                        print("Saving Shader Effects Video")
                        let duration = Double(appSettings.videoDuration)
                        //let framerate = Int32(25)
                        let framerate = Int32(appSettings.videoFPS)
                        
                        //let videoSize = CGSize(width: 640, height:480)
                        let videoSize = CGSize(width: pageSettings.labelWidth*appSettings.dpi, height:pageSettings.labelHeight*appSettings.dpi)
                    
                    build(outputSize: videoSize,pageSettings: pageSettings ,optionSettings: optionSettings, duration: duration,framerate: Int32(framerate))
                        //appSettings.savingInProgress=false
                    
                    }, label: {
                    Label("Save Effects Video",systemImage: "video")
     
                }).foregroundColor(.black).disabled(!pageSettings.isStopped)

            }
            
            Button(action: {
                

                if appSettings.mode=="Shader" || appSettings.imageRes=="Standard Resolution"
                {
                    let avc = UIActivityViewController(activityItems: [pageSettings.filteredBackgroundImage!], applicationActivities: nil)
                    
                    if UIDevice.current.userInterfaceIdiom == .pad {
                        avc.popoverPresentationController?.sourceView = UIApplication.shared.windows.first
                        //avc.popoverPresentationController?.sourceRect = CGRect(x: UIScreen.main.bounds.width / 2.1, y: UIScreen.main.bounds.height / 2.3, width: 200, height: 200)
                        avc.popoverPresentationController?.sourceRect = CGRect(x: UIScreen.main.bounds.width, y: UIScreen.main.bounds.height, width: 200, height: 200)
                    }
                    UIApplication.shared.windows.first?.rootViewController?.present(avc, animated: true, completion: nil)
                }
                else{
                    
                    let data = pageSettings.filteredBackgroundImage!.pngData()! as NSData
                    let imageSourceOptions = [kCGImageSourceShouldCache: false] as CFDictionary
                    guard let imageSource = CGImageSourceCreateWithData(data as CFData, imageSourceOptions) else {
                        return //nil
                    }

                    let maxDimensionInPixels = max(UIScreen.main.bounds.size.width, UIScreen.main.bounds.size.height) * UIScreen.main.scale
                    
                    // Perform downsampling
                    let downsampleOptions = [
                        kCGImageSourceCreateThumbnailFromImageAlways: true,
                        kCGImageSourceShouldCacheImmediately: true,
                        kCGImageSourceCreateThumbnailWithTransform: true,
                        kCGImageSourceThumbnailMaxPixelSize: maxDimensionInPixels
                    ] as CFDictionary
                    guard let downsampledImage = CGImageSourceCreateThumbnailAtIndex(imageSource, 0, downsampleOptions) else {
                        return //nil
                    }
                    
                    let uiimg = UIImage(cgImage: downsampledImage)
                    let avc = UIActivityViewController(activityItems: [uiimg], applicationActivities: nil)
                    UIApplication.shared.windows.first?.rootViewController?.present(avc, animated: true, completion: nil)
                   
                }

            }, label: {
                Label("Share Photo",systemImage: "square.and.arrow.up")
 
            }).foregroundColor(.black).disabled(!pageSettings.isStopped)
            
            Button(action: {
                
                //UIImageWriteToSavedPhotosAlbum(pageSettings.filteredBackgroundImage, self, #selector(saveError), nil)
                ImageSaverX().writeToPhotoAlbum(image: pageSettings.filteredBackgroundImage!)
                optionSettings.showingAlertMessage=true
                optionSettings.alertMessage="Image saved successfully."
        

            }, label: {
                //Label("Save to Photo Album",systemImage: "square.and.arrow.down")
                Label("Save Photo",systemImage: "square.and.arrow.down")
 
            }).foregroundColor(.black).disabled(!pageSettings.isStopped)

        }
        label: {
            
            if (appSettings.mode == "Shader" && pageSettings.filters.gotShaderEffects())
            {
                Image(systemName: "play")
                    .font(.system(size: 23))
                    .foregroundColor(colorScheme == .dark ? Color(UIColor(red: 0.9569, green: 0.9569, blue: 0.9569, alpha: 0.5) ) : Color.black)
            }
            else {
                Image(systemName: "arrow.down")
                    .font(.system(size: 23))
                    .foregroundColor(colorScheme == .dark ? Color(UIColor(red: 0.9569, green: 0.9569, blue: 0.9569, alpha: 0.5) ) : Color.black)
            }
                        
        }
        */
        
        if (appSettings.mode == "Shader" && pageSettings.filters.gotShaderEffects()){
            
            if pageSettings.isStopped{
                Menu{
                    Button(action: {
                        timeElapsedX = 0.0
                        pageSettings.isStopped = false;
                        let animation = SetupAnimation(pageSettings: pageSettings, appSettings: appSettings)
                           animation.createDisplayLink()

                    }, label: {
                        Label("Preview",systemImage: "play")

         
                    }).foregroundColor(.black)
                    
                    Button(action: {
                       
                            timeElapsedX = 0.0
                            pageSettings.isStopped = false;
                            pageSettings.savingInProgress=true
                            print("Saving Shader Effects Video")
                            let duration = Double(appSettings.videoDuration)
                            //let framerate = Int32(25)
                            let framerate = Int32(appSettings.videoFPS)
                            
                            //let videoSize = CGSize(width: 640, height:480)
                            let videoSize = CGSize(width: pageSettings.labelWidth*appSettings.dpi, height:pageSettings.labelHeight*appSettings.dpi)
                        
                        build(outputSize: videoSize,pageSettings: pageSettings ,optionSettings: optionSettings, duration: duration,framerate: Int32(framerate))
                            //appSettings.savingInProgress=false
                        
                        }, label: {
                        Label("Save Video",systemImage: "video")
         
                    }).foregroundColor(.black).disabled(!pageSettings.isStopped)
                    
                    Button(action: {
                        let avc = UIActivityViewController(activityItems: [pageSettings.filteredBackgroundImage!], applicationActivities: nil)
                        
                        if UIDevice.current.userInterfaceIdiom == .pad {
                            avc.popoverPresentationController?.sourceView = UIApplication.shared.windows.first
                            //avc.popoverPresentationController?.sourceRect = CGRect(x: UIScreen.main.bounds.width / 2.1, y: UIScreen.main.bounds.height / 2.3, width: 200, height: 200)
                            avc.popoverPresentationController?.sourceRect = CGRect(x: UIScreen.main.bounds.width, y: UIScreen.main.bounds.height, width: 200, height: 200)
                        }
                        UIApplication.shared.windows.first?.rootViewController?.present(avc, animated: true, completion: nil)
                        

                    }, label: {
                        Label("Share Photo",systemImage: "square.and.arrow.up")
         
                    }).foregroundColor(.black).disabled(!pageSettings.isStopped)
                    
                    Button(action: {
                        
                        //UIImageWriteToSavedPhotosAlbum(pageSettings.filteredBackgroundImage, self, #selector(saveError), nil)
                        ImageSaverX().writeToPhotoAlbum(image: pageSettings.filteredBackgroundImage!)
                        optionSettings.showingAlertMessage=true
                        optionSettings.alertMessage="Image saved successfully."
                
                    }, label: {
                        //Label("Save to Photo Album",systemImage: "square.and.arrow.down")
                        Label("Save Photo",systemImage: "square.and.arrow.down")
         
                    }).foregroundColor(.black).disabled(!pageSettings.isStopped)

                }
                label: {
                    Image(systemName: "play")
                        .font(.system(size: 23))
                        .foregroundColor(colorScheme == .dark ? Color(UIColor(red: 0.9569, green: 0.9569, blue: 0.9569, alpha: 0.5) ) : Color.black)
                                
                }
                                                                
            }
            else {
                Button(action: {
                    pageSettings.isStopped = true;
                    timeElapsedX = 0.0
                    
                }, label: {
                    Image(systemName: "stop")
                        .font(.system(size: 23))
                        .foregroundColor(colorScheme == .dark ? Color(UIColor(red: 0.9569, green: 0.9569, blue: 0.9569, alpha: 0.5) ) : Color.black)
                    
                }).foregroundColor(.black).disabled(pageSettings.isStopped || pageSettings.savingInProgress)
            }
            
        }
        else
        {
            Menu {
                Button(action: {
                
                    if appSettings.mode=="Shader" || appSettings.imageRes=="Standard Resolution"
                    {
                        let avc = UIActivityViewController(activityItems: [pageSettings.filteredBackgroundImage!], applicationActivities: nil)
                        
                        if UIDevice.current.userInterfaceIdiom == .pad {
                            avc.popoverPresentationController?.sourceView = UIApplication.shared.windows.first
                            //avc.popoverPresentationController?.sourceRect = CGRect(x: UIScreen.main.bounds.width / 2.1, y: UIScreen.main.bounds.height / 2.3, width: 200, height: 200)
                            avc.popoverPresentationController?.sourceRect = CGRect(x: UIScreen.main.bounds.width, y: UIScreen.main.bounds.height, width: 200, height: 200)
                        }
                        UIApplication.shared.windows.first?.rootViewController?.present(avc, animated: true, completion: nil)
                    }
                    else{
                        
                        let data = pageSettings.filteredBackgroundImage!.pngData()! as NSData
                        let imageSourceOptions = [kCGImageSourceShouldCache: false] as CFDictionary
                        guard let imageSource = CGImageSourceCreateWithData(data as CFData, imageSourceOptions) else {
                            return //nil
                        }

                        let maxDimensionInPixels = max(UIScreen.main.bounds.size.width, UIScreen.main.bounds.size.height) * UIScreen.main.scale
                        
                        // Perform downsampling
                        let downsampleOptions = [
                            kCGImageSourceCreateThumbnailFromImageAlways: true,
                            kCGImageSourceShouldCacheImmediately: true,
                            kCGImageSourceCreateThumbnailWithTransform: true,
                            kCGImageSourceThumbnailMaxPixelSize: maxDimensionInPixels
                        ] as CFDictionary
                        guard let downsampledImage = CGImageSourceCreateThumbnailAtIndex(imageSource, 0, downsampleOptions) else {
                            return //nil
                        }
                        
                        let uiimg = UIImage(cgImage: downsampledImage)
                        let avc = UIActivityViewController(activityItems: [uiimg], applicationActivities: nil)
                        UIApplication.shared.windows.first?.rootViewController?.present(avc, animated: true, completion: nil)
                       
                    }

                }, label: {
                    Label("Share Photo",systemImage: "square.and.arrow.up")
     
                }).foregroundColor(.black).disabled(!pageSettings.isStopped)
                
                Button(action: {
                    
                    //UIImageWriteToSavedPhotosAlbum(pageSettings.filteredBackgroundImage, self, #selector(saveError), nil)
                    ImageSaverX().writeToPhotoAlbum(image: pageSettings.filteredBackgroundImage!)
                    optionSettings.showingAlertMessage=true
                    optionSettings.alertMessage="Image saved successfully."
            
                }, label: {
                    //Label("Save to Photo Album",systemImage: "square.and.arrow.down")
                    Label("Save Photo",systemImage: "square.and.arrow.down")
     
                }).foregroundColor(.black).disabled(!pageSettings.isStopped)
            }
            label: {
                Image(systemName: "arrow.down")
                                   .font(.system(size: 23))
                                   .foregroundColor(colorScheme == .dark ? Color(UIColor(red: 0.9569, green: 0.9569, blue: 0.9569, alpha: 0.5) ) : Color.black)
            }
        }
        
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
