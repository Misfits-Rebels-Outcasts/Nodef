//
//  Copyright © 2022 James Boo. All rights reserved.
//


import SwiftUI

@available(iOS 15.0, *)
struct PresetsViewX: View {
    @EnvironmentObject var appSettings: AppSettings
    @EnvironmentObject var optionSettings: OptionSettings
    @EnvironmentObject var pageSettings: PageSettings
    //@EnvironmentObject var dataSettings: DataSettings
    //@EnvironmentObject var shapes: ShapesX
    
    var body: some View {
        Form{
            Group{


                
                
                Section(header: Text("Gradient Blend"), footer: Text("Blend different gradient colors with the image.")){
                    VStack (alignment: .leading)
                    {
                        PresetsRowViewX(presetType: "Gradient Blend")
                            .environmentObject(appSettings)
                            .environmentObject(pageSettings)
                    }
                }
                
                Section(header: Text("Stylize"), footer: Text("Style image with Edges, Crystals, Pixels, Hexagons, Hatched, and more.")){
                    VStack (alignment: .leading)
                    {
                        PresetsRowViewX(presetType: "Stylize")
                            .environmentObject(appSettings)
                            .environmentObject(pageSettings)
                    }
                }

                Section(header: Text("Geometry Blend"), footer: Text("Depending on the size of your image, the position of some of the geometry shapes may appear different.")){
                    VStack (alignment: .leading)
                    {
                        PresetsRowViewX(presetType: "Geometry Blend")
                            .environmentObject(appSettings)
                            .environmentObject(pageSettings)
                    }
                }
                
                Section(header: Text("Distortion"), footer: Text("Distort with Twirl, Pinch, Bump, Light Tunnel, and more.")){
                    VStack (alignment: .leading)
                    {
                        PresetsRowViewX(presetType: "Distortion")
                            .environmentObject(appSettings)
                            .environmentObject(pageSettings)
                    }
                }
                Section(header: Text("Transition"), footer: Text("Transit from a source image to a target image with different types of effects.")){
                    VStack (alignment: .leading)
                    {
                        PresetsRowViewX(presetType: "Transition")
                            .environmentObject(appSettings)
                            .environmentObject(pageSettings)
                    }
                }
                
                Section(header: Text("Colors"), footer: Text("Some colors may appear different after the blend.")){
                    VStack (alignment: .leading)
                    {
                        PresetsRowViewX(presetType: "Color Blend")
                            .environmentObject(appSettings)
                            .environmentObject(pageSettings)
                    }
                }
                
                Section(header: Text("Adjust Colors"), footer: Text("Adjust color temperature, tint, clamp colors, or remove colors.")){
                    VStack (alignment: .leading)
                    {
                        PresetsRowViewX(presetType: "ColorAdjust")
                            .environmentObject(appSettings)
                            .environmentObject(pageSettings)
                    }
                }
                
   
                
            }
            

            
   
            /*
            Section(header: Text("Color Blend"), footer: Text("Some colors may appear different after the blend.")){
                VStack (alignment: .leading)
                {
                    PresetsRowViewX(presetType: "Blend")
                        .environmentObject(appSettings)
                        .environmentObject(pageSettings)
                }
            }
            */
            
            

            Section(header: Text("Photo Effects"), footer: Text("Color Effects such as Chrome, Transfer, Process, Fade, and more")){
                VStack (alignment: .leading)
                {
                    PresetsRowViewX(presetType: "Photo Effects")
                        .environmentObject(appSettings)
                        .environmentObject(pageSettings)
                }
            }
            
            Section(header: Text("Blur"), footer: Text("Different types of Blur Gaussian Blur, Motion Blur, Disc Blur, and more.")){
                VStack (alignment: .leading)
                {
                    PresetsRowViewX(presetType: "Blur")
                        .environmentObject(appSettings)
                        .environmentObject(pageSettings)
                }
            }
            
            Section(header: Text("Tiling"), footer: Text("Tile the image in different ways. Depending on the size of your image, the tiling effect may appear different.")){
                VStack (alignment: .leading)
                {
                    PresetsRowViewX(presetType: "Tiling")
                        .environmentObject(appSettings)
                        .environmentObject(pageSettings)
                }
            }
            
            Section(header: Text("Mask"), footer: Text("Blend with a mask, a Histogram or a different image.")){
                VStack (alignment: .leading)
                {
                    PresetsRowViewX(presetType: "Mask")
                        .environmentObject(appSettings)
                        .environmentObject(pageSettings)
                }
            }
            
            Section(header: Text("Extract or Transform"), footer: Text("Crop an image, get color information, get Histogram or apply transformation.")){
                VStack (alignment: .leading)
                {
                    PresetsRowViewX(presetType: "ExtractTransform")
                        .environmentObject(appSettings)
                        .environmentObject(pageSettings)
                }
            }
            
            Section(header: Text("Original"), footer: Text("Tap on a Preset above to apply filters to the image. You can further customize the filters in the Filter Node Editor (f).")){
                VStack (alignment: .leading)
                {
                    PresetsRowViewX(presetType: "Original")
                        .environmentObject(appSettings)
                        .environmentObject(pageSettings)
                }
            }

            Section(header: Text(""), footer: Text("")){
            }
        }
        .navigationTitle("Presets")
        .navigationBarTitleDisplayMode(.inline)
        .toolbar {
            
            ToolbarItem(placement: .navigationBarLeading) {
                    Button("Cancel") {
                        //shapes.shapeList.forEach
                        //{
                        //        $0.isSelected = false
                        //}
                        
                        print("Page Properties Off")
                        pageSettings.resetViewer()
                        optionSettings.showPropertiesView=0
                        optionSettings.showPagePropertiesView=0
                        optionSettings.pagePropertiesHeight=95
                        appSettings.zoomFactor = appSettings.zoomFactor * 1.0/0.999
                    }
            }
            
            ToolbarItem(placement: .navigationBarTrailing) {
                    Button("Edit") {
                        optionSettings.showPagePropertiesView=1
                        optionSettings.pagePropertiesHeight = UIScreen.main.bounds.height >= 1024 ? UIScreen.main.bounds.height*0.46 : 400
                        optionSettings.selectedItem="Add"
                        optionSettings.objectWillChange.send()
                        
                    }
            }
            /*
            ToolbarItem(placement: .cancellationAction) {
                    Button("Cancel") {
                        optionSettings.showPropertiesView=0 //set back to 0
                    }
            }
             */
            /*
            Button("Done") {
                optionSettings.showPropertiesView=0 //set back to 0
            }*/
        }
    }
    
    func initAll()
    {

    }
}
