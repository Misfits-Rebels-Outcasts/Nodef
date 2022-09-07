//
//  Copyright © 2022 James Boo. All rights reserved.
//

import SwiftUI

class FiltersPropertiesViewModel: BaseViewModel {
    @Published var filters:FiltersX = FiltersX()
    @Published var selectedFilterType:String = "Color Monochrome"
    @Published var selectedBlendFilterType:String = "Color Dodge Blend Mode"

}

class ImageFiltersPropertiesViewModel: FiltersPropertiesViewModel {

    /*
    let shapes: ShapesX
    init(shapes: ShapesX) {
       self.shapes = shapes
    }
    */
    func setupSelectedProperties()
    {
        //revisit
        /*
        self.shapes.shapeList.forEach
        {
            if $0.isSelected == true {
                if $0 is ImageX
                {
                    let selectedShape = $0 as! ImageX
                    //self.zIndex = String(format: "%.0f", selectedShape.zIndex)
                    
                    //self.maintainAspectRatio = selectedShape.maintainAspectRatio
                    //self.scale = selectedShape.scale
                    self.filters = selectedShape.filters
                    /*
                    let tX = (selectedShape.location.x - CGFloat(selectedShape.size.width)/2.0) * 72.0 / 300.0
                    let tY = (selectedShape.location.y - CGFloat(selectedShape.size.height)/2.0) * 72.0 / 300.0
                    let tWidth = selectedShape.size.width * 72.0 / 300.0
                    let tHeight = selectedShape.size.height * 72.0 / 300.0
                    let tzIndex = selectedShape.zIndex
                     */
                    //super.setupSelectedProperties(x:tX,y:tY,width:tWidth,height:tHeight,zIndex:tzIndex)

                }

            }
        }
         */
    }

}

class BackgroundFiltersPropertiesViewModel: FiltersPropertiesViewModel {

    let pageSettings: PageSettings
    init(pageSettings: PageSettings) {
        //super.init()
       self.pageSettings = pageSettings
    }
    
    
    func setupSelectedProperties()
    {
        self.filters = pageSettings.filters
        
    }
}
