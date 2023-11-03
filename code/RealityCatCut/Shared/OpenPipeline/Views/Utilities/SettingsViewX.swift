//
//  Copyright © 2022 James Boo. All rights reserved.
//


import SwiftUI

@available(iOS 15.0, *)
//ANCHISES deprecated
struct SettingsViewX: View {
    @Environment(\.verticalSizeClass) var verticalSizeClass: UserInterfaceSizeClass?
    @Environment(\.horizontalSizeClass) var horizontalSizeClass: UserInterfaceSizeClass?
  

    @EnvironmentObject var appSettings: AppSettings
    @EnvironmentObject var pageSettings: PageSettings
    @EnvironmentObject var optionSettings: OptionSettings

    //var resUnits = ["Low Resolution","Standard Resolution","High Resolution"]
    var resUnits = ["Standard Resolution","High Resolution"]
    /*
    var hStr="When set to High Resolution, the imported image will not be downsampled. Filter properties will not be applied real-time to prevent overusage of resources. The High Resolution mode is only available in the Subscribed version."
     */
    var hStr="When set to High Resolution, the imported image will not be downsampled. Filter properties will not be applied real-time to prevent overusage of resources."
    var sStr="When set to Standard Resolution, the imported image will be downsampled and optimized for display on your device. All Filter Properties will be applied real-time."
    var lStr="When set to Low Resolution, the imported image will be downsampled for speed on your device. All Filter Properties will be applied real-time."

    //ANCHISES
    var modeTypes = ["Video","Shader","Image"]
    
    var body: some View {
        
        NavigationStack {
            
            Form {

                Section(header: Text("Mode"), footer: Text("Shader Mode enables shader effects to be added to your photo.")){
                    Picker("Mode", selection: $appSettings.mode) {
                        ForEach(modeTypes, id: \.self) {
                            Text($0)
                        }
                    }
                    .onChange(of: appSettings.mode) { oldValue, newValue in
                        let defaults = UserDefaults.standard
                        print("Setting:",appSettings.mode)
                        defaults.set(appSettings.mode, forKey: "mode")
                        resizeImageBasedonModeAndResolution()
                        //Fix the issue of if in high res switch to shader then it din update immateidalte.
                        if appSettings.mode == "Shader"
                        {
                            appSettings.imageRes = "Standard Resolution"
                        }
                        
                    }.pickerStyle(.segmented)
                }
                
                if appSettings.mode == "Shader"
                {
                    Section(header: Text("Shader Effects Duration in Seconds")){
                        
                        HStack{
                            Text("Duration")
                            Spacer()
                            Text(String(format: "%.2f", appSettings.videoDuration))
                        }
                        
                        Slider(value: $appSettings.videoDuration, in: 5.0...10.0, step: 1)
                         
                    }
                    
                    Section(header: Text("Video Frames per Second (FPS)"), footer: Text("This option only affects the generated Video.")){
                        
                        HStack{
                            Text("FPS")
                            Spacer()
                            Text(String(format: "%.2f", appSettings.videoFPS))
                        }
                        
                        Slider(value: $appSettings.videoFPS, in: 5.0...25.0, step: 1)
                         
                    }
                }
                
                if appSettings.mode == "Image"
                {
                    Section(header: Text("Image Quality"), footer: Text(resolutionHelp(imageRes:appSettings.imageRes))){
                        Picker("Resolution", selection: $appSettings.imageRes) {
                            ForEach(resUnits, id: \.self) {
                                Text($0)
                            }
                        }
                        .onChange(of: appSettings.imageRes) { oldValue, newValue in
                            let defaults = UserDefaults.standard
                            print("Setting:",appSettings.imageRes)
                            defaults.set(appSettings.imageRes, forKey: "resolution")
                            resizeImageBasedonModeAndResolution()
                        }.pickerStyle(.segmented)
                    }
                }
            }
            .navigationTitle("Settings")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                /*
                ToolbarItem(placement: .cancellationAction) {
                        Button("Cancel") {
                            optionSettings.showPropertiesView=0
                            optionSettings.showPropertiesSheet=false
                        }
                }
                 */
                
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button("Done") {
                        optionSettings.showPropertiesView=0
                        optionSettings.showPropertiesSheet=false
                    }
                }
                
            }
        }
    }
    
    func resizeImageBasedonModeAndResolution()
    {
        let image = pageSettings.originalBackgroundImage
        let finalDisplayImage = ImageUtil.downSizeImage(mode: appSettings.mode, imageRes: appSettings.imageRes, shaderDownScale: appSettings.shaderDownScale, image: image)
        DispatchQueue.main.async(execute: {
            pageSettings.applyPhoto(uiImage: finalDisplayImage!, dpi:appSettings.dpi)
            
            appSettings.resetZoom(pageSettings.labelWidth, pageSettings.labelHeight)
            pageSettings.filters.reAdjustProperties()
            pageSettings.applyFilters()
        })
        
    }
    /*
    func resizeImageBasedonModeAndResolutionY()
    {
        let image = pageSettings.originalBackgroundImage
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

            DispatchQueue.main.async(execute: {
                pageSettings.applyPhoto(uiImage: finalDisplayImage!, dpi:appSettings.dpi)
                
                appSettings.resetZoom(pageSettings.labelWidth, pageSettings.labelHeight)
                pageSettings.filters.reAdjustProperties()
                pageSettings.applyFilters()
            })
       }
       else
       {
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
        DispatchQueue.main.async(execute: {
            pageSettings.applyPhoto(uiImage: finalDisplayImage!, dpi:appSettings.dpi)
            
            appSettings.resetZoom(pageSettings.labelWidth, pageSettings.labelHeight)
            pageSettings.filters.reAdjustProperties()
            pageSettings.applyFilters()
        })
      }
         
    }
    */
    
    //self.resolutionHelp(imageRes: appSettings.imageRes)
    func resolutionHelp(imageRes: String)->String
    {
        if imageRes == "Low Resolution"
        {
            return lStr
        }
        else if imageRes == "Standard Resolution"
        {
            return sStr
        }
        else if imageRes == "High Resolution"
        {
            return hStr
        }
        return lStr
    }
    
    func setupViewModel()
    {
    }
}

