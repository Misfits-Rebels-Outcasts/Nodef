//
//  Copyright © 2022 James Boo. All rights reserved.
//

import Foundation
import PhotosUI
import SwiftUI

@available(iOS 15.0, *)
struct ReadPHImagePicker: UIViewControllerRepresentable {
    var didFinishPicking: (_ didSelectItems: Bool) -> Void
    
  
    @EnvironmentObject var appSettings: AppSettings
    @EnvironmentObject var optionSettings: OptionSettings
    @EnvironmentObject var pageSettings: PageSettings
    //@EnvironmentObject var store: Store
    
    func makeUIViewController(context: Context) -> PHPickerViewController {
        var config = PHPickerConfiguration()
        config.filter = .images
        let picker = PHPickerViewController(configuration: config)
        picker.delegate = context.coordinator
        return picker
    }

    func updateUIViewController(_ uiViewController: PHPickerViewController, context: Context) {

    }

    func makeCoordinator() -> Coordinator {
        Coordinator(self)
    }

    class Coordinator: NSObject, PHPickerViewControllerDelegate {
        let parent: ReadPHImagePicker

        init(_ parent: ReadPHImagePicker) {
            self.parent = parent
        }

        func picker(_ picker: PHPickerViewController, didFinishPicking results: [PHPickerResult]) {
            picker.dismiss(animated: true)

            guard let provider = results.first?.itemProvider else { return }
            
            if provider.canLoadObject(ofClass: UIImage.self) {
                provider.loadObject(ofClass: UIImage.self) { image, _ in
                    //self.parent.image = image as? UIImage
                    
                    if (image as? UIImage)!.imageOrientation == UIImage.Orientation.up {
                        print("original portrait")
                        let uiImage = (image as? UIImage)!
                        var finalDisplayImage: UIImage?
                        if //self.parent.store.purchasedSubscriptions.count <= 0 ||
                            self.parent.appSettings.imageRes == "Standard Resolution"
                        {
                            let data = uiImage.pngData()! as NSData
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
                            finalDisplayImage=UIImage(cgImage: downsampledImage)
                        }
                        else{
                            finalDisplayImage=uiImage
                        }
 
                        print("portrait ended")
                        
                        DispatchQueue.main.async(execute: {
                            self.parent.pageSettings.applyReadPhoto(uiImage:finalDisplayImage!)
                                                        
                            self.parent.didFinishPicking(true)
                        })
                        
                       }
                    else{
                        print("original landscape")
                        let uiImage = (image as? UIImage)!
                        
                        var finalDisplayImage: UIImage?
                        if //self.parent.store.purchasedSubscriptions.count <= 0 ||
                            self.parent.appSettings.imageRes == "Standard Resolution"
                        {
                            UIGraphicsBeginImageContext(uiImage.size)
                            uiImage.draw(in: CGRect(origin: CGPoint.zero, size: uiImage.size))
                            let context = UIGraphicsGetCurrentContext()
                            context!.rotate (by: 90 * .pi / 180)
                            let pngImage = UIGraphicsGetImageFromCurrentImageContext()!
                            UIGraphicsEndImageContext()
                            
                            let data = pngImage.pngData()! as NSData
                            
                            //let data = uiImage.pngData()! as NSData
                            
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
                            
                            finalDisplayImage=UIImage(cgImage: downsampledImage)
                            print("standard landscape ended",finalDisplayImage!.size)
                        }
                        else{
                            
                            UIGraphicsBeginImageContext(uiImage.size)
                            uiImage.draw(in: CGRect(origin: CGPoint.zero, size: uiImage.size))
                            let context = UIGraphicsGetCurrentContext()
                            context!.rotate (by: 90 * .pi / 180)
                            let pngImage = UIGraphicsGetImageFromCurrentImageContext()!
                            UIGraphicsEndImageContext()
                             finalDisplayImage=pngImage
                            
                        }
                        
                        print("original landscape ended")
                        DispatchQueue.main.async(execute: {
                            self.parent.pageSettings.applyReadPhoto(uiImage:finalDisplayImage!)


                        })
                    }

                }
            }
  

            
        }
    }
}
