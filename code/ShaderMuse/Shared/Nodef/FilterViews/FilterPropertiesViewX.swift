//
//  Copyright © 2022 James Boo. All rights reserved.
//


import SwiftUI

//Open Photo Effects
//Photo Filters & Animation

@available(iOS 15.0, *)
struct FilterPropertiesViewX: View {
    //@Environment(\.presentationMode) var presentationMode
    @Environment(\.dismiss) private var dismiss
    
    @Environment(\.verticalSizeClass) var verticalSizeClass: UserInterfaceSizeClass?
    @Environment(\.horizontalSizeClass) var horizontalSizeClass: UserInterfaceSizeClass?
    @EnvironmentObject var shapes: ShapesX
    @EnvironmentObject var appSettings: AppSettings
    @EnvironmentObject var optionSettings: OptionSettings
    @EnvironmentObject var pageSettings: PageSettings
    
    @StateObject var filterPropertiesViewModel: FilterPropertiesViewModel
    @ObservedObject var filtersPropertiesViewModel: FiltersPropertiesViewModel
    
    var parent: FiltersViewX
    
    
    //var vImage: UIImage?
    
    var body: some View {
        
        
        Form{
            /*
             Section(header: Text("Node"),footer: Text("")){
             HStack {
             Text("Node Number")
             Spacer()
             Text(String(filterPropertiesViewModel.filterXHolder.filter.nodeIndex))
             }
             }
             */
            
            Section(header: Text("Node Type"),footer: Text(filterPropertiesViewModel.filterXHolder.filter.desc)){
                
                Picker("Type", selection: $filterPropertiesViewModel.selectedFilterType) {
                    ForEach(FilterNames.GetFilterType(), id: \.self) {
                        Text($0)
                    }
                }
                .onChange(of: filterPropertiesViewModel.selectedFilterType) { newValue in
                    //need to update the pageSettings.filters instead
                    if filtersPropertiesViewModel is BackgroundFiltersPropertiesViewModel ||
                        filtersPropertiesViewModel is ImageFiltersPropertiesViewModel
                    {
                        var counter:Int = 0
                        var foundCounter:Int = 0
                        filtersPropertiesViewModel.filters.filterList.forEach
                        {
                            if $0.id==filterPropertiesViewModel.filterXHolder.id
                            {
                                foundCounter = counter
                            }
                            counter=counter+1
                        }
                        print(newValue)
                        let newFilter = pageSettings.filters.getFilterWithHolder(newValue).filter
                        
                        newFilter.inputImageAlias=filterPropertiesViewModel.filterXHolder.filter.inputImageAlias
                        
                        if newFilter is BaseBlendFX &&
                            filterPropertiesViewModel.filterXHolder.filter is  BaseBlendFX
                        {
                            newFilter.backgroundImageAlias=filterPropertiesViewModel.filterXHolder.filter.backgroundImageAlias
                        }
                        
                        if newFilter is MixFX &&
                            filterPropertiesViewModel.filterXHolder.filter is MixFX
                        {
                            newFilter.backgroundImageAlias=filterPropertiesViewModel.filterXHolder.filter.backgroundImageAlias
                        }
                        
                        if newFilter is BaseTransitionFX &&
                            filterPropertiesViewModel.filterXHolder.filter is  BaseTransitionFX
                        {
                            (newFilter as! BaseTransitionFX).targetImageAlias=(filterPropertiesViewModel.filterXHolder.filter as! BaseTransitionFX).targetImageAlias
                        }
                        
                        filterPropertiesViewModel.filterXHolder.filter=newFilter
                        
                        
                        filterPropertiesViewModel.filterXHolder.filter.setupProperties(filtersPropertiesViewModel.filters)
                        filtersPropertiesViewModel.filters.filterList[foundCounter].filter=filterPropertiesViewModel.filterXHolder.filter
                        //filtersPropertiesViewModel.filters.reassignIndex()
                        filtersPropertiesViewModel.filters.initNodeIndex()
                        
                        applyFilter() //remove together with apply causes page to go back
                    }
                    /*
                    else if filtersPropertiesViewModel is ImageFiltersPropertiesViewModel
                    {
                        //test if the same code works for b&l
                        var counter:Int = 0
                        var foundCounter:Int = 0
                        filtersPropertiesViewModel.filters.filterList.forEach
                        {
                            if $0.id==filterPropertiesViewModel.filterXHolder.id
                            {
                                foundCounter = counter
                            }
                            counter=counter+1
                        }
                        print(newValue)
                        //filterPropertiesViewModel.filterXHolder.filter=FiltersX.getFilterWithHolder(newValue).filter
                        filterPropertiesViewModel.filterXHolder.filter=pageSettings.filters.getFilterWithHolder(newValue).filter
                        //filtersPropertiesViewModel.filters.setupSizeBoundsAndCenterIfAny(filterXHolder: filterPropertiesViewModel.filterXHolder)
                        filterPropertiesViewModel.filterXHolder.filter.setupProperties(filtersPropertiesViewModel.filters)
                        
                        filtersPropertiesViewModel.filters.filterList[foundCounter].filter=filterPropertiesViewModel.filterXHolder.filter
                        filtersPropertiesViewModel.filters.reassignIndex()
                        applyFilter() //remove together with apply causes page to go back
                    }
                    */
                    
                    /*
                     self.shapes.shapeList.forEach
                     {
                     if $0.isSelected == true {
                     let selectedImage = $0 as! ImageX
                     var counter:Int = 0
                     var foundCounter:Int = 0
                     selectedImage.filters.filterList.forEach
                     {
                     if $0.id==filterPropertiesViewModel.filter.id
                     {
                     foundCounter = counter
                     }
                     counter=counter+1
                     }
                     selectedImage.filters.filterList.remove(at: foundCounter)
                     let newFX=FiltersX.getFilter(newValue)
                     selectedImage.filters.filterList.insert(newFX, at: foundCounter)
                     filterPropertiesViewModel.filter=newFX
                     filterPropertiesViewModel.filter.objectWillChange.send()
                     applyFilter()
                     }
                     }
                     */
                }
            }
            if filterPropertiesViewModel.filterXHolder.filter is ParticlesFX
            {
                ParticlesPropertiesViewX(fx:filterPropertiesViewModel.filterXHolder.filter as! ParticlesFX, parent: self)
                    .environmentObject(appSettings)
            }
            //compilation
            /*
            else if filterPropertiesViewModel.filterXHolder.filter is AnimFX
            {
                AnimPropertiesViewX(fx:filterPropertiesViewModel.filterXHolder.filter as! AnimFX, parent: self)
                    .environmentObject(appSettings)
            }
            */
            else if filterPropertiesViewModel.filterXHolder.filter is FractalFlowNoiseFX
            {
                FractalFlowNoisePropertiesViewX(
                    fx:filterPropertiesViewModel.filterXHolder.filter as! FractalFlowNoiseFX,
                    filterPropertiesViewModel:filterPropertiesViewModel,
                    filtersPropertiesViewModel:filtersPropertiesViewModel,
                    parent: self)
                .environmentObject(appSettings)
                .environmentObject(pageSettings)
            }
            /*
            else if filterPropertiesViewModel.filterXHolder.filter is AnimTex01FX
            {
                AnimTex01PropertiesViewX(fx:filterPropertiesViewModel.filterXHolder.filter as! AnimTex01FX, parent: self)
                    .environmentObject(appSettings)
            }
            else if filterPropertiesViewModel.filterXHolder.filter is AnimTex02FX
            {
                AnimTex02PropertiesViewX(fx:filterPropertiesViewModel.filterXHolder.filter as! AnimTex02FX, parent: self)
                    .environmentObject(appSettings)
            }
            else if filterPropertiesViewModel.filterXHolder.filter is AnimTex03FX
            {
                AnimTex03PropertiesViewX(fx:filterPropertiesViewModel.filterXHolder.filter as! AnimTex03FX, parent: self)
                    .environmentObject(appSettings)
            }
             */
            else if filterPropertiesViewModel.filterXHolder.filter is FBMNoiseFX
            {
                FBMNoisePropertiesViewX(fx:filterPropertiesViewModel.filterXHolder.filter as! FBMNoiseFX, parent: self)
                    .environmentObject(appSettings)
            }
            /*
            else if filterPropertiesViewModel.filterXHolder.filter is AnimTex05FX
            {
                AnimTex05PropertiesViewX(fx:filterPropertiesViewModel.filterXHolder.filter as! AnimTex05FX, parent: self)
                    .environmentObject(appSettings)
            }
            else if filterPropertiesViewModel.filterXHolder.filter is AnimTex06FX
            {
                AnimTex06PropertiesViewX(fx:filterPropertiesViewModel.filterXHolder.filter as! AnimTex06FX, parent: self)
                    .environmentObject(appSettings)
            }
            else if filterPropertiesViewModel.filterXHolder.filter is AnimTex07FX
            {
                AnimTex07PropertiesViewX(fx:filterPropertiesViewModel.filterXHolder.filter as! AnimTex07FX, parent: self)
                    .environmentObject(appSettings)
            }
            else if filterPropertiesViewModel.filterXHolder.filter is AnimTex08FX
            {
                AnimTex08PropertiesViewX(fx:filterPropertiesViewModel.filterXHolder.filter as! AnimTex08FX, parent: self)
                    .environmentObject(appSettings)
            }
            */
            else if filterPropertiesViewModel.filterXHolder.filter is ColorChannelsFX
            {
                ColorChannelsPropertiesViewX(fx:filterPropertiesViewModel.filterXHolder.filter as! ColorChannelsFX, parent: self)
                    .environmentObject(appSettings)
            }
            else if filterPropertiesViewModel.filterXHolder.filter is ReciprocalFX
            {
                ReciprocalPropertiesViewX(fx:filterPropertiesViewModel.filterXHolder.filter as! ReciprocalFX, parent: self)
                    .environmentObject(appSettings)
            }
            
            else if filterPropertiesViewModel.filterXHolder.filter is BoxBlurFX
            {
                BoxBlurPropertiesViewX(fx:filterPropertiesViewModel.filterXHolder.filter as! BoxBlurFX, parent: self)
                    .environmentObject(appSettings)
            }
            else if filterPropertiesViewModel.filterXHolder.filter is DiscBlurFX
            {
                DiscBlurPropertiesViewX(fx:filterPropertiesViewModel.filterXHolder.filter as! DiscBlurFX, parent: self)
                    .environmentObject(appSettings)
            }
            else if filterPropertiesViewModel.filterXHolder.filter is GaussianBlurFX
            {
                GaussianBlurPropertiesViewX(gaussianBlurFX:filterPropertiesViewModel.filterXHolder.filter as! GaussianBlurFX, parent: self)
                    .environmentObject(appSettings)
            }
            else if filterPropertiesViewModel.filterXHolder.filter is MaskedVariableBlurFX
            {
                MaskedVariableBlurPropertiesViewX(
                    fx:filterPropertiesViewModel.filterXHolder.filter as! MaskedVariableBlurFX,
                    filterPropertiesViewModel:filterPropertiesViewModel,
                    filtersPropertiesViewModel:filtersPropertiesViewModel,parent: self)
                .environmentObject(appSettings)
                .environmentObject(pageSettings)
            }
            else if filterPropertiesViewModel.filterXHolder.filter is MotionBlurFX
            {
                MotionBlurPropertiesViewX(fx:filterPropertiesViewModel.filterXHolder.filter as! MotionBlurFX, parent: self)
                    .environmentObject(appSettings)
            }
            else if filterPropertiesViewModel.filterXHolder.filter is NoiseReductionFX
            {
                NoiseReductionPropertiesViewX(fx:filterPropertiesViewModel.filterXHolder.filter as! NoiseReductionFX, parent: self)
                    .environmentObject(appSettings)
            }
            else if filterPropertiesViewModel.filterXHolder.filter is ZoomBlurFX
            {
                ZoomBlurPropertiesViewX(fx:filterPropertiesViewModel.filterXHolder.filter as! ZoomBlurFX, parent: self)
                    .environmentObject(appSettings)
            }
            
            
            
            else if filterPropertiesViewModel.filterXHolder.filter is ColorClampFX
            {
                ColorClampPropertiesViewX(fx:filterPropertiesViewModel.filterXHolder.filter as! ColorClampFX, parent: self)
                    .environmentObject(appSettings)
            }
            else if filterPropertiesViewModel.filterXHolder.filter is ReadImageFX
            {
                ImageTransformPropertiesViewX(fx:filterPropertiesViewModel.filterXHolder.filter as! ReadImageFX, parent: self)
                    .environmentObject(appSettings)
            }
            else if filterPropertiesViewModel.filterXHolder.filter is ColorControlsFX
            {
                ColorControlsPropertiesViewX(colorControlsFX:filterPropertiesViewModel.filterXHolder.filter as! ColorControlsFX, parent: self)
                    .environmentObject(appSettings)
            }
            else if filterPropertiesViewModel.filterXHolder.filter is ColorMatrixFX
            {
                ColorMatrixPropertiesViewX(fx:filterPropertiesViewModel.filterXHolder.filter as! ColorMatrixFX, parent: self)
                    .environmentObject(appSettings)
            }
            
            else if filterPropertiesViewModel.filterXHolder.filter is ColorPolynomialFX
            {
                ColorPolynomialPropertiesViewX(fx:filterPropertiesViewModel.filterXHolder.filter as! ColorPolynomialFX, parent: self)
                    .environmentObject(appSettings)
            }
            else if filterPropertiesViewModel.filterXHolder.filter is ExposureAdjustFX
            {
                ExposureAdjustPropertiesViewX(fx:filterPropertiesViewModel.filterXHolder.filter as! ExposureAdjustFX, parent: self)
                    .environmentObject(appSettings)
            }
            else if filterPropertiesViewModel.filterXHolder.filter is GammaAdjustFX
            {
                GammaAdjustPropertiesViewX(fx:filterPropertiesViewModel.filterXHolder.filter as! GammaAdjustFX, parent: self)
                    .environmentObject(appSettings)
            }
            else if filterPropertiesViewModel.filterXHolder.filter is HueAdjustFX
            {
                HueAdjustPropertiesViewX(fx:filterPropertiesViewModel.filterXHolder.filter as! HueAdjustFX, parent: self)
                    .environmentObject(appSettings)
            }
            else if filterPropertiesViewModel.filterXHolder.filter is TemperatureAndTintFX
            {
                TemperatureAndTintPropertiesViewX(fx:filterPropertiesViewModel.filterXHolder.filter as! TemperatureAndTintFX, parent: self)
                    .environmentObject(appSettings)
            }
            else if filterPropertiesViewModel.filterXHolder.filter is ToneCurveFX
            {
                ToneCurvePropertiesViewX(fx:filterPropertiesViewModel.filterXHolder.filter as! ToneCurveFX, parent: self)
                    .environmentObject(appSettings)
            }
            else if filterPropertiesViewModel.filterXHolder.filter is VibranceFX
            {
                VibrancePropertiesViewX(fx:filterPropertiesViewModel.filterXHolder.filter as! VibranceFX, parent: self)
                    .environmentObject(appSettings)
            }
            else if filterPropertiesViewModel.filterXHolder.filter is WhitePointAdjustFX
            {
                WhitePointPropertiesViewX(fx:filterPropertiesViewModel.filterXHolder.filter as! WhitePointAdjustFX, parent: self)
                    .environmentObject(appSettings)
            }
            
            
            
            //ColorEffect
            else if filterPropertiesViewModel.filterXHolder.filter is ColorCubeFX
            {
                ColorCubePropertiesViewX(fx:filterPropertiesViewModel.filterXHolder.filter as! ColorCubeFX, parent: self)
                    .environmentObject(appSettings)
            }
            else if filterPropertiesViewModel.filterXHolder.filter is ColorCubeWithColorSpaceFX
            {
                ColorCubeWithColorSpacePropertiesViewX(fx:filterPropertiesViewModel.filterXHolder.filter as! ColorCubeWithColorSpaceFX, parent: self)
                    .environmentObject(appSettings)
            }
            else if filterPropertiesViewModel.filterXHolder.filter is ColorMapFX
            {
                ColorMapPropertiesViewX(fx:filterPropertiesViewModel.filterXHolder.filter as! ColorMapFX, parent: self)
                    .environmentObject(appSettings)
            }
            
            else if filterPropertiesViewModel.filterXHolder.filter is ColorCrossPolynomialFX
            {
                ColorCrossPolynomialPropertiesViewX(fx:filterPropertiesViewModel.filterXHolder.filter as! ColorCrossPolynomialFX, parent: self)
                    .environmentObject(appSettings)
            }
            else if filterPropertiesViewModel.filterXHolder.filter is ColorMonochromeFX
            {
                ColorMonochromePropertiesViewX(fx:filterPropertiesViewModel.filterXHolder.filter as! ColorMonochromeFX, parent: self)
                    .environmentObject(appSettings)
            }
            else if filterPropertiesViewModel.filterXHolder.filter is ColorPosterizeFX
            {
                ColorPosterizePropertiesViewX(fx:filterPropertiesViewModel.filterXHolder.filter as! ColorPosterizeFX, parent: self)
                    .environmentObject(appSettings)
            }
            else if filterPropertiesViewModel.filterXHolder.filter is FalseColorFX
            {
                FalseColorPropertiesViewX(fx:filterPropertiesViewModel.filterXHolder.filter as! FalseColorFX, parent: self)
                    .environmentObject(appSettings)
            }
            else if filterPropertiesViewModel.filterXHolder.filter is SepiaToneFX
            {
                SepiaTonePropertiesViewX(fx:filterPropertiesViewModel.filterXHolder.filter as! SepiaToneFX, parent: self)
                    .environmentObject(appSettings)
            }
            else if filterPropertiesViewModel.filterXHolder.filter is VignetteFX
            {
                VignettePropertiesViewX(fx:filterPropertiesViewModel.filterXHolder.filter as! VignetteFX, parent: self)
                    .environmentObject(appSettings)
            }
            else if filterPropertiesViewModel.filterXHolder.filter is VignetteEffectFX
            {
                VignetteEffectPropertiesViewX(fx:filterPropertiesViewModel.filterXHolder.filter as! VignetteEffectFX, parent: self)
                    .environmentObject(appSettings)
            }
            
            //Distortion
            else if filterPropertiesViewModel.filterXHolder.filter is DrosteFX
            {
                DrostePropertiesViewX(fx:filterPropertiesViewModel.filterXHolder.filter as! DrosteFX,parent: self)
                    .environmentObject(appSettings)
            }
            
            else if filterPropertiesViewModel.filterXHolder.filter is DisplacementDistortionFX
            {
                DisplacementDistortionPropertiesViewX(
                    fx:filterPropertiesViewModel.filterXHolder.filter as! DisplacementDistortionFX,
                    filterPropertiesViewModel:filterPropertiesViewModel,
                    filtersPropertiesViewModel:filtersPropertiesViewModel,parent: self)
                .environmentObject(appSettings)
                .environmentObject(pageSettings)
            }
            
            else if filterPropertiesViewModel.filterXHolder.filter is GlassDistortionFX
            {
                GlassDistortionPropertiesViewX(
                    fx:filterPropertiesViewModel.filterXHolder.filter as! GlassDistortionFX,
                    filterPropertiesViewModel:filterPropertiesViewModel,
                    filtersPropertiesViewModel:filtersPropertiesViewModel,parent: self)
                .environmentObject(appSettings)
                .environmentObject(pageSettings)
            }
            
            else if filterPropertiesViewModel.filterXHolder.filter is GlassLozengeFX
            {
                GlassLozengePropertiesViewX(fx:filterPropertiesViewModel.filterXHolder.filter as! GlassLozengeFX,parent: self)
                    .environmentObject(appSettings)
            }
            else if filterPropertiesViewModel.filterXHolder.filter is StretchCropFX
            {
                StretchCropPropertiesViewX(fx:filterPropertiesViewModel.filterXHolder.filter as! StretchCropFX,parent: self)
                    .environmentObject(appSettings)
            }
            
            
            
            else if filterPropertiesViewModel.filterXHolder.filter is BumpDistortionFX
            {
                BumpDistortionPropertiesViewX(fx:filterPropertiesViewModel.filterXHolder.filter as! BumpDistortionFX,parent: self)
                    .environmentObject(appSettings)
            }
            else if filterPropertiesViewModel.filterXHolder.filter is BumpDistortionLinearFX
            {
                BumpDistortionLinearPropertiesViewX(fx:filterPropertiesViewModel.filterXHolder.filter as! BumpDistortionLinearFX,parent: self)
                    .environmentObject(appSettings)
            }
            else if filterPropertiesViewModel.filterXHolder.filter is CircularWrapFX
            {
                CircularWrapPropertiesViewX(fx:filterPropertiesViewModel.filterXHolder.filter as! CircularWrapFX,parent: self)
                    .environmentObject(appSettings)
            }
            else if filterPropertiesViewModel.filterXHolder.filter is CircleSplashDistortionFX
            {
                CircleSplashDistortionPropertiesViewX(fx:filterPropertiesViewModel.filterXHolder.filter as! CircleSplashDistortionFX,parent: self)
                    .environmentObject(appSettings)
            }
            else if filterPropertiesViewModel.filterXHolder.filter is LightTunnelFX
            {
                LightTunnelPropertiesViewX(fx:filterPropertiesViewModel.filterXHolder.filter as! LightTunnelFX,parent: self)
                    .environmentObject(appSettings)
            }
            else if filterPropertiesViewModel.filterXHolder.filter is HoleDistortionFX
            {
                HoleDistortionPropertiesViewX(fx:filterPropertiesViewModel.filterXHolder.filter as! HoleDistortionFX,parent: self)
                    .environmentObject(appSettings)
            }
            else if filterPropertiesViewModel.filterXHolder.filter is PinchDistortionFX
            {
                PinchDistortionPropertiesViewX(fx:filterPropertiesViewModel.filterXHolder.filter as! PinchDistortionFX,parent: self)
                    .environmentObject(appSettings)
            }
            else if filterPropertiesViewModel.filterXHolder.filter is TorusLensDistortionFX
            {
                TorusLensDistortionPropertiesViewX(fx:filterPropertiesViewModel.filterXHolder.filter as! TorusLensDistortionFX,parent: self)
                    .environmentObject(appSettings)
            }
            else if filterPropertiesViewModel.filterXHolder.filter is TwirlDistortionFX
            {
                TwirlDistortionPropertiesViewX(fx:filterPropertiesViewModel.filterXHolder.filter as! TwirlDistortionFX,parent: self)
                    .environmentObject(appSettings)
            }
            else if filterPropertiesViewModel.filterXHolder.filter is VortexDistortionFX
            {
                VortexDistortionPropertiesViewX(fx:filterPropertiesViewModel.filterXHolder.filter as! VortexDistortionFX,parent: self)
                    .environmentObject(appSettings)
            }
            
            //Generator
            else if filterPropertiesViewModel.filterXHolder.filter is AztecCodeGeneratorFX
            {
                AztecCodeGeneratorPropertiesViewX(fx:filterPropertiesViewModel.filterXHolder.filter as! AztecCodeGeneratorFX,parent: self)
                    .environmentObject(appSettings)
            }
            else if filterPropertiesViewModel.filterXHolder.filter is PDF417BarcodeGeneratorFX
            {
                PDF417BarcodeGeneratorPropertiesViewX(fx:filterPropertiesViewModel.filterXHolder.filter as! PDF417BarcodeGeneratorFX,parent: self)
                    .environmentObject(appSettings)
            }
            else if filterPropertiesViewModel.filterXHolder.filter is ConstantColorGeneratorFX
            {
                ConstantColorGeneratorPropertiesViewX(fx:filterPropertiesViewModel.filterXHolder.filter as! ConstantColorGeneratorFX,parent: self)
                    .environmentObject(appSettings)
            }
            else if filterPropertiesViewModel.filterXHolder.filter is CheckerboardGeneratorFX
            {
                CheckerboardGeneratorPropertiesViewX(fx:filterPropertiesViewModel.filterXHolder.filter as! CheckerboardGeneratorFX,parent: self)
                    .environmentObject(appSettings)
            }
            else if filterPropertiesViewModel.filterXHolder.filter is StripesGeneratorFX
            {
                StripesGeneratorPropertiesViewX(fx:filterPropertiesViewModel.filterXHolder.filter as! StripesGeneratorFX,parent: self)
                    .environmentObject(appSettings)
            }
            else if filterPropertiesViewModel.filterXHolder.filter is LenticularHaloGeneratorFX
            {
                LenticularHaloGeneratorPropertiesViewX(fx:filterPropertiesViewModel.filterXHolder.filter as! LenticularHaloGeneratorFX,parent: self)
                    .environmentObject(appSettings)
            }
            else if filterPropertiesViewModel.filterXHolder.filter is RoundedRectangleGeneratorFX
            {
                RoundedRectangleGeneratorPropertiesViewX(fx:filterPropertiesViewModel.filterXHolder.filter as! RoundedRectangleGeneratorFX,parent: self)
                    .environmentObject(appSettings)
            }
            else if filterPropertiesViewModel.filterXHolder.filter is CircleGeneratorFX
            {
                CircleGeneratorPropertiesViewX(fx:filterPropertiesViewModel.filterXHolder.filter as! CircleGeneratorFX,parent: self)
                    .environmentObject(appSettings)
            }
            else if filterPropertiesViewModel.filterXHolder.filter is StarShineGeneratorFX
            {
                StarShineGeneratorPropertiesViewX(fx:filterPropertiesViewModel.filterXHolder.filter as! StarShineGeneratorFX,parent: self)
                    .environmentObject(appSettings)
            }
            else if filterPropertiesViewModel.filterXHolder.filter is SunbeamsGeneratorFX
            {
                SunbeamsGeneratorPropertiesViewX(fx:filterPropertiesViewModel.filterXHolder.filter as! SunbeamsGeneratorFX,parent: self)
                    .environmentObject(appSettings)
            }
            else if filterPropertiesViewModel.filterXHolder.filter is QRCodeGeneratorFX
            {
                QRCodeGeneratorPropertiesViewX(fx:filterPropertiesViewModel.filterXHolder.filter as! QRCodeGeneratorFX,parent: self)
                    .environmentObject(appSettings)
            }
            else if filterPropertiesViewModel.filterXHolder.filter is Code128BarcodeGeneratorFX
            {
                Code128BarcodeGeneratorPropertiesViewX(fx:filterPropertiesViewModel.filterXHolder.filter as! Code128BarcodeGeneratorFX,parent: self)
                    .environmentObject(appSettings)
            }
            else if filterPropertiesViewModel.filterXHolder.filter is TextImageGeneratorFX
            {
                TextImageGeneratorPropertiesViewX(fx:filterPropertiesViewModel.filterXHolder.filter as! TextImageGeneratorFX,parent: self)
                    .environmentObject(appSettings)
            }
            
            //Geometry Adjustment            
            else if filterPropertiesViewModel.filterXHolder.filter is TranslateFX
            {
                TranslatePropertiesViewX(fx:filterPropertiesViewModel.filterXHolder.filter as! TranslateFX,parent: self)
                    .environmentObject(appSettings)
            }
            else if filterPropertiesViewModel.filterXHolder.filter is RotateFX
            {
                RotatePropertiesViewX(fx:filterPropertiesViewModel.filterXHolder.filter as! RotateFX,parent: self)
                    .environmentObject(appSettings)
            }
            else if filterPropertiesViewModel.filterXHolder.filter is ScaleFX
            {
                ScalePropertiesViewX(fx:filterPropertiesViewModel.filterXHolder.filter as! ScaleFX,parent: self)
                    .environmentObject(appSettings)
            }
            else if filterPropertiesViewModel.filterXHolder.filter is RotateFX
            {
                RotatePropertiesViewX(fx:filterPropertiesViewModel.filterXHolder.filter as! RotateFX,parent: self)
                    .environmentObject(appSettings)
            }
            else if filterPropertiesViewModel.filterXHolder.filter is OpacityFX
            {
                OpacityPropertiesViewX(fx:filterPropertiesViewModel.filterXHolder.filter as! OpacityFX,parent: self)
                    .environmentObject(appSettings)
            }
            else if filterPropertiesViewModel.filterXHolder.filter is MixFX
            {
                MixPropertiesViewX(fx:filterPropertiesViewModel.filterXHolder.filter as! MixFX,parent: self)
                    .environmentObject(appSettings)
            }
            
            else if filterPropertiesViewModel.filterXHolder.filter is AffineTransformFX
            {
                AffineTransformPropertiesViewX(fx:filterPropertiesViewModel.filterXHolder.filter as! AffineTransformFX,parent: self)
                    .environmentObject(appSettings)
            }
            else if filterPropertiesViewModel.filterXHolder.filter is CropFX
            {
                CropPropertiesViewX(fx:filterPropertiesViewModel.filterXHolder.filter as! CropFX,parent: self)
                    .environmentObject(appSettings)
            }
            else if filterPropertiesViewModel.filterXHolder.filter is LanczosScaleTransformFX
            {
                LanczosScaleTransformPropertiesViewX(fx:filterPropertiesViewModel.filterXHolder.filter as! LanczosScaleTransformFX,parent: self)
                    .environmentObject(appSettings)
            }
            else if filterPropertiesViewModel.filterXHolder.filter is PerspectiveCorrectionFX
            {
                PerspectiveCorrectionPropertiesViewX(fx:filterPropertiesViewModel.filterXHolder.filter as! PerspectiveCorrectionFX,parent: self)
                    .environmentObject(appSettings)
            }
            else if filterPropertiesViewModel.filterXHolder.filter is PerspectiveTransformFX
            {
                PerspectiveTransformPropertiesViewX(fx:filterPropertiesViewModel.filterXHolder.filter as! PerspectiveTransformFX,parent: self)
                    .environmentObject(appSettings)
            }
            else if filterPropertiesViewModel.filterXHolder.filter is PerspectiveTransformWithExtentFX
            {
                PerspectiveTransformWithExtentPropertiesViewX(fx:filterPropertiesViewModel.filterXHolder.filter as! PerspectiveTransformWithExtentFX,parent: self)
                    .environmentObject(appSettings)
            }
            else if filterPropertiesViewModel.filterXHolder.filter is StraightenFilterFX
            {
                StraightenFilterPropertiesViewX(fx:filterPropertiesViewModel.filterXHolder.filter as! StraightenFilterFX,parent: self)
                    .environmentObject(appSettings)
            }
            
            
            else if filterPropertiesViewModel.filterXHolder.filter is GaussianGradientFX
            {
                GaussianGradientPropertiesViewX(fx:filterPropertiesViewModel.filterXHolder.filter as! GaussianGradientFX,parent: self)
                    .environmentObject(appSettings)
            }
            else if filterPropertiesViewModel.filterXHolder.filter is LinearGradientFX
            {
                LinearGradientPropertiesViewX(fx:filterPropertiesViewModel.filterXHolder.filter as! LinearGradientFX,parent: self)
                    .environmentObject(appSettings)
            }
            else if filterPropertiesViewModel.filterXHolder.filter is RadialGradientFX
            {
                RadialGradientPropertiesViewX(fx:filterPropertiesViewModel.filterXHolder.filter as! RadialGradientFX,parent: self)
                    .environmentObject(appSettings)
            }
            else if filterPropertiesViewModel.filterXHolder.filter is SmoothLinearGradientFX
            {
                SmoothLinearGradientPropertiesViewX(fx:filterPropertiesViewModel.filterXHolder.filter as! SmoothLinearGradientFX,parent: self)
                    .environmentObject(appSettings)
            }
            else if filterPropertiesViewModel.filterXHolder.filter is SinusoidalGradientFX
            {
                SinusoidalGradientPropertiesViewX(fx:filterPropertiesViewModel.filterXHolder.filter as! SinusoidalGradientFX,parent: self)
                    .environmentObject(appSettings)
            }
            
            else if filterPropertiesViewModel.filterXHolder.filter is CircularScreenFX
            {
                CircularScreenPropertiesViewX(fx:filterPropertiesViewModel.filterXHolder.filter as! CircularScreenFX,parent: self)
                    .environmentObject(appSettings)
            }
            else if filterPropertiesViewModel.filterXHolder.filter is DotScreenFX
            {
                DotScreenPropertiesViewX(fx:filterPropertiesViewModel.filterXHolder.filter as! DotScreenFX,parent: self)
                    .environmentObject(appSettings)
            }
            else if filterPropertiesViewModel.filterXHolder.filter is HatchedScreenFX
            {
                HatchedScreenPropertiesViewX(fx:filterPropertiesViewModel.filterXHolder.filter as! HatchedScreenFX,parent: self)
                    .environmentObject(appSettings)
            }
            else if filterPropertiesViewModel.filterXHolder.filter is LineScreenFX
            {
                LineScreenPropertiesViewX(fx:filterPropertiesViewModel.filterXHolder.filter as! LineScreenFX,parent: self)
                    .environmentObject(appSettings)
            }
            else if filterPropertiesViewModel.filterXHolder.filter is CMYKHalftoneFX
            {
                CMYKHalftonePropertiesViewX(fx:filterPropertiesViewModel.filterXHolder.filter as! CMYKHalftoneFX,parent: self)
                    .environmentObject(appSettings)
            }
            
            //Reduction
            else if filterPropertiesViewModel.filterXHolder.filter is AreaAverageFX
            {
                AreaAveragePropertiesViewX(fx:filterPropertiesViewModel.filterXHolder.filter as! AreaAverageFX,parent: self)
                    .environmentObject(appSettings)
            }
            else if filterPropertiesViewModel.filterXHolder.filter is AreaHistogramFX
            {
                AreaHistogramPropertiesViewX(fx:filterPropertiesViewModel.filterXHolder.filter as! AreaHistogramFX,parent: self)
                    .environmentObject(appSettings)
            }
            else if filterPropertiesViewModel.filterXHolder.filter is RowAverageFX
            {
                RowAveragePropertiesViewX(fx:filterPropertiesViewModel.filterXHolder.filter as! RowAverageFX,parent: self)
                    .environmentObject(appSettings)
            }
            else if filterPropertiesViewModel.filterXHolder.filter is ColumnAverageFX
            {
                ColumnAveragePropertiesViewX(fx:filterPropertiesViewModel.filterXHolder.filter as! ColumnAverageFX,parent: self)
                    .environmentObject(appSettings)
            }
            else if filterPropertiesViewModel.filterXHolder.filter is HistogramDisplayFilterFX
            {
                HistogramDisplayFilterPropertiesViewX(fx:filterPropertiesViewModel.filterXHolder.filter as! HistogramDisplayFilterFX,parent: self)
                    .environmentObject(appSettings)
            }
            else if filterPropertiesViewModel.filterXHolder.filter is AreaMaximumFX
            {
                AreaMaximumPropertiesViewX(fx:filterPropertiesViewModel.filterXHolder.filter as! AreaMaximumFX,parent: self)
                    .environmentObject(appSettings)
            }
            else if filterPropertiesViewModel.filterXHolder.filter is AreaMaximumAlphaFX
            {
                AreaMaximumAlphaPropertiesViewX(fx:filterPropertiesViewModel.filterXHolder.filter as! AreaMaximumAlphaFX,parent: self)
                    .environmentObject(appSettings)
            }
            else if filterPropertiesViewModel.filterXHolder.filter is AreaMinimumFX
            {
                AreaMinimumPropertiesViewX(fx:filterPropertiesViewModel.filterXHolder.filter as! AreaMinimumFX,parent: self)
                    .environmentObject(appSettings)
            }
            else if filterPropertiesViewModel.filterXHolder.filter is AreaMinimumAlphaFX
            {
                AreaMinimumAlphaPropertiesViewX(fx:filterPropertiesViewModel.filterXHolder.filter as! AreaMinimumAlphaFX,parent: self)
                    .environmentObject(appSettings)
            }
            
            //Sharpen
            else if filterPropertiesViewModel.filterXHolder.filter is SharpenLuminanceFX
            {
                SharpenLuminancePropertiesViewX(fx:filterPropertiesViewModel.filterXHolder.filter as! SharpenLuminanceFX,parent: self)
                    .environmentObject(appSettings)
            }
            else if filterPropertiesViewModel.filterXHolder.filter is UnsharpMaskFX
            {
                UnsharpMaskPropertiesViewX(fx:filterPropertiesViewModel.filterXHolder.filter as! UnsharpMaskFX,parent: self)
                    .environmentObject(appSettings)
            }
            
            //stylize
            else if filterPropertiesViewModel.filterXHolder.filter is Convolution3X3FX
            {
                Convolution3X3PropertiesViewX(fx:filterPropertiesViewModel.filterXHolder.filter as! Convolution3X3FX,parent: self)
                    .environmentObject(appSettings)
            }
            else if filterPropertiesViewModel.filterXHolder.filter is Convolution5X5FX
            {
                Convolution5X5PropertiesViewX(fx:filterPropertiesViewModel.filterXHolder.filter as! Convolution5X5FX,parent: self)
                    .environmentObject(appSettings)
            }
            else if filterPropertiesViewModel.filterXHolder.filter is Convolution7X7FX
            {
                Convolution7X7PropertiesViewX(fx:filterPropertiesViewModel.filterXHolder.filter as! Convolution7X7FX,parent: self)
                    .environmentObject(appSettings)
            }
            else if filterPropertiesViewModel.filterXHolder.filter is Convolution9HorizontalFX
            {
                Convolution9HorizontalPropertiesViewX(fx:filterPropertiesViewModel.filterXHolder.filter as! Convolution9HorizontalFX,parent: self)
                    .environmentObject(appSettings)
            }
            else if filterPropertiesViewModel.filterXHolder.filter is Convolution9VerticalFX
            {
                Convolution9VerticalPropertiesViewX(fx:filterPropertiesViewModel.filterXHolder.filter as! Convolution9VerticalFX,parent: self)
                    .environmentObject(appSettings)
            }
            else if filterPropertiesViewModel.filterXHolder.filter is DepthOfFieldFX
            {
                DepthOfFieldPropertiesViewX(fx:filterPropertiesViewModel.filterXHolder.filter as! DepthOfFieldFX,parent: self)
                    .environmentObject(appSettings)
            }
            else if filterPropertiesViewModel.filterXHolder.filter is HeightFieldFromMaskFX
            {
                HeightFieldFromMaskPropertiesViewX(fx:filterPropertiesViewModel.filterXHolder.filter as! HeightFieldFromMaskFX,parent: self)
                    .environmentObject(appSettings)
            }
            else if filterPropertiesViewModel.filterXHolder.filter is LineOverlayFX
            {
                LineOverlayPropertiesViewX(fx:filterPropertiesViewModel.filterXHolder.filter as! LineOverlayFX,parent: self)
                    .environmentObject(appSettings)
            }
            else if filterPropertiesViewModel.filterXHolder.filter is ShadedMaterialFX
            {
                ShadedMaterialPropertiesViewX(
                    fx:filterPropertiesViewModel.filterXHolder.filter as! ShadedMaterialFX,
                    filterPropertiesViewModel:filterPropertiesViewModel,
                    filtersPropertiesViewModel:filtersPropertiesViewModel,
                    parent: self)
                .environmentObject(appSettings)
                .environmentObject(pageSettings)
            }
            else if filterPropertiesViewModel.filterXHolder.filter is SpotColorFX
            {
                SpotColorPropertiesViewX(fx:filterPropertiesViewModel.filterXHolder.filter as! SpotColorFX,parent: self)
                    .environmentObject(appSettings)
            }
            else if filterPropertiesViewModel.filterXHolder.filter is SpotLightFX
            {
                SpotLightPropertiesViewX(fx:filterPropertiesViewModel.filterXHolder.filter as! SpotLightFX,parent: self)
                    .environmentObject(appSettings)
            }
            else if filterPropertiesViewModel.filterXHolder.filter is BloomFX
            {
                BloomPropertiesViewX(fx:filterPropertiesViewModel.filterXHolder.filter as! BloomFX,parent: self)
                    .environmentObject(appSettings)
            }
            else if filterPropertiesViewModel.filterXHolder.filter is CrystallizeFX
            {
                CrystallizePropertiesViewX(fx:filterPropertiesViewModel.filterXHolder.filter as! CrystallizeFX,parent: self)
                    .environmentObject(appSettings)
            }
            else if filterPropertiesViewModel.filterXHolder.filter is EdgesFX
            {
                EdgesPropertiesViewX(fx:filterPropertiesViewModel.filterXHolder.filter as! EdgesFX,parent: self)
                    .environmentObject(appSettings)
            }
            else if filterPropertiesViewModel.filterXHolder.filter is EdgeWorkFX
            {
                EdgeWorkPropertiesViewX(fx:filterPropertiesViewModel.filterXHolder.filter as! EdgeWorkFX,parent: self)
                    .environmentObject(appSettings)
            }
            else if filterPropertiesViewModel.filterXHolder.filter is GloomFX
            {
                GloomPropertiesViewX(fx:filterPropertiesViewModel.filterXHolder.filter as! GloomFX,parent: self)
                    .environmentObject(appSettings)
            }
            else if filterPropertiesViewModel.filterXHolder.filter is PixellateFX
            {
                PixellatePropertiesViewX(fx:filterPropertiesViewModel.filterXHolder.filter as! PixellateFX,parent: self)
                    .environmentObject(appSettings)
            }
            else if filterPropertiesViewModel.filterXHolder.filter is PointillizeFX
            {
                PointillizePropertiesViewX(fx:filterPropertiesViewModel.filterXHolder.filter as! PointillizeFX,parent: self)
                    .environmentObject(appSettings)
            }
            else if filterPropertiesViewModel.filterXHolder.filter is HexagonalPixellateFX
            {
                HexagonalPixellatePropertiesViewX(fx:filterPropertiesViewModel.filterXHolder.filter as! HexagonalPixellateFX,parent: self)
                    .environmentObject(appSettings)
            }
            else if filterPropertiesViewModel.filterXHolder.filter is HighlightShadowAdjustFX
            {
                HighlightShadowAdjustPropertiesViewX(fx:filterPropertiesViewModel.filterXHolder.filter as! HighlightShadowAdjustFX,parent: self)
                    .environmentObject(appSettings)
            }
            else if filterPropertiesViewModel.filterXHolder.filter is BlendWithMaskFX
            {
                BlendWithMaskPropertiesViewX(
                    fx:filterPropertiesViewModel.filterXHolder.filter as! BlendWithMaskFX,
                    filterPropertiesViewModel:filterPropertiesViewModel,
                    filtersPropertiesViewModel:filtersPropertiesViewModel,
                    parent: self)
                .environmentObject(appSettings)
                .environmentObject(pageSettings)
            }
            else if filterPropertiesViewModel.filterXHolder.filter is BlendWithAlphaMaskFX
            {
                BlendWithAlphaMaskPropertiesViewX(
                    fx:filterPropertiesViewModel.filterXHolder.filter as! BlendWithAlphaMaskFX,
                    filterPropertiesViewModel:filterPropertiesViewModel,
                    filtersPropertiesViewModel:filtersPropertiesViewModel,
                    parent: self)
                .environmentObject(appSettings)
                .environmentObject(pageSettings)
            }
            
            //Tile
            else if filterPropertiesViewModel.filterXHolder.filter is AffineClampFX
            {
                AffineClampPropertiesViewX(fx:filterPropertiesViewModel.filterXHolder.filter as! AffineClampFX,parent: self)
                    .environmentObject(appSettings)
            }
            else if filterPropertiesViewModel.filterXHolder.filter is AffineTileFX
            {
                AffineTilePropertiesViewX(fx:filterPropertiesViewModel.filterXHolder.filter as! AffineTileFX,parent: self)
                    .environmentObject(appSettings)
            }
            else if filterPropertiesViewModel.filterXHolder.filter is EightfoldReflectedTileFX
            {
                EightfoldReflectedTilePropertiesViewX(fx:filterPropertiesViewModel.filterXHolder.filter as! EightfoldReflectedTileFX,parent: self)
                    .environmentObject(appSettings)
            }
            else if filterPropertiesViewModel.filterXHolder.filter is TriangleTileFX
            {
                TriangleTilePropertiesViewX(fx:filterPropertiesViewModel.filterXHolder.filter as! TriangleTileFX,parent: self)
                    .environmentObject(appSettings)
            }
            else if filterPropertiesViewModel.filterXHolder.filter is TwelvefoldReflectedTileFX
            {
                TwelvefoldReflectedTilePropertiesViewX(fx:filterPropertiesViewModel.filterXHolder.filter as! TwelvefoldReflectedTileFX,parent: self)
                    .environmentObject(appSettings)
            }
            else if filterPropertiesViewModel.filterXHolder.filter is SixfoldReflectedTileFX
            {
                SixfoldReflectedTilePropertiesViewX(fx:filterPropertiesViewModel.filterXHolder.filter as! SixfoldReflectedTileFX,parent: self)
                    .environmentObject(appSettings)
            }
            else if filterPropertiesViewModel.filterXHolder.filter is SixfoldRotatedTileFX
            {
                SixfoldRotatedTilePropertiesViewX(fx:filterPropertiesViewModel.filterXHolder.filter as! SixfoldRotatedTileFX,parent: self)
                    .environmentObject(appSettings)
            }
            else if filterPropertiesViewModel.filterXHolder.filter is OpTileFX
            {
                OpTilePropertiesViewX(fx:filterPropertiesViewModel.filterXHolder.filter as! OpTileFX,parent: self)
                    .environmentObject(appSettings)
            }
            else if filterPropertiesViewModel.filterXHolder.filter is GlideReflectedTileFX
            {
                GlideReflectedTilePropertiesViewX(fx:filterPropertiesViewModel.filterXHolder.filter as! GlideReflectedTileFX,parent: self)
                    .environmentObject(appSettings)
            }
            else if filterPropertiesViewModel.filterXHolder.filter is KaleidoscopeFX
            {
                KaleidoscopePropertiesViewX(fx:filterPropertiesViewModel.filterXHolder.filter as! KaleidoscopeFX,parent: self)
                    .environmentObject(appSettings)
            }
            else if filterPropertiesViewModel.filterXHolder.filter is TriangleKaleidoscopeFX
            {
                TriangleKaleidoscopePropertiesViewX(fx:filterPropertiesViewModel.filterXHolder.filter as! TriangleKaleidoscopeFX,parent: self)
                    .environmentObject(appSettings)
            }
            else if filterPropertiesViewModel.filterXHolder.filter is FourfoldRotatedTileFX
            {
                FourfoldRotatedTilePropertiesViewX(fx:filterPropertiesViewModel.filterXHolder.filter as! FourfoldRotatedTileFX,parent: self)
                    .environmentObject(appSettings)
            }
            else if filterPropertiesViewModel.filterXHolder.filter is FourfoldReflectedTileFX
            {
                FourfoldReflectedTilePropertiesViewX(fx:filterPropertiesViewModel.filterXHolder.filter as! FourfoldReflectedTileFX,parent: self)
                    .environmentObject(appSettings)
            }
            else if filterPropertiesViewModel.filterXHolder.filter is ParallelogramTileFX
            {
                ParallelogramTilePropertiesViewX(fx:filterPropertiesViewModel.filterXHolder.filter as! ParallelogramTileFX,parent: self)
                    .environmentObject(appSettings)
            }
            else if filterPropertiesViewModel.filterXHolder.filter is PerspectiveTileFX
            {
                PerspectiveTilePropertiesViewX(fx:filterPropertiesViewModel.filterXHolder.filter as! PerspectiveTileFX,parent: self)
                    .environmentObject(appSettings)
            }
            else if filterPropertiesViewModel.filterXHolder.filter is FourfoldTranslatedTileFX
            {
                FourfoldTranslatedTilePropertiesViewX(fx:filterPropertiesViewModel.filterXHolder.filter as! FourfoldTranslatedTileFX,parent: self)
                    .environmentObject(appSettings)
            }
            
            //Transition
            else if filterPropertiesViewModel.filterXHolder.filter is AccordionFoldTransitionFX
            {
                AccordionFoldTransitionPropertiesViewX(
                    fx:filterPropertiesViewModel.filterXHolder.filter as! AccordionFoldTransitionFX,
                    filterPropertiesViewModel:filterPropertiesViewModel,
                    filtersPropertiesViewModel:filtersPropertiesViewModel,
                    parent: self)
                .environmentObject(appSettings)
                .environmentObject(pageSettings)
            }
            else if filterPropertiesViewModel.filterXHolder.filter is BarsSwipeTransitionFX
            {
                BarsSwipeTransitionPropertiesViewX(
                    fx:filterPropertiesViewModel.filterXHolder.filter as! BarsSwipeTransitionFX,
                    filterPropertiesViewModel:filterPropertiesViewModel,
                    filtersPropertiesViewModel:filtersPropertiesViewModel,
                    parent: self)
                .environmentObject(appSettings)
                .environmentObject(pageSettings)
            }
            else if filterPropertiesViewModel.filterXHolder.filter is DissolveTransitionFX
            {
                DissolveTransitionPropertiesViewX(
                    fx:filterPropertiesViewModel.filterXHolder.filter as! DissolveTransitionFX,
                    filterPropertiesViewModel:filterPropertiesViewModel,
                    filtersPropertiesViewModel:filtersPropertiesViewModel,
                    parent: self)
                .environmentObject(appSettings)
                .environmentObject(pageSettings)
            }
            
            else if filterPropertiesViewModel.filterXHolder.filter is CopyMachineTransitionFX
            {
                CopyMachineTransitionPropertiesViewX(
                    fx:filterPropertiesViewModel.filterXHolder.filter as! CopyMachineTransitionFX,
                    filterPropertiesViewModel:filterPropertiesViewModel,
                    filtersPropertiesViewModel:filtersPropertiesViewModel,
                    parent: self)
                .environmentObject(appSettings)
                .environmentObject(pageSettings)
            }
            
            else if filterPropertiesViewModel.filterXHolder.filter is DisintegrateWithMaskTransitionFX
            {
                DisintegrateWithMaskTransitionPropertiesViewX(
                    fx:filterPropertiesViewModel.filterXHolder.filter as! DisintegrateWithMaskTransitionFX,
                    filterPropertiesViewModel:filterPropertiesViewModel,
                    filtersPropertiesViewModel:filtersPropertiesViewModel,
                    parent: self)
                .environmentObject(appSettings)
                .environmentObject(pageSettings)
            }
            
            else if filterPropertiesViewModel.filterXHolder.filter is FlashTransitionFX
            {
                FlashTransitionPropertiesViewX(
                    fx:filterPropertiesViewModel.filterXHolder.filter as! FlashTransitionFX,
                    filterPropertiesViewModel:filterPropertiesViewModel,
                    filtersPropertiesViewModel:filtersPropertiesViewModel,
                    parent: self)
                .environmentObject(appSettings)
                .environmentObject(pageSettings)
            }
            else if filterPropertiesViewModel.filterXHolder.filter is ModTransitionFX
            {
                ModTransitionPropertiesViewX(
                    fx:filterPropertiesViewModel.filterXHolder.filter as! ModTransitionFX,
                    filterPropertiesViewModel:filterPropertiesViewModel,
                    filtersPropertiesViewModel:filtersPropertiesViewModel,
                    parent: self)
                .environmentObject(appSettings)
                .environmentObject(pageSettings)
            }
            else if filterPropertiesViewModel.filterXHolder.filter is PageCurlTransitionFX
            {
                PageCurlTransitionPropertiesViewX(
                    fx:filterPropertiesViewModel.filterXHolder.filter as! PageCurlTransitionFX,
                    filterPropertiesViewModel:filterPropertiesViewModel,
                    filtersPropertiesViewModel:filtersPropertiesViewModel,
                    parent: self)
                .environmentObject(appSettings)
                .environmentObject(pageSettings)
            }
            else if filterPropertiesViewModel.filterXHolder.filter is PageCurlWithShadowTransitionFX
            {
                PageCurlWithShadowTransitionPropertiesViewX(
                    fx:filterPropertiesViewModel.filterXHolder.filter as! PageCurlWithShadowTransitionFX,
                    filterPropertiesViewModel:filterPropertiesViewModel,
                    filtersPropertiesViewModel:filtersPropertiesViewModel,
                    parent: self)
                .environmentObject(appSettings)
                .environmentObject(pageSettings)
            }
            else if filterPropertiesViewModel.filterXHolder.filter is RippleTransitionFX
            {
                RippleTransitionPropertiesViewX(
                    fx:filterPropertiesViewModel.filterXHolder.filter as! RippleTransitionFX,
                    filterPropertiesViewModel:filterPropertiesViewModel,
                    filtersPropertiesViewModel:filtersPropertiesViewModel,
                    parent: self)
                .environmentObject(appSettings)
                .environmentObject(pageSettings)
            }
            else if filterPropertiesViewModel.filterXHolder.filter is SwipeTransitionFX
            {
                SwipeTransitionPropertiesViewX(
                    fx:filterPropertiesViewModel.filterXHolder.filter as! SwipeTransitionFX,
                    filterPropertiesViewModel:filterPropertiesViewModel,
                    filtersPropertiesViewModel:filtersPropertiesViewModel,
                    parent: self)
                .environmentObject(appSettings)
                .environmentObject(pageSettings)
            }
            
            if !(filterPropertiesViewModel.filterXHolder.filter is BaseGeneratorFX) &&
                !(filterPropertiesViewModel.filterXHolder.filter is BaseGeneratorFX) &&
                !(filterPropertiesViewModel.filterXHolder.filter is ReadImageFX) &&
                !(filterPropertiesViewModel.filterXHolder.filter is BaseTransitionFX) &&
                !(filterPropertiesViewModel.filterXHolder.filter is BlendWithMaskFX) &&
                //!(filterPropertiesViewModel.filterXHolder.filter is FractalFlowNoiseFX) &&
                !(filterPropertiesViewModel.filterXHolder.filter is BlendWithAlphaMaskFX) &&
                !(filterPropertiesViewModel.filterXHolder.filter is ShadedMaterialFX) &&
                !(filterPropertiesViewModel.filterXHolder.filter is MaskedVariableBlurFX) &&
                !(filterPropertiesViewModel.filterXHolder.filter is DisplacementDistortionFX) &&
                !(filterPropertiesViewModel.filterXHolder.filter is GlassDistortionFX)
            {
                Section(header: Text("Input Image Node"), footer: Text("Select a Node to use as the Input Image. The preceding Node is used by default."))
                {
                    NavigationLink
                    {
                        NodeSelectionViewX(nodeType:"input",
                                           numNodes: filterPropertiesViewModel.filterXHolder.filter.nodeIndex,
                                           filterPropertiesViewModel: filterPropertiesViewModel,
                                           filtersPropertiesViewModel: filtersPropertiesViewModel)
                        .environmentObject(pageSettings)
                    } label: {
                        HStack{
                            Text("Node")
                            Spacer()
                            if filterPropertiesViewModel.filterXHolder.filter.inputImageAlias == ""{
                                Text("Preceding").foregroundColor(Color.gray)
                            }
                            else{
                                Text("Node "+filterPropertiesViewModel.filterXHolder.filter.inputImageAlias).foregroundColor(Color.gray)
                            }
                            
                        }
                    }
                    HStack{
                        Text("Node Number")
                        Spacer()
                        if filterPropertiesViewModel.filterXHolder.filter.inputImageAlias == ""{
                            Text(String(filterPropertiesViewModel.filterXHolder.filter.nodeIndex-1))
                        }
                        else{
                            Text(filterPropertiesViewModel.filterXHolder.filter.inputImageAlias)
                        }
                    }
                }
                
            }
            
            if filterPropertiesViewModel.filterXHolder.filter is BaseBlendFX ||
                filterPropertiesViewModel.filterXHolder.filter is MixFX
            {
                Section(header: Text("Background Image Node"), footer: Text("Select a Node to use as the Background Image. The original image is used by default."))
                {
                    NavigationLink
                    {
                        NodeSelectionViewX(nodeType:"background",
                                           numNodes: filterPropertiesViewModel.filterXHolder.filter.nodeIndex,
                                           filterPropertiesViewModel: filterPropertiesViewModel,
                                           filtersPropertiesViewModel: filtersPropertiesViewModel)
                        .environmentObject(pageSettings)
                    } label: {
                        HStack{
                            Text("Node")
                            Spacer()
                            if filterPropertiesViewModel.filterXHolder.filter.backgroundImageAlias == ""{
                                Text("Preceding").foregroundColor(Color.gray)
                            }
                            else{
                                Text("Node "+filterPropertiesViewModel.filterXHolder.filter.backgroundImageAlias).foregroundColor(Color.gray)
                            }
                            
                        }
                    }
                    HStack{
                        Text("Node Number")
                        Spacer()
                        if filterPropertiesViewModel.filterXHolder.filter.backgroundImageAlias == ""{
                            Text(String(filterPropertiesViewModel.filterXHolder.filter.nodeIndex-1))
                        }
                        else{
                            Text(filterPropertiesViewModel.filterXHolder.filter.backgroundImageAlias)
                        }
                    }
                }
                
            }
            
            Section(header: Text("Filter Node Output"))
            {
                
                HStack{
                    Spacer()
                    if filtersPropertiesViewModel is BackgroundFiltersPropertiesViewModel
                    {
                        Image(uiImage: filterPropertiesViewModel.filterXHolder.filter.getCurrentImage(thumbImage: pageSettings.backgroundImage!))
                            .resizable()
                            .edgesIgnoringSafeArea(.all)
                            .scaledToFit()
                            .frame(width: 200.0, height: 200.0, alignment: .center)
                            .padding()
                    }
                    else if filtersPropertiesViewModel is ImageFiltersPropertiesViewModel
                    {
                        Image(uiImage: filterPropertiesViewModel.filterXHolder.filter.getCurrentImage(thumbImage: (filtersPropertiesViewModel as! ImageFiltersPropertiesViewModel).image!))
                            .resizable()
                            .edgesIgnoringSafeArea(.all)
                            .scaledToFit()
                            .frame(width: 200.0, height: 200.0, alignment: .center)
                            .padding()
                        
                    
                        

                    }
                    Spacer()
                }
                
                
            }
            
            
            Section(header: Text(""), footer: Text("")){
            }
        }
        .navigationTitle(String("Node ")+String(filterPropertiesViewModel.filterXHolder.filter.nodeIndex))
        .navigationBarTitleDisplayMode(.inline)
        /* -causes crash
        .toolbar {
            ToolbarItem(placement: .navigationBarTrailing) {
                    Button("Done") {
                        
                        //presentationMode.wrappedValue.dismiss()
                        //dismiss()
                        //parent.childDismiss()
                        
                        shapes.shapeList.forEach
                        {
                                $0.isSelected = false
                        }
                        
                        print("Page Properties Off - Node Properties Done")
                        pageSettings.resetViewer()
                        optionSettings.showPropertiesView=0
                        optionSettings.showPagePropertiesView=0
                        optionSettings.pagePropertiesHeight=95
                        appSettings.zoomFactor = appSettings.zoomFactor * 1.0/0.999
                        

                    }
            }
        }*/
         
        //.frame(height:horizontalSizeClass == .regular && verticalSizeClass == .regular ? propertiesHeightTall : propertiesHeight)
        .onAppear(perform: setupViewModel)
        //70 causes issue here on ipad so taken out
        //        .padding(.bottom, horizontalSizeClass == .regular && verticalSizeClass == .regular ? 70 : 0)
        
    }
    
    func setupViewModel()
    {
        
        //filterPropertiesViewModel.filterXHolder.filter.objectWillChange.send()
        //selectedFilterType=filterPropertiesViewModel.filter.type
        //self.colorControlsFX = filterPropertiesViewModel.filter as! ColorControlsFX
    }
    
    func readImage(fx: FilterX) {
        if filtersPropertiesViewModel is BackgroundFiltersPropertiesViewModel
        {
            pageSettings.readFX=(fx as! ReadImageFX)
        }
        else if filtersPropertiesViewModel is ImageFiltersPropertiesViewModel
        {
            self.shapes.shapeList.forEach
            {
                if $0.isSelected == true {
                    
                    let selectedImage = $0 as! ImageX
                    selectedImage.readFX=(fx as! ReadImageFX)
                    
                }
            }
        }
        
        optionSettings.action = "ReadPhoto"
        optionSettings.showPropertiesSheet = true
    }
    
    func applyFilter() {
        
        print("Number of Filters Count",FilterNames.GetFilterType().count)
        if filtersPropertiesViewModel is BackgroundFiltersPropertiesViewModel
        {
            DispatchQueue.main.async {
                do {
                    pageSettings.applyFilters()
                }
            }
            //vImage=filterPropertiesViewModel.filterXHolder.filter.getCurrentImage(originalImage: pageSettings.backgroundImage)
        }
        else if filtersPropertiesViewModel is ImageFiltersPropertiesViewModel
        {
            self.shapes.shapeList.forEach
            {
                if $0.isSelected == true {
                    
                    let selectedImage = $0 as! ImageX
                    selectedImage.applyFilter()
                    
                }
            }
        }
        
    }

}


