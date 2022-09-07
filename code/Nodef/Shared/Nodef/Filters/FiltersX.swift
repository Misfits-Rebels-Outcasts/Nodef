//
//  Copyright © 2022 James Boo. All rights reserved.
//

import SwiftUI

class FiltersX: Codable, ObservableObject, Identifiable, Equatable{
    
    static func == (lhs: FiltersX, rhs: FiltersX) -> Bool {
        return lhs.id==rhs.id
    }
    
    var id = UUID()
    
    @Published var presetName : String = "" //no need to save
    @Published var presetLongName : String = "" //no need to save

    @Published var filterList = [FilterXHolder]()
    @Published var size: CGSize =  CGSize(width:0,height:0)
    @Published var boundsCenter: CIVector =  CIVector(x:0,y:0) //no need to save
    
    @Published var viewerIndex:Int = -1
    
    var context:CIContext? = nil
    
    init(_ context: CIContext? = nil) {
        if context==nil
        {
            self.context=CIContext()
        }
        else
        {
            self.context=context
        }
    }

    func add(filterHolder: FilterXHolder)
    {
        let filterXHolder = filterHolder
        filterXHolder.filter.setupProperties(self)
        //setupSizeBoundsAndCenterIfAny(filterXHolder: filterXHolder)
        filterList.append(filterHolder)
        reassignIndexWithoutId()
        //reassignIndex()
    }
    
    func clear()
    {
        filterList = [FilterXHolder]()
        presetName=""
        presetLongName=""
        viewerIndex = -1
    }
    
    enum CodingKeys: String, CodingKey {
        case size
        case boundsCenter
        case filterList
    }
        
    enum FilterTypeKey: CodingKey {
       case type
    }

    enum FilterTypes: String, Decodable {
        
        
        case boxBlur = "CIBoxBlur"
        case discBlur = "CIDiscBlur"
        case gaussianBlur = "CIGaussianBlur"
        case maskedVairableBlur = "CIMaskedVariableBlur"
        case medianFilter = "CIMedianFilter"
        case motionBlur = "CIMotionBlur"
        case noiseReduction = "CINoiseReduction"
        case zoomBlur = "CIZoomBlur"
        
        case colorClamp = "CIColorClamp"
        case colorControls = "CIColorControls"
        case colorMatrix = "CIColorMatrix"
        case colorPolynomial = "CIColorPolynomial"
        case exposureAdjust = "CIExposureAdjust"
        case gammaAdjust = "CIGammaAdjust"
        case hueAdjust = "CIHueAdjust"
        case linearToSRGBToneCurve = "CILinearToSRGBToneCurve"
        case sRGBToneCurveToLinear = "CISRGBToneCurveToLinear"
        case temperatureAndTint = "CITemperatureAndTint"
        case toneCurve = "CIToneCurve"
        case vibrance = "CIVibrance"
        case whitePointAdjust = "CIWhitePointAdjust"

        case colorCrossPolynomial = "CIColorCrossPolynomial"
        case removeColorColorCube = "CIRemoveColorWithColorCube"
        case colorCubeWithColorSpace = "CIColorCubeWithColorSpace"
        case colorInvert = "CIColorInvert"
        case colorMap = "CIColorMap"
        case colorMonochrome = "CIColorMonochrome"
        case colorPosterize = "CIColorPosterize"
        case falseColor = "CIFalseColor"
        case maskToAlpha = "CIMaskToAlpha"
        case maximumComponent = "CIMaximumComponent"
        case minimumComponent = "CIMinimumComponent"
        case photoEffectChrome = "CIPhotoEffectChrome"
        case photoEffectFade = "CIPhotoEffectFade"
        case photoEffectInstant = "CIPhotoEffectInstant"
        case photoEffectMono = "CIPhotoEffectMono"
        case photoEffectNoir = "CIPhotoEffectNoir"
        case photoEffectProcess = "CIPhotoEffectProcess"
        case photoEffectTonal = "CIPhotoEffectTonal"
        case photoEffectTransfer = "CIPhotoEffectTransfer"
        case sepiaTone = "CISepiaTone"
        case vignette = "CIVignette"
        case vignetteEffect = "CIVignetteEffect"
        
        case additionCompositing = "CIAdditionCompositing"
        case colorBlendMode = "CIColorBlendMode"
        case colorBurnBlendMode = "CIColorBurnBlendMode"
        case colorDodgeBlendMode = "CIColorDodgeBlendMode"
        case darkenBlendMode = "CIDarkenBlendMode"
        case differenceBlendMode = "CIDifferenceBlendMode"
        case divideBlendMode = "CIDivideBlendMode"
        case exclusionBlendMode = "CIExclusionBlendMode"
        case hardLightBlendMode = "CIHardLightBlendMode"
        case hueBlendMode = "CIHueBlendMode"
        case lightenBlendMode = "CILightenBlendMode"
        case linearBurnBlendMode = "CILinearBurnBlendMode"
        case linearDodgeBlendMode = "CILinearDodgeBlendMode"
        case luminosityBlendMode = "CILuminosityBlendMode"
        case maximumCompositing = "CIMaximumCompositing"
        case minimumCompositing = "CIMinimumCompositing"
        case multiplyBlendMode = "CIMultiplyBlendMode"
        case multiplyCompositing = "CIMultiplyCompositing"
        case overlayBlendMode = "CIOverlayBlendMode"
        case pinLightBlendMode = "CIPinLightBlendMode"
        case saturationBlendMode = "CISaturationBlendMode"
        case screenBlendMode = "CIScreenBlendMode"
        case softLightBlendMode = "CISoftLightBlendMode"
        case sourceAtopCompositing = "CISourceAtopCompositing"
        case sourceInCompositing = "CISourceInCompositing"
        case sourceOutCompositing = "CISourceOutCompositing"
        case sourceOverCompositing = "CISourceOverCompositing"
        case subtractBlendMode = "CISubtractBlendMode"
        
        case bumpDistortion = "CIBumpDistortion"
        case bumpDistortionLinear = "CIBumpDistortionLinear"
        case circularWarp = "CICircularWrap"
        case droste = "CIDroste"
        case circleSplashDistortion = "CICircleSplashDistortion"
        case glassLozenge = "CIGlassLozenge"
        case glassDistortion = "CIGlassDistortion"
        case displacementDistortion = "CIDisplacementDistortion"
        case holeDistortionDistortion = "CIHoleDistortion"
        case lightTunnel = "CILightTunnel"
        case pinchDistortion = "CIPinchDistortion"
        case stretchCrop = "CIStretchCrop"
        case twirlDistortion = "CITwirlDistortion"
        case torusLensDistortion = "CITorusLensDistortion"
        case vortexDistortion = "CIVortexDistortion"
        
        case aztecCodeGenerator = "CIAztecCodeGenerator"
        case checkerboardGenerator = "CICheckerboardGenerator"
        case code128BarcodeGenerator = "CICode128BarcodeGenerator"
        case constantColorGenerator = "CIConstantColorGenerator"
        case lenticularHaloGenerator = "CILenticularHaloGenerator"
        case pDF417BarcodeGenerator = "CIPDF417BarcodeGenerator"
        case qRCodeGenerator = "CIQRCodeGenerator"
        case randomGenerator = "CIRandomGenerator"
        case starShineGenerator = "CIStarShineGenerator"
        case stripesGenerator = "CIStripesGenerator"
        case sunbeamsGenerator = "CISunbeamsGenerator"
        
        case translate = "CITranslate"
        case rotate = "CIRotate"
        case scale = "CIScale"
        case opacity = "CIOpacity"
        case mix = "CIMix"
        case readImage = "CIReadImage"

        case affineTransform = "CIAffineTransform"
        case crop = "CICrop"
        case lanczosScaleTransform = "CILanczosScaleTransform"
        case perspectiveCorrection = "CIPerspectiveCorrection"
        case perspectiveTransform = "CIPerspectiveTransform"
        case perspectiveTransformWithExtent = "CIPerspectiveTransformWithExtent"
        case straightenFilter = "CIStraightenFilter"
        
        case gaussianGradient = "CIGaussianGradient"
        case linearGradient = "CILinearGradient"
        case radialGradient = "CIRadialGradient"
        case smoothLinearGradient = "CISmoothLinearGradient"
        
        case circularScreen = "CICircularScreen"
        case cMYKHalftone = "CICMYKHalftone"
        case dotScreen = "CIDotScreen"
        case hatchedScreen = "CIHatchedScreen"
        case lineScreen = "CILineScreen"
        
        //reduction
        case areaAverage = "CIAreaAverage"
        case areaHistogram = "CIAreaHistogram"
        case rowAverage = "CIRowAverage"
        case columnAverage = "CIColumnAverage"
        case histogramDisplayFilter = "CIHistogramDisplayFilter"
        case areaMaximum = "CIAreaMaximum"
        case areaMinimum = "CIAreaMinimum"
        case areaMaximumAlpha = "CIAreaMaximumAlpha"
        case areaMinimumAlpha = "CIAreaMinimumAlpha"

        
        case sharpenLuminance = "CISharpenLuminance"
        case unsharpMask = "CIUnsharpMask"

        //stylize
        case blendWithAlphaMask = "CIBlendWithAlphaMask"
        case blendWithMask = "CIBlendWithMask"
        case bloom = "CIBloom"
        case comicEffect = "CIComicEffect"
        case convolution3X3 = "CIConvolution3X3"
        case convolution5X5 = "CIConvolution5X5"
        case convolution7X7 = "CIConvolution7X7"
        case convolution9Horizontal = "CIConvolution9Horizontal"
        case convolution9Vertical = "CIConvolution9Vertical"
        case crystallize = "CICrystallize"
        case depthOfField = "CIDepthOfField"
        case edges = "CIEdges"
        case edgeWork = "CIEdgeWork"
        case gaborGradients = "CIGaborGradients"

        case gloom = "CIGloom"
        case heightFieldFromMask = "CIHeightFieldFromMask"
        case hexagonalPixellate = "CIHexagonalPixellate"
        case highlightShadowAdjust = "CIHighlightShadowAdjust"
        case lineOverlay = "CILineOverlay"
        case pixellate = "CIPixellate"
        case pointillize = "CIPointillize"
        case shadedMaterial = "CIShadedMaterial"
        case spotColor = "CISpotColor"
        case spotLight = "CISpotLight"

        case affineClamp = "CIAffineClamp"
        case affineTile = "CIAffineTile"
        case eightfoldReflectedTile = "CIEightfoldReflectedTile"
        case fourfoldReflectedTile = "CIFourfoldReflectedTile"
        case fourfoldRotatedTile = "CIFourfoldRotatedTile"
        case fourfoldTranslatedTile = "CIFourfoldTranslatedTile"
        case glideReflectedTile = "CIGlideReflectedTile"
        case kaleidoscope = "CIKaleidoscope"
        case opTile = "CIOpTile"
        case parallelogramTile = "CIParallelogramTile"
        case perspectiveTile = "CIPerspectiveTile"
        case sixfoldReflectedTile = "CISixfoldReflectedTile"
        case sixfoldRotatedTile = "CISixfoldRotatedTile"
        case triangleKaleidoscope = "CITriangleKaleidoscope"
        case triangleTile = "CITriangleTile"
        case twelvefoldReflectedTile = "CITwelvefoldReflectedTile"

        //transition
        case accordionFoldTransition = "CIAccordionFoldTransition"
        case barsSwipeTransition = "CIBarsSwipeTransition"
        case copyMachineTransition = "CICopyMachineTransition"
        case disintegrateWithMaskTransition = "CIDisintegrateWithMaskTransition"
        case dissolveTransition = "CIDissolveTransition"
        case flashTransition = "CIFlashTransition"
        case modTransition = "CIModTransition"
        case pageCurlTransition = "CIPageCurlTransition"
        case pageCurlWithShadowTransition = "CIPageCurlWithShadowTransition"
        case rippleTransition = "CIRippleTransition"
        case swipeTransition = "CISwipeTransition"

    }
 
    required init(from decoder: Decoder) throws {
        
        if context==nil
        {
            self.context=CIContext()
        }
        
        let container = try decoder.container(keyedBy: CodingKeys.self)
        size = try container.decodeIfPresent(CGSize.self, forKey: .size) ?? CGSize(width:0.0,height:0.0)
        boundsCenter=CIVector(x:size.width/2.0, y:size.height/2.0)

        var filterArrayForType = try container.nestedUnkeyedContainer(forKey: CodingKeys.filterList)
        var newFilterList = [FilterXHolder]()
        var filtersArray = filterArrayForType //JSONUnkeyedDecodingContainer that contains a currentIndex. assignining it this way gives you another object which currentIndex is independent

        while(!filterArrayForType.isAtEnd)
        {
            //isAtEnd and the nestedContainer will loop through
            //Get the shape which is a KeyedDecodingContainer
            let filter = try filterArrayForType.nestedContainer(keyedBy: FilterTypeKey.self) //causes the currentIndex to increase
            let type = try filter.decode(FilterTypes.self, forKey: FilterTypeKey.type)
  
            let filterXHolder = FilterXHolder()
            switch type {

            case .boxBlur:
                filterXHolder.filter=try filtersArray.decode(BoxBlurFX.self)
            case .discBlur:
                filterXHolder.filter=try filtersArray.decode(DiscBlurFX.self)
            case .gaussianBlur:
                filterXHolder.filter=try filtersArray.decode(GaussianBlurFX.self)
            case .maskedVairableBlur:
                filterXHolder.filter=try filtersArray.decode(MaskedVariableBlurFX.self)
            case .medianFilter:
                filterXHolder.filter=try filtersArray.decode(MedianFilterFX.self)
            case .motionBlur:
                filterXHolder.filter=try filtersArray.decode(MotionBlurFX.self)
            case .noiseReduction:
                filterXHolder.filter=try filtersArray.decode(NoiseReductionFX.self)
            case .zoomBlur:
                filterXHolder.filter=try filtersArray.decode(ZoomBlurFX.self)
                
            case .readImage:
                filterXHolder.filter=try filtersArray.decode(ReadImageFX.self)
            case .colorClamp:
                filterXHolder.filter=try filtersArray.decode(ColorClampFX.self)
            case .colorControls:
                filterXHolder.filter=try filtersArray.decode(ColorControlsFX.self)
            case .colorMatrix:
                filterXHolder.filter=try filtersArray.decode(ColorMatrixFX.self)
            case .colorPolynomial:
                filterXHolder.filter=try filtersArray.decode(ColorPolynomialFX.self)
            case .exposureAdjust:
                filterXHolder.filter=try filtersArray.decode(ExposureAdjustFX.self)
            case .gammaAdjust:
                filterXHolder.filter=try filtersArray.decode(GammaAdjustFX.self)
            case .hueAdjust:
                filterXHolder.filter=try filtersArray.decode(HueAdjustFX.self)
            case .linearToSRGBToneCurve:
                filterXHolder.filter=try filtersArray.decode(LinearToSRGBToneCurveFX.self)
            case .sRGBToneCurveToLinear:
                filterXHolder.filter=try filtersArray.decode(SRGBToneCurveToLinearFX.self)
            case .temperatureAndTint:
                filterXHolder.filter=try filtersArray.decode(TemperatureAndTintFX.self)
            case .toneCurve:
                filterXHolder.filter=try filtersArray.decode(ToneCurveFX.self)
            case .vibrance:
                filterXHolder.filter=try filtersArray.decode(VibranceFX.self)
            case .whitePointAdjust:
                filterXHolder.filter=try filtersArray.decode(WhitePointAdjustFX.self)

            case .colorCrossPolynomial:
                filterXHolder.filter=try filtersArray.decode(ColorCrossPolynomialFX.self)
            case .removeColorColorCube:
                filterXHolder.filter=try filtersArray.decode(ColorCubeFX.self)
            case .colorCubeWithColorSpace:
                filterXHolder.filter=try filtersArray.decode(ColorCubeWithColorSpaceFX.self)
            case .colorInvert:
                filterXHolder.filter=try filtersArray.decode(ColorInvertFX.self)
            case .colorMap:
                filterXHolder.filter=try filtersArray.decode(ColorMapFX.self)
            case .colorMonochrome:
                filterXHolder.filter=try filtersArray.decode(ColorMonochromeFX.self)
            case .colorPosterize:
                filterXHolder.filter=try filtersArray.decode(ColorPosterizeFX.self)
            case .falseColor:
                filterXHolder.filter=try filtersArray.decode(FalseColorFX.self)
            case .maskToAlpha:
                filterXHolder.filter=try filtersArray.decode(MaskToAlphaFX.self)
            case .maximumComponent:
                filterXHolder.filter=try filtersArray.decode(MaximumComponentFX.self)
            case .minimumComponent:
                filterXHolder.filter=try filtersArray.decode(MinimumComponentFX.self)
            case .photoEffectChrome:
                filterXHolder.filter=try filtersArray.decode(PhotoEffectChromeFX.self)
            case .photoEffectFade:
                filterXHolder.filter=try filtersArray.decode(PhotoEffectFadeFX.self)
            case .photoEffectInstant:
                filterXHolder.filter=try filtersArray.decode(PhotoEffectInstantFX.self)
            case .photoEffectMono:
                filterXHolder.filter=try filtersArray.decode(PhotoEffectMonoFX.self)
            case .photoEffectNoir:
                filterXHolder.filter=try filtersArray.decode(PhotoEffectNoirFX.self)
            case .photoEffectProcess:
                filterXHolder.filter=try filtersArray.decode(PhotoEffectProcessFX.self)
            case .photoEffectTonal:
                filterXHolder.filter=try filtersArray.decode(PhotoEffectTonalFX.self)
            case .photoEffectTransfer:
                filterXHolder.filter=try filtersArray.decode(PhotoEffectTransferFX.self)
            case .sepiaTone:
                filterXHolder.filter=try filtersArray.decode(SepiaToneFX.self)
            case .vignette:
                filterXHolder.filter=try filtersArray.decode(VignetteFX.self)
            case .vignetteEffect:
                filterXHolder.filter=try filtersArray.decode(VignetteEffectFX.self)

            case .additionCompositing:
                filterXHolder.filter=try filtersArray.decode(AdditionCompositingFX.self)
            case .colorBlendMode:
                filterXHolder.filter=try filtersArray.decode(ColorBlendModeFX.self)
            case .colorBurnBlendMode:
                filterXHolder.filter=try filtersArray.decode(ColorBurnBlendModeFX.self)
            case .colorDodgeBlendMode:
                filterXHolder.filter=try filtersArray.decode(ColorDodgeBlendModeFX.self)
            case .darkenBlendMode:
                filterXHolder.filter=try filtersArray.decode(DarkenBlendModeFX.self)
            case .differenceBlendMode:
                filterXHolder.filter=try filtersArray.decode(DifferenceBlendModeFX.self)
            case .divideBlendMode:
                filterXHolder.filter=try filtersArray.decode(DivideBlendModeFX.self)
            case .exclusionBlendMode:
                filterXHolder.filter=try filtersArray.decode(ExclusionBlendModeFX.self)
            case .hardLightBlendMode:
                filterXHolder.filter=try filtersArray.decode(HardLightBlendModeFX.self)
            case .hueBlendMode:
                filterXHolder.filter=try filtersArray.decode(HueBlendModeFX.self)
            case .lightenBlendMode:
                filterXHolder.filter=try filtersArray.decode(LightenBlendModeFX.self)
            case .linearBurnBlendMode:
                filterXHolder.filter=try filtersArray.decode(LinearBurnBlendModeFX.self)
            case .linearDodgeBlendMode:
                filterXHolder.filter=try filtersArray.decode(LinearDodgeBlendModeFX.self)
            case .luminosityBlendMode:
                filterXHolder.filter=try filtersArray.decode(LuminosityBlendModeFX.self)
            case .maximumCompositing:
                filterXHolder.filter=try filtersArray.decode(MaximumCompositingFX.self)
            case .minimumCompositing:
                filterXHolder.filter=try filtersArray.decode(MinimumCompositingFX.self)
            case .multiplyBlendMode:
                filterXHolder.filter=try filtersArray.decode(MultiplyBlendModeFX.self)
            case .multiplyCompositing:
                filterXHolder.filter=try filtersArray.decode(MultiplyCompositingFX.self)
            case .overlayBlendMode:
                filterXHolder.filter=try filtersArray.decode(OverlayBlendModeFX.self)
            case .pinLightBlendMode:
                filterXHolder.filter=try filtersArray.decode(LuminosityBlendModeFX.self)
            case .saturationBlendMode:
                filterXHolder.filter=try filtersArray.decode(PinLightBlendModeFX.self)
            case .screenBlendMode:
                filterXHolder.filter=try filtersArray.decode(ScreenBlendModeFX.self)
            case .softLightBlendMode:
                filterXHolder.filter=try filtersArray.decode(SoftLightBlendModeFX.self)
            case .sourceAtopCompositing:
                filterXHolder.filter=try filtersArray.decode(SourceAtopCompositingFX.self)
            case .sourceInCompositing:
                filterXHolder.filter=try filtersArray.decode(SourceInCompositingFX.self)
            case .sourceOutCompositing:
                filterXHolder.filter=try filtersArray.decode(SourceOutCompositingFX.self)
            case .sourceOverCompositing:
                filterXHolder.filter=try filtersArray.decode(SourceOverCompositingFX.self)
            case .subtractBlendMode:
                filterXHolder.filter=try filtersArray.decode(SubtractBlendModeFX.self)

            case .bumpDistortion:
                filterXHolder.filter=try filtersArray.decode(BumpDistortionFX.self)
            case .bumpDistortionLinear:
                filterXHolder.filter=try filtersArray.decode(BumpDistortionLinearFX.self)
            case .circularWarp:
                filterXHolder.filter=try filtersArray.decode(CircularWrapFX.self)
            case .droste:
                filterXHolder.filter=try filtersArray.decode(DrosteFX.self)
           case .circleSplashDistortion:
                filterXHolder.filter=try filtersArray.decode(CircleSplashDistortionFX.self)
            case .glassLozenge:
                filterXHolder.filter=try filtersArray.decode(GlassLozengeFX.self)
            case .glassDistortion:
                filterXHolder.filter=try filtersArray.decode(GlassDistortionFX.self)
            case .displacementDistortion:
                filterXHolder.filter=try filtersArray.decode(DisplacementDistortionFX.self)
           case .holeDistortionDistortion:
                filterXHolder.filter=try filtersArray.decode(HoleDistortionFX.self)
            case .lightTunnel:
                filterXHolder.filter=try filtersArray.decode(LightTunnelFX.self)
           case .pinchDistortion:
                filterXHolder.filter=try filtersArray.decode(PinchDistortionFX.self)
            case .stretchCrop:
                filterXHolder.filter=try filtersArray.decode(StretchCropFX.self)
           case .twirlDistortion:
                filterXHolder.filter=try filtersArray.decode(TwirlDistortionFX.self)
            case .torusLensDistortion:
                filterXHolder.filter=try filtersArray.decode(TorusLensDistortionFX.self)
            case .vortexDistortion:
                filterXHolder.filter=try filtersArray.decode(VortexDistortionFX.self)
                
            case .aztecCodeGenerator:
                filterXHolder.filter=try filtersArray.decode(AztecCodeGeneratorFX.self)
            case .checkerboardGenerator:
                filterXHolder.filter=try filtersArray.decode(CheckerboardGeneratorFX.self)
            case .code128BarcodeGenerator:
                filterXHolder.filter=try filtersArray.decode(Code128BarcodeGeneratorFX.self)
            case .constantColorGenerator:
                filterXHolder.filter=try filtersArray.decode(ConstantColorGeneratorFX.self)
            case .lenticularHaloGenerator:
                filterXHolder.filter=try filtersArray.decode(LenticularHaloGeneratorFX.self)
            case .pDF417BarcodeGenerator:
                filterXHolder.filter=try filtersArray.decode(PDF417BarcodeGeneratorFX.self)
            case .qRCodeGenerator:
                filterXHolder.filter=try filtersArray.decode(QRCodeGeneratorFX.self)
            case .randomGenerator:
                filterXHolder.filter=try filtersArray.decode(RandomGeneratorFX.self)
            case .starShineGenerator:
                filterXHolder.filter=try filtersArray.decode(StarShineGeneratorFX.self)
            case .stripesGenerator:
                filterXHolder.filter=try filtersArray.decode(StripesGeneratorFX.self)
            case .sunbeamsGenerator:
                filterXHolder.filter=try filtersArray.decode(SunbeamsGeneratorFX.self)

            case .translate:
                filterXHolder.filter=try filtersArray.decode(TranslateFX.self)
            case .rotate:
                filterXHolder.filter=try filtersArray.decode(RotateFX.self)
            case .scale:
                filterXHolder.filter=try filtersArray.decode(ScaleFX.self)
            case .opacity:
                filterXHolder.filter=try filtersArray.decode(OpacityFX.self)
            case .mix:
                filterXHolder.filter=try filtersArray.decode(MixFX.self)

            case .affineTransform:
                filterXHolder.filter=try filtersArray.decode(AffineTransformFX.self)
            case .crop:
                filterXHolder.filter=try filtersArray.decode(CropFX.self)
            case .lanczosScaleTransform:
                filterXHolder.filter=try filtersArray.decode(LanczosScaleTransformFX.self)
            case .perspectiveCorrection:
                filterXHolder.filter=try filtersArray.decode(PerspectiveCorrectionFX.self)
            case .perspectiveTransform:
                filterXHolder.filter=try filtersArray.decode(PerspectiveTransformFX.self)
            case .perspectiveTransformWithExtent:
                filterXHolder.filter=try filtersArray.decode(PerspectiveTransformWithExtentFX.self)
            case .straightenFilter:
                filterXHolder.filter=try filtersArray.decode(StraightenFilterFX.self)
                
            case .gaussianGradient:
                filterXHolder.filter=try filtersArray.decode(GaussianGradientFX.self)
            case .linearGradient:
                filterXHolder.filter=try filtersArray.decode(LinearGradientFX.self)
            case .radialGradient:
                filterXHolder.filter=try filtersArray.decode(RadialGradientFX.self)
            case .smoothLinearGradient:
                filterXHolder.filter=try filtersArray.decode(SmoothLinearGradientFX.self)

            case .circularScreen:
                filterXHolder.filter=try filtersArray.decode(CircularScreenFX.self)
            case .cMYKHalftone:
                filterXHolder.filter=try filtersArray.decode(CMYKHalftoneFX.self)
            case .dotScreen:
                filterXHolder.filter=try filtersArray.decode(DotScreenFX.self)
            case .hatchedScreen:
                filterXHolder.filter=try filtersArray.decode(HatchedScreenFX.self)
            case .lineScreen:
                filterXHolder.filter=try filtersArray.decode(LineScreenFX.self)
                
            //Reduction
            case .areaAverage:
                filterXHolder.filter=try filtersArray.decode(AreaAverageFX.self)
            case .areaHistogram:
                filterXHolder.filter=try filtersArray.decode(AreaHistogramFX.self)
            case .rowAverage:
                filterXHolder.filter=try filtersArray.decode(RowAverageFX.self)
            case .columnAverage:
                filterXHolder.filter=try filtersArray.decode(ColumnAverageFX.self)
            case .histogramDisplayFilter:
                filterXHolder.filter=try filtersArray.decode(HistogramDisplayFilterFX.self)
            case .areaMaximum:
                filterXHolder.filter=try filtersArray.decode(AreaMinimumFX.self)
            case .areaMinimum:
                filterXHolder.filter=try filtersArray.decode(AreaMinimumFX.self)
            case .areaMaximumAlpha:
                filterXHolder.filter=try filtersArray.decode(AreaMaximumAlphaFX.self)
            case .areaMinimumAlpha:
                filterXHolder.filter=try filtersArray.decode(AreaMinimumAlphaFX.self)

            case .sharpenLuminance:
                filterXHolder.filter=try filtersArray.decode(SharpenLuminanceFX.self)
            case .unsharpMask:
                filterXHolder.filter=try filtersArray.decode(UnsharpMaskFX.self)
                
            case .blendWithAlphaMask:
                filterXHolder.filter=try filtersArray.decode(BlendWithAlphaMaskFX.self)
            case .blendWithMask:
                filterXHolder.filter=try filtersArray.decode(BlendWithMaskFX.self)
            case .bloom:
                filterXHolder.filter=try filtersArray.decode(BloomFX.self)
            case .comicEffect:
                filterXHolder.filter=try filtersArray.decode(ComicEffectFX.self)
            case .convolution3X3:
                filterXHolder.filter=try filtersArray.decode(Convolution3X3FX.self)
            case .convolution5X5:
                filterXHolder.filter=try filtersArray.decode(Convolution5X5FX.self)
            case .convolution7X7:
                filterXHolder.filter=try filtersArray.decode(Convolution7X7FX.self)
            case .convolution9Horizontal:
                filterXHolder.filter=try filtersArray.decode(Convolution9HorizontalFX.self)
            case .convolution9Vertical:
                filterXHolder.filter=try filtersArray.decode(Convolution9VerticalFX.self)
            case .crystallize:
                filterXHolder.filter=try filtersArray.decode(CrystallizeFX.self)
            case .depthOfField:
                filterXHolder.filter=try filtersArray.decode(DepthOfFieldFX.self)
            case .edges:
                filterXHolder.filter=try filtersArray.decode(EdgesFX.self)
            case .edgeWork:
                filterXHolder.filter=try filtersArray.decode(EdgeWorkFX.self)
            case .gaborGradients:
                filterXHolder.filter=try filtersArray.decode(GaborGradientsFX.self)

            case .gloom:
                filterXHolder.filter=try filtersArray.decode(GloomFX.self)
            case .heightFieldFromMask:
                filterXHolder.filter=try filtersArray.decode(HeightFieldFromMaskFX.self)
            case .hexagonalPixellate:
                filterXHolder.filter=try filtersArray.decode(HexagonalPixellateFX.self)
            case .highlightShadowAdjust:
                filterXHolder.filter=try filtersArray.decode(HighlightShadowAdjustFX.self)
            case .lineOverlay:
                filterXHolder.filter=try filtersArray.decode(LineOverlayFX.self)
            case .pixellate:
                filterXHolder.filter=try filtersArray.decode(PixellateFX.self)
            case .pointillize:
                filterXHolder.filter=try filtersArray.decode(PointillizeFX.self)
            case .shadedMaterial:
                filterXHolder.filter=try filtersArray.decode(ShadedMaterialFX.self)
            case .spotColor:
                filterXHolder.filter=try filtersArray.decode(SpotColorFX.self)
            case .spotLight:
                filterXHolder.filter=try filtersArray.decode(SpotLightFX.self)
                
            case .affineClamp:
                filterXHolder.filter=try filtersArray.decode(AffineClampFX.self)
            case .affineTile:
                filterXHolder.filter=try filtersArray.decode(AffineTileFX.self)
            case .eightfoldReflectedTile:
                filterXHolder.filter=try filtersArray.decode(EightfoldReflectedTileFX.self)
            case .fourfoldReflectedTile:
                filterXHolder.filter=try filtersArray.decode(FourfoldReflectedTileFX.self)
            case .fourfoldRotatedTile:
                filterXHolder.filter=try filtersArray.decode(FourfoldRotatedTileFX.self)
            case .fourfoldTranslatedTile:
                filterXHolder.filter=try filtersArray.decode(FourfoldTranslatedTileFX.self)
            case .glideReflectedTile:
                filterXHolder.filter=try filtersArray.decode(GlideReflectedTileFX.self)
            case .kaleidoscope:
                filterXHolder.filter=try filtersArray.decode(KaleidoscopeFX.self)
            case .opTile:
                filterXHolder.filter=try filtersArray.decode(OpTileFX.self)
            case .parallelogramTile:
                filterXHolder.filter=try filtersArray.decode(ParallelogramTileFX.self)
            case .perspectiveTile:
                filterXHolder.filter=try filtersArray.decode(PerspectiveTileFX.self)
            case .sixfoldReflectedTile:
                filterXHolder.filter=try filtersArray.decode(SixfoldReflectedTileFX.self)
            case .sixfoldRotatedTile:
                filterXHolder.filter=try filtersArray.decode(SixfoldRotatedTileFX.self)
            case .triangleKaleidoscope:
                filterXHolder.filter=try filtersArray.decode(TriangleKaleidoscopeFX.self)
            case .triangleTile:
                filterXHolder.filter=try filtersArray.decode(TriangleTileFX.self)
            case .twelvefoldReflectedTile:
                filterXHolder.filter=try filtersArray.decode(TwelvefoldReflectedTileFX.self)
                
            case .accordionFoldTransition:
                filterXHolder.filter=try filtersArray.decode(AccordionFoldTransitionFX.self)
            case .barsSwipeTransition:
                filterXHolder.filter=try filtersArray.decode(BarsSwipeTransitionFX.self)
            case .copyMachineTransition:
                filterXHolder.filter=try filtersArray.decode(CopyMachineTransitionFX.self)
            case .disintegrateWithMaskTransition:
                filterXHolder.filter=try filtersArray.decode(DisintegrateWithMaskTransitionFX.self)
            case .dissolveTransition:
                filterXHolder.filter=try filtersArray.decode(DissolveTransitionFX.self)
            case .flashTransition:
                filterXHolder.filter=try filtersArray.decode(FlashTransitionFX.self)
            case .modTransition:
                filterXHolder.filter=try filtersArray.decode(ModTransitionFX.self)
            case .pageCurlTransition:
                filterXHolder.filter=try filtersArray.decode(PageCurlTransitionFX.self)
            case .pageCurlWithShadowTransition:
                filterXHolder.filter=try filtersArray.decode(PageCurlWithShadowTransitionFX.self)
            case .rippleTransition:
                filterXHolder.filter=try filtersArray.decode(RippleTransitionFX.self)
            case .swipeTransition:
                filterXHolder.filter=try filtersArray.decode(SwipeTransitionFX.self)

            }

            filterXHolder.filter.parent=self
            newFilterList.append(filterXHolder)

        }
        self.filterList = newFilterList
    }

    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(size, forKey: .size)

        var filterListWithNoHolder = [FilterX]()
        filterList.forEach
        {
            let currentFilterHolder = $0 as FilterXHolder
            filterListWithNoHolder.append(currentFilterHolder.filter)
        }
        print("count:",filterListWithNoHolder.count)
        try container.encode(filterListWithNoHolder, forKey: .filterList)
        
        //try container.encode(filterList, forKey: .filterList)
    }

    func getFilterWithHolder(_ filterName: String)->FilterXHolder {
        
        var innerFilter: FilterX
        var type = "CI"+filterName.filter { !$0.isWhitespace }
        //revisit remporary patch
        /*
        if filterName == "Remove Color With Color Cube"
        {
            type="CIRemoveColorWithColorCube"
        }
        
        print(type)
        */
        if type == "CIBoxBlur"
        {
            innerFilter = BoxBlurFX()
        }
        else if type == "CIDiscBlur"
        {
            innerFilter = DiscBlurFX()
        }
        else if type == "CIGaussianBlur"
        {
            innerFilter = GaussianBlurFX()
        }
        else if type == "CIMaskedVariableBlur"
        {
            innerFilter = MaskedVariableBlurFX()
        }
        else if type == "CIMedianFilter"
        {
            innerFilter = MedianFilterFX()
        }
        else if type == "CIMotionBlur"
        {
            innerFilter = MotionBlurFX()
        }
        else if type == "CINoiseReduction"
        {
            innerFilter = NoiseReductionFX()
        }
        else if type == "CIZoomBlur"
        {
            innerFilter = ZoomBlurFX()
        }
        
        else if type == "CIColorClamp"
        {
            innerFilter = ColorClampFX()
        }
        else if type == "CIReadImage"
        {
            innerFilter = ReadImageFX()
        }
        else if type == "CIColorControls"
        {
            innerFilter = ColorControlsFX()
        }
        else if type == "CIColorMatrix"
        {
            innerFilter = ColorMatrixFX()
        }
        else if type == "CIColorPolynomial"
        {
            innerFilter = ColorPolynomialFX()
        }
        else if type == "CIExposureAdjust"
        {
            innerFilter = ExposureAdjustFX()
        }
        else if type == "CIGammaAdjust"
        {
            innerFilter = GammaAdjustFX()
        }
        else if type == "CIHueAdjust"
        {
            innerFilter = HueAdjustFX()
        }
        else if type == "CILinearToSRGBToneCurve"
        {
            innerFilter = LinearToSRGBToneCurveFX()
        }
        else if type == "CISRGBToneCurveToLinear"
        {
            innerFilter = SRGBToneCurveToLinearFX()
        }
        else if type == "CITemperatureAndTint"
        {
            innerFilter = TemperatureAndTintFX()
        }
        else if type == "CIToneCurve"
        {
            innerFilter = ToneCurveFX()
        }
        else if type == "CIVibrance"
        {
            innerFilter = VibranceFX()
        }
        else if type == "CIWhitePointAdjust"
        {
            innerFilter = WhitePointAdjustFX()
        }
        
        else if type == "CIColorCrossPolynomial"
        {
            innerFilter = ColorCrossPolynomialFX()
        }
        else if type == "CIRemoveColorWithColorCube"
        {
            innerFilter = ColorCubeFX()
        }
        else if type == "CIColorCubeWithColorSpace"
        {
            innerFilter = ColorCubeWithColorSpaceFX()
        }
        else if type == "CIColorInvert"
        {
            innerFilter = ColorInvertFX()
        }

        else if type == "CIColorMap"
        {
            innerFilter = ColorMapFX()
        }
        else if type == "CIColorMonochrome"
        {
            innerFilter = ColorMonochromeFX()
        }
        else if type == "CIColorPosterize"
        {
            innerFilter = ColorPosterizeFX()
        }
        else if type == "CIFalseColor"
        {
            innerFilter = FalseColorFX()
        }
        else if type == "CIMaskToAlpha"
        {
            innerFilter = MaskToAlphaFX()
        }
        else if type == "CIMaximumComponent"
        {
            innerFilter = MaximumComponentFX()
        }
        else if type == "CIMinimumComponent"
        {
            innerFilter = MinimumComponentFX()
        }
        else if type == "CIPhotoEffectChrome"
        {
            innerFilter = PhotoEffectChromeFX()
        }
        else if type == "CIPhotoEffectFade"
        {
            innerFilter = PhotoEffectFadeFX()
        }
        else if type == "CIPhotoEffectInstant"
        {
            innerFilter = PhotoEffectInstantFX()
        }
        else if type == "CIPhotoEffectMono"
        {
            innerFilter = PhotoEffectMonoFX()
        }
        else if type == "CIPhotoEffectNoir"
        {
            innerFilter = PhotoEffectNoirFX()
        }
        else if type == "CIPhotoEffectProcess"
        {
            innerFilter = PhotoEffectProcessFX()
        }
        else if type == "CIPhotoEffectTonal"
        {
            innerFilter = PhotoEffectTonalFX()
        }
        else if type == "CIPhotoEffectTransfer"
        {
            innerFilter = PhotoEffectTransferFX()
        }
        else if type == "CISepiaTone"
        {
            innerFilter = SepiaToneFX()
        }
        else if type == "CIVignette"
        {
            innerFilter = VignetteFX()
        }
        else if type == "CIVignetteEffect"
        {
            innerFilter = VignetteEffectFX()
        }
        
        
        else if type == "CIAdditionCompositing"
        {
            innerFilter = AdditionCompositingFX()
        }
        else if type == "CIColorBlendMode"
        {
            innerFilter = ColorBlendModeFX()
        }
        else if type == "CIColorBurnBlendMode"
        {
            innerFilter = ColorBurnBlendModeFX()
        }
        else if type == "CIColorDodgeBlendMode"
        {
            innerFilter = ColorDodgeBlendModeFX()
        }
        else if type == "CIDarkenBlendMode"
        {
            innerFilter = DarkenBlendModeFX()
        }
        else if type == "CIDifferenceBlendMode"
        {
            innerFilter = DifferenceBlendModeFX()
        }
        else if type == "CIDivideBlendMode"
        {
            innerFilter = DivideBlendModeFX()
        }
        else if type == "CIExclusionBlendMode"
        {
            innerFilter = ExclusionBlendModeFX()
        }
        else if type == "CIHardLightBlendMode"
        {
            innerFilter = HardLightBlendModeFX()
        }
        else if type == "CIHueBlendMode"
        {
            innerFilter = HueBlendModeFX()
        }
        else if type == "CILightenBlendMode"
        {
            innerFilter = LightenBlendModeFX()
        }
        else if type == "CILinearBurnBlendMode"
        {
            innerFilter = LinearBurnBlendModeFX()
        }
        else if type == "CILinearDodgeBlendMode"
        {
            innerFilter = LinearDodgeBlendModeFX()
        }
        else if type == "CILuminosityBlendMode"
        {
            innerFilter = LuminosityBlendModeFX()
        }
        else if type == "CIMaximumCompositing"
        {
            innerFilter = MaximumCompositingFX()
        }
        else if type == "CIMinimumCompositing"
        {
            innerFilter = MinimumCompositingFX()
        }
        else if type == "CIMultiplyBlendMode"
        {
            innerFilter = MultiplyBlendModeFX()
        }
        else if type == "CIMultiplyCompositing"
        {
            innerFilter = MultiplyCompositingFX()
        }
        else if type == "CIOverlayBlendMode"
        {
            innerFilter = OverlayBlendModeFX()
        }
        else if type == "CIPinLightBlendMode"
        {
            innerFilter = PinLightBlendModeFX()
        }
        else if type == "CISaturationBlendMode"
        {
            innerFilter = SaturationBlendModeFX()
        }
        else if type == "CIScreenBlendMode"
        {
            innerFilter = ScreenBlendModeFX()
        }
        else if type == "CISoftLightBlendMode"
        {
            innerFilter = SoftLightBlendModeFX()
        }
        else if type == "CISourceAtopCompositing"
        {
            innerFilter = SourceAtopCompositingFX()
        }
        else if type == "CISourceInCompositing"
        {
            innerFilter = SourceInCompositingFX()
        }
        else if type == "CISourceOutCompositing"
        {
            innerFilter = SourceOutCompositingFX()
        }
        else if type == "CISourceOverCompositing"
        {
            innerFilter = SourceOverCompositingFX()
        }
        else if type == "CISubtractBlendMode"
        {
            innerFilter = SubtractBlendModeFX()
        }
        

        else if type == "CIBumpDistortion"
        {
            innerFilter = BumpDistortionFX()
        }
        else if type == "CIBumpDistortionLinear"
        {
            innerFilter = BumpDistortionLinearFX()
        }
        else if type == "CICircularWrap"
        {
            innerFilter = CircularWrapFX()
        }
        else if type == "CIDroste"
        {
            innerFilter = DrosteFX()
        }
        else if type == "CIDisplacementDistortion"
        {
            innerFilter = DisplacementDistortionFX()
        }
        else if type == "CICircleSplashDistortion"
        {
            innerFilter = CircleSplashDistortionFX()
        }
        else if type == "CIGlassLozenge"
        {
            innerFilter = GlassLozengeFX()
        }
        else if type == "CIGlassDistortion"
        {
            innerFilter = GlassDistortionFX()
        }
        else if type == "CIHoleDistortion"
        {
            innerFilter = HoleDistortionFX()
        }
        else if type == "CILightTunnel"
        {
            innerFilter = LightTunnelFX()
        }
        else if type == "CIPinchDistortion"
        {
            innerFilter = PinchDistortionFX()
        }
        else if type == "CIStretchCrop"
        {
            innerFilter = StretchCropFX()
        }
        else if type == "CITorusLensDistortion"
        {
            innerFilter = TorusLensDistortionFX()
        }
        else if type == "CITwirlDistortion"
        {
            innerFilter = TwirlDistortionFX()
        }
        else if type == "CIVortexDistortion"
        {
            innerFilter = VortexDistortionFX()
        }

        else if type == "CIAztecCodeGenerator"
        {
            innerFilter = AztecCodeGeneratorFX()
        }
        else if type == "CICheckerboardGenerator"
        {
            innerFilter = CheckerboardGeneratorFX()
        }
        else if type == "CICode128BarcodeGenerator"
        {
            innerFilter = Code128BarcodeGeneratorFX()
        }
        else if type == "CIConstantColorGenerator"
        {
            innerFilter = ConstantColorGeneratorFX()
        }
        else if type == "CILenticularHaloGenerator"
        {
            innerFilter = LenticularHaloGeneratorFX()
        }
        else if type == "CIPDF417BarcodeGenerator"
        {
            innerFilter = PDF417BarcodeGeneratorFX()
        }
        else if type == "CIQRCodeGenerator"
        {
            innerFilter = QRCodeGeneratorFX()
        }
        else if type == "CIRandomGenerator"
        {
            innerFilter = RandomGeneratorFX()
        }
        else if type == "CIStarShineGenerator"
        {
            innerFilter = StarShineGeneratorFX()
        }
        else if type == "CIStripesGenerator"
        {
            innerFilter = StripesGeneratorFX()
        }
        else if type == "CISunbeamsGenerator"
        {
            innerFilter = SunbeamsGeneratorFX()
        }
        
        else if type == "CITranslate"
        {
            innerFilter = TranslateFX()
        }
        else if type == "CIRotate"
        {
            innerFilter = RotateFX()
        }
        else if type == "CIScale"
        {
            innerFilter = ScaleFX()
        }
        else if type == "CIOpacity"
        {
            innerFilter = OpacityFX()
        }
        else if type == "CIMix"
        {
            innerFilter = MixFX()
            innerFilter.backgroundImageAlias="0"
        }

        else if type == "CIAffineTransform"
        {
            innerFilter = AffineTransformFX()
        }
        else if type == "CICrop"
        {
            innerFilter = CropFX()
        }
        else if type == "CILanczosScaleTransform"
        {
            innerFilter = LanczosScaleTransformFX()
        }
        else if type == "CIPerspectiveCorrection"
        {
            innerFilter = PerspectiveCorrectionFX()
        }
        else if type == "CIPerspectiveTransform"
        {
            innerFilter = PerspectiveTransformFX()
        }
        else if type == "CIPerspectiveTransformWithExtent"
        {
            innerFilter = PerspectiveTransformWithExtentFX()
        }
        else if type == "CIStraightenFilter"
        {
            innerFilter = StraightenFilterFX()
        }
 
        else if type == "CIGaussianGradient"
        {
            innerFilter = GaussianGradientFX()
        }
        else if type == "CILinearGradient"
        {
            innerFilter = LinearGradientFX()
        }
        else if type == "CIRadialGradient"
        {
            innerFilter = RadialGradientFX()
        }
        else if type == "CISmoothLinearGradient"
        {
            innerFilter = SmoothLinearGradientFX()
        }

        else if type == "CICircularScreen"
        {
            innerFilter = CircularScreenFX()
        }
        else if type == "CICMYKHalftone"
        {
            innerFilter = CMYKHalftoneFX()
        }
        else if type == "CIDotScreen"
        {
            innerFilter = DotScreenFX()
        }
        else if type == "CIHatchedScreen"
        {
            innerFilter = HatchedScreenFX()
        }
        else if type == "CILineScreen"
        {
            innerFilter = LineScreenFX()
        }
        //reduction
        else if type == "CIAreaAverage"
        {
            innerFilter = AreaAverageFX()
        }
        else if type == "CIAreaHistogram"
        {
            innerFilter = AreaHistogramFX()
        }
        else if type == "CIRowAverage"
        {
            innerFilter = RowAverageFX()
        }
        else if type == "CIColumnAverage"
        {
            innerFilter = ColumnAverageFX()
        }
        else if type == "CIHistogramDisplayFilter"
        {
            innerFilter = HistogramDisplayFilterFX()
        }
        else if type == "CIAreaMaximum"
        {
            innerFilter = AreaMaximumFX()
        }
        else if type == "CIAreaMinimum"
        {
            innerFilter = AreaMinimumFX()
        }
        else if type == "CIAreaMaximumAlpha"
        {
            innerFilter = AreaMaximumAlphaFX()
        }
        else if type == "CIAreaMinimumAlpha"
        {
            innerFilter = AreaMinimumAlphaFX()
        }
        else if type == "CISharpenLuminance"
        {
            innerFilter = SharpenLuminanceFX()
        }
        else if type == "CIUnsharpMask"
        {
            innerFilter = UnsharpMaskFX()
        }

        else if type == "CIBlendWithAlphaMask"
        {
            innerFilter = BlendWithAlphaMaskFX()
            innerFilter.backgroundImageAlias="0"
            //innerFilter.inputImageAlias="0"
            //(innerFilter as! BlendWithAlphaMaskFX).inputMaskImageAlias=""
        }
        else if type == "CIBlendWithMask"
        {
            innerFilter = BlendWithMaskFX()
            innerFilter.backgroundImageAlias="0"
            //innerFilter.inputImageAlias="0"
            //(innerFilter as! BlendWithMaskFX).inputMaskImageAlias=""
        }
        else if type == "CIBloom"
        {
            innerFilter = BloomFX()
        }
        else if type == "CIComicEffect"
        {
            innerFilter = ComicEffectFX()
        }
        else if type == "CIConvolution3X3"
        {
            innerFilter = Convolution3X3FX()
        }
        else if type == "CIConvolution5X5"
        {
            innerFilter = Convolution5X5FX()
        }
        else if type == "CIConvolution7X7"
        {
            innerFilter = Convolution7X7FX()
        }
        else if type == "CIConvolution9Horizontal"
        {
            innerFilter = Convolution9HorizontalFX()
        }
        else if type == "CIConvolution9Vertical"
        {
            innerFilter = Convolution9VerticalFX()
        }
        else if type == "CICrystallize"
        {
            innerFilter = CrystallizeFX()
        }
        else if type == "CIDepthOfField"
        {
            innerFilter = DepthOfFieldFX()
        }
        else if type == "CIEdges"
        {
            innerFilter = EdgesFX()
        }
        else if type == "CIEdgeWork"
        {
            innerFilter = EdgeWorkFX()
        }
        else if type == "CIGaborGradients"
        {
            innerFilter = GaborGradientsFX()
        }
        else if type == "CIGloom"
        {
            innerFilter = GloomFX()
        }
        else if type == "CIHeightFieldFromMask"
        {
            innerFilter = HeightFieldFromMaskFX()
        }
        else if type == "CIHexagonalPixellate"
        {
            innerFilter = HexagonalPixellateFX()
        }
        else if type == "CIHighlightShadowAdjust"
        {
            innerFilter = HighlightShadowAdjustFX()
        }
        else if type == "CILineOverlay"
        {
            innerFilter = LineOverlayFX()
        }
        else if type == "CIPixellate"
        {
            innerFilter = PixellateFX()
        }
        else if type == "CIPointillize"
        {
            innerFilter = PointillizeFX()
        }
        else if type == "CIShadedMaterial"
        {
            innerFilter = ShadedMaterialFX()
            //innerFilter.inputImageAlias="0"
            //(innerFilter as! ShadedMaterialFX).inputShadingImageAlias=""
        }
        else if type == "CISpotColor"
        {
            innerFilter = SpotColorFX()
        }
        else if type == "CISpotLight"
        {
            innerFilter = SpotLightFX()
        }
        else if type == "CIAffineClamp"
        {
            innerFilter = AffineClampFX()
        }
        else if type == "CIAffineTile"
        {
            innerFilter = AffineTileFX()
        }
        else if type == "CIEightfoldReflectedTile"
        {
            innerFilter = EightfoldReflectedTileFX()
        }
        else if type == "CIFourfoldReflectedTile"
        {
            innerFilter = FourfoldReflectedTileFX()
        }
        else if type == "CIFourfoldRotatedTile"
        {
            innerFilter = FourfoldRotatedTileFX()
        }
        else if type == "CIFourfoldTranslatedTile"
        {
            innerFilter = FourfoldTranslatedTileFX()
        }
        else if type == "CIGlideReflectedTile"
        {
            innerFilter = GlideReflectedTileFX()
        }
        else if type == "CIKaleidoscope"
        {
            innerFilter = KaleidoscopeFX()
        }
        else if type == "CIOpTile"
        {
            innerFilter = OpTileFX()
        }
        else if type == "CIParallelogramTile"
        {
            innerFilter = ParallelogramTileFX()
        }
        else if type == "CIPerspectiveTile"
        {
            innerFilter = PerspectiveTileFX()
        }
        else if type == "CISixfoldReflectedTile"
        {
            innerFilter = SixfoldReflectedTileFX()
        }
        else if type == "CISixfoldRotatedTile"
        {
            innerFilter = SixfoldRotatedTileFX()
        }
        else if type == "CITriangleKaleidoscope"
        {
            innerFilter = TriangleKaleidoscopeFX()
        }
        else if type == "CITriangleTile"
        {
            innerFilter = TriangleTileFX()
        }
        else if type == "CITwelvefoldReflectedTile"
        {
            innerFilter = TwelvefoldReflectedTileFX()
        }

        else if type == "CIAccordionFoldTransition"
        {
            innerFilter = AccordionFoldTransitionFX()
        }
        else if type == "CIBarsSwipeTransition"
        {
            innerFilter = BarsSwipeTransitionFX()
        }
        else if type == "CICopyMachineTransition"
        {
            innerFilter = CopyMachineTransitionFX()
        }
        else if type == "CIDisintegrateWithMaskTransition"
        {
            innerFilter = DisintegrateWithMaskTransitionFX()
        }
        else if type == "CIDissolveTransition"
        {
            innerFilter = DissolveTransitionFX()
        }
        else if type == "CIFlashTransition"
        {
            innerFilter = FlashTransitionFX()
        }
        else if type == "CIModTransition"
        {
            innerFilter = ModTransitionFX()
        }
        else if type == "CIPageCurlTransition"
        {
            innerFilter = PageCurlTransitionFX()
        }
        else if type == "CIPageCurlWithShadowTransition"
        {
            innerFilter = PageCurlWithShadowTransitionFX()
        }
        else if type == "CIRippleTransition"
        {
            innerFilter = RippleTransitionFX()
        }
        else if type == "CISwipeTransition"
        {
            innerFilter = SwipeTransitionFX()
        }

        else{
            innerFilter = ColorControlsFX()

        }
        
        innerFilter.setupProperties(self)

        
        if innerFilter is BaseBlendFX{
            innerFilter.backgroundImageAlias="0"
        }
        
        
        if innerFilter is BaseTransitionFX{
            innerFilter.inputImageAlias=""
            (innerFilter as! BaseTransitionFX).targetImageAlias="0"
        }
        
        let filterXHolder = FilterXHolder()
        filterXHolder.filter=innerFilter
        return filterXHolder

    }

    func handleAlias(inputAlias: String, inputImage: CIImage, beginImage: CIImage)->CIImage
    {
        if inputAlias != ""
        {
            let num = Int(inputAlias)
            if num != nil {
                
                if num == 0{
                    return beginImage
                }
                
                if let filterWithInputAlias = filterList.first(where: {$0.filter.nodeIndex == num}) {
                    print("handleAlias#")
                    if let cifilterUw = filterWithInputAlias.filter.getCIFilter()
                    {
                        return cifilterUw.outputImage!
                    }
                }
            }
            else {
                if let filterWithInputAlias = filterList.first(where: {$0.filter.alias == inputAlias}) {
                    print("handleAlias")
                    if let cifilterUw = filterWithInputAlias.filter.getCIFilter()
                    {
                        return cifilterUw.outputImage!
                    }
                }
            }
            
        }
        return inputImage
    }
    
    func setViewer(nodeIndex: Int)
    {
        viewerIndex=nodeIndex
    }
    func resetViewer()
    {
        viewerIndex = -1
    }
    
    func initNodeIndex()
    {
        viewerIndex = -1
        
        var counter=1
        filterList.forEach
        {
            let currentFilter = $0.filter
            currentFilter.nodeIndex=counter
            counter=counter+1
        }
        filterList.forEach
        {
            let currentFilter = $0.filter
            if currentFilter.inputImageAlias != "" && currentFilter.inputImageAlias != "0" {
                
                filterList.forEach
                {
                    let innerFilter = $0.filter
                    if currentFilter.inputImageAlias == String(innerFilter.nodeIndex) {
                        currentFilter.inputImageAliasId = innerFilter.id.uuidString
                    }
                }
            }
            if currentFilter.backgroundImageAlias != "" && currentFilter.backgroundImageAlias != "0" {
                
                filterList.forEach
                {
                    let innerFilter = $0.filter
                    if currentFilter.backgroundImageAlias == String(innerFilter.nodeIndex) {
                        currentFilter.backgroundImageAliasId = innerFilter.id.uuidString
                    }
                }
            }
            
            if currentFilter is BaseTransitionFX {
                let cf = currentFilter as! BaseTransitionFX
                if cf.targetImageAlias != "" && cf.targetImageAlias != "0" {
                    filterList.forEach
                    {
                        let innerFilter = $0.filter
                        if cf.targetImageAlias == String(innerFilter.nodeIndex) {
                            cf.targetImageAliasId = innerFilter.id.uuidString
                        }
                    }
                }
            }
            
            if currentFilter is BlendWithMaskFX {
                let cf = currentFilter as! BlendWithMaskFX
                if cf.inputMaskImageAlias != "" && cf.inputMaskImageAlias != "0" {
                    filterList.forEach
                    {
                        let innerFilter = $0.filter
                        if cf.inputMaskImageAlias == String(innerFilter.nodeIndex) {
                            cf.inputMaskImageAliasId = innerFilter.id.uuidString
                        }
                    }
                }
            }
            
            if currentFilter is BlendWithAlphaMaskFX {
                let cf = currentFilter as! BlendWithAlphaMaskFX
                if cf.inputMaskImageAlias != "" && cf.inputMaskImageAlias != "0" {
                    filterList.forEach
                    {
                        let innerFilter = $0.filter
                        if cf.inputMaskImageAlias == String(innerFilter.nodeIndex) {
                            cf.inputMaskImageAliasId = innerFilter.id.uuidString
                        }
                    }
                }
            }

            if currentFilter is MaskedVariableBlurFX {
                let cf = currentFilter as! MaskedVariableBlurFX
                if cf.inputMaskImageAlias != "" && cf.inputMaskImageAlias != "0" {
                    filterList.forEach
                    {
                        let innerFilter = $0.filter
                        if cf.inputMaskImageAlias == String(innerFilter.nodeIndex) {
                            cf.inputMaskImageAliasId = innerFilter.id.uuidString
                        }
                    }
                }
            }
            
            if currentFilter is ShadedMaterialFX {
                let cf = currentFilter as! ShadedMaterialFX
                if cf.inputShadingImageAlias != "" && cf.inputShadingImageAlias != "0" {
                    filterList.forEach
                    {
                        let innerFilter = $0.filter
                        if cf.inputShadingImageAlias == String(innerFilter.nodeIndex) {
                            cf.inputShadingImageAliasId = innerFilter.id.uuidString
                        }
                    }
                }
            }
            
            if currentFilter is GlassDistortionFX {
                let cf = currentFilter as! GlassDistortionFX
                if cf.inputTextureAlias != "" && cf.inputTextureAlias != "0" {
                    filterList.forEach
                    {
                        let innerFilter = $0.filter
                        if cf.inputTextureAlias == String(innerFilter.nodeIndex) {
                            cf.inputTextureAliasId = innerFilter.id.uuidString
                        }
                    }
                }
            }
            
            if currentFilter is DisplacementDistortionFX {
                let cf = currentFilter as! DisplacementDistortionFX
                if cf.inputDisplacementImageAlias != "" && cf.inputDisplacementImageAlias != "0" {
                    filterList.forEach
                    {
                        let innerFilter = $0.filter
                        if cf.inputDisplacementImageAlias == String(innerFilter.nodeIndex) {
                            cf.inputDisplacementImageAliasId = innerFilter.id.uuidString
                        }
                    }
                }
            }
            
            if currentFilter is RippleTransitionFX {
                let cf = currentFilter as! RippleTransitionFX
                if cf.inputShadingImageAlias != "" && cf.inputShadingImageAlias != "0" {
                    filterList.forEach
                    {
                        let innerFilter = $0.filter
                        if cf.inputShadingImageAlias == String(innerFilter.nodeIndex) {
                            cf.inputShadingImageAliasId = innerFilter.id.uuidString
                        }
                    }
                }
            }
            
            if currentFilter is DisintegrateWithMaskTransitionFX {
                let cf = currentFilter as! DisintegrateWithMaskTransitionFX
                if cf.inputMaskImageAlias != "" && cf.inputMaskImageAlias != "0" {
                    filterList.forEach
                    {
                        let innerFilter = $0.filter
                        if cf.inputMaskImageAlias == String(innerFilter.nodeIndex) {
                            cf.inputMaskImageAliasId = innerFilter.id.uuidString
                        }
                    }
                }
            }
            
            if currentFilter is PageCurlTransitionFX {
                let cf = currentFilter as! PageCurlTransitionFX
                if cf.inputBacksideImageAlias != "" && cf.inputBacksideImageAlias != "0" {
                    filterList.forEach
                    {
                        let innerFilter = $0.filter
                        if cf.inputBacksideImageAlias == String(innerFilter.nodeIndex) {
                            cf.inputBacksideImageAliasId = innerFilter.id.uuidString
                        }
                    }
                }
                if cf.inputShadingImageAlias != "" && cf.inputShadingImageAlias != "0" {
                    filterList.forEach
                    {
                        let innerFilter = $0.filter
                        if cf.inputShadingImageAlias == String(innerFilter.nodeIndex) {
                            cf.inputShadingImageAliasId = innerFilter.id.uuidString
                        }
                    }
                }
            }
            
            if currentFilter is PageCurlWithShadowTransitionFX {
                let cf = currentFilter as! PageCurlWithShadowTransitionFX
                if cf.inputBacksideImageAlias != "" && cf.inputBacksideImageAlias != "0" {
                    filterList.forEach
                    {
                        let innerFilter = $0.filter
                        if cf.inputBacksideImageAlias == String(innerFilter.nodeIndex) {
                            cf.inputBacksideImageAliasId = innerFilter.id.uuidString
                        }
                    }
                }
            }
            
        }
    }
    
    func reassignIndexWithoutId()
    {
        viewerIndex = -1
        
        var counter=1
        filterList.forEach
        {
            let currentFilter = $0.filter
            currentFilter.nodeIndex=counter
            counter=counter+1
        }
    }
    
    func reassignIndex()
    {
        viewerIndex = -1
        
        var counter=1
        filterList.forEach
        {
            let currentFilter = $0.filter
            currentFilter.nodeIndex=counter
            counter=counter+1
        }
        
        filterList.forEach
        {
            let currentFilter = $0.filter
            if currentFilter.inputImageAlias != "" && currentFilter.inputImageAlias != "0" {
                var found=false
                filterList.forEach
                {
                    let innerFilter = $0.filter
                    if currentFilter.inputImageAliasId == innerFilter.id.uuidString {
                        if innerFilter.nodeIndex < currentFilter.nodeIndex {
                            currentFilter.inputImageAlias = String(innerFilter.nodeIndex)
                        }
                        else {
                            currentFilter.inputImageAlias = "#REF!"
                        }
                        found=true
                    }
                }
                if found == false {
                    currentFilter.inputImageAlias = "#REF!"
                }
            }
            
            if currentFilter.backgroundImageAlias != "" && currentFilter.backgroundImageAlias != "0" {
                var found=false
                filterList.forEach
                {
                    let innerFilter = $0.filter
                    if currentFilter.backgroundImageAliasId == innerFilter.id.uuidString {
                        if innerFilter.nodeIndex < currentFilter.nodeIndex {
                            currentFilter.backgroundImageAlias = String(innerFilter.nodeIndex)
                        }
                        else {
                            currentFilter.backgroundImageAlias = "#REF!"
                        }
                        found=true

                    }
                }
                if found == false {
                    currentFilter.backgroundImageAlias = "#REF!"
                }

            }
            
            if currentFilter is BaseTransitionFX {
                let cf = currentFilter as! BaseTransitionFX
                if cf.targetImageAlias != "" && cf.targetImageAlias != "0" {
                    var found=false
                    filterList.forEach
                    {
                        let innerFilter = $0.filter
                        if cf.targetImageAliasId == innerFilter.id.uuidString {
                            if innerFilter.nodeIndex < currentFilter.nodeIndex {
                                cf.targetImageAlias = String(innerFilter.nodeIndex)
                            }
                            else {
                                cf.targetImageAlias = "#REF!"
                            }
                            found=true

                        }
                        
                    }
                    if found == false {
                        cf.targetImageAlias = "#REF!"
                    }
                }
            }
            
            if currentFilter is BlendWithMaskFX {
                let cf = currentFilter as! BlendWithMaskFX
                if cf.inputMaskImageAlias != "" && cf.inputMaskImageAlias != "0" {
                    var found=false
                    filterList.forEach
                    {
                        let innerFilter = $0.filter
                        if cf.inputMaskImageAliasId == innerFilter.id.uuidString {
                            if innerFilter.nodeIndex < currentFilter.nodeIndex {
                                cf.inputMaskImageAlias = String(innerFilter.nodeIndex)
                            }
                            else {
                                cf.inputMaskImageAlias = "#REF!"
                            }
                            found=true

                        }                     }
                    if found == false {
                        cf.inputMaskImageAlias = "#REF!"
                    }

                }
            }

            if currentFilter is BlendWithAlphaMaskFX {
                let cf = currentFilter as! BlendWithAlphaMaskFX
                if cf.inputMaskImageAlias != "" && cf.inputMaskImageAlias != "0" {
                    var found=false
                    filterList.forEach
                    {
                        let innerFilter = $0.filter
                        if cf.inputMaskImageAliasId == innerFilter.id.uuidString {
                            if innerFilter.nodeIndex < currentFilter.nodeIndex {
                                cf.inputMaskImageAlias = String(innerFilter.nodeIndex)
                            }
                            else {
                                cf.inputMaskImageAlias = "#REF!"
                            }
                            found=true

                        }
                    }
                    if found == false {
                        cf.inputMaskImageAlias = "#REF!"
                    }

                }
            }

            if currentFilter is MaskedVariableBlurFX {
                let cf = currentFilter as! MaskedVariableBlurFX
                if cf.inputMaskImageAlias != "" && cf.inputMaskImageAlias != "0" {
                    var found=false
                    filterList.forEach
                    {
                        let innerFilter = $0.filter
                        if cf.inputMaskImageAliasId == innerFilter.id.uuidString {
                            if innerFilter.nodeIndex < currentFilter.nodeIndex {
                                cf.inputMaskImageAlias = String(innerFilter.nodeIndex)
                            }
                            else {
                                cf.inputMaskImageAlias = "#REF!"
                            }
                            found=true

                        }
                    }
                    if found == false {
                        cf.inputMaskImageAlias = "#REF!"
                    }

                }
            }

            if currentFilter is ShadedMaterialFX {
                let cf = currentFilter as! ShadedMaterialFX
                if cf.inputShadingImageAlias != "" && cf.inputShadingImageAlias != "0" {
                    var found=false
                    filterList.forEach
                    {
                        let innerFilter = $0.filter
                        if cf.inputShadingImageAliasId == innerFilter.id.uuidString {
                            if innerFilter.nodeIndex < currentFilter.nodeIndex {
                                cf.inputShadingImageAlias = String(innerFilter.nodeIndex)
                            }
                            else {
                                cf.inputShadingImageAlias = "#REF!"
                            }
                            found=true

                        }
                    }
                    if found == false {
                        cf.inputShadingImageAlias = "#REF!"
                    }

                }
            }

            if currentFilter is GlassDistortionFX {
                let cf = currentFilter as! GlassDistortionFX
                if cf.inputTextureAlias != "" && cf.inputTextureAlias != "0" {
                    var found=false
                    filterList.forEach
                    {
                        let innerFilter = $0.filter
                        if cf.inputTextureAliasId == innerFilter.id.uuidString {
                            if innerFilter.nodeIndex < currentFilter.nodeIndex {
                                cf.inputTextureAlias = String(innerFilter.nodeIndex)
                            }
                            else {
                                cf.inputTextureAlias = "#REF!"
                            }
                            found=true

                        }
                    }
                    if found == false {
                        cf.inputTextureAlias = "#REF!"
                    }

                }
            }
            
            if currentFilter is DisplacementDistortionFX {
                let cf = currentFilter as! DisplacementDistortionFX
                if cf.inputDisplacementImageAlias != "" && cf.inputDisplacementImageAlias != "0" {
                    var found=false
                    filterList.forEach
                    {
                        let innerFilter = $0.filter
                        if cf.inputDisplacementImageAliasId == innerFilter.id.uuidString {
                            if innerFilter.nodeIndex < currentFilter.nodeIndex {
                                cf.inputDisplacementImageAlias = String(innerFilter.nodeIndex)
                            }
                            else {
                                cf.inputDisplacementImageAlias = "#REF!"
                            }
                            found=true

                        }
                    }
                    if found == false {
                        cf.inputDisplacementImageAlias = "#REF!"
                    }

                }
            }
            
            if currentFilter is RippleTransitionFX {
                let cf = currentFilter as! RippleTransitionFX
                if cf.inputShadingImageAlias != "" && cf.inputShadingImageAlias != "0" {
                    var found=false
                    filterList.forEach
                    {
                        let innerFilter = $0.filter
                        if cf.inputShadingImageAliasId == innerFilter.id.uuidString {
                            if innerFilter.nodeIndex < currentFilter.nodeIndex {
                                cf.inputShadingImageAlias = String(innerFilter.nodeIndex)
                            }
                            else {
                                cf.inputShadingImageAlias = "#REF!"
                            }
                            found=true

                        }
                    }
                    if found == false {
                        cf.inputShadingImageAlias = "#REF!"
                    }

                }
            }
            
            if currentFilter is DisintegrateWithMaskTransitionFX {
                let cf = currentFilter as! DisintegrateWithMaskTransitionFX
                if cf.inputMaskImageAlias != "" && cf.inputMaskImageAlias != "0" {
                    var found=false
                    filterList.forEach
                    {
                        let innerFilter = $0.filter
                        if cf.inputMaskImageAliasId == innerFilter.id.uuidString {
                            if innerFilter.nodeIndex < currentFilter.nodeIndex {
                                cf.inputMaskImageAlias = String(innerFilter.nodeIndex)
                            }
                            else {
                                cf.inputMaskImageAlias = "#REF!"
                            }
                            found=true

                        }
                    }
                    if found == false {
                        cf.inputMaskImageAlias = "#REF!"
                    }

                }
            }
            
            if currentFilter is PageCurlTransitionFX {
                let cf = currentFilter as! PageCurlTransitionFX
                if cf.inputBacksideImageAlias != "" && cf.inputBacksideImageAlias != "0" {
                    var found=false
                    filterList.forEach
                    {
                        let innerFilter = $0.filter
                        if cf.inputBacksideImageAliasId == innerFilter.id.uuidString {
                            if innerFilter.nodeIndex < currentFilter.nodeIndex {
                                cf.inputBacksideImageAlias = String(innerFilter.nodeIndex)
                            }
                            else {
                                cf.inputBacksideImageAlias = "#REF!"
                            }
                            found=true

                        }
                    }
                    if found == false {
                        cf.inputBacksideImageAlias = "#REF!"
                    }

                }
                if cf.inputShadingImageAlias != "" && cf.inputShadingImageAlias != "0" {
                    var found=false
                    filterList.forEach
                    {
                        let innerFilter = $0.filter
                        if cf.inputShadingImageAliasId == innerFilter.id.uuidString {
                            if innerFilter.nodeIndex < currentFilter.nodeIndex {
                                cf.inputShadingImageAlias = String(innerFilter.nodeIndex)
                            }
                            else {
                                cf.inputShadingImageAlias = "#REF!"
                            }
                            found=true

                        }
                    }
                    if found == false {
                        cf.inputShadingImageAlias = "#REF!"
                    }

                }
            }
            
            if currentFilter is PageCurlWithShadowTransitionFX {
                let cf = currentFilter as! PageCurlWithShadowTransitionFX
                if cf.inputBacksideImageAlias != "" && cf.inputBacksideImageAlias != "0" {
                    var found=false
                    filterList.forEach
                    {
                        let innerFilter = $0.filter
                        if cf.inputBacksideImageAliasId == innerFilter.id.uuidString {
                            if innerFilter.nodeIndex < currentFilter.nodeIndex {
                                cf.inputBacksideImageAlias = String(innerFilter.nodeIndex)
                            }
                            else {
                                cf.inputBacksideImageAlias = "#REF!"
                            }
                            found=true

                        }
                    }
                    if found == false {
                        cf.inputBacksideImageAlias = "#REF!"
                    }

                }
            }
            
            
        }
        
    }

    
    
    
    func reAdjustProperties()
    {
        filterList.forEach
        {
            let filterXHolder = $0
            filterXHolder.filter.adjustPropertiesToBounds(self)
        }
    }
    
    func reSetupProperties()
    {
        filterList.forEach
        {
            let filterXHolder = $0
            filterXHolder.filter.setupProperties(self)
        }
    }
    
    func reassignAllBounds()
    {
        filterList.forEach
        {
            let filterXHolder = $0
            filterXHolder.filter.size=self.size
            filterXHolder.filter.boundsCenter=self.boundsCenter
            
            //setupSizeBoundsAndCenterIfAny(filterXHolder: filterXHolder)
        }
    }
    
    func setPresetName(name: String){
        presetLongName=name
                
        let lowerCase = CharacterSet.lowercaseLetters
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
        
        presetName=String(retName.prefix(4))

    }
    
    func compensatePresets()
    {
        if presetLongName != ""
        {
            filterList.forEach
            {
                let filterXHolder = $0
                filterXHolder.filter.setupProperties(self)
                //setupSizeBoundsAndCenterIfAny(filterXHolder: filterXHolder)
                
                //this will reduce reliance on the above.
                filterXHolder.filter.setupProperties(self)
                
                if presetLongName == "Color Invert Color Burn Blend Mode"
                {
                    if filterXHolder.filter is ColorControlsFX
                    {
                        (filterXHolder.filter as! ColorControlsFX).brightness=0.4
                    }
                }
                else if presetLongName == "Pinch Distortion"
                {
                    if filterXHolder.filter is PinchDistortionFX
                    {
                        let tdFX = PinchDistortionFX()
                        (filterXHolder.filter as! PinchDistortionFX).radius=tdFX.radius
                        (filterXHolder.filter as! PinchDistortionFX).scale=tdFX.scale
                    }
                }
                else if presetLongName == "Light Tunnel"
                {
                    if filterXHolder.filter is LightTunnelFX
                    {
                        let tdFX = LightTunnelFX()
                        (filterXHolder.filter as! LightTunnelFX).rotation=2.0
                    }
                }
                else if presetLongName == "Lenticular Soft Light Blend"
                {
                    if filterXHolder.filter is LenticularHaloGeneratorFX
                    {
                        //let tdFX = LenticularHaloGeneratorFX()
                        (filterXHolder.filter as! LenticularHaloGeneratorFX).haloWidth=300.0
                
                    }
                }
                else if presetLongName == "Twirl Distortion"
                {
                    if filterXHolder.filter is TwirlDistortionFX
                    {
                        let tdFX = TwirlDistortionFX()
                        (filterXHolder.filter as! TwirlDistortionFX).radius=tdFX.radius
                        (filterXHolder.filter as! TwirlDistortionFX).angle=tdFX.angle
                    }
                }
                else if presetLongName == "Bump Distortion"
                {
                    if filterXHolder.filter is BumpDistortionFX
                    {
                        (filterXHolder.filter as! BumpDistortionFX).radius=600
                        (filterXHolder.filter as! BumpDistortionFX).scale=1.0
                    }
                }
                else if presetLongName == "Vortex Distortion"
                {
                    if filterXHolder.filter is VortexDistortionFX
                    {
                        (filterXHolder.filter as! VortexDistortionFX).radius=515
                        (filterXHolder.filter as! VortexDistortionFX).angle=316
                    }
                }
                else if presetLongName == "CMYK Halftone"
                {
                    if filterXHolder.filter is CMYKHalftoneFX
                    {
                        (filterXHolder.filter as! CMYKHalftoneFX).width=24.0
                    }
                }
                else if presetLongName == "Checkerboard Light Tunnel Difference Blend"
                {
                    if filterXHolder.filter is CheckerboardGeneratorFX
                    {
                        let tdFX = CheckerboardGeneratorFX()
                        (filterXHolder.filter as! CheckerboardGeneratorFX).width=50//250.0//tdFX.width
                    }
                    
                    if filterXHolder.filter is LightTunnelFX
                    {
                        //let tdFX = CheckerboardGeneratorFX()
                        (filterXHolder.filter as! LightTunnelFX).radius=150//250.0//tdFX.width
                        (filterXHolder.filter as! LightTunnelFX).rotation=2.0//250.0//tdFX.width
                    }
                }
                else if presetLongName == "Checkerboard Color Burn Blend Tonal"
                {
                    if filterXHolder.filter is CheckerboardGeneratorFX
                    {
                        let tdFX = CheckerboardGeneratorFX()
                        (filterXHolder.filter as! CheckerboardGeneratorFX).width=50//250.0//tdFX.width
                
                    }
                }
                else if presetLongName == "Checkerboard Soft Light Blend"
                {
                    if filterXHolder.filter is CheckerboardGeneratorFX
                    {
                        let tdFX = CheckerboardGeneratorFX()
                        (filterXHolder.filter as! CheckerboardGeneratorFX).width=tdFX.width
                
                    }
                }
                else if presetLongName == "Checkerboard Soft Light Blend Tile"
                {
                    if filterXHolder.filter is CheckerboardGeneratorFX
                    {
                        let tdFX = CheckerboardGeneratorFX()
                        (filterXHolder.filter as! CheckerboardGeneratorFX).width=tdFX.width
                
                    }
                }
                else if presetLongName == "Circular Screen"
                {
                    if filterXHolder.filter is CircularScreenFX
                    {
                        let tdFX = CircularScreenFX()
                        (filterXHolder.filter as! CircularScreenFX).width=20.0
                        (filterXHolder.filter as! CircularScreenFX).sharpness=tdFX.sharpness
                    }
                }
                else if presetLongName == "Stripes Soft Light Blend"
                {
                    if filterXHolder.filter is StripesGeneratorFX
                     {
                         let tdFX = StripesGeneratorFX()
                         (filterXHolder.filter as! StripesGeneratorFX).width=tdFX.width
                 
                     }
                }
                else if presetLongName == "Stripes Difference Blend Mode"
                {
                    if filterXHolder.filter is StripesGeneratorFX
                     {
                         let tdFX = StripesGeneratorFX()
                         (filterXHolder.filter as! StripesGeneratorFX).width=tdFX.width
                 
                     }
                    if filterXHolder.filter is HoleDistortionFX
                     {
                         let tdFX = HoleDistortionFX()
                         (filterXHolder.filter as! HoleDistortionFX).radius=tdFX.radius
                     }
                }
                else if presetLongName == "Linear Gradient Addition Compoisition Blend"
                {
                    if filterXHolder.filter is LinearGradientFX
                    {
                        (filterXHolder.filter as! LinearGradientFX).pointX0=Float(self.size.width/2.0)
                        (filterXHolder.filter as! LinearGradientFX).pointY0=Float(self.size.height/2.0)
                    }
                }
                else if presetLongName == "Hole Source Out Compositing"
                {
                    if filterXHolder.filter is HoleDistortionFX
                    {
                        //let tdFX = HoleDistortionFX()
                        (filterXHolder.filter as! HoleDistortionFX).radius=400//tdFX.radius
                    }
                }
                else if presetLongName == "Radial Gradient Luminosity Blend"
                {
                    if filterXHolder.filter is RadialGradientFX
                    {
                       
                        (filterXHolder.filter as! RadialGradientFX).radius1=550
                    }
                }
                else if presetLongName == "Radial Gradient Addition Compositing"
                {
                    if filterXHolder.filter is RadialGradientFX
                    {
                       
                        (filterXHolder.filter as! RadialGradientFX).radius1=600
                    }
                }
                else if presetLongName == "Copy Machine Transition"
                {
                    if filterXHolder.filter is CopyMachineTransitionFX
                    {
                        (filterXHolder.filter as! CopyMachineTransitionFX).width=60
                    }
                    if filterXHolder.filter is EightfoldReflectedTileFX
                    {
                        (filterXHolder.filter as! EightfoldReflectedTileFX).angle=1.22
                        (filterXHolder.filter as! EightfoldReflectedTileFX).width=108
                    }
                }
                else if presetLongName == "Page Curl With Shadow Transition"
                {
                    if filterXHolder.filter is PageCurlWithShadowTransitionFX
                    {
                        (filterXHolder.filter as! PageCurlWithShadowTransitionFX).time=0.18
                    }
                }
                else if presetLongName == "Ripple Transition"
                {
                    if filterXHolder.filter is CropFX
                    {
                        (filterXHolder.filter as! CropFX).y=Float(2/3*size.height)
                    }
                }
                else if presetLongName == "Perspective Tile Image"
                {
                    if filterXHolder.filter is PerspectiveTileFX
                    {
                        (filterXHolder.filter as! PerspectiveTileFX).topLeftX=Float(size.width/4.0)
                        (filterXHolder.filter as! PerspectiveTileFX).topLeftY=Float(size.height*3.0/4.0)
                        (filterXHolder.filter as! PerspectiveTileFX).topRightX=Float(size.width*3.0/4.0)
                        (filterXHolder.filter as! PerspectiveTileFX).topRightY=Float(size.height*3.0/4.0)
                    }
                }
                else if presetLongName == "Glide Reflected Tile Image"
                {
                    if filterXHolder.filter is GlideReflectedTileFX
                    {
                        (filterXHolder.filter as! GlideReflectedTileFX).width = 100.0
                    }
                }
                else if presetLongName == "Triangle Kaleidoscope Image"
                {
                    if filterXHolder.filter is TriangleKaleidoscopeFX
                    {
                        //let tdFX = TriangleKaleidoscopeFX()
                        (filterXHolder.filter as! TriangleKaleidoscopeFX).tksize=440
                    }
                }
                else if presetLongName == "Twelvefold Reflected Tile Image"
                {
                    if filterXHolder.filter is TwelvefoldReflectedTileFX
                    {
                        //let tdFX = TwelvefoldReflectedTileFX()
                        //(filterXHolder.filter as! TwelvefoldReflectedTileFX).angle=1.39
                        //(filterXHolder.filter as! TwelvefoldReflectedTileFX).width=106
                        (filterXHolder.filter as! TwelvefoldReflectedTileFX).angle=1.15
                        (filterXHolder.filter as! TwelvefoldReflectedTileFX).width=146
                    }
                }
                else if presetLongName == "Eightfold Reflected Tile Image"
                {
                    if filterXHolder.filter is EightfoldReflectedTileFX
                    {
                        (filterXHolder.filter as! EightfoldReflectedTileFX).angle=1.01
                        (filterXHolder.filter as! EightfoldReflectedTileFX).width=100
                    }
                }
                else if presetLongName == "Sunbeams Generator Soft Light Blend"
                {
                    if filterXHolder.filter is SunbeamsGeneratorFX
                    {
                        (filterXHolder.filter as! SunbeamsGeneratorFX).sunRadius=300
                    }
                }
                else if presetLongName == "Star Shine Soft Light Blend"
                {
                    if filterXHolder.filter is StarShineGeneratorFX
                    {
                        (filterXHolder.filter as! StarShineGeneratorFX).radius=50
                    }
                }
                
                else if presetLongName == "Masked Variable Blur"
                {
                    if filterXHolder.filter is StarShineGeneratorFX
                    {
                        (filterXHolder.filter as! StarShineGeneratorFX).radius=80
                    }
                }
                else if presetLongName == "Read Image Soft Light Blend Mode"
                {
                    if filterXHolder.filter is ScaleFX
                    {
                        (filterXHolder.filter as! ScaleFX).a=0.75
                        (filterXHolder.filter as! ScaleFX).d=0.75
                    }
                }
                /*
  
                 
                else if presetLongName == "Stripes Difference Blend Mode"
                {
                    if filterXHolder.filter is ColorMonochromeFX
                    {
                       
                        (filterXHolder.filter as! ColorMonochromeFX).intensity=1
                    }
                }*/
                else if presetLongName == ""
                {
                }
            }

        }
    }


    
    func applyFilters(image: UIImage) -> UIImage
    {
        //NSLog("FiltersX applyFilters Started*****")

        print("applying filter",filterList.count)
        let beginImage = CIImage(image: image)
       

        if filterList.count == 0
        {
            return image
        }

        var currentCIFilter : CIFilter = CIFilter()
        var viewerCIFilter : CIFilter = CIFilter()
        var currentImage = beginImage!
        
        //var previousFilterO: FilterX?
        
        filterList.forEach
        {
            let currentFilterHolder = $0
            let currentFilter = currentFilterHolder.filter //$0 as FilterX
            print("current id",currentFilter.id,currentFilter.type,currentFilter.alias)
            //NSLog("Time")

            if let currentCIFilterUw = currentFilter.getCIFilter(currentImage: currentImage, beginImage: beginImage!)
            {
                currentCIFilter = currentCIFilterUw
                currentImage=currentCIFilter.outputImage!
                print("currentImage",currentImage.extent.size)
                //NSLog("Time")
                if viewerIndex == -1 || currentFilter.nodeIndex <= viewerIndex{
                    viewerCIFilter=currentCIFilter
                }

            }
   

            /*
            if viewerIndex == -1 || currentFilter.nodeIndex <= viewerIndex{
                if let currentCIFilterUw = currentFilter.getCIFilter(currentImage: currentImage, beginImage: beginImage!)
                {
                    currentCIFilter = currentCIFilterUw
                    currentImage=currentCIFilter.outputImage!
                    print("currentImage",currentImage.extent.size)
                }
            }
             */
            //previousFilterO = currentFilter //store previous
            
        }
        
        print("image.imageOrientation",image.imageOrientation,image.size,image.scale)
        //NSLog("FiltersX after imageOrientation")
        //this line is slow after metal
        if let cgimg = context!.createCGImage(viewerCIFilter.outputImage!, from: beginImage!.extent) {
            //NSLog("FiltersX applyFilters b4 UIImage")
            let processedImage = UIImage(cgImage: cgimg, scale: image.scale, orientation: image.imageOrientation)
            //NSLog("FiltersX applyFilters Completed*****")
            return processedImage
        }
        /*
        if let cgimg = context!.createCGImage(currentCIFilter.outputImage!, from: beginImage!.extent) {
            let processedImage = UIImage(cgImage: cgimg, scale: image.scale, orientation: image.imageOrientation)
            return processedImage
        }
         */
        return image
            
    }
}


