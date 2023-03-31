//
//  Copyright © 2022 James Boo. All rights reserved.
//


import Foundation
import PhotosUI
import SwiftUI

@available(iOS 15.0, *)
struct PhotoPHImagePicker: UIViewControllerRepresentable {
    var didFinishPicking: (_ didSelectItems: Bool,_ image: UIImage?) -> Void
    /*
    @EnvironmentObject var shapes: ShapesX
    @EnvironmentObject var appSettings: AppSettings
    @EnvironmentObject var optionSettings: OptionSettings
    @EnvironmentObject var pageSettings: PageSettings
    @EnvironmentObject var store: Store
     */
    //@Binding var image: UIImage?

    func makeUIViewController(context: Context) -> PHPickerViewController {
        var config = PHPickerConfiguration()
        config.filter = .images
           
        /*
        //https://developer.apple.com/forums/thread/672363
        var config = PHPickerConfiguration(photoLibrary: PHPhotoLibrary.shared())
        config.filter = .images
         
         not required for loadFileRepresentation to work
        */
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
     
                //existing code keep for backward compatibility
                if provider.canLoadObject(ofClass: UIImage.self) {
                    
                    provider.loadObject(ofClass: UIImage.self) { [self] image, _ in
                        
                        //handleImage(image: image as? UIImage)
                        self.parent.didFinishPicking(true, image as? UIImage)
                    }
                }
            else { //added to support RAW
                provider.loadFileRepresentation(forTypeIdentifier: "public.image") { url, _ in
                    print("load file representation : processing DNG")
                    guard let url = url
                    else {
                        return
                    }
                    let rawFilter = CIRAWFilter(imageURL: url)
                    let rawImg = rawFilter!.outputImage!
                    let context:CIContext? = CIContext()
                    if let cgImg = context!.createCGImage(rawImg, from: rawImg.extent) {
                        let image = UIImage(cgImage: cgImg)
                        self.parent.didFinishPicking(true, image)
                    }                    
                }
            }
            
           
        }
    }
}
