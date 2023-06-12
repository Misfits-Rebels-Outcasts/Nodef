//
//  Copyright © 2022 James Boo. All rights reserved.
//


import SwiftUI

@available(iOS 15.0, *)
struct PhotoMainSheetViewX: View {
    @EnvironmentObject var optionSettings: OptionSettings
    @EnvironmentObject var appSettings: AppSettings
    @EnvironmentObject var pageSettings: PageSettings

    var body: some View {
 
        if optionSettings.action == "SelectPhoto" {

            PhotoPHImagePicker(didFinishPicking: {didSelectItems, image in
           
                handleImage(image: image)
                
            })


        }
        else if optionSettings.action == "Settings"
        {
            SettingsViewX()
                .environmentObject(appSettings)
                .environmentObject(pageSettings)
                .environmentObject(optionSettings)

        }

    }
    
    func readjustPhoto(originalImage: UIImage, backgroundImage: UIImage)
    {
        if optionSettings.action == "ReadPhoto" {
            DispatchQueue.main.async(execute: {
                pageSettings.applyReadPhoto(uiImage:backgroundImage)
            })
        }
        else {
            DispatchQueue.main.async(execute: {
                pageSettings.storeOriginalAndApplyPhoto(originalImage:originalImage,backgroundImage:backgroundImage, dpi:appSettings.dpi)
                
                appSettings.resetZoom(pageSettings.labelWidth, pageSettings.labelHeight)
                pageSettings.filters.reAdjustProperties()
                pageSettings.applyFilters()
            })
        }
    }
    
    
    func handleImage(image : UIImage?)
    {

        //if include down as below
        //if image!.imageOrientation == UIImage.Orientation.down
        //the photo will be shown as upside down
        //somehow the funny thing is the following code works when it is down
        //the rotate will somehow ignore it??
        //further when it is left it will also work in the roate code below
        if image!.imageOrientation == UIImage.Orientation.up
            
            {
            print("portrait")
            var finalDisplayImage: UIImage?

            if appSettings.mode=="Shader"
            {
                finalDisplayImage=ImageUtil.downsample(uiImage: image!, scale: UIScreen.main.scale / appSettings.shaderDownScale)
            }
            else
            {
                if appSettings.imageRes=="Standard Resolution"
                {
                    finalDisplayImage=ImageUtil.downsample(uiImage: image!, scale: UIScreen.main.scale)
                }
                else {
                    finalDisplayImage=image!
                }
            }

            //readjustPhoto(uiImage: finalDisplayImage!)
            readjustPhoto(originalImage: image!,backgroundImage: finalDisplayImage!)
           }
        else{
            print("landscape")
            var finalDisplayImage: UIImage?
            
            UIGraphicsBeginImageContext(image!.size)
            image!.draw(in: CGRect(origin: CGPoint.zero, size: image!.size))
            let context = UIGraphicsGetCurrentContext()
            context!.rotate (by: 90 * .pi / 180)
            let pngImage = UIGraphicsGetImageFromCurrentImageContext()!
            UIGraphicsEndImageContext()

            if appSettings.mode=="Shader"
            {
                finalDisplayImage=ImageUtil.downsample(uiImage: pngImage, scale: UIScreen.main.scale / appSettings.shaderDownScale)
            }
            else
            {
                if appSettings.imageRes=="Standard Resolution"
                {
                    finalDisplayImage=ImageUtil.downsample(uiImage: pngImage, scale: UIScreen.main.scale)
                }
                else{
                    finalDisplayImage=pngImage
                }
            }
            readjustPhoto(originalImage: image!,backgroundImage: finalDisplayImage!)
            //readjustPhoto(uiImage: finalDisplayImage!)
        }
         
    }
}
