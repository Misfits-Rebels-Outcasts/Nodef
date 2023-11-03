//
//  Copyright © 2022 James Boo. All rights reserved.
//

import SwiftUI

class ImageFiltersPropertiesViewModel: FiltersPropertiesViewModel {

    var image: UIImage?
    /*
    let shapes: ShapesX
    init(shapes: ShapesX) {
       self.shapes = shapes
    }
    */
    func setupSelectedProperties()
    {
        /*
        self.shapes.shapeList.forEach
        {
            if $0.isSelected == true {
                if $0 is ImageX
                {
                    let selectedShape = $0 as! ImageX
                    self.filters = selectedShape.filters
                    image = selectedShape.image
                    
                }
                
            }
        }
         */
        
    }
    
    override func setupReadImage(fx: FilterX) {
        /*
        self.shapes.shapeList.forEach
        {
            if $0.isSelected == true {
                
                let selectedImage = $0 as! ImageX
                selectedImage.readFX=(fx as! ReadImageFX)
                
            }
        }
         */
    }
    override func applyFiltersAsync() async{
    }
    
    override func applyFilters()
    {
        /*
        self.shapes.shapeList.forEach
        {
            if $0.isSelected == true {
                if $0 is ImageX
                {
                    let selectedShape = $0 as! ImageX
                    selectedShape.applyFilter()

                }

            }
        }
         */
    }
         
    
    override func createFilter(selectedFilter: String)->FilterXHolder {
        
        print("createFilter",selectedFilter)

        let filterXHolder=filters.getFilterWithHolder(selectedFilter)
        /*
        self.shapes.shapeList.forEach
        {
            if $0.isSelected == true {
                
                let selectedImage = $0 as! ImageX
                filterXHolder.filter.size=CGSize(width: selectedImage.image.size.width,height: selectedImage.image.size.height)

          }
        }
        */
        return filterXHolder
    }

    

}
