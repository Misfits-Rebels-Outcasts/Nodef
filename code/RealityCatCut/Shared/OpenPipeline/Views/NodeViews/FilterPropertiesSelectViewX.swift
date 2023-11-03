//
//  Copyright © 2022-2023 James Boo. All rights reserved.
//


import SwiftUI


struct FilterPropertiesSelectViewX: View {
    
    @EnvironmentObject var appSettings: AppSettings
    @EnvironmentObject var optionSettings: OptionSettings
    
    @StateObject var filterPropertiesViewModel: FilterPropertiesViewModel
    @ObservedObject var filtersPropertiesViewModel: FiltersPropertiesViewModel
    
    var parent: FilterPropertiesViewX
    
    
    var body: some View {
        
        
        
        if filterPropertiesViewModel.filterXHolder.filter is PhotoFrameFX
        {
            PhotoFrameARPropertiesViewX(fx:filterPropertiesViewModel.filterXHolder.filter as! PhotoFrameFX, parent: parent)
            
        }
        else if filterPropertiesViewModel.filterXHolder.filter is TextFX
        {
            TextARPropertiesViewX(fx:filterPropertiesViewModel.filterXHolder.filter as! TextFX, parent: parent)
            
        }
        else if filterPropertiesViewModel.filterXHolder.filter is SphereFX
        {
            SpherePropertiesViewX(fx:filterPropertiesViewModel.filterXHolder.filter as! SphereFX, parent: parent)
            
        }
        else if filterPropertiesViewModel.filterXHolder.filter is BoxFX
        {
            BoxPropertiesViewX(fx:filterPropertiesViewModel.filterXHolder.filter as! BoxFX, parent: parent)
            
        }
        else if filterPropertiesViewModel.filterXHolder.filter is TerrianFX
        {
            TerrianPropertiesViewX(fx:filterPropertiesViewModel.filterXHolder.filter as! TerrianFX, parent: parent)
            
        }
        else if filterPropertiesViewModel.filterXHolder.filter is WavesFX
        {
            WavesPropertiesViewX(fx:filterPropertiesViewModel.filterXHolder.filter as! WavesFX, parent: parent)
            
        }
        else if filterPropertiesViewModel.filterXHolder.filter is SeashoreFX
        {
            SeashorePropertiesViewX(fx:filterPropertiesViewModel.filterXHolder.filter as! SeashoreFX, parent: parent)
            
        }
        else if filterPropertiesViewModel.filterXHolder.filter is ParticlesFX
        {
            ParticlesPropertiesViewX(fx:filterPropertiesViewModel.filterXHolder.filter as! ParticlesFX, parent: parent)
                .environmentObject(appSettings)
        }
        //Compilation
        /*
         else if filterPropertiesViewModel.filterXHolder.filter is AnimFX
         {
         AnimPropertiesViewX(fx:filterPropertiesViewModel.filterXHolder.filter as! AnimFX, parent: parent)
         .environmentObject(appSettings)
         }
         */
        else if filterPropertiesViewModel.filterXHolder.filter is FractalFlowNoiseFX
        {
            FractalFlowNoisePropertiesViewX(
                fx:filterPropertiesViewModel.filterXHolder.filter as! FractalFlowNoiseFX,
                filterPropertiesViewModel:filterPropertiesViewModel,
                filtersPropertiesViewModel:filtersPropertiesViewModel,
                parent: parent)
            .environmentObject(appSettings)
            
        }
        /*
         else if filterPropertiesViewModel.filterXHolder.filter is AnimTex01FX
         {
         AnimTex01PropertiesViewX(fx:filterPropertiesViewModel.filterXHolder.filter as! AnimTex01FX, parent: parent)
         .environmentObject(appSettings)
         }
         else if filterPropertiesViewModel.filterXHolder.filter is AnimTex02FX
         {
         AnimTex02PropertiesViewX(fx:filterPropertiesViewModel.filterXHolder.filter as! AnimTex02FX, parent: parent)
         .environmentObject(appSettings)
         }
         else if filterPropertiesViewModel.filterXHolder.filter is AnimTex03FX
         {
         AnimTex03PropertiesViewX(fx:filterPropertiesViewModel.filterXHolder.filter as! AnimTex03FX, parent: parent)
         .environmentObject(appSettings)
         }
         */
        else if filterPropertiesViewModel.filterXHolder.filter is FBMNoiseFX
        {
            FBMNoisePropertiesViewX(fx:filterPropertiesViewModel.filterXHolder.filter as! FBMNoiseFX, parent: parent)
                .environmentObject(appSettings)
        }
        else if filterPropertiesViewModel.filterXHolder.filter is SmokeEffectsFX
        {
            SmokeEffectsPropertiesViewX(fx:filterPropertiesViewModel.filterXHolder.filter as! SmokeEffectsFX, parent: parent)
                .environmentObject(appSettings)
        }
        
        else if filterPropertiesViewModel.filterXHolder.filter is WaterEffectsFX
        {
            WaterEffectsPropertiesViewX(fx:filterPropertiesViewModel.filterXHolder.filter as! WaterEffectsFX, parent: parent)
                .environmentObject(appSettings)
        }
        else if filterPropertiesViewModel.filterXHolder.filter is TortiseShellVoronoiFX
        {
            TortiseShellPropertiesViewX(fx:filterPropertiesViewModel.filterXHolder.filter as! TortiseShellVoronoiFX, parent: parent)
                .environmentObject(appSettings)
        }
        /*
         else if filterPropertiesViewModel.filterXHolder.filter is AnimTex05FX
         {
         AnimTex05PropertiesViewX(fx:filterPropertiesViewModel.filterXHolder.filter as! AnimTex05FX, parent: parent)
         .environmentObject(appSettings)
         }
         else if filterPropertiesViewModel.filterXHolder.filter is AnimTex06FX
         {
         AnimTex06PropertiesViewX(fx:filterPropertiesViewModel.filterXHolder.filter as! AnimTex06FX, parent: parent)
         .environmentObject(appSettings)
         }
         else if filterPropertiesViewModel.filterXHolder.filter is AnimTex07FX
         {
         AnimTex07PropertiesViewX(fx:filterPropertiesViewModel.filterXHolder.filter as! AnimTex07FX, parent: parent)
         .environmentObject(appSettings)
         }
         else if filterPropertiesViewModel.filterXHolder.filter is AnimTex08FX
         {
         AnimTex08PropertiesViewX(fx:filterPropertiesViewModel.filterXHolder.filter as! AnimTex08FX, parent: parent)
         .environmentObject(appSettings)
         }
         */
        else if filterPropertiesViewModel.filterXHolder.filter is ColorChannelsFX
        {
            ColorChannelsPropertiesViewX(fx:filterPropertiesViewModel.filterXHolder.filter as! ColorChannelsFX, parent: parent)
            
        }
        else if filterPropertiesViewModel.filterXHolder.filter is ReciprocalFX
        {
            ReciprocalPropertiesViewX(fx:filterPropertiesViewModel.filterXHolder.filter as! ReciprocalFX, parent: parent)
            
        }
        
        else if filterPropertiesViewModel.filterXHolder.filter is BoxBlurFX
        {
            BoxBlurPropertiesViewX(fx:filterPropertiesViewModel.filterXHolder.filter as! BoxBlurFX, parent: parent)
            
        }
        else if filterPropertiesViewModel.filterXHolder.filter is DiscBlurFX
        {
            DiscBlurPropertiesViewX(fx:filterPropertiesViewModel.filterXHolder.filter as! DiscBlurFX, parent: parent)
            
        }
        else if filterPropertiesViewModel.filterXHolder.filter is GaussianBlurFX
        {
            GaussianBlurPropertiesViewX(gaussianBlurFX:filterPropertiesViewModel.filterXHolder.filter as! GaussianBlurFX, parent: parent)
            
        }
        else if filterPropertiesViewModel.filterXHolder.filter is MaskedVariableBlurFX
        {
            MaskedVariableBlurPropertiesViewX(
                fx:filterPropertiesViewModel.filterXHolder.filter as! MaskedVariableBlurFX,
                filterPropertiesViewModel:filterPropertiesViewModel,
                filtersPropertiesViewModel:filtersPropertiesViewModel,parent: parent)
            
        }
        else if filterPropertiesViewModel.filterXHolder.filter is MotionBlurFX
        {
            MotionBlurPropertiesViewX(fx:filterPropertiesViewModel.filterXHolder.filter as! MotionBlurFX, parent: parent)
            
        }
        else if filterPropertiesViewModel.filterXHolder.filter is NoiseReductionFX
        {
            NoiseReductionPropertiesViewX(fx:filterPropertiesViewModel.filterXHolder.filter as! NoiseReductionFX, parent: parent)
            
        }
        else if filterPropertiesViewModel.filterXHolder.filter is ZoomBlurFX
        {
            ZoomBlurPropertiesViewX(fx:filterPropertiesViewModel.filterXHolder.filter as! ZoomBlurFX, parent: parent)
            
        }
        
        
        
        else if filterPropertiesViewModel.filterXHolder.filter is ColorClampFX
        {
            ColorClampPropertiesViewX(fx:filterPropertiesViewModel.filterXHolder.filter as! ColorClampFX, parent: parent)
            
        }
        else if filterPropertiesViewModel.filterXHolder.filter is ReadImageFX
        {
            //ANCHISES
            //ImageTransformPropertiesViewX(fx:filterPropertiesViewModel.filterXHolder.filter as! ReadImageFX, parent: parent)
            
            ReadImagePropertiesViewX(fx:filterPropertiesViewModel.filterXHolder.filter as! ReadImageFX, parent: parent)
            
        }
        //ANCHISES
        
        else if filterPropertiesViewModel.filterXHolder.filter is ReadVideoFX
        {
            ReadVideoPropertiesViewX(fx:filterPropertiesViewModel.filterXHolder.filter as! ReadVideoFX, parent: parent)
            
        }
        else if filterPropertiesViewModel.filterXHolder.filter is JoinVideoFX
        {
            JoinVideoPropertiesViewX(fx:filterPropertiesViewModel.filterXHolder.filter as! JoinVideoFX, parent: parent)
            
        }
        else if filterPropertiesViewModel.filterXHolder.filter is CutVideoFX
        {
            CutVideoPropertiesViewX(fx:filterPropertiesViewModel.filterXHolder.filter as! CutVideoFX, parent: parent)
            
        }
        
        else if filterPropertiesViewModel.filterXHolder.filter is ColorControlsFX
        {
            ColorControlsPropertiesViewX(colorControlsFX:filterPropertiesViewModel.filterXHolder.filter as! ColorControlsFX, parent: parent)
            
        }
        else if filterPropertiesViewModel.filterXHolder.filter is ColorMatrixFX
        {
            ColorMatrixPropertiesViewX(fx:filterPropertiesViewModel.filterXHolder.filter as! ColorMatrixFX, parent: parent)
            
        }
        
        else if filterPropertiesViewModel.filterXHolder.filter is ColorPolynomialFX
        {
            ColorPolynomialPropertiesViewX(fx:filterPropertiesViewModel.filterXHolder.filter as! ColorPolynomialFX, parent: parent)
            
        }
        else if filterPropertiesViewModel.filterXHolder.filter is ExposureAdjustFX
        {
            ExposureAdjustPropertiesViewX(fx:filterPropertiesViewModel.filterXHolder.filter as! ExposureAdjustFX, parent: parent)
            
        }
        else if filterPropertiesViewModel.filterXHolder.filter is GammaAdjustFX
        {
            GammaAdjustPropertiesViewX(fx:filterPropertiesViewModel.filterXHolder.filter as! GammaAdjustFX, parent: parent)
            
        }
        else if filterPropertiesViewModel.filterXHolder.filter is HueAdjustFX
        {
            HueAdjustPropertiesViewX(fx:filterPropertiesViewModel.filterXHolder.filter as! HueAdjustFX, parent: parent)
            
        }
        else if filterPropertiesViewModel.filterXHolder.filter is TemperatureAndTintFX
        {
            TemperatureAndTintPropertiesViewX(fx:filterPropertiesViewModel.filterXHolder.filter as! TemperatureAndTintFX, parent: parent)
            
        }
        else if filterPropertiesViewModel.filterXHolder.filter is ToneCurveFX
        {
            ToneCurvePropertiesViewX(fx:filterPropertiesViewModel.filterXHolder.filter as! ToneCurveFX, parent: parent)
            
        }
        else if filterPropertiesViewModel.filterXHolder.filter is VibranceFX
        {
            VibrancePropertiesViewX(fx:filterPropertiesViewModel.filterXHolder.filter as! VibranceFX, parent: parent)
            
        }
        else if filterPropertiesViewModel.filterXHolder.filter is WhitePointAdjustFX
        {
            WhitePointPropertiesViewX(fx:filterPropertiesViewModel.filterXHolder.filter as! WhitePointAdjustFX, parent: parent)
            
        }
        
        
        
        //ColorEffect
        else if filterPropertiesViewModel.filterXHolder.filter is ColorCubeFX
        {
            ColorCubePropertiesViewX(fx:filterPropertiesViewModel.filterXHolder.filter as! ColorCubeFX, parent: parent)
            
        }
        else if filterPropertiesViewModel.filterXHolder.filter is ColorCubeWithColorSpaceFX
        {
            ColorCubeWithColorSpacePropertiesViewX(fx:filterPropertiesViewModel.filterXHolder.filter as! ColorCubeWithColorSpaceFX, parent: parent)
            
        }
        else if filterPropertiesViewModel.filterXHolder.filter is ColorMapFX
        {
            ColorMapPropertiesViewX(fx:filterPropertiesViewModel.filterXHolder.filter as! ColorMapFX, parent: parent)
            
        }
        
        else if filterPropertiesViewModel.filterXHolder.filter is ColorCrossPolynomialFX
        {
            ColorCrossPolynomialPropertiesViewX(fx:filterPropertiesViewModel.filterXHolder.filter as! ColorCrossPolynomialFX, parent: parent)
            
        }
        else if filterPropertiesViewModel.filterXHolder.filter is ColorMonochromeFX
        {
            ColorMonochromePropertiesViewX(fx:filterPropertiesViewModel.filterXHolder.filter as! ColorMonochromeFX, parent: parent)
            
        }
        else if filterPropertiesViewModel.filterXHolder.filter is ColorPosterizeFX
        {
            ColorPosterizePropertiesViewX(fx:filterPropertiesViewModel.filterXHolder.filter as! ColorPosterizeFX, parent: parent)
            
        }
        else if filterPropertiesViewModel.filterXHolder.filter is FalseColorFX
        {
            FalseColorPropertiesViewX(fx:filterPropertiesViewModel.filterXHolder.filter as! FalseColorFX, parent: parent)
            
        }
        else if filterPropertiesViewModel.filterXHolder.filter is SepiaToneFX
        {
            SepiaTonePropertiesViewX(fx:filterPropertiesViewModel.filterXHolder.filter as! SepiaToneFX, parent: parent)
            
        }
        else if filterPropertiesViewModel.filterXHolder.filter is VignetteFX
        {
            VignettePropertiesViewX(fx:filterPropertiesViewModel.filterXHolder.filter as! VignetteFX, parent: parent)
            
        }
        else if filterPropertiesViewModel.filterXHolder.filter is VignetteEffectFX
        {
            VignetteEffectPropertiesViewX(fx:filterPropertiesViewModel.filterXHolder.filter as! VignetteEffectFX, parent: parent)
            
        }
        
        //Distortion
        else if filterPropertiesViewModel.filterXHolder.filter is DrosteFX
        {
            DrostePropertiesViewX(fx:filterPropertiesViewModel.filterXHolder.filter as! DrosteFX,parent: parent)
            
        }
        
        else if filterPropertiesViewModel.filterXHolder.filter is DisplacementDistortionFX
        {
            DisplacementDistortionPropertiesViewX(
                fx:filterPropertiesViewModel.filterXHolder.filter as! DisplacementDistortionFX,
                filterPropertiesViewModel:filterPropertiesViewModel,
                filtersPropertiesViewModel:filtersPropertiesViewModel,parent: parent)
            
        }
        
        else if filterPropertiesViewModel.filterXHolder.filter is GlassDistortionFX
        {
            GlassDistortionPropertiesViewX(
                fx:filterPropertiesViewModel.filterXHolder.filter as! GlassDistortionFX,
                filterPropertiesViewModel:filterPropertiesViewModel,
                filtersPropertiesViewModel:filtersPropertiesViewModel,parent: parent)
            
        }
        
        else if filterPropertiesViewModel.filterXHolder.filter is GlassLozengeFX
        {
            GlassLozengePropertiesViewX(fx:filterPropertiesViewModel.filterXHolder.filter as! GlassLozengeFX,parent: parent)
            
        }
        else if filterPropertiesViewModel.filterXHolder.filter is StretchCropFX
        {
            StretchCropPropertiesViewX(fx:filterPropertiesViewModel.filterXHolder.filter as! StretchCropFX,parent: parent)
        }
        else if filterPropertiesViewModel.filterXHolder.filter is BumpDistortionFX
        {
            BumpDistortionPropertiesViewX(fx:filterPropertiesViewModel.filterXHolder.filter as! BumpDistortionFX,parent: parent)
            
        }
        else if filterPropertiesViewModel.filterXHolder.filter is BumpDistortionLinearFX
        {
            BumpDistortionLinearPropertiesViewX(fx:filterPropertiesViewModel.filterXHolder.filter as! BumpDistortionLinearFX,parent: parent)
            
        }
        else if filterPropertiesViewModel.filterXHolder.filter is CircularWrapFX
        {
            CircularWrapPropertiesViewX(fx:filterPropertiesViewModel.filterXHolder.filter as! CircularWrapFX,parent: parent)
            
        }
        else if filterPropertiesViewModel.filterXHolder.filter is CircleSplashDistortionFX
        {
            CircleSplashDistortionPropertiesViewX(fx:filterPropertiesViewModel.filterXHolder.filter as! CircleSplashDistortionFX,parent: parent)
            
        }
        else if filterPropertiesViewModel.filterXHolder.filter is LightTunnelFX
        {
            LightTunnelPropertiesViewX(fx:filterPropertiesViewModel.filterXHolder.filter as! LightTunnelFX,parent: parent)
            
        }
        else if filterPropertiesViewModel.filterXHolder.filter is HoleDistortionFX
        {
            HoleDistortionPropertiesViewX(fx:filterPropertiesViewModel.filterXHolder.filter as! HoleDistortionFX,parent: parent)
            
        }
        else if filterPropertiesViewModel.filterXHolder.filter is PinchDistortionFX
        {
            PinchDistortionPropertiesViewX(fx:filterPropertiesViewModel.filterXHolder.filter as! PinchDistortionFX,parent: parent)
            
        }
        else if filterPropertiesViewModel.filterXHolder.filter is TorusLensDistortionFX
        {
            TorusLensDistortionPropertiesViewX(fx:filterPropertiesViewModel.filterXHolder.filter as! TorusLensDistortionFX,parent: parent)
            
        }
        else if filterPropertiesViewModel.filterXHolder.filter is TwirlDistortionFX
        {
            TwirlDistortionPropertiesViewX(fx:filterPropertiesViewModel.filterXHolder.filter as! TwirlDistortionFX,parent: parent)
            
        }
        else if filterPropertiesViewModel.filterXHolder.filter is VortexDistortionFX
        {
            VortexDistortionPropertiesViewX(fx:filterPropertiesViewModel.filterXHolder.filter as! VortexDistortionFX,parent: parent)
            
        }
        
        //Generator
        else if filterPropertiesViewModel.filterXHolder.filter is AztecCodeGeneratorFX
        {
            AztecCodeGeneratorPropertiesViewX(fx:filterPropertiesViewModel.filterXHolder.filter as! AztecCodeGeneratorFX,parent: parent)
            
        }
        else if filterPropertiesViewModel.filterXHolder.filter is PDF417BarcodeGeneratorFX
        {
            PDF417BarcodeGeneratorPropertiesViewX(fx:filterPropertiesViewModel.filterXHolder.filter as! PDF417BarcodeGeneratorFX,parent: parent)
            
        }
        else if filterPropertiesViewModel.filterXHolder.filter is ConstantColorGeneratorFX
        {
            ConstantColorGeneratorPropertiesViewX(fx:filterPropertiesViewModel.filterXHolder.filter as! ConstantColorGeneratorFX,parent: parent)
            
        }
        else if filterPropertiesViewModel.filterXHolder.filter is CheckerboardGeneratorFX
        {
            CheckerboardGeneratorPropertiesViewX(fx:filterPropertiesViewModel.filterXHolder.filter as! CheckerboardGeneratorFX,parent: parent)
            
        }
        else if filterPropertiesViewModel.filterXHolder.filter is StripesGeneratorFX
        {
            StripesGeneratorPropertiesViewX(fx:filterPropertiesViewModel.filterXHolder.filter as! StripesGeneratorFX,parent: parent)
            
        }
        else if filterPropertiesViewModel.filterXHolder.filter is LenticularHaloGeneratorFX
        {
            LenticularHaloGeneratorPropertiesViewX(fx:filterPropertiesViewModel.filterXHolder.filter as! LenticularHaloGeneratorFX,parent: parent)
            
        }
        else if filterPropertiesViewModel.filterXHolder.filter is RoundedRectangleGeneratorFX
        {
            RoundedRectangleGeneratorPropertiesViewX(fx:filterPropertiesViewModel.filterXHolder.filter as! RoundedRectangleGeneratorFX,parent: parent)
            
        }
        else if filterPropertiesViewModel.filterXHolder.filter is CircleGeneratorFX
        {
            CircleGeneratorPropertiesViewX(fx:filterPropertiesViewModel.filterXHolder.filter as! CircleGeneratorFX,parent: parent)
            
        }
        else if filterPropertiesViewModel.filterXHolder.filter is StarShineGeneratorFX
        {
            StarShineGeneratorPropertiesViewX(fx:filterPropertiesViewModel.filterXHolder.filter as! StarShineGeneratorFX,parent: parent)
            
        }
        else if filterPropertiesViewModel.filterXHolder.filter is SunbeamsGeneratorFX
        {
            SunbeamsGeneratorPropertiesViewX(fx:filterPropertiesViewModel.filterXHolder.filter as! SunbeamsGeneratorFX,parent: parent)
            
        }
        else if filterPropertiesViewModel.filterXHolder.filter is QRCodeGeneratorFX
        {
            QRCodeGeneratorPropertiesViewX(fx:filterPropertiesViewModel.filterXHolder.filter as! QRCodeGeneratorFX,parent: parent)
            
        }
        else if filterPropertiesViewModel.filterXHolder.filter is Code128BarcodeGeneratorFX
        {
            Code128BarcodeGeneratorPropertiesViewX(fx:filterPropertiesViewModel.filterXHolder.filter as! Code128BarcodeGeneratorFX,parent: parent)
            
        }
        else if filterPropertiesViewModel.filterXHolder.filter is TextImageGeneratorFX
        {
            TextImageGeneratorPropertiesViewX(fx:filterPropertiesViewModel.filterXHolder.filter as! TextImageGeneratorFX,parent: parent)
            
        }
        
        //Geometry Adjustment            
        else if filterPropertiesViewModel.filterXHolder.filter is TranslateFX
        {
            TranslatePropertiesViewX(fx:filterPropertiesViewModel.filterXHolder.filter as! TranslateFX,parent: parent)
            
        }
        else if filterPropertiesViewModel.filterXHolder.filter is RotateFX
        {
            RotatePropertiesViewX(fx:filterPropertiesViewModel.filterXHolder.filter as! RotateFX,parent: parent)
            
        }
        else if filterPropertiesViewModel.filterXHolder.filter is ScaleFX
        {
            ScalePropertiesViewX(fx:filterPropertiesViewModel.filterXHolder.filter as! ScaleFX,parent: parent)
            
        }
        else if filterPropertiesViewModel.filterXHolder.filter is RotateFX
        {
            RotatePropertiesViewX(fx:filterPropertiesViewModel.filterXHolder.filter as! RotateFX,parent: parent)
            
        }
        else if filterPropertiesViewModel.filterXHolder.filter is OpacityFX
        {
            OpacityPropertiesViewX(fx:filterPropertiesViewModel.filterXHolder.filter as! OpacityFX,parent: parent)
            
        }
        else if filterPropertiesViewModel.filterXHolder.filter is MixFX
        {
            MixPropertiesViewX(fx:filterPropertiesViewModel.filterXHolder.filter as! MixFX,parent: parent)
            
        }
        
        else if filterPropertiesViewModel.filterXHolder.filter is AffineTransformFX
        {
            AffineTransformPropertiesViewX(fx:filterPropertiesViewModel.filterXHolder.filter as! AffineTransformFX,parent: parent)
            
        }
        else if filterPropertiesViewModel.filterXHolder.filter is CropFX
        {
            CropPropertiesViewX(fx:filterPropertiesViewModel.filterXHolder.filter as! CropFX,parent: parent)
            
        }
        else if filterPropertiesViewModel.filterXHolder.filter is LanczosScaleTransformFX
        {
            LanczosScaleTransformPropertiesViewX(fx:filterPropertiesViewModel.filterXHolder.filter as! LanczosScaleTransformFX,parent: parent)
            
        }
        else if filterPropertiesViewModel.filterXHolder.filter is PerspectiveCorrectionFX
        {
            PerspectiveCorrectionPropertiesViewX(fx:filterPropertiesViewModel.filterXHolder.filter as! PerspectiveCorrectionFX,parent: parent)
            
        }
        else if filterPropertiesViewModel.filterXHolder.filter is PerspectiveTransformFX
        {
            PerspectiveTransformPropertiesViewX(fx:filterPropertiesViewModel.filterXHolder.filter as! PerspectiveTransformFX,parent: parent)
            
        }
        else if filterPropertiesViewModel.filterXHolder.filter is PerspectiveTransformWithExtentFX
        {
            PerspectiveTransformWithExtentPropertiesViewX(fx:filterPropertiesViewModel.filterXHolder.filter as! PerspectiveTransformWithExtentFX,parent: parent)
            
        }
        else if filterPropertiesViewModel.filterXHolder.filter is StraightenFilterFX
        {
            StraightenFilterPropertiesViewX(fx:filterPropertiesViewModel.filterXHolder.filter as! StraightenFilterFX,parent: parent)
            
        }
        
        
        else if filterPropertiesViewModel.filterXHolder.filter is GaussianGradientFX
        {
            GaussianGradientPropertiesViewX(fx:filterPropertiesViewModel.filterXHolder.filter as! GaussianGradientFX,parent: parent)
            
        }
        else if filterPropertiesViewModel.filterXHolder.filter is LinearGradientFX
        {
            LinearGradientPropertiesViewX(fx:filterPropertiesViewModel.filterXHolder.filter as! LinearGradientFX,parent: parent)
            
        }
        else if filterPropertiesViewModel.filterXHolder.filter is RadialGradientFX
        {
            RadialGradientPropertiesViewX(fx:filterPropertiesViewModel.filterXHolder.filter as! RadialGradientFX,parent: parent)
            
        }
        else if filterPropertiesViewModel.filterXHolder.filter is SmoothLinearGradientFX
        {
            SmoothLinearGradientPropertiesViewX(fx:filterPropertiesViewModel.filterXHolder.filter as! SmoothLinearGradientFX,parent: parent)
            
        }
        else if filterPropertiesViewModel.filterXHolder.filter is SinusoidalGradientFX
        {
            SinusoidalGradientPropertiesViewX(fx:filterPropertiesViewModel.filterXHolder.filter as! SinusoidalGradientFX,parent: parent)
            
        }
        
        else if filterPropertiesViewModel.filterXHolder.filter is CircularScreenFX
        {
            CircularScreenPropertiesViewX(fx:filterPropertiesViewModel.filterXHolder.filter as! CircularScreenFX,parent: parent)
            
        }
        else if filterPropertiesViewModel.filterXHolder.filter is DotScreenFX
        {
            DotScreenPropertiesViewX(fx:filterPropertiesViewModel.filterXHolder.filter as! DotScreenFX,parent: parent)
            
        }
        else if filterPropertiesViewModel.filterXHolder.filter is HatchedScreenFX
        {
            HatchedScreenPropertiesViewX(fx:filterPropertiesViewModel.filterXHolder.filter as! HatchedScreenFX,parent: parent)
            
        }
        else if filterPropertiesViewModel.filterXHolder.filter is LineScreenFX
        {
            LineScreenPropertiesViewX(fx:filterPropertiesViewModel.filterXHolder.filter as! LineScreenFX,parent: parent)
            
        }
        else if filterPropertiesViewModel.filterXHolder.filter is CMYKHalftoneFX
        {
            CMYKHalftonePropertiesViewX(fx:filterPropertiesViewModel.filterXHolder.filter as! CMYKHalftoneFX,parent: parent)
            
        }
        
        //Reduction
        else if filterPropertiesViewModel.filterXHolder.filter is AreaAverageFX
        {
            AreaAveragePropertiesViewX(fx:filterPropertiesViewModel.filterXHolder.filter as! AreaAverageFX,parent: parent)
            
        }
        else if filterPropertiesViewModel.filterXHolder.filter is AreaHistogramFX
        {
            AreaHistogramPropertiesViewX(fx:filterPropertiesViewModel.filterXHolder.filter as! AreaHistogramFX,parent: parent)
            
        }
        else if filterPropertiesViewModel.filterXHolder.filter is RowAverageFX
        {
            RowAveragePropertiesViewX(fx:filterPropertiesViewModel.filterXHolder.filter as! RowAverageFX,parent: parent)
            
        }
        else if filterPropertiesViewModel.filterXHolder.filter is ColumnAverageFX
        {
            ColumnAveragePropertiesViewX(fx:filterPropertiesViewModel.filterXHolder.filter as! ColumnAverageFX,parent: parent)
            
        }
        else if filterPropertiesViewModel.filterXHolder.filter is HistogramDisplayFilterFX
        {
            HistogramDisplayFilterPropertiesViewX(fx:filterPropertiesViewModel.filterXHolder.filter as! HistogramDisplayFilterFX,parent: parent)
            
        }
        else if filterPropertiesViewModel.filterXHolder.filter is AreaMaximumFX
        {
            AreaMaximumPropertiesViewX(fx:filterPropertiesViewModel.filterXHolder.filter as! AreaMaximumFX,parent: parent)
            
        }
        else if filterPropertiesViewModel.filterXHolder.filter is AreaMaximumAlphaFX
        {
            AreaMaximumAlphaPropertiesViewX(fx:filterPropertiesViewModel.filterXHolder.filter as! AreaMaximumAlphaFX,parent: parent)
            
        }
        else if filterPropertiesViewModel.filterXHolder.filter is AreaMinimumFX
        {
            AreaMinimumPropertiesViewX(fx:filterPropertiesViewModel.filterXHolder.filter as! AreaMinimumFX,parent: parent)
            
        }
        else if filterPropertiesViewModel.filterXHolder.filter is AreaMinimumAlphaFX
        {
            AreaMinimumAlphaPropertiesViewX(fx:filterPropertiesViewModel.filterXHolder.filter as! AreaMinimumAlphaFX,parent: parent)
            
        }
        
        //Sharpen
        else if filterPropertiesViewModel.filterXHolder.filter is SharpenLuminanceFX
        {
            SharpenLuminancePropertiesViewX(fx:filterPropertiesViewModel.filterXHolder.filter as! SharpenLuminanceFX,parent: parent)
            
        }
        else if filterPropertiesViewModel.filterXHolder.filter is UnsharpMaskFX
        {
            UnsharpMaskPropertiesViewX(fx:filterPropertiesViewModel.filterXHolder.filter as! UnsharpMaskFX,parent: parent)
            
        }
        
        //stylize
        else if filterPropertiesViewModel.filterXHolder.filter is Convolution3X3FX
        {
            Convolution3X3PropertiesViewX(fx:filterPropertiesViewModel.filterXHolder.filter as! Convolution3X3FX,parent: parent)
            
        }
        else if filterPropertiesViewModel.filterXHolder.filter is Convolution5X5FX
        {
            Convolution5X5PropertiesViewX(fx:filterPropertiesViewModel.filterXHolder.filter as! Convolution5X5FX,parent: parent)
            
        }
        else if filterPropertiesViewModel.filterXHolder.filter is Convolution7X7FX
        {
            Convolution7X7PropertiesViewX(fx:filterPropertiesViewModel.filterXHolder.filter as! Convolution7X7FX,parent: parent)
            
        }
        else if filterPropertiesViewModel.filterXHolder.filter is Convolution9HorizontalFX
        {
            Convolution9HorizontalPropertiesViewX(fx:filterPropertiesViewModel.filterXHolder.filter as! Convolution9HorizontalFX,parent: parent)
            
        }
        else if filterPropertiesViewModel.filterXHolder.filter is Convolution9VerticalFX
        {
            Convolution9VerticalPropertiesViewX(fx:filterPropertiesViewModel.filterXHolder.filter as! Convolution9VerticalFX,parent: parent)
            
        }
        else if filterPropertiesViewModel.filterXHolder.filter is DepthOfFieldFX
        {
            DepthOfFieldPropertiesViewX(fx:filterPropertiesViewModel.filterXHolder.filter as! DepthOfFieldFX,parent: parent)
            
        }
        else if filterPropertiesViewModel.filterXHolder.filter is HeightFieldFromMaskFX
        {
            HeightFieldFromMaskPropertiesViewX(fx:filterPropertiesViewModel.filterXHolder.filter as! HeightFieldFromMaskFX,parent: parent)
            
        }
        else if filterPropertiesViewModel.filterXHolder.filter is LineOverlayFX
        {
            LineOverlayPropertiesViewX(fx:filterPropertiesViewModel.filterXHolder.filter as! LineOverlayFX,parent: parent)
            
        }
        else if filterPropertiesViewModel.filterXHolder.filter is ShadedMaterialFX
        {
            ShadedMaterialPropertiesViewX(
                fx:filterPropertiesViewModel.filterXHolder.filter as! ShadedMaterialFX,
                filterPropertiesViewModel:filterPropertiesViewModel,
                filtersPropertiesViewModel:filtersPropertiesViewModel,
                parent: parent)
            
        }
        else if filterPropertiesViewModel.filterXHolder.filter is SpotColorFX
        {
            SpotColorPropertiesViewX(fx:filterPropertiesViewModel.filterXHolder.filter as! SpotColorFX,parent: parent)
            
        }
        else if filterPropertiesViewModel.filterXHolder.filter is SpotLightFX
        {
            SpotLightPropertiesViewX(fx:filterPropertiesViewModel.filterXHolder.filter as! SpotLightFX,parent: parent)
            
        }
        else if filterPropertiesViewModel.filterXHolder.filter is BloomFX
        {
            BloomPropertiesViewX(fx:filterPropertiesViewModel.filterXHolder.filter as! BloomFX,parent: parent)
            
        }
        else if filterPropertiesViewModel.filterXHolder.filter is CrystallizeFX
        {
            CrystallizePropertiesViewX(fx:filterPropertiesViewModel.filterXHolder.filter as! CrystallizeFX,parent: parent)
            
        }
        else if filterPropertiesViewModel.filterXHolder.filter is EdgesFX
        {
            EdgesPropertiesViewX(fx:filterPropertiesViewModel.filterXHolder.filter as! EdgesFX,parent: parent)
            
        }
        else if filterPropertiesViewModel.filterXHolder.filter is EdgeWorkFX
        {
            EdgeWorkPropertiesViewX(fx:filterPropertiesViewModel.filterXHolder.filter as! EdgeWorkFX,parent: parent)
            
        }
        else if filterPropertiesViewModel.filterXHolder.filter is GloomFX
        {
            GloomPropertiesViewX(fx:filterPropertiesViewModel.filterXHolder.filter as! GloomFX,parent: parent)
            
        }
        else if filterPropertiesViewModel.filterXHolder.filter is PixellateFX
        {
            PixellatePropertiesViewX(fx:filterPropertiesViewModel.filterXHolder.filter as! PixellateFX,parent: parent)
            
        }
        else if filterPropertiesViewModel.filterXHolder.filter is PointillizeFX
        {
            PointillizePropertiesViewX(fx:filterPropertiesViewModel.filterXHolder.filter as! PointillizeFX,parent: parent)
            
        }
        else if filterPropertiesViewModel.filterXHolder.filter is HexagonalPixellateFX
        {
            HexagonalPixellatePropertiesViewX(fx:filterPropertiesViewModel.filterXHolder.filter as! HexagonalPixellateFX,parent: parent)
            
        }
        else if filterPropertiesViewModel.filterXHolder.filter is HighlightShadowAdjustFX
        {
            HighlightShadowAdjustPropertiesViewX(fx:filterPropertiesViewModel.filterXHolder.filter as! HighlightShadowAdjustFX,parent: parent)
            
        }
        else if filterPropertiesViewModel.filterXHolder.filter is BlendWithMaskFX
        {
            //ANCHISES
            /*
            BlendWithMaskPropertiesViewX(
                fx:filterPropertiesViewModel.filterXHolder.filter as! BlendWithMaskFX,
                filterPropertiesViewModel:filterPropertiesViewModel,
                filtersPropertiesViewModel:filtersPropertiesViewModel,
                parent: parent)
             */
            
        }
        else if filterPropertiesViewModel.filterXHolder.filter is BlendWithAlphaMaskFX
        {
            //ANCHISES
            /*
            BlendWithAlphaMaskPropertiesViewX(
                fx:filterPropertiesViewModel.filterXHolder.filter as! BlendWithAlphaMaskFX,
                filterPropertiesViewModel:filterPropertiesViewModel,
                filtersPropertiesViewModel:filtersPropertiesViewModel,
                parent: parent)
             */
            
        }
        
        //Tile
        else if filterPropertiesViewModel.filterXHolder.filter is AffineClampFX
        {
            AffineClampPropertiesViewX(fx:filterPropertiesViewModel.filterXHolder.filter as! AffineClampFX,parent: parent)
            
        }
        else if filterPropertiesViewModel.filterXHolder.filter is AffineTileFX
        {
            AffineTilePropertiesViewX(fx:filterPropertiesViewModel.filterXHolder.filter as! AffineTileFX,parent: parent)
            
        }
        else if filterPropertiesViewModel.filterXHolder.filter is EightfoldReflectedTileFX
        {
            EightfoldReflectedTilePropertiesViewX(fx:filterPropertiesViewModel.filterXHolder.filter as! EightfoldReflectedTileFX,parent: parent)
            
        }
        else if filterPropertiesViewModel.filterXHolder.filter is TriangleTileFX
        {
            TriangleTilePropertiesViewX(fx:filterPropertiesViewModel.filterXHolder.filter as! TriangleTileFX,parent: parent)
            
        }
        else if filterPropertiesViewModel.filterXHolder.filter is TwelvefoldReflectedTileFX
        {
            TwelvefoldReflectedTilePropertiesViewX(fx:filterPropertiesViewModel.filterXHolder.filter as! TwelvefoldReflectedTileFX,parent: parent)
            
        }
        else if filterPropertiesViewModel.filterXHolder.filter is SixfoldReflectedTileFX
        {
            SixfoldReflectedTilePropertiesViewX(fx:filterPropertiesViewModel.filterXHolder.filter as! SixfoldReflectedTileFX,parent: parent)
            
        }
        else if filterPropertiesViewModel.filterXHolder.filter is SixfoldRotatedTileFX
        {
            SixfoldRotatedTilePropertiesViewX(fx:filterPropertiesViewModel.filterXHolder.filter as! SixfoldRotatedTileFX,parent: parent)
            
        }
        else if filterPropertiesViewModel.filterXHolder.filter is OpTileFX
        {
            OpTilePropertiesViewX(fx:filterPropertiesViewModel.filterXHolder.filter as! OpTileFX,parent: parent)
            
        }
        else if filterPropertiesViewModel.filterXHolder.filter is GlideReflectedTileFX
        {
            GlideReflectedTilePropertiesViewX(fx:filterPropertiesViewModel.filterXHolder.filter as! GlideReflectedTileFX,parent: parent)
            
        }
        else if filterPropertiesViewModel.filterXHolder.filter is KaleidoscopeFX
        {
            KaleidoscopePropertiesViewX(fx:filterPropertiesViewModel.filterXHolder.filter as! KaleidoscopeFX,parent: parent)
            
        }
        else if filterPropertiesViewModel.filterXHolder.filter is TriangleKaleidoscopeFX
        {
            TriangleKaleidoscopePropertiesViewX(fx:filterPropertiesViewModel.filterXHolder.filter as! TriangleKaleidoscopeFX,parent: parent)
            
        }
        else if filterPropertiesViewModel.filterXHolder.filter is FourfoldRotatedTileFX
        {
            FourfoldRotatedTilePropertiesViewX(fx:filterPropertiesViewModel.filterXHolder.filter as! FourfoldRotatedTileFX,parent: parent)
            
        }
        else if filterPropertiesViewModel.filterXHolder.filter is FourfoldReflectedTileFX
        {
            FourfoldReflectedTilePropertiesViewX(fx:filterPropertiesViewModel.filterXHolder.filter as! FourfoldReflectedTileFX,parent: parent)
            
        }
        else if filterPropertiesViewModel.filterXHolder.filter is ParallelogramTileFX
        {
            ParallelogramTilePropertiesViewX(fx:filterPropertiesViewModel.filterXHolder.filter as! ParallelogramTileFX,parent: parent)
            
        }
        else if filterPropertiesViewModel.filterXHolder.filter is PerspectiveTileFX
        {
            PerspectiveTilePropertiesViewX(fx:filterPropertiesViewModel.filterXHolder.filter as! PerspectiveTileFX,parent: parent)
            
        }
        else if filterPropertiesViewModel.filterXHolder.filter is FourfoldTranslatedTileFX
        {
            FourfoldTranslatedTilePropertiesViewX(fx:filterPropertiesViewModel.filterXHolder.filter as! FourfoldTranslatedTileFX,parent: parent)
            
        }
        
        //Transition
        else if filterPropertiesViewModel.filterXHolder.filter is AccordionFoldTransitionFX
        {
            AccordionFoldTransitionPropertiesViewX(
                fx:filterPropertiesViewModel.filterXHolder.filter as! AccordionFoldTransitionFX,
                filterPropertiesViewModel:filterPropertiesViewModel,
                filtersPropertiesViewModel:filtersPropertiesViewModel,
                parent: parent)
            
        }
        else if filterPropertiesViewModel.filterXHolder.filter is BarsSwipeTransitionFX
        {
            BarsSwipeTransitionPropertiesViewX(
                fx:filterPropertiesViewModel.filterXHolder.filter as! BarsSwipeTransitionFX,
                filterPropertiesViewModel:filterPropertiesViewModel,
                filtersPropertiesViewModel:filtersPropertiesViewModel,
                parent: parent)
            
        }
        else if filterPropertiesViewModel.filterXHolder.filter is DissolveTransitionFX
        {
            DissolveTransitionPropertiesViewX(
                fx:filterPropertiesViewModel.filterXHolder.filter as! DissolveTransitionFX,
                filterPropertiesViewModel:filterPropertiesViewModel,
                filtersPropertiesViewModel:filtersPropertiesViewModel,
                parent: parent)
            
        }
        
        else if filterPropertiesViewModel.filterXHolder.filter is CopyMachineTransitionFX
        {
            CopyMachineTransitionPropertiesViewX(
                fx:filterPropertiesViewModel.filterXHolder.filter as! CopyMachineTransitionFX,
                filterPropertiesViewModel:filterPropertiesViewModel,
                filtersPropertiesViewModel:filtersPropertiesViewModel,
                parent: parent)
            
        }
        
        else if filterPropertiesViewModel.filterXHolder.filter is DisintegrateWithMaskTransitionFX
        {
            DisintegrateWithMaskTransitionPropertiesViewX(
                fx:filterPropertiesViewModel.filterXHolder.filter as! DisintegrateWithMaskTransitionFX,
                filterPropertiesViewModel:filterPropertiesViewModel,
                filtersPropertiesViewModel:filtersPropertiesViewModel,
                parent: parent)
            
        }
        
        else if filterPropertiesViewModel.filterXHolder.filter is FlashTransitionFX
        {
            FlashTransitionPropertiesViewX(
                fx:filterPropertiesViewModel.filterXHolder.filter as! FlashTransitionFX,
                filterPropertiesViewModel:filterPropertiesViewModel,
                filtersPropertiesViewModel:filtersPropertiesViewModel,
                parent: parent)
            
        }
        else if filterPropertiesViewModel.filterXHolder.filter is ModTransitionFX
        {
            ModTransitionPropertiesViewX(
                fx:filterPropertiesViewModel.filterXHolder.filter as! ModTransitionFX,
                filterPropertiesViewModel:filterPropertiesViewModel,
                filtersPropertiesViewModel:filtersPropertiesViewModel,
                parent: parent)
            
        }
        else if filterPropertiesViewModel.filterXHolder.filter is PageCurlTransitionFX
        {
            PageCurlTransitionPropertiesViewX(
                fx:filterPropertiesViewModel.filterXHolder.filter as! PageCurlTransitionFX,
                filterPropertiesViewModel:filterPropertiesViewModel,
                filtersPropertiesViewModel:filtersPropertiesViewModel,
                parent: parent)
            
        }
        else if filterPropertiesViewModel.filterXHolder.filter is PageCurlWithShadowTransitionFX
        {
            PageCurlWithShadowTransitionPropertiesViewX(
                fx:filterPropertiesViewModel.filterXHolder.filter as! PageCurlWithShadowTransitionFX,
                filterPropertiesViewModel:filterPropertiesViewModel,
                filtersPropertiesViewModel:filtersPropertiesViewModel,
                parent: parent)
            
        }
        else if filterPropertiesViewModel.filterXHolder.filter is RippleTransitionFX
        {
            RippleTransitionPropertiesViewX(
                fx:filterPropertiesViewModel.filterXHolder.filter as! RippleTransitionFX,
                filterPropertiesViewModel:filterPropertiesViewModel,
                filtersPropertiesViewModel:filtersPropertiesViewModel,
                parent: parent)
            
        }
        else if filterPropertiesViewModel.filterXHolder.filter is SwipeTransitionFX
        {
            SwipeTransitionPropertiesViewX(
                fx:filterPropertiesViewModel.filterXHolder.filter as! SwipeTransitionFX,
                filterPropertiesViewModel:filterPropertiesViewModel,
                filtersPropertiesViewModel:filtersPropertiesViewModel,
                parent: parent)
            
        }
    }
}
