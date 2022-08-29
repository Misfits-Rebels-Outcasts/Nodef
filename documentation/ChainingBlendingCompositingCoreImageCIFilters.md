# A library for Node-compositing Core Image CIFilter

## From Chaining/Blending to Node-based Compositing Core Image CIFilters

Core Image is a powerful iOS framework that makes makes hardware-accelerated image manipulation easy. Oftentimes, we use it to add graphical effects to an image in our app. The process involves choosing a right CIFilter, setting parameters, and applying the filter to the image. 

Sometimes, the process may involve chaining several filters to get the desired result. For example, we can use a CIColorControls to first adjust the saturation of an image followed by applying a Vignette filter to add a dark fading border around the edges.

<span>
<img src="https://user-images.githubusercontent.com/47021297/187051741-049939e6-0371-47b3-951c-cc83d8a1bffb.JPG" width="15%" height="15%">
 -----> 
<img src="https://user-images.githubusercontent.com/47021297/187098124-0282542b-b176-4de2-8f1d-ad3e7765084e.JPG" width="15%" height="15%">
</span>

## Background for a wrapper Library

Core Image CIFilter is already a library that should be used on its own. Furthermore, if we have implementation questions, we can usually sought out the open-source [Filterpedia](https://github.com/FlexMonkey/Filterpedia) project by Simon Gladman to gather implmentation details.  

However, there may be times, when we need to go beyond just chaining a few CIFilter. We may need to chain filters, blend it with another image, and then apply more filters to achieve a desired result. Or in other words, we may need to apply some kind of node graph to get the effect we wanted. As a developer, we often find ourselves in this programmatical chaining and blending process repeatedly. 

For example, a CIEdgeWork filter produces a stylized black-and-white rendition of an image that looks similar to a woodblock cutout. The output of this filter, however, requires a background image to visualize. This requires a composite filter, CISourceAtopCompositing, to place the output of CIEdgeWork over a constant color background.  
<p></p>
<img src="https://user-images.githubusercontent.com/47021297/187098089-17b8df82-5110-4ba3-9a88-666e7707bc7b.JPG" width="15%" height="15%">
<p></p>
Beyond this, we may want to twirl the output, and then further apply an Addition composite/blend with another image. We often need to test this out in our programming code. 

### Nodef library

The Nodef library aims to provide a simple wrapper for Core Image CIFilter to apply a node graph (of CIFilter) on an image easily. The library is the same library used in the open-source Nodef app that aims to provide compositing capabilities on a mobile device. With the app, we can peform many of the compositing behavior without changing programming code. At the same time, the Nodef app, is used to test out a [Node Pipeline](NodePipeline.md) idea, to reimagine node-based compositing on a mobile device.

Besides providng a library for node based compositing, the library also provides default values for each of the different filters, and implements the Codabale protocol to enable saving and loading of the node graph in JSON. Nodef aims to allow you to creatively perform compositing on a mobile device and then load the node graph on your desktop or command line to render the final video clip.

## Sample Usage

### Original Image

<img src="https://user-images.githubusercontent.com/47021297/187051741-049939e6-0371-47b3-951c-cc83d8a1bffb.JPG" width="15%" height="15%">

### Create a CIColorMonochrome filter

    func createOneFilter(_ inputImage: UIImage) -> UIImage {
        
        let filters = FiltersX()
        filters.add(filterHolder: filters.getFilterWithHolder("Color Monochrome"))
        return filters.applyFilters(image: inputImage)
        
    }

<span>
<img src="https://user-images.githubusercontent.com/47021297/187051741-049939e6-0371-47b3-951c-cc83d8a1bffb.JPG" width="15%" height="15%">
 -----> 
<img src="https://user-images.githubusercontent.com/47021297/187051787-0888162e-5a25-4b64-996d-1518f656d281.JPG" width="15%" height="15%">
</span>

### Chain a CISepiaTone filter and CIZoomBlur filter

CISepiaTone takes the original image as the input image and CIZoomBlur takes the output of CISepiaTone as the input image.

    func chainFilters(_ inputImage: UIImage) -> UIImage {
        
        let filters = FiltersX()
        filters.add(filterHolder: filters.getFilterWithHolder("Sepia Tone"))
        filters.add(filterHolder: filters.getFilterWithHolder("Zoom Blur"))
        return filters.applyFilters(image: inputImage)
        
    }

<span>
<img src="https://user-images.githubusercontent.com/47021297/187051741-049939e6-0371-47b3-951c-cc83d8a1bffb.JPG" width="15%" height="15%">
 -----> 
<img src="https://user-images.githubusercontent.com/47021297/187051982-f760e1e9-d7d3-4150-9c24-99573374483c.JPG" width="15%" height="15%">
 -----> 
<img src="https://user-images.githubusercontent.com/47021297/187051826-937ed8c1-8be3-4863-8299-8b904cbf40a0.JPG" width="15%" height="15%">
</span>

    
### Apply a CIDotScreen filter and then CISubtractBlendMode it with the original image

First apply a CIDotScreen filter.

    func blendFilters(_ inputImage: UIImage) -> UIImage {
        
        let filters = FiltersX()
        
        filters.add(filterHolder: filters.getFilterWithHolder("Dot Screen"))
        filters.add(filterHolder: filters.getFilterWithHolder("Subtract Blend Mode"))

        return filters.applyFilters(image: inputImage)
        
    }

<span>
<img src="https://user-images.githubusercontent.com/47021297/187051741-049939e6-0371-47b3-951c-cc83d8a1bffb.JPG" width="15%" height="15%">
 --------> 
<img src="https://user-images.githubusercontent.com/47021297/187052027-8f5318f1-064a-492d-9508-b4fc86e9e5f1.JPG" width="15%" height="15%">
</span>
<p></p>

CISubtractBlendMode takes the output of CIDotScreen as the inputImage and the original image as the backgroundImage
<p></p>


<span>
<img src="https://user-images.githubusercontent.com/47021297/187052027-8f5318f1-064a-492d-9508-b4fc86e9e5f1.JPG" width="15%" height="15%">
 &nbspSubtract&nbsp
<img src="https://user-images.githubusercontent.com/47021297/187051741-049939e6-0371-47b3-951c-cc83d8a1bffb.JPG" width="15%" height="15%">
 -----> 
<img src="https://user-images.githubusercontent.com/47021297/187052025-9bfa7b49-915c-4fc5-85e4-a3b177f70141.JPG" width="15%" height="15%">
</span>

### Create a CICheckboardGenerator filter 
    
CICheckboardGenerator requires no inputImage
    
    func generatorFilters(_ inputImage: UIImage) -> UIImage {
        
        let filters = FiltersX()
        
        filters.size=CGSize(width:inputImage.size.width, height:inputImage.size.height)
        filters.add(filterHolder: filters.getFilterWithHolder("Checkerboard Generator"))
        
        return filters.applyFilters(image: inputImage)
        
    }

<img src="https://user-images.githubusercontent.com/47021297/187052198-f182ca6f-ea23-4487-bcb4-4c92bfe0d58f.JPG" width="15%" height="15%">

### Changing CIFilter properties through the wrapper class.
    
Changing the width of CICheckboardGenerator 

    func filterProperties(_ inputImage: UIImage) -> UIImage {
        
        let filters = FiltersX()
        filters.size=CGSize(width:inputImage.size.width, height:inputImage.size.height)
        
        let fxHolder=filters.getFilterWithHolder("Checkerboard Generator")
        (fxHolder.filter as! CheckerboardGeneratorFX).width = 500
        filters.add(filterHolder: fxHolder)
        
        return filters.applyFilters(image: inputImage)
        
    }
    
<img src="https://user-images.githubusercontent.com/47021297/187052202-55b768c9-a836-45a9-8be5-e770a18436fb.JPG" width="15%" height="15%">

### Compositing CIFilters

Apply a CIMultiplyBlendMode with a CIColorMonochrome version of the original image with a CICheckboardGenerator.

    func compositingFilters(_ inputImage: UIImage) -> UIImage {
        
        let filters = FiltersX()
        
        filters.size=CGSize(width:inputImage.size.width, height:inputImage.size.height)
        
        filters.add(filterHolder: filters.getFilterWithHolder("Color Monochrome")) //Node 1
        filters.add(filterHolder: filters.getFilterWithHolder("Checkerboard Generator")) //Node 2
        
        let fxHolder=filters.getFilterWithHolder("Multiply Blend Mode")
        (fxHolder.filter as! MultiplyBlendModeFX).inputImageAlias = "2"
        (fxHolder.filter as! MultiplyBlendModeFX).backgroundImageAlias = "1"
        filters.add(filterHolder: fxHolder)
        
        return filters.applyFilters(image: inputImage)
        
    }

<span>
<img src="https://user-images.githubusercontent.com/47021297/187051741-049939e6-0371-47b3-951c-cc83d8a1bffb.JPG" width="15%" height="15%">
 -----> 
<img src="https://user-images.githubusercontent.com/47021297/187051787-0888162e-5a25-4b64-996d-1518f656d281.JPG" width="15%" height="15%">
 Multiply 
<img src="https://user-images.githubusercontent.com/47021297/187052198-f182ca6f-ea23-4487-bcb4-4c92bfe0d58f.JPG" width="15%" height="15%">
 -----> 
<img src="https://user-images.githubusercontent.com/47021297/187052461-b61e5505-a8e3-4ec5-b0a0-7ff9db0b8e06.JPG" width="15%" height="15%">
</span>



### Node Graph Compositing CIFilters

First, chain the original image with the following filters.

    Original Image -> CILineScreen -> CIColorMonochrome

<span>
<img src="https://user-images.githubusercontent.com/47021297/187051741-049939e6-0371-47b3-951c-cc83d8a1bffb.JPG" width="15%" height="15%">
 --------> 
<img src="https://user-images.githubusercontent.com/47021297/187052654-7090f44c-0535-4baa-81a5-ec04f9613623.JPG" width="15%" height="15%">
 --------> 
<img src="https://user-images.githubusercontent.com/47021297/187052744-7bb58e3d-167d-46e3-8aed-b7c9cbf4b75c.JPG" width="15%" height="15%">
</span>
<p></p>
Next, generate a checkboard and then apply a triangle tile.

    CheckboardGenerator -> CITriangleTile
<p></p>

<span>
<img src="https://user-images.githubusercontent.com/47021297/187052659-9d2ba373-e45f-4f29-bf4c-6755bc615196.JPG" width="15%" height="15%">
 --------> 
<img src="https://user-images.githubusercontent.com/47021297/187052660-ec33f346-1164-4f24-88e4-6a71e6baa05a.JPG" width="15%" height="15%">
</span>
<p></p>

Finally, multiply blend the output of the color monochrome with the output of the triangle tile.

    CIMultiplyBlendMode on CIColorMonochrome and CITriangleTile
<p></p>
    
<span>
<img src="https://user-images.githubusercontent.com/47021297/187052744-7bb58e3d-167d-46e3-8aed-b7c9cbf4b75c.JPG" width="15%" height="15%">
Multiply
<img src="https://user-images.githubusercontent.com/47021297/187052660-ec33f346-1164-4f24-88e4-6a71e6baa05a.JPG" width="15%" height="15%">
 --------> 
<img src="https://user-images.githubusercontent.com/47021297/187052661-0fa73541-a1f2-41a3-a1da-f27b8b1cf9ce.JPG" width="15%" height="15%">
</span>
<p></p>


The Swift code for the node graph above.
<p></p>

    func nodeGraphFilters(_ inputImage: UIImage) -> UIImage {
        
        let filters = FiltersX()
        
        filters.size=CGSize(width:inputImage.size.width, height:inputImage.size.height)
        
        filters.add(filterHolder: filters.getFilterWithHolder("Line Screen")) //Node 1
        filters.add(filterHolder: filters.getFilterWithHolder("Color Monochrome")) //Node 2
        filters.add(filterHolder: filters.getFilterWithHolder("Checkerboard Generator")) //Node 3
        filters.add(filterHolder: filters.getFilterWithHolder("Triangle Tile")) //Node 4

        let fxHolder=filters.getFilterWithHolder("Multiply Blend Mode")
        (fxHolder.filter as! MultiplyBlendModeFX).inputImageAlias = "4"
        (fxHolder.filter as! MultiplyBlendModeFX).backgroundImageAlias = "2"
        filters.add(filterHolder: fxHolder)

        return filters.applyFilters(image: inputImage)
        
    }
    
    
## Compiling the Source

### Prerequisites

* XCode 13
* iOS 15

### Build

* Download the Source
* Launch XCode and load Nodef.xcodeproj
Build and run on iPhone Simulator or Device
