//
//  Copyright © 2022 James Boo. All rights reserved.
//


import SwiftUI

@available(iOS 15.0, *)

struct SharePhotoButtonViewX: View {

    @EnvironmentObject var pageSettings: PageSettings
    //ANCHISES
    let keyWindow = UIApplication.shared.connectedScenes
            .filter({$0.activationState == .foregroundActive})
            .compactMap({$0 as? UIWindowScene})
            .first?.windows
            .filter({$0.isKeyWindow}).first
    
    var body: some View {
                
        Button(action: {
            let avc = UIActivityViewController(activityItems: [pageSettings.filteredBackgroundImage!], applicationActivities: nil)
            
            if UIDevice.current.userInterfaceIdiom == .pad {
                //ANCHISES
                //avc.popoverPresentationController?.sourceView = UIApplication.shared.windows.first
                avc.popoverPresentationController?.sourceView = keyWindow
                avc.popoverPresentationController?.sourceRect = CGRect(x: UIScreen.main.bounds.width, y: UIScreen.main.bounds.height, width: 200, height: 200)
            }
            //ANCHISES
            keyWindow?.rootViewController?.present(avc, animated: true, completion: nil)
            //UIApplication.shared.windows.first?.rootViewController?.present(avc, animated: true, completion: nil)
            

        }, label: {
            Label("Share Photo",systemImage: "square.and.arrow.up")

        }).foregroundColor(.black).disabled(!pageSettings.isStopped)
    }

}

struct SharePhotoWithResButtonViewX: View {

    @EnvironmentObject var appSettings: AppSettings
    @EnvironmentObject var pageSettings: PageSettings
        
    //ANCHISES
    let keyWindow = UIApplication.shared.connectedScenes
            .filter({$0.activationState == .foregroundActive})
            .compactMap({$0 as? UIWindowScene})
            .first?.windows
            .filter({$0.isKeyWindow}).first
    
    var body: some View {
                
        Button(action: {
        
            if appSettings.mode=="Shader" || appSettings.imageRes=="Standard Resolution"
            {
                let avc = UIActivityViewController(activityItems: [pageSettings.filteredBackgroundImage!], applicationActivities: nil)
                
                if UIDevice.current.userInterfaceIdiom == .pad {
                    //ANCHISES
                    //avc.popoverPresentationController?.sourceView = UIApplication.shared.windows.first
                    avc.popoverPresentationController?.sourceView = keyWindow
                    avc.popoverPresentationController?.sourceRect = CGRect(x: UIScreen.main.bounds.width, y: UIScreen.main.bounds.height, width: 200, height: 200)
                }
            
              
                //ANCHISES
                keyWindow?.rootViewController?.present(avc, animated: true, completion: nil)
                //UIApplication.shared.windows.first?.rootViewController?.present(avc, animated: true, completion: nil)
            }
            else{
                
                let data = pageSettings.filteredBackgroundImage!.pngData()! as NSData
                let imageSourceOptions = [kCGImageSourceShouldCache: false] as CFDictionary
                guard let imageSource = CGImageSourceCreateWithData(data as CFData, imageSourceOptions) else {
                    return //nil
                }

                let maxDimensionInPixels = max(UIScreen.main.bounds.size.width, UIScreen.main.bounds.size.height) * UIScreen.main.scale
                
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
                //ANCHISES
                keyWindow?.rootViewController?.present(avc, animated: true, completion: nil)
                //UIApplication.shared.windows.first?.rootViewController?.present(avc, animated: true, completion: nil)
               
            }

        }, label: {
            Label("Share Photo",systemImage: "square.and.arrow.up")

        }).foregroundColor(.black).disabled(!pageSettings.isStopped)
          }

}
