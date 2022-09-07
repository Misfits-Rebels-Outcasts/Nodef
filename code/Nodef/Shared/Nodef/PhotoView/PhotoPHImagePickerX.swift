//
//  Copyright © 2022 James Boo. All rights reserved.
//


import Foundation
import PhotosUI
import SwiftUI

@available(iOS 15.0, *)
struct PhotoPHImagePicker: UIViewControllerRepresentable {
    var didFinishPicking: (_ didSelectItems: Bool) -> Void
    
  
    @EnvironmentObject var appSettings: AppSettings
    @EnvironmentObject var optionSettings: OptionSettings
    @EnvironmentObject var pageSettings: PageSettings
    //@EnvironmentObject var store: Store
    //@Binding var image: UIImage?

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
        let parent: PhotoPHImagePicker

        init(_ parent: PhotoPHImagePicker) {
            self.parent = parent
        }

        func picker(_ picker: PHPickerViewController, didFinishPicking results: [PHPickerResult]) {
            picker.dismiss(animated: true)

            guard let provider = results.first?.itemProvider else { return }
            let bounds = UIScreen.main.bounds
            let scale = UIScreen.main.scale
            
            if provider.canLoadObject(ofClass: UIImage.self) {
                provider.loadObject(ofClass: UIImage.self) { image, _ in
                    //self.parent.image = image as? UIImage
                    
                    if (image as? UIImage)!.imageOrientation == UIImage.Orientation.up {
                        print("original portrait")
                        var uiImage = (image as? UIImage)!
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
                            self.parent.pageSettings.applyPhoto(uiImage:finalDisplayImage!, dpi:self.parent.appSettings.dpi)
                            
                            let hRatio=UIScreen.main.bounds.size.height/(self.parent.pageSettings.labelHeight*self.parent.appSettings.dpi)
                            let wRatio=UIScreen.main.bounds.size.width/(self.parent.pageSettings.labelWidth*self.parent.appSettings.dpi)
                            var smallRatio = hRatio > wRatio ? wRatio*0.8 : hRatio*0.8
                            smallRatio = smallRatio < 0.05 ? 0.05 : smallRatio
                            smallRatio = smallRatio > 1 ? 1 : smallRatio
                            print("apply photo zoom ratio",smallRatio)
                            self.parent.appSettings.zoomFactor=smallRatio
                                                        
                            self.parent.pageSettings.filters.reAdjustProperties()
                            self.parent.pageSettings.applyFilters()
                            self.parent.didFinishPicking(true)
                        })
                        
                       }
                    else{
                        print("original landscape")
                        var uiImage = (image as? UIImage)!
                        

                        
                        var finalDisplayImage: UIImage?
                        if //self.parent.store.purchasedSubscriptions.count <= 0 ||
                            self.parent.appSettings.imageRes == "Standard Resolution"
                        {
                            UIGraphicsBeginImageContext(uiImage.size)
                            uiImage.draw(in: CGRect(origin: CGPoint.zero, size: uiImage.size))
                            var context = UIGraphicsGetCurrentContext()
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
                            /*
                            UIGraphicsBeginImageContext(finalDisplayImage!.size)
                            finalDisplayImage!.draw(in: CGRect(origin: CGPoint.zero, size: finalDisplayImage!.size))
                            let pngImage = UIGraphicsGetImageFromCurrentImageContext()!
                            UIGraphicsEndImageContext()
                            */
                            /*
                            UIGraphicsBeginImageContext(finalDisplayImage!.size)
                            finalDisplayImage!.draw(in: CGRect(origin: CGPoint.zero, size: finalDisplayImage!.size))
                            var context = UIGraphicsGetCurrentContext()
                            context!.rotate (by: 90 * .pi / 180)
                            let pngImage = UIGraphicsGetImageFromCurrentImageContext()!
                            UIGraphicsEndImageContext()
                             */
                            
                            //finalDisplayImage=pngImage
                             
                            print("standard landscape ended",finalDisplayImage!.size)
                        }
                        else{
                            
                            UIGraphicsBeginImageContext(uiImage.size)
                            uiImage.draw(in: CGRect(origin: CGPoint.zero, size: uiImage.size))
                            var context = UIGraphicsGetCurrentContext()
                            context!.rotate (by: 90 * .pi / 180)
                            let pngImage = UIGraphicsGetImageFromCurrentImageContext()!
                            UIGraphicsEndImageContext()
                             finalDisplayImage=pngImage
                            
                        }
                        
                        print("original landscape ended")
                        DispatchQueue.main.async(execute: {
                            self.parent.pageSettings.applyPhoto(uiImage: finalDisplayImage!, dpi:self.parent.appSettings.dpi)
                            
                            let hRatio=UIScreen.main.bounds.size.height/(self.parent.pageSettings.labelHeight*self.parent.appSettings.dpi)
                            let wRatio=UIScreen.main.bounds.size.width/(self.parent.pageSettings.labelWidth*self.parent.appSettings.dpi)
                            var smallRatio = hRatio > wRatio ? wRatio*0.8 : hRatio*0.8
                            smallRatio = smallRatio < 0.05 ? 0.05 : smallRatio
                            smallRatio = smallRatio > 1 ? 1 : smallRatio
                            print("apply photo zoom ratio",smallRatio)
                            self.parent.appSettings.zoomFactor=smallRatio
                            
                            self.parent.pageSettings.filters.reAdjustProperties()
                            self.parent.pageSettings.applyFilters()

                            self.parent.didFinishPicking(true)

                        })
                    }
                    /*
                    let imgName = "currentImage"//imgUrl.lastPathComponent
                    let documentDirectory = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true).first
                    let localPath = documentDirectory?.appending(imgName)
                    let data = (image as? UIImage)!.pngData()! as NSData
                    data.write(toFile: localPath!, atomically: true)
                    
                    let photoURL = URL.init(fileURLWithPath: localPath!)
                    //let downsampledImage = ImageUtil.downsample(imageAt: photoURL, to: bounds.size)!
                    DispatchQueue.main.async(execute: {
                        //if let data = try? Data(contentsOf: photoURL) {
                        let uiImage = UIImage(data: data as Data)!
                            print("yesy")
                            var pngImage=uiImage.toPNG()!
                            if uiImage.imageOrientation == UIImage.Orientation.up {
                                  print("portrait")
                               }
                            else{
                                print("landscape")
                                UIGraphicsBeginImageContext(uiImage.size)
                                uiImage.draw(in: CGRect(origin: CGPoint.zero, size: uiImage.size))
                                pngImage = UIGraphicsGetImageFromCurrentImageContext()!
                                UIGraphicsEndImageContext()
                            }

                            
                            self.parent.pageSettings.applyPhoto(uiImage: pngImage, dpi:self.parent.appSettings.dpi)
                        //}
                        
                        //self.parent.pageSettings.applyPhoto(uiImage: (image as? UIImage)!,dpi: self.parent.appSettings.dpi)
                    })
                     */
                }
            }
  
            /*
            let bounds = UIScreen.main.bounds
            let scale = UIScreen.main.scale

            for item in results {
                item.itemProvider.loadObject(ofClass: UIImage.self) {(image, error) in
                    // This will give you the file name
                    guard let fileName = item.itemProvider.suggestedName else { return }
                    print(fileName)
                    var sourceURL: URL?
                    
                    item.itemProvider.loadFileRepresentation(forTypeIdentifier: "public.item") { [self] (url, error) in
                                    if error != nil {
                                       print("error \(error!)");
                                    } else {
                                        print("inside",url)
                                        sourceURL = url
                                        DispatchQueue.main.async(execute: {
                                            guard let imageSource = CGImageSourceCreateWithURL(sourceURL! as CFURL, nil)
                                                , let imageProperties = CGImageSourceCopyPropertiesAtIndex(imageSource, 0, nil) as? [AnyHashable: Any]
                                            else{
                                                    return
                                            }
                                            var orientation: Int = 0
                                            let orientationNumber = imageProperties[kCGImagePropertyOrientation as String]
                                            print("orientationNumber",orientationNumber)
                                            
                                            if let orN = orientationNumber
                                            {
                                                CFNumberGetValue(orientationNumber as! CFNumber, .intType, &orientation)
                                                //if orientation > 4 { let temp = width; width = height; height = temp }
                                                if orientation > 4 {
                                                    print("flipping",orientation)
                                                }
                                                else{
                                                    print("no flipping",orientation)
                                                }
                                            }
                                            
                                            let documentDirectory = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true).first
                                            let localPath = documentDirectory?.appending(url!.lastPathComponent)
                                            let newUrl = URL.init(fileURLWithPath: localPath!)
                                            //let newUrl = URL(fileURLWithPath: NSTemporaryDirectory() + fileName)
                                            try? FileManager.default.copyItem(at: sourceURL!, to: newUrl)
                                            print("new",newUrl)
                                            //try? FileManager.default.copyItem(at: sourceURL!, to: newUrl)
                                            self.parent.pageSettings.backgroundURL=newUrl
                                            self.parent.didFinishPicking(!results.isEmpty)
                                            /*
                                            let downsampledImage = ImageUtil.downsample(imageAt: newUrl, to: bounds.size, scale: scale)!
                                             */
                                            /*
                                            let downsampledImage = ImageUtil.downsample(imageAt: sourceURL!, to: bounds.size, scale: scale)!
                                            self.parent.pageSettings.applyPhoto(uiImage: downsampledImage, dpi:self.parent.appSettings.dpi)
                                             */
                                            

                                        })
                                        //if let url = url {
                                        //    print(url)
                                            /*
                                            let filename = url.lastPathComponent;
                                            print(filename)
                                            let downsampledImage = ImageUtil.downsample(imageAt: url, to: UIScreen.main.bounds.size)!
                                            parent.pageSettings.applyPhoto(uiImage: downsampledImage, dpi:parent.appSettings.dpi)
                                             */
                                            /*
                                            let documentDirectory = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true).first
                                            let localPath = documentDirectory?.appending(imgName)
                                            try? FileManager.default.copyItem(at: url, to: newUrl)
                                            */
                                        //}
                                    }
                                }
             
                    

                    
                    print("final")
                    /*
                    let photoURL = URL.init(fileURLWithPath: fileName)
                    let downsampledImage = ImageUtil.downsample(imageAt: photoURL, to: UIScreen.main.bounds.size)!
                    */
                    //if let image = image as? UIImage{
           
                    //}
                }
            }
*/
            
        }
    }
}
