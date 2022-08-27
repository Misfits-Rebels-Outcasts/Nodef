# Chaining, blending, and Compositing Core Image CIFilters

### Create a CIColorMonochrome filter

    func createOneFilter(_ inputImage: UIImage) -> UIImage {
        
        let filters = FiltersX()
        filters.add(filterHolder: filters.getFilterWithHolder("Color Monochrome"))
        return filters.applyFilters(image: inputImage)
        
    }

### Chain a CISepiaTone filter and CIZoomBlur filter

CISepiaTone takes the original image as the input image and CIZoomBlur takes the output of CISepiaTone as the input image.

    func chainFilters(_ inputImage: UIImage) -> UIImage {
        
        let filters = FiltersX()
        filters.add(filterHolder: filters.getFilterWithHolder("Sepia Tone"))
        filters.add(filterHolder: filters.getFilterWithHolder("Zoom Blur"))
        return filters.applyFilters(image: inputImage)
        
    }

### Apply a CIDotScreen filter and then CISubtractBlendMode it with the original image

CISubtractBlendMode takes the output of CIDotScreen as the inputImage and the original image as the backgroundImage

    func blendFilters(_ inputImage: UIImage) -> UIImage {
        
        let filters = FiltersX()
        
        filters.add(filterHolder: filters.getFilterWithHolder("Dot Screen"))
        filters.add(filterHolder: filters.getFilterWithHolder("Subtract Blend Mode"))

        return filters.applyFilters(image: inputImage)
        
    }
    
### Create a CICheckboardGenerator filter 
    
CICheckboardGenerator requires no inputImage
    
    func generatorFilters(_ inputImage: UIImage) -> UIImage {
        
        let filters = FiltersX()
        
        filters.size=CGSize(width:inputImage.size.width, height:inputImage.size.height)
        filters.add(filterHolder: filters.getFilterWithHolder("Checkerboard Generator"))
        
        return filters.applyFilters(image: inputImage)
        
    }

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
    
### Node Graph Compositing CIFilters

First, chain the original image with the following filters.

    Original Image -> CILineScreen -> CIColorMonochrome

Next, generate a checkboard and then apply a triangle tile.

    CheckboardGenerator -> CITriangleTile

Finally, multiply blend the output of the color monochrome with the output of the triangle tile.

    CIMultipleBlendMode (CIColorMonochrome, CITriangleTile)
    

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
