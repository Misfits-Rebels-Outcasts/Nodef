//
//  Copyright © 2022 James Boo. All rights reserved.
//

import SwiftUI

@available(iOS 15.0, *)
struct PipelineMainSheetViewX: View {
    @EnvironmentObject var optionSettings: OptionSettings
    @EnvironmentObject var appSettings: AppSettings
    @EnvironmentObject var pageSettings: PageSettings

    
    var body: some View {
 
        //ANCHISES deprecated
        if optionSettings.action == "SelectPhoto" {

            PhotoPHImagePicker(didFinishPicking: {didSelectItems, image in
           
                handleImage(image: image)
                
            })

        }
        //ANCHISES deprecated
        else if optionSettings.action == "ReadPhoto" {

            PhotoPHImagePicker(didFinishPicking: {didSelectItems, image in
                handleImage(image: image)
            })
   
        }
        //ANCHISES deprecated
        else if optionSettings.action == "NodefHelpViewer"
        {
            HelpViewerViewX()
                .environmentObject(optionSettings)
        }
        else if optionSettings.action == "NodefHelpPipeline"
        {
            HelpPipelineViewX()
                .environmentObject(optionSettings)
        }
        else if optionSettings.action == "NodefHelp"
        {
            HelpViewX()
                .environmentObject(optionSettings)
        }
        //ANCHISES to be updated for future save and load
        else if optionSettings.action == "NewLabel"
        {
        
        PhotoPHImagePicker(didFinishPicking: {didSelectItems, image in
            
            handleImage(image: image)

            let size=CGSize(width: pageSettings.filters.size.width, height:pageSettings.filters.size.height)
            let boundsCenter=CIVector(x:size.width/2.0,y:size.height/2.0)
            
            pageSettings.filters=FiltersX()
            pageSettings.filters.size=size
            pageSettings.filters.boundsCenter=boundsCenter
            
            _ = pageSettings.filters.add("Color Controls")
            
            pageSettings.filters.reassignAllBounds()
            pageSettings.applyFilters()
        })

        }
        
        else if optionSettings.action == "OpenLabel"
        {

            DocumentsViewX(documentsViewModel: DocumentsViewModel())
                .environmentObject(appSettings)
                .environmentObject(optionSettings)
                .environmentObject(pageSettings)
                //.environmentObject(dataSettings)
                //.environmentObject(shapes)
             
        }
        else if optionSettings.action == "Presets"
        {
            //OptimizeCode
            PresetsViewX()
                .environmentObject(pageSettings)
                .environmentObject(appSettings)
                .environmentObject(optionSettings)
                .presentationDetents([.medium, .large])
                .presentationContentInteraction(.scrolls)
                //.presentationDetents([.fraction(0.5)])
                //.presentationBackgroundInteraction(.enabled(upThrough: .fraction(0.5)))
            
        }
        else if optionSettings.action == "Filters"
        {
            //OptimizeCode
            //with Navigation View inside FiltersViewX will work well on iPhone but iPad and Mac will be blocked
            //so existing code kept for the moment
            
            FiltersViewX(filtersPropertiesViewModel: BackgroundFiltersPropertiesViewModel(pageSettings: pageSettings))
                           .environmentObject(appSettings)
                           .environmentObject(optionSettings)
                           .environmentObject(pageSettings)
                           .presentationDetents([.medium, .large])
                           .presentationContentInteraction(.scrolls)
//                           .presentationDetents([.fraction(0.5)])
//                           .presentationBackgroundInteraction(.enabled(upThrough: .fraction(0.5)))
             
            /*
                           .interactiveDismissDisabled(true)
                                          .presentationDetents([.fraction(0.4), .large])
                                          .presentationDragIndicator(.visible)
             */
            
        }
        else if optionSettings.action == "Settings"
        {

            SettingsViewX()
                .environmentObject(appSettings)
                .environmentObject(pageSettings)
                .environmentObject(optionSettings)
             
        }
        //deprecated
        else if optionSettings.action == "NewImage" || optionSettings.action == "EditImage" {

            PhotoPHImagePicker(didFinishPicking: {didSelectItems, image in
                handleCaptionImage(image: image)
            })
            
        }
    }
    
    //ANCHISES-deprecated
    func readjustPhoto(originalImage: UIImage, backgroundImage: UIImage)
    {
        if optionSettings.action == "ReadPhoto" {
            DispatchQueue.main.async(execute: {
                
                //ANCHISES
                pageSettings.applyReadPhoto(uiImage:backgroundImage)
                
                pageSettings.backgroundImage=backgroundImage
                pageSettings.filteredBackgroundImage=pageSettings.backgroundImage
                pageSettings.readFX!.setupProperties(pageSettings.filters)
                //Phoebus comeback
                pageSettings.setCanvas(image: pageSettings.backgroundImage!, dpi: 1000)
                pageSettings.filters.initNodeIndex()
                appSettings.resetZoom(pageSettings.labelWidth, pageSettings.labelHeight)
                pageSettings.applyFilters()
               
                
                //takeoutmiximagesize
                /*
                pageSettings.applyPhoto(uiImage:backgroundImage, dpi:appSettings.dpi)
                appSettings.resetZoom(pageSettings.labelWidth, pageSettings.labelHeight)
                //pageSettings.filters.reAdjustProperties()
                pageSettings.applyFilters()
                 */
            })
        }//deprecated?ANCHISES
        else {
            DispatchQueue.main.async(execute: {
                pageSettings.storeOriginalAndApplyPhoto(originalImage:originalImage,backgroundImage:backgroundImage, dpi:appSettings.dpi)
                
                appSettings.resetZoom(pageSettings.labelWidth, pageSettings.labelHeight)
                pageSettings.filters.reAdjustProperties()
                pageSettings.applyFilters()
            })
        }
    }
    //deprecated-ANCHISES
    func handleCaptionImage(image : UIImage?)
    {
        /*
        var finalDisplayImage: UIImage?
        
        if image!.imageOrientation == UIImage.Orientation.up {
            print("portrait")
            finalDisplayImage=image!
           }
        else{
            print("landscape")
            
            UIGraphicsBeginImageContext(image!.size)
            image!.draw(in: CGRect(origin: CGPoint.zero, size: image!.size))
            let context = UIGraphicsGetCurrentContext()
            context!.rotate (by: 90 * .pi / 180)
            let pngImage = UIGraphicsGetImageFromCurrentImageContext()!
            UIGraphicsEndImageContext()
            finalDisplayImage=pngImage

        }
        */
        
    }
    
    func handleImage(image : UIImage?)
    {
        //ANCHISES
        //var finalDisplayImage = ImageUtil.downSizeImage(mode: appSettings.mode, imageRes: appSettings.imageRes, shaderDownScale: appSettings.shaderDownScale, image: image)
        let finalDisplayImage = ImageUtil.getImageWithOrientation(image: image)
        readjustPhoto(originalImage: image!,backgroundImage: finalDisplayImage!)
        
    }
    

    
}
