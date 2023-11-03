//
//  Copyright © 2022 James Boo. All rights reserved.
//

import SwiftUI
class PresetsXA: ObservableObject, Identifiable, Equatable{
    
    static func == (lhs: PresetsXA, rhs: PresetsXA) -> Bool {
        return lhs.id==rhs.id
    }
    @Published var presetsList = [FiltersX]()
    var id = UUID()
    
    init(presetType: String) {
        
        let defaultThumbSize = CGSize(width:500,height:655.5)
        //let compensateFactor:Float = 1.6
        let context = CIContext()
        //Small Sunflower
        //Tiling OTIM and TRTI
        //Large 4K Sunflower
        //Tiling ERTI and OTIM issue        
        if presetType == "Original"
        {
            /*
            var filters=FiltersX(context)
            filters.size=defaultThumbSize
            filters.boundsCenter=CIVector(x:filters.size.width/2.0,y:filters.size.height/2.0)
            var filterXHolder=filters.getFilterWithHolder("Color Controls")
            filters.setPresetName(name: "Original Image")
            filters.add(filterHolder: filterXHolder)
            presetsList.append(filters)
            filters.initNodeIndex()
            */
            let filters=FiltersX(context)
            let node=filters.add("Read Image")
            //node.readOnly=true
            //node.sticky=true
            node.size=defaultThumbSize
            
            filters.setPresetName(name: "Original Image")
            presetsList.append(filters)

        }
        else if presetType == "Shader Effects"
        {
            /*
            var filters=FiltersX(context)
            filters.size=defaultThumbSize
            filters.boundsCenter=CIVector(x:filters.size.width/2.0,y:filters.size.height/2.0)
            var filterXHolder=filters.getFilterWithHolder("Photo Effect Noir")
            filters.add(filterHolder: filterXHolder)
            filterXHolder=filters.getFilterWithHolder("Color Invert")
            filters.add(filterHolder: filterXHolder)
            filterXHolder=filters.getFilterWithHolder("Gaussian Blur")
            (filterXHolder.filter as! GaussianBlurFX).radius=14.88
            filters.add(filterHolder: filterXHolder)
            filterXHolder=filters.getFilterWithHolder("Gaussian Blur")
            filterXHolder.filter.inputImageAlias="1"
            (filterXHolder.filter as! GaussianBlurFX).radius=4.63
            filters.add(filterHolder: filterXHolder)
            filterXHolder=filters.getFilterWithHolder("Color Dodge Blend Mode")
            filterXHolder.filter.inputImageAlias="3"
            filterXHolder.filter.backgroundImageAlias="4"
            filters.add(filterHolder: filterXHolder)
            filterXHolder=filters.getFilterWithHolder("Fractal Flow Noise")
            filterXHolder.filter.inputImageAlias="0"
            filters.add(filterHolder: filterXHolder)
            filterXHolder=filters.getFilterWithHolder("Blend With Mask")
            filterXHolder.filter.inputImageAlias="0"
            filterXHolder.filter.backgroundImageAlias="6"
            (filterXHolder.filter as! BlendWithMaskFX).inputMaskImageAlias="5"
            filters.add(filterHolder: filterXHolder)
            filters.setPresetName(name: "Fractal Irrigate Repeat Expand")
            presetsList.append(filters)
            filters.initNodeIndex()

            filters=FiltersX(context)
            filters.size=defaultThumbSize
            filters.boundsCenter=CIVector(x:filters.size.width/2.0,y:filters.size.height/2.0)
            filterXHolder=filters.getFilterWithHolder("Color Controls")
            (filterXHolder.filter as! ColorControlsFX).contrast=2.5
            filters.add(filterHolder: filterXHolder)
            filterXHolder=filters.getFilterWithHolder("FBM Noise")
            filters.add(filterHolder: filterXHolder)
            filterXHolder=filters.getFilterWithHolder("Screen Blend Mode")
            filterXHolder.filter.inputImageAlias=""
            filterXHolder.filter.backgroundImageAlias="0"
            filters.add(filterHolder: filterXHolder)
            filters.setPresetName(name: "FBM Screen Blend Effects")
            presetsList.append(filters)
            filters.initNodeIndex()
            
            filters=FiltersX(context)
            filters.size=defaultThumbSize
            filters.boundsCenter=CIVector(x:filters.size.width/2.0,y:filters.size.height/2.0)
            filterXHolder=filters.getFilterWithHolder("Photo Effect Noir")
            filters.add(filterHolder: filterXHolder)
            filterXHolder=filters.getFilterWithHolder("Color Invert")
            filters.add(filterHolder: filterXHolder)
            filterXHolder=filters.getFilterWithHolder("Gaussian Blur")
            (filterXHolder.filter as! GaussianBlurFX).radius=14.88
            filters.add(filterHolder: filterXHolder)
            filterXHolder=filters.getFilterWithHolder("Gaussian Blur")
            filterXHolder.filter.inputImageAlias="1"
            (filterXHolder.filter as! GaussianBlurFX).radius=4.63
            filters.add(filterHolder: filterXHolder)
            filterXHolder=filters.getFilterWithHolder("Color Dodge Blend Mode")
            filterXHolder.filter.inputImageAlias="3"
            filterXHolder.filter.backgroundImageAlias="4"
            filters.add(filterHolder: filterXHolder)
            filterXHolder=filters.getFilterWithHolder("Fractal Flow Noise")
            filterXHolder.filter.inputImageAlias="0"
            filters.add(filterHolder: filterXHolder)
            filterXHolder=filters.getFilterWithHolder("Blend With Mask")
            filterXHolder.filter.inputImageAlias="0"
            filterXHolder.filter.backgroundImageAlias="6"
            (filterXHolder.filter as! BlendWithMaskFX).inputMaskImageAlias="5"
            filters.add(filterHolder: filterXHolder)
            filterXHolder=filters.getFilterWithHolder("Crystallize")
            filters.add(filterHolder: filterXHolder)
            filterXHolder=filters.getFilterWithHolder("Mix")
            filterXHolder.filter.inputImageAlias="8"
            filterXHolder.filter.backgroundImageAlias="0"
            (filterXHolder.filter as! MixFX).amount=0.3

            filters.add(filterHolder: filterXHolder)
            filters.setPresetName(name: "Fractal Lake Are King Eagle")
            presetsList.append(filters)
            filters.initNodeIndex()
            
            filters=FiltersX(context)
            filters.size=defaultThumbSize
            filters.boundsCenter=CIVector(x:filters.size.width/2.0,y:filters.size.height/2.0)
            filterXHolder=filters.getFilterWithHolder("Color Controls")
            (filterXHolder.filter as! ColorControlsFX).contrast=2.5
            filters.add(filterHolder: filterXHolder)
            filterXHolder=filters.getFilterWithHolder("FBM Noise")
            filters.add(filterHolder: filterXHolder)
            filterXHolder=filters.getFilterWithHolder("Luminosity Blend Mode")
            filterXHolder.filter.inputImageAlias=""
            filterXHolder.filter.backgroundImageAlias="0"
            filters.add(filterHolder: filterXHolder)
            filters.setPresetName(name: "FBM Luminosity Blend Effects")
            presetsList.append(filters)
            filters.initNodeIndex()
            
            filters=FiltersX(context)
            filters.size=defaultThumbSize
            filters.boundsCenter=CIVector(x:filters.size.width/2.0,y:filters.size.height/2.0)
            filterXHolder=filters.getFilterWithHolder("Glass Distortion")
            (filterXHolder.filter as! GlassDistortionFX).scale=235
            filters.add(filterHolder: filterXHolder)
            filterXHolder=filters.getFilterWithHolder("Color Monochrome")
            (filterXHolder.filter as! ColorMonochromeFX).colorx = Color.black
            (filterXHolder.filter as! ColorMonochromeFX).color = CIColor(color: UIColor((filterXHolder.filter as! ColorMonochromeFX).colorx))
            filters.add(filterHolder: filterXHolder)
            filterXHolder=filters.getFilterWithHolder("Fractal Flow Noise")
            filters.add(filterHolder: filterXHolder)
            filterXHolder=filters.getFilterWithHolder("Divide Blend Mode")
            filterXHolder.filter.inputImageAlias="3"
            filterXHolder.filter.backgroundImageAlias="2"
            filters.add(filterHolder: filterXHolder)
            filters.setPresetName(name: "Fractal Noise Glass Distortion")
            presetsList.append(filters)
            filters.initNodeIndex()
            
            filters=FiltersX(context)
            filters.size=defaultThumbSize
            filters.boundsCenter=CIVector(x:filters.size.width/2.0,y:filters.size.height/2.0)
            filterXHolder=filters.getFilterWithHolder("Glass Distortion")
            (filterXHolder.filter as! GlassDistortionFX).scale=235
            filters.add(filterHolder: filterXHolder)
            filterXHolder=filters.getFilterWithHolder("Color Monochrome")
            (filterXHolder.filter as! ColorMonochromeFX).colorx = Color.black
            (filterXHolder.filter as! ColorMonochromeFX).color = CIColor(color: UIColor((filterXHolder.filter as! ColorMonochromeFX).colorx))
            filters.add(filterHolder: filterXHolder)
            filterXHolder=filters.getFilterWithHolder("Fractal Flow Noise")
            filters.add(filterHolder: filterXHolder)
            filterXHolder=filters.getFilterWithHolder("Darken Blend Mode")
            filterXHolder.filter.inputImageAlias="3"
            filterXHolder.filter.backgroundImageAlias="2"
            filters.add(filterHolder: filterXHolder)
            filters.setPresetName(name: "Fractal Noise Darken Blend")
            presetsList.append(filters)
            filters.initNodeIndex()

  

            filters=FiltersX(context)
            filters.size=defaultThumbSize
            filters.boundsCenter=CIVector(x:filters.size.width/2.0,y:filters.size.height/2.0)
            filterXHolder=filters.getFilterWithHolder("Color Controls")
            (filterXHolder.filter as! ColorControlsFX).contrast=2.5
            filters.add(filterHolder: filterXHolder)
            filterXHolder=filters.getFilterWithHolder("Particles")
            filters.add(filterHolder: filterXHolder)
            filters.setPresetName(name: "Particles Effects")
            presetsList.append(filters)
            filters.initNodeIndex()
            
            filters=FiltersX(context)
            filters.size=defaultThumbSize
            filters.boundsCenter=CIVector(x:filters.size.width/2.0,y:filters.size.height/2.0)
            filterXHolder=filters.getFilterWithHolder("Fractal Flow Noise")
            filters.setPresetName(name: "Fractal Noise Effects")
            filters.add(filterHolder: filterXHolder)
            filterXHolder=filters.getFilterWithHolder("Minimum Compositing")
            filterXHolder.filter.inputImageAlias=""
            filterXHolder.filter.backgroundImageAlias="0"
            filters.add(filterHolder: filterXHolder)
            presetsList.append(filters)
            filters.initNodeIndex()
            
            
            filters=FiltersX(context)
            filters.size=defaultThumbSize
            filters.boundsCenter=CIVector(x:filters.size.width/2.0,y:filters.size.height/2.0)
            filterXHolder=filters.getFilterWithHolder("Color Controls")
            (filterXHolder.filter as! ColorControlsFX).contrast=2.5
            filters.add(filterHolder: filterXHolder)
            filterXHolder=filters.getFilterWithHolder("FBM Noise")
            filters.add(filterHolder: filterXHolder)

            filterXHolder=filters.getFilterWithHolder("Mix")
            filterXHolder.filter.inputImageAlias=""
            filterXHolder.filter.backgroundImageAlias="0"
            (filterXHolder.filter as! MixFX).amount=0.7
            filters.add(filterHolder: filterXHolder)
            filters.setPresetName(name: "FBM Noise Effects")
            presetsList.append(filters)
            filters.initNodeIndex()
            
            
            filters=FiltersX(context)
            filters.size=defaultThumbSize
            filters.boundsCenter=CIVector(x:filters.size.width/2.0,y:filters.size.height/2.0)
            filterXHolder=filters.getFilterWithHolder("Row Average")
            filters.add(filterHolder: filterXHolder)
            filterXHolder=filters.getFilterWithHolder("Swipe Transition")
            filterXHolder.filter.inputImageAlias=""
            (filterXHolder.filter as! SwipeTransitionFX).targetImageAlias="0"
            filters.add(filterHolder: filterXHolder)
            filterXHolder=filters.getFilterWithHolder("Fractal Flow Noise")
            filterXHolder.filter.inputImageAlias="0"
            filters.add(filterHolder: filterXHolder)
            filterXHolder=filters.getFilterWithHolder("Difference Blend Mode")
            filterXHolder.filter.inputImageAlias="3"
            filterXHolder.filter.backgroundImageAlias="2"
            filters.add(filterHolder: filterXHolder)
            filterXHolder=filters.getFilterWithHolder("Motion Blur")
            filters.add(filterHolder: filterXHolder)
            filterXHolder=filters.getFilterWithHolder("Mix")
            filterXHolder.filter.inputImageAlias="5"
            filterXHolder.filter.backgroundImageAlias="0"
            (filterXHolder.filter as! MixFX).amount=0.5
            filters.add(filterHolder: filterXHolder)
            filters.setPresetName(name: "Fractal Noise Swipe Motion")
            presetsList.append(filters)
            filters.initNodeIndex()
                        
            
            filters=FiltersX(context)
            filters.size=defaultThumbSize
            filters.boundsCenter=CIVector(x:filters.size.width/2.0,y:filters.size.height/2.0)
            filterXHolder=filters.getFilterWithHolder("Color Controls")
            (filterXHolder.filter as! ColorControlsFX).contrast=2.5
            filters.add(filterHolder: filterXHolder)
            filterXHolder=filters.getFilterWithHolder("FBM Noise")
            filters.add(filterHolder: filterXHolder)
            filterXHolder=filters.getFilterWithHolder("Saturation Blend Mode")
            filterXHolder.filter.inputImageAlias=""
            filterXHolder.filter.backgroundImageAlias="0"
            filters.add(filterHolder: filterXHolder)
            filterXHolder=filters.getFilterWithHolder("Particles")
            filters.add(filterHolder: filterXHolder)
            filters.setPresetName(name: "Saturation Blend Particles Effects")
            presetsList.append(filters)
            filters.initNodeIndex()
            
            filters=FiltersX(context)
            filters.size=defaultThumbSize
            filters.boundsCenter=CIVector(x:filters.size.width/2.0,y:filters.size.height/2.0)
            filterXHolder=filters.getFilterWithHolder("Color Controls")
            filters.add(filterHolder: filterXHolder)
            filterXHolder=filters.getFilterWithHolder("Pointillize")
            filters.add(filterHolder: filterXHolder)

            filterXHolder=filters.getFilterWithHolder("FBM Noise")
            filters.add(filterHolder: filterXHolder)

            filterXHolder=filters.getFilterWithHolder("Darken Blend Mode")
            filterXHolder.filter.inputImageAlias=""
            filterXHolder.filter.backgroundImageAlias="2"
            filters.add(filterHolder: filterXHolder)
            filterXHolder=filters.getFilterWithHolder("Difference Blend Mode")
            filterXHolder.filter.inputImageAlias=""
            filterXHolder.filter.backgroundImageAlias="0"
            filters.add(filterHolder: filterXHolder)

            filters.setPresetName(name: "Pointillize Fractal Darken Difference")
            presetsList.append(filters)
            filters.initNodeIndex()
            */
        }
        else if presetType == "Mask"
        {
            /*
            var filters=FiltersX(context)
            filters.size=defaultThumbSize
            filters.boundsCenter=CIVector(x:filters.size.width/2.0,y:filters.size.height/2.0)
            var filterXHolder=filters.getFilterWithHolder("Displacement Distortion")
            (filterXHolder.filter as! DisplacementDistortionFX).scale=135
            filters.add(filterHolder: filterXHolder)
            filterXHolder=filters.getFilterWithHolder("Color Controls")
            filters.add(filterHolder: filterXHolder)
            filters.setPresetName(name: "Displacement Distortion")
            presetsList.append(filters)
            filters.initNodeIndex()

            filters=FiltersX(context)
            filters.size=defaultThumbSize
            filters.boundsCenter=CIVector(x:filters.size.width/2.0,y:filters.size.height/2.0)
            filterXHolder=filters.getFilterWithHolder("Glass Distortion")
            (filterXHolder.filter as! GlassDistortionFX).scale=235
            filters.add(filterHolder: filterXHolder)
            filterXHolder=filters.getFilterWithHolder("Color Monochrome")
            (filterXHolder.filter as! ColorMonochromeFX).colorx = Color.black
            (filterXHolder.filter as! ColorMonochromeFX).color = CIColor(color: UIColor((filterXHolder.filter as! ColorMonochromeFX).colorx))
            filters.add(filterHolder: filterXHolder)
            filters.setPresetName(name: "Glass Distortion")
            presetsList.append(filters)
            filters.initNodeIndex()

            filters=FiltersX(context)
            filters.size=defaultThumbSize
            filters.boundsCenter=CIVector(x:filters.size.width/2.0,y:filters.size.height/2.0)
            filterXHolder=filters.getFilterWithHolder("Color Controls")
            filters.add(filterHolder: filterXHolder)
            filterXHolder=filters.getFilterWithHolder("Star Shine Generator")
            (filterXHolder.filter as! StarShineGeneratorFX).radius=30
            filters.add(filterHolder: filterXHolder)
            filterXHolder=filters.getFilterWithHolder("Masked Variable Blur")
            filterXHolder.filter.inputImageAlias="0"
            filterXHolder.filter.backgroundImageAlias=""
            filters.setPresetName(name: "Masked Variable Blur")
            filters.add(filterHolder: filterXHolder)
            presetsList.append(filters)
            filters.initNodeIndex()

            filters=FiltersX(context)
            filters.size=defaultThumbSize
            filters.boundsCenter=CIVector(x:filters.size.width/2.0,y:filters.size.height/2.0)
            filterXHolder=filters.getFilterWithHolder("Read Image")
            filters.add(filterHolder: filterXHolder)
            filterXHolder=filters.getFilterWithHolder("Translate")
            filters.add(filterHolder: filterXHolder)
            filterXHolder=filters.getFilterWithHolder("Scale")
            filters.add(filterHolder: filterXHolder)
            (filterXHolder.filter as! ScaleFX).a=0.2
            (filterXHolder.filter as! ScaleFX).d=0.2
            filterXHolder=filters.getFilterWithHolder("Soft Light Blend Mode")
            filterXHolder.filter.inputImageAlias=""
            filterXHolder.filter.backgroundImageAlias="0"
            filters.add(filterHolder: filterXHolder)
            filters.setPresetName(name: "Read Image Soft Light Blend Mode")
            presetsList.append(filters)
            filters.initNodeIndex()

            filters=FiltersX(context)
            filters.size=defaultThumbSize
            filters.boundsCenter=CIVector(x:filters.size.width/2.0,y:filters.size.height/2.0)
            filterXHolder=filters.getFilterWithHolder("Shaded Material")
            filters.add(filterHolder: filterXHolder)
            filters.setPresetName(name: "Shaded Material")
            presetsList.append(filters)
            filters.initNodeIndex()
             */

            

            
        }
        else if presetType == "ExtractTransform"
        {
       
            /*
            var filters=FiltersX(context)
            filters.size=defaultThumbSize
            filters.boundsCenter=CIVector(x:filters.size.width/2.0,y:filters.size.height/2.0)
            var filterXHolder=filters.getFilterWithHolder("RowAverage")
            filters.add(filterHolder: filterXHolder)
            filters.setPresetName(name: "Row Average Image")
            presetsList.append(filters)
            filters.initNodeIndex()

            filters=FiltersX(context)
            filters.size=defaultThumbSize
            filters.boundsCenter=CIVector(x:filters.size.width/2.0,y:filters.size.height/2.0)
            filterXHolder=filters.getFilterWithHolder("ColumnAverage")
            filters.add(filterHolder: filterXHolder)
            filters.setPresetName(name: "Column Average Image")
            presetsList.append(filters)
            filters.initNodeIndex()


            
            filters=FiltersX(context)
            filters.size=defaultThumbSize
            filters.boundsCenter=CIVector(x:filters.size.width/2.0,y:filters.size.height/2.0)
            filterXHolder=filters.getFilterWithHolder("Area Average")
            filters.add(filterHolder: filterXHolder)
            filters.setPresetName(name: "Area Average Image")
            presetsList.append(filters)
            filters.initNodeIndex()

            
            filters=FiltersX(context)
            filters.size=defaultThumbSize
            filters.boundsCenter=CIVector(x:filters.size.width/2.0,y:filters.size.height/2.0)
            filterXHolder=filters.getFilterWithHolder("Area Maximum Alpha")
            filters.add(filterHolder: filterXHolder)
            filters.setPresetName(name: "Area Maximum Alpha Image")
            presetsList.append(filters)
            filters.initNodeIndex()

            //filters=FiltersX(context)
            //filters.size=defaultThumbSize
            //filters.boundsCenter=CIVector(x:filters.size.width/2.0,y:filters.size.height/2.0)
            //filterXHolder=filters.getFilterWithHolder("Area Minimum Alpha")
            //filters.add(filterHolder: filterXHolder)
            //filters.setPresetName(name: "Area MInimum Alpha Image")
            //presetsList.append(filters)

            filters=FiltersX(context)
            filters.size=defaultThumbSize
            filters.boundsCenter=CIVector(x:filters.size.width/2.0,y:filters.size.height/2.0)
            filterXHolder=filters.getFilterWithHolder("Minimum Component")
            filters.add(filterHolder: filterXHolder)
            filters.setPresetName(name: "Minimum Component Image")
            presetsList.append(filters)
            filters.initNodeIndex()

            filters=FiltersX(context)
            filters.size=defaultThumbSize
            filters.boundsCenter=CIVector(x:filters.size.width/2.0,y:filters.size.height/2.0)
            filterXHolder=filters.getFilterWithHolder("Maximum Component")
            filters.add(filterHolder: filterXHolder)
            filters.setPresetName(name: "Maximum Component Image")
            presetsList.append(filters)
            filters.initNodeIndex()

            filters=FiltersX(context)
            filters.size=defaultThumbSize
            filters.boundsCenter=CIVector(x:filters.size.width/2.0,y:filters.size.height/2.0)
            filterXHolder=filters.getFilterWithHolder("Histogram Display Filter")
            filters.add(filterHolder: filterXHolder)
            filters.setPresetName(name: "Histogram Display Filter")
            presetsList.append(filters)
            filters.initNodeIndex()

            filters=FiltersX(context)
            filters.size=defaultThumbSize
            filters.boundsCenter=CIVector(x:filters.size.width/2.0,y:filters.size.height/2.0)
            filterXHolder=filters.getFilterWithHolder("Crop")
            filters.add(filterHolder: filterXHolder)
            filters.setPresetName(name: "Crop Image")
            presetsList.append(filters)
            filters.initNodeIndex()

            filters=FiltersX(context)
            filters.size=defaultThumbSize
            filters.boundsCenter=CIVector(x:filters.size.width/2.0,y:filters.size.height/2.0)
            filterXHolder=filters.getFilterWithHolder("Perspective Transform With Extent")
            filters.add(filterHolder: filterXHolder)
            filters.setPresetName(name: "Perspective Transform With Extent Image")
            presetsList.append(filters)
            filters.initNodeIndex()
             */
        }
        else if presetType == "ColorAdjust"
        {
            /*
            var filters=FiltersX(context)
            filters.size=defaultThumbSize
            filters.boundsCenter=CIVector(x:filters.size.width/2.0,y:filters.size.height/2.0)
            var filterXHolder=filters.getFilterWithHolder("Remove Color With Color Cube")
            filters.add(filterHolder: filterXHolder)
            filters.setPresetName(name: "Remove Color With Color Cube")
            presetsList.append(filters)
            filters.initNodeIndex()

   
            
            filters=FiltersX(context)
            filters.size=defaultThumbSize
            filters.boundsCenter=CIVector(x:filters.size.width/2.0,y:filters.size.height/2.0)
            filterXHolder=filters.getFilterWithHolder("Color Invert")
            filters.add(filterHolder: filterXHolder)
            filterXHolder=filters.getFilterWithHolder("Exposure Adjust")
            filters.add(filterHolder: filterXHolder)
            filterXHolder=filters.getFilterWithHolder("Gamma Adjust")
            filters.add(filterHolder: filterXHolder)
            filterXHolder=filters.getFilterWithHolder("Temperature And Tint")
            filters.add(filterHolder: filterXHolder)
            filterXHolder=filters.getFilterWithHolder("White Point Adjust")
            filters.add(filterHolder: filterXHolder)
            filters.setPresetName(name: "Exposure Gamma Temperature Tint White Point Adjust Image")
            presetsList.append(filters)
            filters.initNodeIndex()
             
            filters=FiltersX(context)
            filters.size=defaultThumbSize
            filters.boundsCenter=CIVector(x:filters.size.width/2.0,y:filters.size.height/2.0)
            filterXHolder=filters.getFilterWithHolder("Hue Adjust")
            filters.add(filterHolder: filterXHolder)
            (filterXHolder.filter as! HueAdjustFX).angle=0.2
            filterXHolder=filters.getFilterWithHolder("Color Matrix")
            filters.add(filterHolder: filterXHolder)
            filters.setPresetName(name: "Color Matrix Image")
            presetsList.append(filters)
            filters.initNodeIndex()

            filters=FiltersX(context)
            filters.size=defaultThumbSize
            filters.boundsCenter=CIVector(x:filters.size.width/2.0,y:filters.size.height/2.0)
            filterXHolder=filters.getFilterWithHolder("Color Posterize")
            (filterXHolder.filter as! ColorPosterizeFX).levels=4.0
            filters.add(filterHolder: filterXHolder)
            filterXHolder=filters.getFilterWithHolder("Color Clamp")
            filters.add(filterHolder: filterXHolder)
            filters.setPresetName(name: "Color Clamp Image")
            presetsList.append(filters)
            filters.initNodeIndex()

            filters=FiltersX(context)
            filters.size=defaultThumbSize
            filters.boundsCenter=CIVector(x:filters.size.width/2.0,y:filters.size.height/2.0)
            filterXHolder=filters.getFilterWithHolder("Color Polynomial")
            (filterXHolder.filter as! ColorPolynomialFX).rx=1.0
            (filterXHolder.filter as! ColorPolynomialFX).ry=0.0

            filters.add(filterHolder: filterXHolder)
            filters.setPresetName(name: "Color Polynomial Image")
            presetsList.append(filters)
            filters.initNodeIndex()

            filters=FiltersX(context)
            filters.size=defaultThumbSize
            filters.boundsCenter=CIVector(x:filters.size.width/2.0,y:filters.size.height/2.0)
            filterXHolder=filters.getFilterWithHolder("Color Cross Polynomial")
            (filterXHolder.filter as! ColorCrossPolynomialFX).rw1=0.0
          
            filters.add(filterHolder: filterXHolder)
            filters.setPresetName(name: "Color Cross Polynomial Image")
            presetsList.append(filters)
            filters.initNodeIndex()

            */
        }
        else if presetType == "Stylize"
        {
/*
            var filters=FiltersX(context)
            filters.size=defaultThumbSize
            filters.boundsCenter=CIVector(x:filters.size.width/2.0,y:filters.size.height/2.0)
            var filterXHolder=filters.getFilterWithHolder("Color Controls")
            filters.add(filterHolder: filterXHolder)
            filterXHolder=filters.getFilterWithHolder("Pixellate")
            (filterXHolder.filter as! PixellateFX).scale=23
            filters.add(filterHolder: filterXHolder)
            filters.setPresetName(name: "Pixellate Image")
            presetsList.append(filters)
            filters.initNodeIndex()

            filters=FiltersX(context)
            filters.size=defaultThumbSize
            filters.boundsCenter=CIVector(x:filters.size.width/2.0,y:filters.size.height/2.0)
            filterXHolder=filters.getFilterWithHolder("Color Controls")
            filters.add(filterHolder: filterXHolder)
            filterXHolder=filters.getFilterWithHolder("Pointillize")
            (filterXHolder.filter as! PointillizeFX).radius=40
            filters.add(filterHolder: filterXHolder)
            filters.setPresetName(name: "Pointillize Style Image")
            presetsList.append(filters)
            filters.initNodeIndex()

            filters=FiltersX(context)
            filters.size=defaultThumbSize
            filters.boundsCenter=CIVector(x:filters.size.width/2.0,y:filters.size.height/2.0)
            filterXHolder=filters.getFilterWithHolder("Color Controls")
            filters.add(filterHolder: filterXHolder)
            filterXHolder=filters.getFilterWithHolder("HexagonalPixellate")
            (filterXHolder.filter as! HexagonalPixellateFX).scale=23
            filters.add(filterHolder: filterXHolder)
            filters.setPresetName(name: "Hexagonal Pixellate Image")
            presetsList.append(filters)
            filters.initNodeIndex()

            filters=FiltersX(context)
            filters.size=defaultThumbSize
            filters.boundsCenter=CIVector(x:filters.size.width/2.0,y:filters.size.height/2.0)
            filterXHolder=filters.getFilterWithHolder("Color Controls")
            filters.add(filterHolder: filterXHolder)
            filterXHolder=filters.getFilterWithHolder("Crystallize")
            (filterXHolder.filter as! CrystallizeFX).radius=20
            filters.add(filterHolder: filterXHolder)
            filters.setPresetName(name: "Crystallize Image")
            presetsList.append(filters)
            filters.initNodeIndex()

            filters=FiltersX(context)
            filters.size=defaultThumbSize
            filters.boundsCenter=CIVector(x:filters.size.width/2.0,y:filters.size.height/2.0)
            filterXHolder=filters.getFilterWithHolder("Color Controls")
            filters.add(filterHolder: filterXHolder)
            filterXHolder=filters.getFilterWithHolder("Bloom")
            (filterXHolder.filter as! BloomFX).radius=80
            (filterXHolder.filter as! BloomFX).intensity=0.8
            filters.add(filterHolder: filterXHolder)
            filters.setPresetName(name: "Bloom Image")
            presetsList.append(filters)
            filters.initNodeIndex()

            filters=FiltersX(context)
            filters.size=defaultThumbSize
            filters.boundsCenter=CIVector(x:filters.size.width/2.0,y:filters.size.height/2.0)
            filterXHolder=filters.getFilterWithHolder("Color Controls")
            filters.add(filterHolder: filterXHolder)
            filterXHolder=filters.getFilterWithHolder("Hatched Screen")
            filters.add(filterHolder: filterXHolder)
            filters.setPresetName(name: "Hatched Pattern of Halftone Screen")
            presetsList.append(filters)
            filters.initNodeIndex()

            filters=FiltersX(context)
            filters.size=defaultThumbSize
            filters.boundsCenter=CIVector(x:filters.size.width/2.0,y:filters.size.height/2.0)
            filterXHolder=filters.getFilterWithHolder("Color Controls")
            filters.add(filterHolder: filterXHolder)
            filterXHolder=filters.getFilterWithHolder("Dot Screen")
            filters.add(filterHolder: filterXHolder)
            filters.setPresetName(name: "Dot Pattern of Halftone Screen")
            presetsList.append(filters)
            filters.initNodeIndex()

            filters=FiltersX(context)
            filters.size=defaultThumbSize
            filters.boundsCenter=CIVector(x:filters.size.width/2.0,y:filters.size.height/2.0)
            filterXHolder=filters.getFilterWithHolder("Color Controls")
            filters.add(filterHolder: filterXHolder)
            filterXHolder=filters.getFilterWithHolder("LineOverlay")
            filters.add(filterHolder: filterXHolder)
            filters.setPresetName(name: "Line Overlay Image")
            presetsList.append(filters)
            filters.initNodeIndex()

            filters=FiltersX(context)
            filters.size=defaultThumbSize
            filters.boundsCenter=CIVector(x:filters.size.width/2.0,y:filters.size.height/2.0)
            filterXHolder=filters.getFilterWithHolder("Edge Work")
            filters.add(filterHolder: filterXHolder)
            filterXHolder=filters.getFilterWithHolder("Constant Color Generator")
            (filterXHolder.filter as! ConstantColorGeneratorFX).color = .black
            (filterXHolder.filter as! ConstantColorGeneratorFX).colorx = .black
            filters.add(filterHolder: filterXHolder)
            filterXHolder=filters.getFilterWithHolder("Source Atop Compositing")
            filterXHolder.filter.inputImageAlias="1"
            filterXHolder.filter.backgroundImageAlias="2"
            filters.add(filterHolder: filterXHolder)
            filters.setPresetName(name: "Edge Work Atop Image")
            presetsList.append(filters)
            filters.initNodeIndex()

            filters=FiltersX(context)
            filters.size=defaultThumbSize
            filters.boundsCenter=CIVector(x:filters.size.width/2.0,y:filters.size.height/2.0)
            filterXHolder=filters.getFilterWithHolder("Color Controls")
            filters.add(filterHolder: filterXHolder)
            filterXHolder=filters.getFilterWithHolder("Comic Effect")
            filters.add(filterHolder: filterXHolder)
            filters.setPresetName(name: "Comic Effect")
            presetsList.append(filters)
            filters.initNodeIndex()

            filters=FiltersX(context)
            filters.size=defaultThumbSize
            filters.boundsCenter=CIVector(x:filters.size.width/2.0,y:filters.size.height/2.0)
            filterXHolder=filters.getFilterWithHolder("Edges")
            filters.add(filterHolder: filterXHolder)
            (filterXHolder.filter as! EdgesFX).intensity=7.0
            filterXHolder=filters.getFilterWithHolder("Color Clamp")
            (filterXHolder.filter as! ColorClampFX).maxy=0.5
            filters.add(filterHolder: filterXHolder)
            filters.setPresetName(name: "Edges with Color Clamp")
            presetsList.append(filters)
            filters.initNodeIndex()

*/
            


        }
        
        else if presetType == "Transition"
        {
            /*
            var filters=FiltersX(context)
            filters.size=defaultThumbSize
            filters.boundsCenter=CIVector(x:filters.size.width/2.0,y:filters.size.height/2.0)
            
            var filterXHolder=filters.getFilterWithHolder("QR Code Generator")
            filters.add(filterHolder: filterXHolder)
            filterXHolder=filters.getFilterWithHolder("Checkerboard Generator")
            filters.add(filterHolder: filterXHolder)
            filterXHolder=filters.getFilterWithHolder("Page Curl With Shadow Transition")
            filterXHolder.filter.inputImageAlias="0"
            (filterXHolder.filter as! PageCurlWithShadowTransitionFX).time=0.3
            (filterXHolder.filter as! PageCurlWithShadowTransitionFX).angle=0.6
            (filterXHolder.filter as! PageCurlWithShadowTransitionFX).targetImageAlias="1"
            (filterXHolder.filter as! PageCurlWithShadowTransitionFX).inputBacksideImageAlias="2"
            filters.add(filterHolder: filterXHolder)
            filters.setPresetName(name: "Page Curl With Shadow Transition")
            presetsList.append(filters)
            filters.initNodeIndex()

            filters=FiltersX(context)
            filters.size=defaultThumbSize
            filters.boundsCenter=CIVector(x:filters.size.width/2.0,y:filters.size.height/2.0)
            filterXHolder=filters.getFilterWithHolder("Row Average")
            filters.add(filterHolder: filterXHolder)
            filterXHolder=filters.getFilterWithHolder("Swipe Transition")
            filterXHolder.filter.inputImageAlias=""
            (filterXHolder.filter as! SwipeTransitionFX).targetImageAlias="0"
            filters.add(filterHolder: filterXHolder)
            filters.setPresetName(name: "Swipe Transition")
            presetsList.append(filters)
            filters.initNodeIndex()

            filters=FiltersX(context)
            filters.size=defaultThumbSize
            filters.boundsCenter=CIVector(x:filters.size.width/2.0,y:filters.size.height/2.0)
            filterXHolder=filters.getFilterWithHolder("False Color")
            filters.add(filterHolder: filterXHolder)
            filterXHolder=filters.getFilterWithHolder("Overlay Blend Mode")
            filterXHolder.filter.inputImageAlias=""
            (filterXHolder.filter as! OverlayBlendModeFX).backgroundImageAlias="0"
            filters.add(filterHolder: filterXHolder)
            filterXHolder=filters.getFilterWithHolder("Swipe Transition")
            filterXHolder.filter.inputImageAlias=""
            (filterXHolder.filter as! SwipeTransitionFX).targetImageAlias="0"
            filters.add(filterHolder: filterXHolder)
            filters.setPresetName(name: "Swipe Transition")
            presetsList.append(filters)
            filters.initNodeIndex()

            filters=FiltersX(context)
            filters.size=defaultThumbSize
            filters.boundsCenter=CIVector(x:filters.size.width/2.0,y:filters.size.height/2.0)
            filterXHolder=filters.getFilterWithHolder("False Color")
            filters.add(filterHolder: filterXHolder)
            filterXHolder=filters.getFilterWithHolder("Overlay Blend Mode")
            filterXHolder.filter.inputImageAlias=""
            (filterXHolder.filter as! OverlayBlendModeFX).backgroundImageAlias="0"
            filters.add(filterHolder: filterXHolder)
            filterXHolder=filters.getFilterWithHolder("Mod Transition")
            filterXHolder.filter.inputImageAlias="0"
            (filterXHolder.filter as! ModTransitionFX).targetImageAlias=""
            filters.add(filterHolder: filterXHolder)
            filters.setPresetName(name: "Mod Transition")
            presetsList.append(filters)
            filters.initNodeIndex()

            filters=FiltersX(context)
            filters.size=defaultThumbSize
            filters.boundsCenter=CIVector(x:filters.size.width/2.0,y:filters.size.height/2.0)
            filterXHolder=filters.getFilterWithHolder("False Color")
            filters.add(filterHolder: filterXHolder)
            filterXHolder=filters.getFilterWithHolder("Flash Transition")
            filterXHolder.filter.inputImageAlias="0"
            (filterXHolder.filter as! FlashTransitionFX).time=0.6
            (filterXHolder.filter as! FlashTransitionFX).targetImageAlias=""
            (filterXHolder.filter as! FlashTransitionFX).colorx = Color.blue
//            (filterXHolder.filter as! FlashTransitionFX).color = CIColor(color: UIColor(Color.blue))
            (filterXHolder.filter as! FlashTransitionFX).color = .blue
            filters.add(filterHolder: filterXHolder)
            filters.setPresetName(name: "Flash Transition")
            presetsList.append(filters)
            filters.initNodeIndex()

            filters=FiltersX(context)
            filters.size=defaultThumbSize
            filters.boundsCenter=CIVector(x:filters.size.width/2.0,y:filters.size.height/2.0)
            filterXHolder=filters.getFilterWithHolder("Dot Screen")
            filters.add(filterHolder: filterXHolder)
            filterXHolder=filters.getFilterWithHolder("Crop")
            (filterXHolder.filter as! CropFX).y=Float(2/3*filters.size.height)
            
            filters.add(filterHolder: filterXHolder)
            
            filterXHolder=filters.getFilterWithHolder("Ripple Transition")
            filterXHolder.filter.inputImageAlias="0"
            (filterXHolder.filter as! RippleTransitionFX).time=0.35
            (filterXHolder.filter as! RippleTransitionFX).targetImageAlias="1"
            filters.add(filterHolder: filterXHolder)
            filters.setPresetName(name: "Ripple Transition")
            presetsList.append(filters)
            filters.initNodeIndex()

            filters=FiltersX(context)
            filters.size=defaultThumbSize
            filters.boundsCenter=CIVector(x:filters.size.width/2.0,y:filters.size.height/2.0)
            filterXHolder=filters.getFilterWithHolder("Eightfold Reflected Tile")
            (filterXHolder.filter as! EightfoldReflectedTileFX).angle=1
            filters.add(filterHolder: filterXHolder)
            filterXHolder=filters.getFilterWithHolder("Copy Machine Transition")
            filterXHolder.filter.inputImageAlias="0"
            (filterXHolder.filter as! CopyMachineTransitionFX).time=0.15
            (filterXHolder.filter as! CopyMachineTransitionFX).targetImageAlias=""
            (filterXHolder.filter as! CopyMachineTransitionFX).width=20
            (filterXHolder.filter as! CopyMachineTransitionFX).angle=1
            (filterXHolder.filter as! CopyMachineTransitionFX).colorx = Color.red
            (filterXHolder.filter as! CopyMachineTransitionFX).color = CIColor(color: UIColor(Color.red))
            filters.add(filterHolder: filterXHolder)
            filters.setPresetName(name: "Copy Machine Transition")
            presetsList.append(filters)
            filters.initNodeIndex()
             */
        }
        
        else if presetType == "Gradient Blend"
        {
            /*
            var filters=FiltersX(context)
            filters.size=defaultThumbSize
            filters.boundsCenter=CIVector(x:filters.size.width/2.0,y:filters.size.height/2.0)
            var filterXHolder=filters.getFilterWithHolder("Color Controls")
            filters.add(filterHolder: filterXHolder)
            filterXHolder=filters.getFilterWithHolder("Linear Gradient")
            (filterXHolder.filter as! LinearGradientFX).color0 = .red
            (filterXHolder.filter as! LinearGradientFX).colorx0 = .red
            (filterXHolder.filter as! LinearGradientFX).color1 = .yellow
            (filterXHolder.filter as! LinearGradientFX).colorx1 = .yellow
            filters.add(filterHolder: filterXHolder)
            filterXHolder=filters.getFilterWithHolder("Luminosity Blend Mode")
            filterXHolder.filter.inputImageAlias="1"
            filterXHolder.filter.backgroundImageAlias="2"
            filters.add(filterHolder: filterXHolder)
            filters.setPresetName(name: "Linear Gradient Luminosity Blend")
            presetsList.append(filters)
            filters.initNodeIndex()

            filters=FiltersX(context)
            filters.size=defaultThumbSize
            filters.boundsCenter=CIVector(x:filters.size.width/2.0,y:filters.size.height/2.0)
            filterXHolder=filters.getFilterWithHolder("Color Monochrome")
            (filterXHolder.filter as! ColorMonochromeFX).intensity=1
            filters.add(filterHolder: filterXHolder)
            filterXHolder=filters.getFilterWithHolder("Linear Gradient")
            filters.add(filterHolder: filterXHolder)
            filterXHolder=filters.getFilterWithHolder("Blend With Mask")
            filterXHolder.filter.inputImageAlias="0"
            (filterXHolder.filter as! BlendWithMaskFX).backgroundImageAlias="1"
              (filterXHolder.filter as! BlendWithMaskFX).inputMaskImageAlias=""
            filters.add(filterHolder: filterXHolder)
            filters.setPresetName(name: "Blend With Mask")
            presetsList.append(filters)
            filters.initNodeIndex()

      
            
            filters=FiltersX(context)
            filters.size=defaultThumbSize
            filters.boundsCenter=CIVector(x:filters.size.width/2.0,y:filters.size.height/2.0)
            filterXHolder=filters.getFilterWithHolder("Color Controls")
            filters.add(filterHolder: filterXHolder)
            filterXHolder=filters.getFilterWithHolder("Radial Gradient")
            (filterXHolder.filter as! RadialGradientFX).radius1 = 250
            (filterXHolder.filter as! RadialGradientFX).color0 = .red
            (filterXHolder.filter as! RadialGradientFX).colorx0 = .red
            (filterXHolder.filter as! RadialGradientFX).color1 = .yellow
            (filterXHolder.filter as! RadialGradientFX).colorx1 = .yellow
            filters.add(filterHolder: filterXHolder)
            filterXHolder=filters.getFilterWithHolder("Luminosity Blend Mode")
            filterXHolder.filter.inputImageAlias="1"
            filterXHolder.filter.backgroundImageAlias="2"
            filters.add(filterHolder: filterXHolder)
            filters.setPresetName(name: "Radial Gradient Luminosity Blend")
            presetsList.append(filters)
            filters.initNodeIndex()

            filters=FiltersX(context)
            filters.size=defaultThumbSize
            filters.boundsCenter=CIVector(x:filters.size.width/2.0,y:filters.size.height/2.0)
            filterXHolder=filters.getFilterWithHolder("Color Controls")
            filters.add(filterHolder: filterXHolder)
            filterXHolder=filters.getFilterWithHolder("Radial Gradient")
            (filterXHolder.filter as! RadialGradientFX).radius1 = 250
            (filterXHolder.filter as! RadialGradientFX).color0 = .yellow
            (filterXHolder.filter as! RadialGradientFX).colorx0 = .yellow
            (filterXHolder.filter as! RadialGradientFX).color1 = .magenta
            (filterXHolder.filter as! RadialGradientFX).colorx1 = Color(UIColor(ciColor: (filterXHolder.filter as! RadialGradientFX).color1))
            filters.add(filterHolder: filterXHolder)
            filterXHolder=filters.getFilterWithHolder("Subtract Blend Mode")
            filterXHolder.filter.inputImageAlias="1"
            filterXHolder.filter.backgroundImageAlias="2"
            filters.add(filterHolder: filterXHolder)
            filterXHolder=filters.getFilterWithHolder("Disc Blur")
            (filterXHolder.filter as! DiscBlurFX).radius = 30

            filters.add(filterHolder: filterXHolder)

            filters.setPresetName(name: "Radial Gradient Subtract Blend Mode")
            presetsList.append(filters)
            filters.initNodeIndex()

            filters=FiltersX(context)
            filters.size=defaultThumbSize
            filters.boundsCenter=CIVector(x:filters.size.width/2.0,y:filters.size.height/2.0)
            filterXHolder=filters.getFilterWithHolder("Color Controls")
            filters.add(filterHolder: filterXHolder)
            filterXHolder=filters.getFilterWithHolder("Linear Gradient")
            (filterXHolder.filter as! LinearGradientFX).color0 = .red
            (filterXHolder.filter as! LinearGradientFX).colorx0 = .red
            (filterXHolder.filter as! LinearGradientFX).color1 = .yellow
            (filterXHolder.filter as! LinearGradientFX).colorx1 = .yellow
            filters.add(filterHolder: filterXHolder)
            filterXHolder=filters.getFilterWithHolder("Subtract Blend Mode")
            filterXHolder.filter.inputImageAlias="1"
            filterXHolder.filter.backgroundImageAlias="2"
            filters.add(filterHolder: filterXHolder)
            filters.setPresetName(name: "Linear Gradient Subtract Blend Mode")
            presetsList.append(filters)
            filters.initNodeIndex()

            
            filters=FiltersX(context)
            filters.size=defaultThumbSize
            filters.boundsCenter=CIVector(x:filters.size.width/2.0,y:filters.size.height/2.0)
            filterXHolder=filters.getFilterWithHolder("Color Controls")
            filters.add(filterHolder: filterXHolder)
            filterXHolder=filters.getFilterWithHolder("Radial Gradient")
            (filterXHolder.filter as! RadialGradientFX).radius1 = 300
            (filterXHolder.filter as! RadialGradientFX).color0 = .clear
            (filterXHolder.filter as! RadialGradientFX).colorx0 = .clear
            (filterXHolder.filter as! RadialGradientFX).color1 = .blue
            (filterXHolder.filter as! RadialGradientFX).colorx1 = .blue
            filters.add(filterHolder: filterXHolder)
            filterXHolder=filters.getFilterWithHolder("Addition Compositing")
            filterXHolder.filter.inputImageAlias="1"
            filterXHolder.filter.backgroundImageAlias="2"
            filters.add(filterHolder: filterXHolder)
            filters.setPresetName(name: "Radial Gradient Addition Compositing")
            presetsList.append(filters)
            filters.initNodeIndex()

            
      
            
            filters=FiltersX(context)
            filters.size=defaultThumbSize
            filters.boundsCenter=CIVector(x:filters.size.width/2.0,y:filters.size.height/2.0)
            filterXHolder=filters.getFilterWithHolder("Color Controls")
            filters.add(filterHolder: filterXHolder)
            filterXHolder=filters.getFilterWithHolder("Linear Gradient")
            filters.add(filterHolder: filterXHolder) //add adjust the size
            (filterXHolder.filter as! LinearGradientFX).pointX0=Float(filters.size.width/2.0)
            (filterXHolder.filter as! LinearGradientFX).pointY0=Float(filters.size.height/2.0)
            (filterXHolder.filter as! LinearGradientFX).pointX1=Float(filters.size.width)
            (filterXHolder.filter as! LinearGradientFX).pointY1=Float(filters.size.height)
            (filterXHolder.filter as! LinearGradientFX).color0 = .clear
            (filterXHolder.filter as! LinearGradientFX).colorx0 = .clear
            (filterXHolder.filter as! LinearGradientFX).color1 = .red
            (filterXHolder.filter as! LinearGradientFX).colorx1 = .red
            print((filterXHolder.filter as! LinearGradientFX).pointX0,(filterXHolder.filter as! LinearGradientFX).pointY0)
            print((filterXHolder.filter as! LinearGradientFX).pointX1,(filterXHolder.filter as! LinearGradientFX).pointY1)
            filterXHolder=filters.getFilterWithHolder("Addition Compositing")
            filterXHolder.filter.inputImageAlias="1"
            filterXHolder.filter.backgroundImageAlias="2"
            filters.setPresetName(name: "Linear Gradient Addition Compoisition Blend")
            filters.add(filterHolder: filterXHolder)
            presetsList.append(filters)
            filters.initNodeIndex()

            filters=FiltersX(context)
            filters.size=defaultThumbSize
            filters.boundsCenter=CIVector(x:filters.size.width/2.0,y:filters.size.height/2.0)
            filterXHolder=filters.getFilterWithHolder("Column Average")
            filters.add(filterHolder: filterXHolder)
            filterXHolder=filters.getFilterWithHolder("Hue Adjust")
            (filterXHolder.filter as! HueAdjustFX).angle=0.2
            filters.add(filterHolder: filterXHolder)
            filterXHolder=filters.getFilterWithHolder("Difference Blend Mode")
            filterXHolder.filter.inputImageAlias=""
            (filterXHolder.filter as! DifferenceBlendModeFX).backgroundImageAlias="0"
            filters.add(filterHolder: filterXHolder)
            filters.setPresetName(name: "Column Average Difference Blend Mode")
            presetsList.append(filters)
            filters.initNodeIndex()

            filters=FiltersX(context)
            filters.size=defaultThumbSize
            filters.boundsCenter=CIVector(x:filters.size.width/2.0,y:filters.size.height/2.0)
            filterXHolder=filters.getFilterWithHolder("Row Average")
            filters.add(filterHolder: filterXHolder)
            filterXHolder=filters.getFilterWithHolder("Hue Adjust")
            (filterXHolder.filter as! HueAdjustFX).angle=3.94
            filters.add(filterHolder: filterXHolder)
            filterXHolder=filters.getFilterWithHolder("Difference Blend Mode")
            filterXHolder.filter.inputImageAlias=""
            (filterXHolder.filter as! DifferenceBlendModeFX).backgroundImageAlias="0"
            filters.add(filterHolder: filterXHolder)
            filters.setPresetName(name: "Column Average Difference Blend Mode")
            presetsList.append(filters)
            filters.initNodeIndex()
*/
        }
        else if presetType == "Tiling"
        {
            /*
            var filters=FiltersX(context)
            filters.size=defaultThumbSize
            filters.boundsCenter=CIVector(x:filters.size.width/2.0,y:filters.size.height/2.0)
            var filterXHolder=filters.getFilterWithHolder("AffineTile")
            filters.add(filterHolder: filterXHolder)
            filters.setPresetName(name: "Affine Tile Four by Four")
            presetsList.append(filters)
            filters.initNodeIndex()

            filters=FiltersX(context)
            filters.size=defaultThumbSize
            filters.boundsCenter=CIVector(x:filters.size.width/2.0,y:filters.size.height/2.0)
            filterXHolder=filters.getFilterWithHolder("OpTile")
            (filterXHolder.filter as! OpTileFX).width = (filterXHolder.filter as! OpTileFX).width/4
            filters.add(filterHolder: filterXHolder)
            filters.setPresetName(name: "Op Tile Image")
            presetsList.append(filters)
            filters.initNodeIndex()

            filters=FiltersX(context)
            filters.size=defaultThumbSize
            filters.boundsCenter=CIVector(x:filters.size.width/2.0,y:filters.size.height/2.0)
            filterXHolder=filters.getFilterWithHolder("GlideReflectedTile")
            (filterXHolder.filter as! GlideReflectedTileFX).width = (filterXHolder.filter as! GlideReflectedTileFX).width/4
            filters.add(filterHolder: filterXHolder)
            filterXHolder=filters.getFilterWithHolder("Perspective Transform With Extent")
            filters.add(filterHolder: filterXHolder)
            filters.setPresetName(name: "Glide Reflected Tile Image")
            presetsList.append(filters)
            filters.initNodeIndex()

            filters=FiltersX(context)
            filters.size=defaultThumbSize
            filters.boundsCenter=CIVector(x:filters.size.width/2.0,y:filters.size.height/2.0)
            filterXHolder=filters.getFilterWithHolder("Kaleidoscope")
            (filterXHolder.filter as! KaleidoscopeFX).angle = 2
            filters.add(filterHolder: filterXHolder)
            filterXHolder=filters.getFilterWithHolder("TriangleKaleidoscope")
            (filterXHolder.filter as! TriangleKaleidoscopeFX).tksize = (filterXHolder.filter as! TriangleKaleidoscopeFX).tksize/4
            filters.add(filterHolder: filterXHolder)
            filters.setPresetName(name: "Triangle Kaleidoscope Image")
            presetsList.append(filters)
            filters.initNodeIndex()

            filters=FiltersX(context)
            filters.size=defaultThumbSize
            filters.boundsCenter=CIVector(x:filters.size.width/2.0,y:filters.size.height/2.0)
            filterXHolder=filters.getFilterWithHolder("TwelvefoldReflectedTile")
            (filterXHolder.filter as! TwelvefoldReflectedTileFX).width = (filterXHolder.filter as! TwelvefoldReflectedTileFX).width/2
            (filterXHolder.filter as! TwelvefoldReflectedTileFX).angle = 1
            filters.add(filterHolder: filterXHolder)
            filterXHolder=filters.getFilterWithHolder("Perspective Transform With Extent")
            filters.add(filterHolder: filterXHolder)
            filters.setPresetName(name: "Twelvefold Reflected Tile Image")
            presetsList.append(filters)
            filters.initNodeIndex()

            filters=FiltersX(context)
            filters.size=defaultThumbSize
            filters.boundsCenter=CIVector(x:filters.size.width/2.0,y:filters.size.height/2.0)
            filterXHolder=filters.getFilterWithHolder("Eightfold Reflected Tile")
            (filterXHolder.filter as! EightfoldReflectedTileFX).angle = 1.08
            (filterXHolder.filter as! EightfoldReflectedTileFX).width = 30
            filters.add(filterHolder: filterXHolder)
            filterXHolder=filters.getFilterWithHolder("Perspective Transform With Extent")
            filters.add(filterHolder: filterXHolder)
            filterXHolder=filters.getFilterWithHolder("Photo Effect Fade")
            filters.add(filterHolder: filterXHolder)
            filters.setPresetName(name: "Eightfold Reflected Tile Image")
            presetsList.append(filters)
            filters.initNodeIndex()

            filters=FiltersX(context)
            filters.size=defaultThumbSize
            filters.boundsCenter=CIVector(x:filters.size.width/2.0,y:filters.size.height/2.0)
            filterXHolder=filters.getFilterWithHolder("Kaleidoscope")
            (filterXHolder.filter as! KaleidoscopeFX).angle = 1
            filters.add(filterHolder: filterXHolder)
            filterXHolder=filters.getFilterWithHolder("Perspective Transform With Extent")
            filters.add(filterHolder: filterXHolder)
            filters.setPresetName(name: "Kaleidoscope Image")
            presetsList.append(filters)
            filters.initNodeIndex()

            */
    
        }
        else if presetType == "Geometry Blend"
        {
            

            /*
            var filters=FiltersX(context)
            filters.size=defaultThumbSize
            filters.boundsCenter=CIVector(x:filters.size.width/2.0,y:filters.size.height/2.0)
            var filterXHolder=filters.getFilterWithHolder("Color Controls")
            filters.add(filterHolder: filterXHolder)
            filterXHolder=filters.getFilterWithHolder("Checkerboard Generator")
            (filterXHolder.filter as! CheckerboardGeneratorFX).width=(filterXHolder.filter as! CheckerboardGeneratorFX).width/(compensateFactor*1.5)
            filters.add(filterHolder: filterXHolder)
            filterXHolder=filters.getFilterWithHolder("Fourfold Reflected Tile")
            (filterXHolder.filter as! FourfoldReflectedTileFX).angle=0.453
            filters.add(filterHolder: filterXHolder)
            filterXHolder=filters.getFilterWithHolder("Soft Light Blend Mode")
            filterXHolder.filter.inputImageAlias=""
            filterXHolder.filter.backgroundImageAlias="1"
            filters.setPresetName(name: "Checkerboard Soft Light Blend Tile")
            filters.add(filterHolder: filterXHolder)
            presetsList.append(filters)
            filters.initNodeIndex()

            
            filters=FiltersX(context)
            filters.size=defaultThumbSize
            filters.boundsCenter=CIVector(x:filters.size.width/2.0,y:filters.size.height/2.0)
            filterXHolder=filters.getFilterWithHolder("Color Controls")
            filters.add(filterHolder: filterXHolder)
            filterXHolder=filters.getFilterWithHolder("Star Shine Generator")
            (filterXHolder.filter as! StarShineGeneratorFX).radius=50/3
            filters.add(filterHolder: filterXHolder)
            filterXHolder=filters.getFilterWithHolder("Soft Light Blend Mode")
            filterXHolder.filter.inputImageAlias="1"
            filterXHolder.filter.backgroundImageAlias="2"
            filters.setPresetName(name: "Star Shine Soft Light Blend")
            filters.add(filterHolder: filterXHolder)
            presetsList.append(filters)
            filters.initNodeIndex()

            filters=FiltersX(context)
            filters.size=defaultThumbSize
            filters.boundsCenter=CIVector(x:filters.size.width/2.0,y:filters.size.height/2.0)
            filterXHolder=filters.getFilterWithHolder("Color Controls")
            filters.add(filterHolder: filterXHolder)
            filterXHolder=filters.getFilterWithHolder("Sunbeams Generator")
            (filterXHolder.filter as! SunbeamsGeneratorFX).time=0.14
            (filterXHolder.filter as! SunbeamsGeneratorFX).colorx = Color.red
            (filterXHolder.filter as! SunbeamsGeneratorFX).color = .red//CIColor(color: UIColor(Color.red))
            (filterXHolder.filter as! SunbeamsGeneratorFX).sunRadius=300/4
            (filterXHolder.filter as! SunbeamsGeneratorFX).maxStriationRadius=3
            (filterXHolder.filter as! SunbeamsGeneratorFX).striationStrength=2
            (filterXHolder.filter as! SunbeamsGeneratorFX).striationContrast=1
            filters.add(filterHolder: filterXHolder)
            filterXHolder=filters.getFilterWithHolder("Soft Light Blend Mode")
            filterXHolder.filter.inputImageAlias="1"
            filterXHolder.filter.backgroundImageAlias="2"
            filters.setPresetName(name: "Sunbeams Generator Soft Light Blend")
            filters.add(filterHolder: filterXHolder)
            presetsList.append(filters)
            filters.initNodeIndex()

            
            
            filters=FiltersX(context)
            filters.size=defaultThumbSize
            filters.boundsCenter=CIVector(x:filters.size.width/2.0,y:filters.size.height/2.0)
            filterXHolder=filters.getFilterWithHolder("Color Controls")
            filters.add(filterHolder: filterXHolder)
            filterXHolder=filters.getFilterWithHolder("Checkerboard Generator")
            (filterXHolder.filter as! CheckerboardGeneratorFX).width=(filterXHolder.filter as! CheckerboardGeneratorFX).width/compensateFactor
            filters.add(filterHolder: filterXHolder)
            filterXHolder=filters.getFilterWithHolder("Soft Light Blend Mode")
            filterXHolder.filter.inputImageAlias="2"
            filterXHolder.filter.backgroundImageAlias="1"
            filters.setPresetName(name: "Checkerboard Soft Light Blend")
            filters.add(filterHolder: filterXHolder)
            presetsList.append(filters)
            filters.initNodeIndex()

            
            
            
            filters=FiltersX(context)
            filters.size=defaultThumbSize
            filters.boundsCenter=CIVector(x:filters.size.width/2.0,y:filters.size.height/2.0)

            filterXHolder=filters.getFilterWithHolder("Color Controls")
            filters.add(filterHolder: filterXHolder)
            filterXHolder=filters.getFilterWithHolder("Checkerboard Generator")
            (filterXHolder.filter as! CheckerboardGeneratorFX).width=35/compensateFactor
            //(filterXHolder.filter as! CheckerboardGeneratorFX).width=117/compensateFactor
            filters.add(filterHolder: filterXHolder)
            
            filterXHolder=filters.getFilterWithHolder("Color Burn Blend Mode")
            filterXHolder.filter.inputImageAlias="2"
            filterXHolder.filter.backgroundImageAlias="1"
            filters.add(filterHolder: filterXHolder)

            filterXHolder=filters.getFilterWithHolder("Photo Effect Tonal")
            filters.add(filterHolder: filterXHolder)
            filters.setPresetName(name: "Checkerboard Color Burn Blend Tonal")
            presetsList.append(filters)
            filters.initNodeIndex()

            filters=FiltersX(context)
            filters.size=defaultThumbSize
            filters.boundsCenter=CIVector(x:filters.size.width/2.0,y:filters.size.height/2.0)

            filterXHolder=filters.getFilterWithHolder("Color Controls")
            filters.add(filterHolder: filterXHolder)
            filterXHolder=filters.getFilterWithHolder("Stripes Generator")
            (filterXHolder.filter as! StripesGeneratorFX).width=(filterXHolder.filter as! StripesGeneratorFX).width/compensateFactor
            filters.add(filterHolder: filterXHolder)
            filterXHolder=filters.getFilterWithHolder("Soft Light Blend Mode")
            filterXHolder.filter.inputImageAlias="2"
            filterXHolder.filter.backgroundImageAlias="1"
            filters.setPresetName(name: "Stripes Soft Light Blend")
            filters.add(filterHolder: filterXHolder)
            presetsList.append(filters)
            filters.initNodeIndex()

            
            filters=FiltersX(context)
            filters.size=defaultThumbSize
            filters.boundsCenter=CIVector(x:filters.size.width/2.0,y:filters.size.height/2.0)
            filterXHolder=filters.getFilterWithHolder("Color Controls")
            filters.add(filterHolder: filterXHolder)
            filterXHolder=filters.getFilterWithHolder("Stripes Generator")
            (filterXHolder.filter as! StripesGeneratorFX).width=15//(filterXHolder.filter as! StripesGeneratorFX).width/compensateFactor
            filters.add(filterHolder: filterXHolder)
            filterXHolder=filters.getFilterWithHolder("Hole Distortion")
            (filterXHolder.filter as! HoleDistortionFX).radius=40.0//(filterXHolder.filter as! HoleDistortionFX).radius/compensateFactor
            filters.add(filterHolder: filterXHolder)
            filterXHolder=filters.getFilterWithHolder("Difference Blend Mode")
            filterXHolder.filter.inputImageAlias="3"
            filterXHolder.filter.backgroundImageAlias="1"
            filters.add(filterHolder: filterXHolder)
            filterXHolder=filters.getFilterWithHolder("Color Monochrome")
            (filterXHolder.filter as! ColorMonochromeFX).colorx = .black
            (filterXHolder.filter as! ColorMonochromeFX).color = .black
            (filterXHolder.filter as! ColorMonochromeFX).intensity=1
            filters.add(filterHolder: filterXHolder)
            filters.setPresetName(name: "Stripes Difference Blend Mode")
            
            presetsList.append(filters)
            filters.initNodeIndex()

            
            filters=FiltersX(context)
            filters.size=defaultThumbSize
            filters.boundsCenter=CIVector(x:filters.size.width/2.0,y:filters.size.height/2.0)
            filterXHolder=filters.getFilterWithHolder("Color Controls")
            filters.add(filterHolder: filterXHolder)
            filterXHolder=filters.getFilterWithHolder("Color Invert")
            filters.add(filterHolder: filterXHolder)
            filterXHolder=filters.getFilterWithHolder("Circular Wrap")
            (filterXHolder.filter as! CircularWrapFX).radius=5
            filters.add(filterHolder: filterXHolder)
            filterXHolder=filters.getFilterWithHolder("Color Dodge Blend Mode")
            filterXHolder.filter.inputImageAlias="3"
            filterXHolder.filter.backgroundImageAlias="0"
            filters.add(filterHolder: filterXHolder)
            filterXHolder=filters.getFilterWithHolder("Photo Effect Noir")
            filters.add(filterHolder: filterXHolder)
            filters.setPresetName(name: "Color Invert Circular Wrap Color Dodge Blend")
            presetsList.append(filters)
            filters.initNodeIndex()

            filters=FiltersX(context)
            filters.size=defaultThumbSize
            filters.boundsCenter=CIVector(x:filters.size.width/2.0,y:filters.size.height/2.0)
            filterXHolder=filters.getFilterWithHolder("Color Controls")
            filters.add(filterHolder: filterXHolder)
            filterXHolder=filters.getFilterWithHolder("Checkerboard Generator")
            (filterXHolder.filter as! CheckerboardGeneratorFX).width=20
            filters.add(filterHolder: filterXHolder)
            filterXHolder=filters.getFilterWithHolder("Light Tunnel")
            (filterXHolder.filter as! LightTunnelFX).radius=60
            (filterXHolder.filter as! LightTunnelFX).rotation=1.5
            filters.add(filterHolder: filterXHolder)
            filterXHolder=filters.getFilterWithHolder("Difference Blend Mode")
            filterXHolder.filter.inputImageAlias="3"
            filterXHolder.filter.backgroundImageAlias="1"
            filters.add(filterHolder: filterXHolder)
            filterXHolder=filters.getFilterWithHolder("Color Monochrome")
            (filterXHolder.filter as! ColorMonochromeFX).color = .red
            (filterXHolder.filter as! ColorMonochromeFX).colorx = .red
            filters.add(filterHolder: filterXHolder)
            filters.setPresetName(name: "Checkerboard Light Tunnel Difference Blend")
            presetsList.append(filters)
            filters.initNodeIndex()
*/
  
        }

        else if presetType == "Color Blend"
        {
            /*
            
            var filters=FiltersX(context)
            filters.size=defaultThumbSize
            filters.boundsCenter=CIVector(x:filters.size.width/2.0,y:filters.size.height/2.0)
            var filterXHolder=filters.getFilterWithHolder("Color Controls")
            filters.add(filterHolder: filterXHolder)
            filterXHolder=filters.getFilterWithHolder("Color Monochrome")
            (filterXHolder.filter as! ColorMonochromeFX).intensity = 0.7
            (filterXHolder.filter as! ColorMonochromeFX).colorx = .blue
            (filterXHolder.filter as! ColorMonochromeFX).color = .blue
            filters.add(filterHolder: filterXHolder)
            filters.setPresetName(name: "Color Monochrome Blue")
            presetsList.append(filters)
            filters.initNodeIndex()


            
            filters=FiltersX(context)
            filters.size=defaultThumbSize
            filters.boundsCenter=CIVector(x:filters.size.width/2.0,y:filters.size.height/2.0)
            filterXHolder=filters.getFilterWithHolder("Color Controls")
            filters.add(filterHolder: filterXHolder)
            filterXHolder=filters.getFilterWithHolder("Sepia Tone")
            filters.add(filterHolder: filterXHolder)
            filterXHolder=filters.getFilterWithHolder("Vignette")
            (filterXHolder.filter as! VignetteFX).intensity = 1.0
            (filterXHolder.filter as! VignetteFX).radius = 2.0
            filters.add(filterHolder: filterXHolder)
            filters.setPresetName(name: "Sepia Tone Vignette")
            presetsList.append(filters)
            filters.initNodeIndex()

            filters=FiltersX(context)
            filters.size=defaultThumbSize
            filters.boundsCenter=CIVector(x:filters.size.width/2.0,y:filters.size.height/2.0)
            filterXHolder=filters.getFilterWithHolder("Color Controls")
            filters.add(filterHolder: filterXHolder)
            filterXHolder=filters.getFilterWithHolder("Color Monochrome")
            (filterXHolder.filter as! ColorMonochromeFX).intensity = 0.5
            (filterXHolder.filter as! ColorMonochromeFX).colorx = .red
            (filterXHolder.filter as! ColorMonochromeFX).color = .red
            filters.add(filterHolder: filterXHolder)
            filterXHolder=filters.getFilterWithHolder("Color Invert")
            filters.add(filterHolder: filterXHolder)
            filters.setPresetName(name: "Color Monochrome Red Invert")
            presetsList.append(filters)
            filters.initNodeIndex()

            filters=FiltersX(context)
            filters.size=defaultThumbSize
            filters.boundsCenter=CIVector(x:filters.size.width/2.0,y:filters.size.height/2.0)
            filterXHolder=filters.getFilterWithHolder("Color Controls")
            filters.add(filterHolder: filterXHolder)
            filterXHolder=filters.getFilterWithHolder("Color Monochrome")
            (filterXHolder.filter as! ColorMonochromeFX).intensity = 0.5
            (filterXHolder.filter as! ColorMonochromeFX).colorx = .red
            (filterXHolder.filter as! ColorMonochromeFX).color = .red
            filters.add(filterHolder: filterXHolder)
            filterXHolder=filters.getFilterWithHolder("CMYK Halftone")
            filters.add(filterHolder: filterXHolder)
            filters.setPresetName(name: "Color Monochrome Red CMYK Halftone")
            presetsList.append(filters)
            filters.initNodeIndex()

            filters=FiltersX(context)
            filters.size=defaultThumbSize
            filters.boundsCenter=CIVector(x:filters.size.width/2.0,y:filters.size.height/2.0)
            filterXHolder=filters.getFilterWithHolder("Color Controls")
            filters.add(filterHolder: filterXHolder)
            filterXHolder=filters.getFilterWithHolder("False Color")
            filters.add(filterHolder: filterXHolder)
            filters.setPresetName(name: "False Color Default")
            presetsList.append(filters)
            filters.initNodeIndex()

            
            filters=FiltersX(context)
            filters.size=defaultThumbSize
            filters.boundsCenter=CIVector(x:filters.size.width/2.0,y:filters.size.height/2.0)
            filterXHolder=filters.getFilterWithHolder("Color Controls")
            filters.add(filterHolder: filterXHolder)
            filterXHolder=filters.getFilterWithHolder("Color Invert")
            filters.add(filterHolder: filterXHolder)
            filterXHolder=filters.getFilterWithHolder("Subtract Blend Mode")
            filterXHolder.filter.inputImageAlias="1"
            filterXHolder.filter.backgroundImageAlias="2"
            filters.add(filterHolder: filterXHolder)
            filterXHolder=filters.getFilterWithHolder("Photo Effect Noir")
            filters.add(filterHolder: filterXHolder)
            filters.setPresetName(name: "Color Invert Subtract Blend Mode")
            presetsList.append(filters)
            filters.initNodeIndex()

            filters=FiltersX(context)
            filters.size=defaultThumbSize
            filters.boundsCenter=CIVector(x:filters.size.width/2.0,y:filters.size.height/2.0)
            filterXHolder=filters.getFilterWithHolder("Color Controls")
            filters.add(filterHolder: filterXHolder)
            filterXHolder=filters.getFilterWithHolder("Lenticular Halo Generator")
            (filterXHolder.filter as! LenticularHaloGeneratorFX).haloWidth=300.0/(compensateFactor*2.5)
            filters.add(filterHolder: filterXHolder)
            filterXHolder=filters.getFilterWithHolder("Soft Light Blend Mode")
            filterXHolder.filter.inputImageAlias="1"
            filterXHolder.filter.backgroundImageAlias="2"
            filters.setPresetName(name: "Lenticular Soft Light Blend")
            filters.add(filterHolder: filterXHolder)
            presetsList.append(filters)
            filters.initNodeIndex()

            
            filters=FiltersX(context)
            filters.size=defaultThumbSize
            filters.boundsCenter=CIVector(x:filters.size.width/2.0,y:filters.size.height/2.0)
            filterXHolder=filters.getFilterWithHolder("Color Controls")
            (filterXHolder.filter as! ColorControlsFX).brightness=0.6/compensateFactor
            filters.add(filterHolder: filterXHolder)
            filterXHolder=filters.getFilterWithHolder("Color Invert")
            filters.add(filterHolder: filterXHolder)
            filterXHolder=filters.getFilterWithHolder("Color Burn Blend Mode")
            filterXHolder.filter.inputImageAlias="2"
            filterXHolder.filter.backgroundImageAlias="1"
            filters.add(filterHolder: filterXHolder)
            filters.setPresetName(name: "Color Invert Color Burn Blend Mode")
            presetsList.append(filters)
            filters.initNodeIndex()

            filters=FiltersX(context)
            filters.size=defaultThumbSize
            filters.boundsCenter=CIVector(x:filters.size.width/2.0,y:filters.size.height/2.0)
            filterXHolder=filters.getFilterWithHolder("Color Controls")
            filters.add(filterHolder: filterXHolder)
            filterXHolder=filters.getFilterWithHolder("Constant Color Generator")
            (filterXHolder.filter as! ConstantColorGeneratorFX).color = .black
            (filterXHolder.filter as! ConstantColorGeneratorFX).colorx = .black
            filters.add(filterHolder: filterXHolder)
            filterXHolder=filters.getFilterWithHolder("Pin Light Blend Mode")
            filterXHolder.filter.inputImageAlias="1"
            filterXHolder.filter.backgroundImageAlias="2"
            filters.add(filterHolder: filterXHolder)
            filters.setPresetName(name: "Constant Color Pin Light Blend")
            presetsList.append(filters)
            filters.initNodeIndex()
*/
        }
        else if presetType == "Distortion"
        {
            /*
            var filters=FiltersX(context)
            filters.size=defaultThumbSize
            filters.boundsCenter=CIVector(x:filters.size.width/2.0,y:filters.size.height/2.0)
            
            var filterXHolder=filters.getFilterWithHolder("Color Controls")
            filters.add(filterHolder: filterXHolder)
            
            filterXHolder=filters.getFilterWithHolder("Twirl Distortion")
            filters.add(filterHolder: filterXHolder)
            (filterXHolder.filter as! TwirlDistortionFX).radius=(filterXHolder.filter as! TwirlDistortionFX).radius/compensateFactor
            (filterXHolder.filter as! TwirlDistortionFX).angle=(filterXHolder.filter as! TwirlDistortionFX).angle/compensateFactor
            filters.setPresetName(name: "Twirl Distortion")
            presetsList.append(filters)
            filters.initNodeIndex()


            
            filters=FiltersX(context)
            filters.size=defaultThumbSize
            filters.boundsCenter=CIVector(x:filters.size.width/2.0,y:filters.size.height/2.0)
            filterXHolder=filters.getFilterWithHolder("Color Controls")
            filters.add(filterHolder: filterXHolder)
            filterXHolder=filters.getFilterWithHolder("Pinch Distortion")
            filters.add(filterHolder: filterXHolder)
            (filterXHolder.filter as! PinchDistortionFX).radius=100.0//(filterXHolder.filter as! PinchDistortionFX).radius/compensateFactor
            (filterXHolder.filter as! PinchDistortionFX).scale=0.8
            filters.setPresetName(name: "Pinch Distortion")
            presetsList.append(filters)
            filters.initNodeIndex()

            filters=FiltersX(context)
            filters.size=defaultThumbSize
            filters.boundsCenter=CIVector(x:filters.size.width/2.0,y:filters.size.height/2.0)
            filterXHolder=filters.getFilterWithHolder("Color Controls")
            filters.add(filterHolder: filterXHolder)

            filterXHolder=filters.getFilterWithHolder("Circular Screen")
            filters.add(filterHolder: filterXHolder)
            (filterXHolder.filter as! CircularScreenFX).width=20.0/compensateFactor
            (filterXHolder.filter as! CircularScreenFX).sharpness=(filterXHolder.filter as! CircularScreenFX).sharpness/compensateFactor
            filters.setPresetName(name: "Circular Screen")
            presetsList.append(filters)
            filters.initNodeIndex()

            filters=FiltersX(context)
            filters.size=defaultThumbSize
            filters.boundsCenter=CIVector(x:filters.size.width/2.0,y:filters.size.height/2.0)
            filterXHolder=filters.getFilterWithHolder("Color Controls")
            filters.add(filterHolder: filterXHolder)
            filterXHolder=filters.getFilterWithHolder("Bump Distortion")
            filters.add(filterHolder: filterXHolder)
            (filterXHolder.filter as! BumpDistortionFX).radius=600.0/compensateFactor
            (filterXHolder.filter as! BumpDistortionFX).scale=1.0/compensateFactor
            filters.setPresetName(name: "Bump Distortion")
            presetsList.append(filters)
            filters.initNodeIndex()

            filters=FiltersX(context)
            filters.size=defaultThumbSize
            filters.boundsCenter=CIVector(x:filters.size.width/2.0,y:filters.size.height/2.0)
            filterXHolder=filters.getFilterWithHolder("Color Controls")
            filters.add(filterHolder: filterXHolder)
            filterXHolder=filters.getFilterWithHolder("Vortex Distortion")
            filters.add(filterHolder: filterXHolder)
            (filterXHolder.filter as! VortexDistortionFX).radius=515/compensateFactor
            (filterXHolder.filter as! VortexDistortionFX).angle=316/compensateFactor
            filters.setPresetName(name: "Vortex Distortion")
            presetsList.append(filters)
            filters.initNodeIndex()

            filters=FiltersX(context)
            filters.size=defaultThumbSize
            filters.boundsCenter=CIVector(x:filters.size.width/2.0,y:filters.size.height/2.0)
            filterXHolder=filters.getFilterWithHolder("Color Controls")
            filters.add(filterHolder: filterXHolder)
            filterXHolder=filters.getFilterWithHolder("Light Tunnel")
            (filterXHolder.filter as! LightTunnelFX).rotation=2.0/compensateFactor
                        filters.add(filterHolder: filterXHolder)
            filters.setPresetName(name: "Light Tunnel")
            presetsList.append(filters)
            filters.initNodeIndex()

            filters=FiltersX(context)
            filters.size=defaultThumbSize
            filters.boundsCenter=CIVector(x:filters.size.width/2.0,y:filters.size.height/2.0)

            filterXHolder=filters.getFilterWithHolder("Color Controls")
            filters.add(filterHolder: filterXHolder)

            filterXHolder=filters.getFilterWithHolder("CMYK Halftone")
            filters.add(filterHolder: filterXHolder)
            (filterXHolder.filter as! CMYKHalftoneFX).width=24.0/compensateFactor
            filters.setPresetName(name: "CMYK Halftone")
            presetsList.append(filters)
            filters.initNodeIndex()
*/
        }
        else if presetType == "Blur"
        {
            /*
            var filters=FiltersX(context)
            filters.size=defaultThumbSize
            filters.boundsCenter=CIVector(x:filters.size.width/2.0,y:filters.size.height/2.0)
            var filterXHolder=filters.getFilterWithHolder("Color Controls")
            filters.add(filterHolder: filterXHolder)

            filterXHolder=filters.getFilterWithHolder("Gaussian Blur")
            filters.setPresetName(name: "Gaussian Blur")
            filters.add(filterHolder: filterXHolder)
            presetsList.append(filters)
            filters.initNodeIndex()

            filters=FiltersX(context)
            filters.size=defaultThumbSize
            filters.boundsCenter=CIVector(x:filters.size.width/2.0,y:filters.size.height/2.0)
            filterXHolder=filters.getFilterWithHolder("Color Controls")
            filters.add(filterHolder: filterXHolder)
            filterXHolder=filters.getFilterWithHolder("Dot Screen")
            filters.add(filterHolder: filterXHolder)
            filterXHolder=filters.getFilterWithHolder("Gaussian Blur")
            filters.add(filterHolder: filterXHolder)
            filterXHolder=filters.getFilterWithHolder("Color Dodge Blend Mode")
            filterXHolder.filter.inputImageAlias="1"
            filterXHolder.filter.backgroundImageAlias="3"
            filters.add(filterHolder: filterXHolder)
            filters.setPresetName(name: "Dot Screen Color Dodge Blend Gaussian Blur")
            presetsList.append(filters)
            filters.initNodeIndex()

            
            
            
            filters=FiltersX(context)
            filters.size=defaultThumbSize
            filters.boundsCenter=CIVector(x:filters.size.width/2.0,y:filters.size.height/2.0)
            filterXHolder=filters.getFilterWithHolder("Color Controls")
            filters.add(filterHolder: filterXHolder)

            filterXHolder=filters.getFilterWithHolder("Motion Blur")
            filters.setPresetName(name: "Motion Blur")
            filters.add(filterHolder: filterXHolder)
            presetsList.append(filters)
            filters.initNodeIndex()

            
            filters=FiltersX(context)
            filters.size=defaultThumbSize
            filters.boundsCenter=CIVector(x:filters.size.width/2.0,y:filters.size.height/2.0)
            filterXHolder=filters.getFilterWithHolder("Color Controls")
            filters.add(filterHolder: filterXHolder)
            filterXHolder=filters.getFilterWithHolder("Hatched Screen")
            filters.add(filterHolder: filterXHolder)
            filterXHolder=filters.getFilterWithHolder("Motion Blur")
            filters.add(filterHolder: filterXHolder)
            filterXHolder=filters.getFilterWithHolder("Color Burn Blend Mode")
            filterXHolder.filter.inputImageAlias="1"
            filterXHolder.filter.backgroundImageAlias="3"
            filters.add(filterHolder: filterXHolder)
            filters.setPresetName(name: "Hatched Screen Color Burn Blend Motion Blur")
            presetsList.append(filters)
            filters.initNodeIndex()

            
            filters=FiltersX(context)
            filters.size=defaultThumbSize
            filters.boundsCenter=CIVector(x:filters.size.width/2.0,y:filters.size.height/2.0)
            filterXHolder=filters.getFilterWithHolder("Color Controls")
            filters.add(filterHolder: filterXHolder)

            filterXHolder=filters.getFilterWithHolder("Disc Blur")
            (filterXHolder.filter as! DiscBlurFX).radius=25
            filters.setPresetName(name: "Disc Blur")
            filters.add(filterHolder: filterXHolder)
            presetsList.append(filters)
            filters.initNodeIndex()

            filters=FiltersX(context)
            filters.size=defaultThumbSize
            filters.boundsCenter=CIVector(x:filters.size.width/2.0,y:filters.size.height/2.0)
            filterXHolder=filters.getFilterWithHolder("Color Controls")
            filters.add(filterHolder: filterXHolder)
            filterXHolder=filters.getFilterWithHolder("Line Screen")
            filters.add(filterHolder: filterXHolder)
            filterXHolder=filters.getFilterWithHolder("Motion Blur")
            filters.add(filterHolder: filterXHolder)
            filterXHolder=filters.getFilterWithHolder("Subtract Blend Mode")
            filterXHolder.filter.inputImageAlias="3"
            filterXHolder.filter.backgroundImageAlias="1"
            filters.add(filterHolder: filterXHolder)
            filters.setPresetName(name: "Line Screen Subtract Blend Motion Blur")
            presetsList.append(filters)
            filters.initNodeIndex()

            
            filters=FiltersX(context)
            filters.size=defaultThumbSize
            filters.boundsCenter=CIVector(x:filters.size.width/2.0,y:filters.size.height/2.0)
            filterXHolder=filters.getFilterWithHolder("Color Controls")
            filters.add(filterHolder: filterXHolder)

            filterXHolder=filters.getFilterWithHolder("Box Blur")
            (filterXHolder.filter as! BoxBlurFX).radius=25
            filters.setPresetName(name: "Box Blur")
            filters.add(filterHolder: filterXHolder)
            presetsList.append(filters)
            filters.initNodeIndex()

            
            filters=FiltersX(context)
            filters.size=defaultThumbSize
            filters.boundsCenter=CIVector(x:filters.size.width/2.0,y:filters.size.height/2.0)
            filterXHolder=filters.getFilterWithHolder("Color Controls")
            filters.add(filterHolder: filterXHolder)
            filterXHolder=filters.getFilterWithHolder("Dot Screen")
            filters.add(filterHolder: filterXHolder)
            filterXHolder=filters.getFilterWithHolder("Zoom Blur")
            filters.add(filterHolder: filterXHolder)
            filterXHolder=filters.getFilterWithHolder("Hard Light Blend Mode")
            filterXHolder.filter.inputImageAlias="1"
            filterXHolder.filter.backgroundImageAlias="3"
            filters.add(filterHolder: filterXHolder)
            filters.setPresetName(name: "Dot Screen Hard Light Blend Zoom Blur")
            presetsList.append(filters)
            filters.initNodeIndex()

            filters=FiltersX(context)
            filters.size=defaultThumbSize
            filters.boundsCenter=CIVector(x:filters.size.width/2.0,y:filters.size.height/2.0)
            filterXHolder=filters.getFilterWithHolder("Color Controls")
            filters.add(filterHolder: filterXHolder)
            filterXHolder=filters.getFilterWithHolder("Zoom Blur")
            filters.setPresetName(name: "Zoom Blur")
            filters.add(filterHolder: filterXHolder)
            presetsList.append(filters)
            filters.initNodeIndex()

            
            filters=FiltersX(context)
            filters.size=defaultThumbSize
            filters.boundsCenter=CIVector(x:filters.size.width/2.0,y:filters.size.height/2.0)
            filterXHolder=filters.getFilterWithHolder("Depth Of Field")
            filters.add(filterHolder: filterXHolder)
            filters.setPresetName(name: "Depth Of Field")
            presetsList.append(filters)
            filters.initNodeIndex()

*/
        }
        else if presetType == "Photo Effects"
        {
            var filters=FiltersX(context)
            var node=filters.add("Read Image")
            //node.readOnly=true
            //node.sticky=true
            node.size=defaultThumbSize
            
            _ = filters.add("Color Controls")
            _ = filters.add("Photo Effect Chrome")
            
            filters.setPresetName(name: "Photo Effect Chrome")
            presetsList.append(filters)

            
            filters=FiltersX(context)
            node=filters.add("Read Image")
            //node.readOnly=true
            //node.sticky=true
            node.size=defaultThumbSize
            
            _ = filters.add("Color Controls")
            _ = filters.add("Photo Effect Transfer")
            
            filters.setPresetName(name: "Photo Effect Transfer")
            presetsList.append(filters)
            
            filters=FiltersX(context)
            node=filters.add("Read Image")
            //node.readOnly=true
            //node.sticky=true
            node.size=defaultThumbSize
            
            _ = filters.add("Color Controls")
            _ = filters.add("Photo Effect Process")
            
            filters.setPresetName(name: "Photo Effect Process")
            presetsList.append(filters)
            
            /*
            var filters=FiltersX(context)
            filters.size=defaultThumbSize
            filters.boundsCenter=CIVector(x:filters.size.width/2.0,y:filters.size.height/2.0)
            var filterXHolder=filters.getFilterWithHolder("Color Controls")
            filters.add(filterHolder: filterXHolder)
            filterXHolder=filters.getFilterWithHolder("Photo Effect Chrome")
            filters.setPresetName(name: "Photo Effect Chrome")
            filters.add(filterHolder: filterXHolder)
            presetsList.append(filters)
            filters.initNodeIndex()

            filters=FiltersX(context)
            filters.size=defaultThumbSize
            filters.boundsCenter=CIVector(x:filters.size.width/2.0,y:filters.size.height/2.0)
            filterXHolder=filters.getFilterWithHolder("Color Controls")
            filters.add(filterHolder: filterXHolder)

            filterXHolder=filters.getFilterWithHolder("Photo Effect Transfer")
            filters.setPresetName(name: "Photo Effect Transfer")
            filters.add(filterHolder: filterXHolder)
            presetsList.append(filters)
            filters.initNodeIndex()

            filters=FiltersX(context)
            filters.size=defaultThumbSize
            filters.boundsCenter=CIVector(x:filters.size.width/2.0,y:filters.size.height/2.0)
            filterXHolder=filters.getFilterWithHolder("Color Controls")
            filters.add(filterHolder: filterXHolder)

            filterXHolder=filters.getFilterWithHolder("Photo Effect Process")
            filters.setPresetName(name: "Photo Effect Process")
            filters.add(filterHolder: filterXHolder)
            presetsList.append(filters)
            filters.initNodeIndex()

            filters=FiltersX(context)
            filters.size=defaultThumbSize
            filters.boundsCenter=CIVector(x:filters.size.width/2.0,y:filters.size.height/2.0)
            filterXHolder=filters.getFilterWithHolder("Color Controls")
            filters.add(filterHolder: filterXHolder)

            filterXHolder=filters.getFilterWithHolder("Photo Effect Fade")
            filters.setPresetName(name: "Photo Effect Fade")
            filters.add(filterHolder: filterXHolder)
            presetsList.append(filters)
            filters.initNodeIndex()

            filters=FiltersX(context)
            filters.size=defaultThumbSize
            filters.boundsCenter=CIVector(x:filters.size.width/2.0,y:filters.size.height/2.0)
            filterXHolder=filters.getFilterWithHolder("Color Controls")
            filters.add(filterHolder: filterXHolder)

            filterXHolder=filters.getFilterWithHolder("Photo Effect Instant")
            filters.setPresetName(name: "Photo Effect Instant")
            filters.add(filterHolder: filterXHolder)
            presetsList.append(filters)
            filters.initNodeIndex()

            filters=FiltersX(context)
            filters.size=defaultThumbSize
            filters.boundsCenter=CIVector(x:filters.size.width/2.0,y:filters.size.height/2.0)
            filterXHolder=filters.getFilterWithHolder("Color Controls")
            filters.add(filterHolder: filterXHolder)

            filterXHolder=filters.getFilterWithHolder("Photo Effect Tonal")
            filters.setPresetName(name: "Photo Effect Tonal")
            filters.add(filterHolder: filterXHolder)
            presetsList.append(filters)
            filters.initNodeIndex()

            filters=FiltersX(context)
            filters.size=defaultThumbSize
            filters.boundsCenter=CIVector(x:filters.size.width/2.0,y:filters.size.height/2.0)
            filterXHolder=filters.getFilterWithHolder("Color Controls")
            filters.add(filterHolder: filterXHolder)

            filterXHolder=filters.getFilterWithHolder("Photo Effect Mono")
            filters.setPresetName(name: "Photo Effect Mono")
            filters.add(filterHolder: filterXHolder)
            presetsList.append(filters)
            filters.initNodeIndex()

            filters=FiltersX(context)
            filters.size=defaultThumbSize
            filters.boundsCenter=CIVector(x:filters.size.width/2.0,y:filters.size.height/2.0)
            filterXHolder=filters.getFilterWithHolder("Color Controls")
            filters.add(filterHolder: filterXHolder)

            filterXHolder=filters.getFilterWithHolder("Photo Effect Noir")
            filters.setPresetName(name: "Photo Effect Noir")
            filters.add(filterHolder: filterXHolder)
            presetsList.append(filters)
            filters.initNodeIndex()
*/
        }
        
    }

   
    
    func getShortName(name: String) -> String
    {
        
        //let lowerCase = CharacterSet.lowercaseLetters
        let upperCase = CharacterSet.uppercaseLetters

        //let name = String(name.dropFirst(2))
        var firstTime = true
        var retName = String("")
        var counter=0
        var lastCapIndex=0
        for currentCharacter in name.unicodeScalars {
            
            if upperCase.contains(currentCharacter) {
                if firstTime {
                    retName = String(currentCharacter)
                    firstTime=false
                    lastCapIndex=counter
                }
                else{
                    retName = retName + "" + String(currentCharacter)
                    lastCapIndex=counter
                }
            } else {
                //print("Character code \(currentCharacter) is neither upper- nor lowercase.")
                //print("Character code \(currentCharacter) is neither upper- nor lowercase.")
                //print("Character code \(currentCharacter) is neither upper- nor lowercase.")
            }
            counter=counter+1
        }
        
        lastCapIndex=lastCapIndex+1
        if lastCapIndex < name.count
        {
            retName = retName + "" + String(name[lastCapIndex]).uppercased()
        }
        lastCapIndex=lastCapIndex+1
        if lastCapIndex < name.count
        {
            retName = retName + "" + String(name[lastCapIndex]).uppercased()
        }

        print("Short:",retName)
        return String(retName.prefix(4))
    }

}

extension String {
    subscript (index: Int) -> Character {
        let charIndex = self.index(self.startIndex, offsetBy: index)
        return self[charIndex]
    }

    subscript (range: Range<Int>) -> Substring {
        let startIndex = self.index(self.startIndex, offsetBy: range.startIndex)
        let stopIndex = self.index(self.startIndex, offsetBy: range.startIndex + range.count)
        return self[startIndex..<stopIndex]
    }

}
