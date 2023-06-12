//
//  Copyright © 2022 James Boo. All rights reserved.
//

import SwiftUI
import CoreImage
import CoreImage.CIFilterBuiltins

class FilterNames
{
    static func GetFilterType() -> [String]
    {

        
        if appType == "N" {
            return (GetMonoFilterType() + GetBlendFilterType() + GetShaderType()).sorted()
        } else if appType == "B" {
            return (GetLabelMonoFilterType() + GetBlendFilterType() + GetShaderType()).sorted()
        } else {
            return (GetLabelMonoFilterType() + GetBlendFilterType() + GetShaderType()).sorted()
        }
            
    }
    
    static func GetLabelMonoFilterType() -> [String]
    {
        let filterType = [

            
            "Box Blur",
            "Disc Blur",
            "Gaussian Blur",
            "Masked Variable Blur",
            "Median Filter",
            "Motion Blur",
            "Noise Reduction",
            "Zoom Blur",
            
            "Color Clamp",
            "Color Controls",
            "Read Image",
            "Color Matrix",
            "Color Polynomial",
            "Exposure Adjust",
            "Gamma Adjust",
            "Hue Adjust",
            "Linear To SRGB Tone Curve",
            "SRGB Tone Curve To Linear",
            "Temperature And Tint",
            "Tone Curve",
            "Vibrance",
            "White Point Adjust",

            "Color Cross Polynomial",
            "Remove Color With Color Cube",
            //"Color Cube With Color Space",
            "Color Invert",
            "False Color",
            //"Color Map",
            "Color Monochrome",
            "Color Posterize",
            "Mask To Alpha",
            "Maximum Component",
            "Minimum Component",
            "Photo Effect Chrome",
            "Photo Effect Fade",
            "Photo Effect Instant",
            "Photo Effect Mono",
            "Photo Effect Noir",
            "Photo Effect Process",
            "Photo Effect Tonal",
            "Photo Effect Transfer",
            "Sepia Tone",
            "Vignette",
            "Vignette Effect",
                                                    
            "Bump Distortion",
            "Bump Distortion Linear",
            "Circular Wrap",
            "Droste",
            "Displacement Distortion",
            "Circle Splash Distortion",
            "Glass Lozenge",
            "Glass Distortion",
            "Hole Distortion",
            "Light Tunnel",
            "Pinch Distortion",
            "Stretch Crop",
            "Torus Lens Distortion",
            "Twirl Distortion",
            "Vortex Distortion",
            
            //"Aztec Code Generator",
            "Checkerboard Generator",
            //"Code128 Barcode Generator",
            "Constant Color Generator",
            "Lenticular Halo Generator",
            //"PDF417 Barcode Generator",
            "QR Code Generator",
            "Random Generator",
            "Rounded Rectangle Generator",
            "Circle Generator",
            "Star Shine Generator",
            "Stripes Generator",
            "Sunbeams Generator",
            "Text Image Generator",
            
            "Translate",
            "Rotate",
            "Scale",
            "Opacity",

            "Affine Transform",
            "Crop",
            "Lanczos Scale Transform",
            "Perspective Correction",
            "Perspective Transform",
            "Perspective Transform With Extent",
            "Straighten Filter",
                          
            "Gaussian Gradient",
            "Linear Gradient",
            "Radial Gradient",
            //"Sinusoidal Gradient",
            "Smooth Linear Gradient",
                          
            "Circular Screen",
            "CMYK Halftone",
            "Dot Screen",
            "Hatched Screen",
            "Line Screen",

            "Area Average",
            //"Area Histogram",
            "Row Average",
            "Column Average",
            "Histogram Display Filter",
            "Area Maximum",
            "Area Minimum",
            "Area Maximum Alpha",
            "Area Minimum Alpha",
            
            "Sharpen Luminance",
            "Unsharp Mask",

            "Bloom",
            "Comic Effect",
            "Convolution 3 X 3",
            "Convolution 5 X 5",
            //"Convolution 7 X 7",
            "Convolution 9 Horizontal",
            "Convolution 9 Vertical",
            "Crystallize",
            "Depth Of Field",
            "Edges",
            "Edge Work",
            "Gabor Gradients",
            "Gloom",
            "Height Field From Mask",
            "Hexagonal Pixellate",
            "Highlight Shadow Adjust",
            "Line Overlay",
            "Pixellate",
            "Pointillize",
            "Shaded Material",
            "Spot Color",
            "Spot Light",
            
            //"Affine Clamp",
            "Affine Tile",
            "Eightfold Reflected Tile",
            "Fourfold Reflected Tile",
            "Fourfold Rotated Tile",
            "Fourfold Translated Tile",
            "Glide Reflected Tile",
            "Kaleidoscope",
            "Op Tile",
            "Parallelogram Tile",
            "Perspective Tile",
            "Sixfold Reflected Tile",
            "Sixfold Rotated Tile",
            "Triangle Kaleidoscope",
            "Triangle Tile",
            "Twelvefold Reflected Tile",

        ]
        return filterType.sorted()
    }

    static func GetShaderType() -> [String]
    {
        let shaderType = [
                        
            "FBM Noise",
            "Fractal Flow Noise",
            "Particles",
            "Tortise Shell Voronoi",
            "Water Effects"
            //Test Switch - Only if need to add new effects

            /*
            "Anim",
            "Aura",
            "AnimTex01",
            "AnimTex02",
            "AnimTex03",
            "AnimTex04",
            "AnimTex05",
            "AnimTex06",
            "AnimTex07",
            "AnimTex08",
             */
        ]
        return shaderType.sorted()
    }
    
    static func GetMonoFilterType() -> [String]
    {
        let filterType = [


            "Reciprocal",
            "Color Channels",


            
            "Box Blur",
            "Disc Blur",
            "Gaussian Blur",
            "Masked Variable Blur",
            "Median Filter",
            "Motion Blur",
            "Noise Reduction",
            "Zoom Blur",
            
            "Color Clamp",
            "Color Controls",
            "Read Image",
            "Color Matrix",
            "Color Polynomial",
            "Exposure Adjust",
            "Gamma Adjust",
            "Hue Adjust",
            "Linear To SRGB Tone Curve",
            "SRGB Tone Curve To Linear",
            "Temperature And Tint",
            "Tone Curve",
            "Vibrance",
            "White Point Adjust",

            "Color Cross Polynomial",
            "Remove Color With Color Cube",
            //"Color Cube With Color Space",
            "Color Invert",
            "False Color",
            //"Color Map",
            "Color Monochrome",
            "Color Posterize",
            "Mask To Alpha",
            "Maximum Component",
            "Minimum Component",
            "Photo Effect Chrome",
            "Photo Effect Fade",
            "Photo Effect Instant",
            "Photo Effect Mono",
            "Photo Effect Noir",
            "Photo Effect Process",
            "Photo Effect Tonal",
            "Photo Effect Transfer",
            "Sepia Tone",
            "Vignette",
            "Vignette Effect",
                                                    
            "Bump Distortion",
            "Bump Distortion Linear",
            "Circular Wrap",
            "Droste",
            "Displacement Distortion",
            "Circle Splash Distortion",
            "Glass Lozenge",
            "Glass Distortion",
            "Hole Distortion",
            "Light Tunnel",
            "Pinch Distortion",
            "Stretch Crop",
            "Torus Lens Distortion",
            "Twirl Distortion",
            "Vortex Distortion",
            
            //"Aztec Code Generator",
            "Checkerboard Generator",
            //"Code128 Barcode Generator",
            "Constant Color Generator",
            "Lenticular Halo Generator",
            //"PDF417 Barcode Generator",
            "QR Code Generator",
            "Random Generator",
            "Rounded Rectangle Generator",
            "Circle Generator",
            "Star Shine Generator",
            "Stripes Generator",
            "Sunbeams Generator",
            "Text Image Generator",
            
            "Translate",
            "Rotate",
            "Scale",
            "Opacity",

            "Affine Transform",
            "Crop",
            "Lanczos Scale Transform",
            "Perspective Correction",
            "Perspective Transform",
            "Perspective Transform With Extent",
            "Straighten Filter",
                          
            "Gaussian Gradient",
            "Linear Gradient",
            "Radial Gradient",
            "Sinusoidal Gradient",
            "Smooth Linear Gradient",
                          
            "Circular Screen",
            "CMYK Halftone",
            "Dot Screen",
            "Hatched Screen",
            "Line Screen",

            "Area Average",
            //"Area Histogram",
            "Row Average",
            "Column Average",
            "Histogram Display Filter",
            "Area Maximum",
            "Area Minimum",
            "Area Maximum Alpha",
            "Area Minimum Alpha",
            
            "Sharpen Luminance",
            "Unsharp Mask",

            "Bloom",
            "Comic Effect",
            "Convolution 3 X 3",
            "Convolution 5 X 5",
            //"Convolution 7 X 7",
            "Convolution 9 Horizontal",
            "Convolution 9 Vertical",
            "Crystallize",
            "Depth Of Field",
            "Edges",
            "Edge Work",
            "Gabor Gradients",
            "Gloom",
            "Height Field From Mask",
            "Hexagonal Pixellate",
            "Highlight Shadow Adjust",
            "Line Overlay",
            "Pixellate",
            "Pointillize",
            "Shaded Material",
            "Spot Color",
            "Spot Light",
            
            //"Affine Clamp",
            "Affine Tile",
            "Eightfold Reflected Tile",
            "Fourfold Reflected Tile",
            "Fourfold Rotated Tile",
            "Fourfold Translated Tile",
            "Glide Reflected Tile",
            "Kaleidoscope",
            "Op Tile",
            "Parallelogram Tile",
            "Perspective Tile",
            "Sixfold Reflected Tile",
            "Sixfold Rotated Tile",
            "Triangle Kaleidoscope",
            "Triangle Tile",
            "Twelvefold Reflected Tile",

        ]
        return filterType.sorted()
    }
    
    static func GetBlendFilterType() -> [String]
    {
        let filterType = [
                          "Addition Compositing",
                          "Color Blend Mode",
                          "Color Burn Blend Mode",
                          "Color Dodge Blend Mode",
                          "Darken Blend Mode",
                          "Difference Blend Mode",
                          "Divide Blend Mode",
                          "Exclusion Blend Mode",
                          "Hard Light Blend Mode",
                          "Hue Blend Mode",
                          "Lighten Blend Mode",
                          "Linear Burn Blend Mode",
                          "Linear Dodge Blend Mode",
                          "Luminosity Blend Mode",
                          "Maximum Compositing",
                          "Minimum Compositing",
                          "Multiply Blend Mode",
                          "Multiply Compositing",
                          "Overlay Blend Mode",
                          "Pin Light Blend Mode",
                          "Saturation Blend Mode",
                          "Screen Blend Mode",
                          "Soft Light Blend Mode",
                          "Source Atop Compositing",
                          "Source In Compositing",
                          "Source Out Compositing",
                          "Source Over Compositing",
                          "Subtract Blend Mode",
                          
                          //"Accordion Fold Transition",
                          "Bars Swipe Transition",
                          "Copy Machine Transition",
                          "Disintegrate With Mask Transition",
                          "Dissolve Transition",
                          "Flash Transition",
                          "Mod Transition",
                          "Page Curl Transition",
                          "Page Curl With Shadow Transition",
                          "Ripple Transition",
                          "Swipe Transition",
                          
                          "Blend With Alpha Mask",
                          "Blend With Mask",
                          
                          "Mix"

        ]
        return filterType.sorted()
    }
}
