//
//  Copyright © 2022 James Boo. All rights reserved.
//

import SwiftUI

class ShapePropertiesViewModel: ObjectBaseViewModel {

    @Published var strokeWidth: Double = 1.0
    @Published var strokeColor = Color.black
    @Published var fillColor = Color.white
    //@Published var zIndex: String = "0"
    //inject with shapes
    /*
    let shapes: ShapesX
    init(shapes: ShapesX) {
       self.shapes = shapes
    }
    */
    func setupSelectedProperties()
    {
        self.shapes.shapeList.forEach
        {
            if $0.isSelected == true {
                if $0 is RectangleX
                {
                    let selectedShape = $0 as! RectangleX
                    print(selectedShape.strokeWidth)
                    self.strokeWidth = selectedShape.strokeWidth
                    self.strokeColor = selectedShape.strokeColor
                    self.fillColor = selectedShape.fillColor
                    //self.zIndex = String(format: "%.0f", selectedShape.zIndex)
                    
                    let tX = (selectedShape.location.x - CGFloat(selectedShape.size.width)/2.0) * 72.0 / 300.0
                    let tY = (selectedShape.location.y - CGFloat(selectedShape.size.height)/2.0) * 72.0 / 300.0
                    let tWidth = selectedShape.size.width * 72.0 / 300.0
                    let tHeight = selectedShape.size.height * 72.0 / 300.0
                    let tzIndex = selectedShape.zIndex
                    super.setupSelectedProperties(x:tX,y:tY,width:tWidth,height:tHeight,zIndex:tzIndex)

                }
                else if $0 is EllipseX
                {
                    let selectedShape = $0 as! EllipseX
                    self.strokeWidth = selectedShape.strokeWidth
                    self.strokeColor = selectedShape.strokeColor
                    self.fillColor = selectedShape.fillColor
                    //self.zIndex = String(format: "%.0f", selectedShape.zIndex)
                    
                    let tX = (selectedShape.location.x - CGFloat(selectedShape.size.width)/2.0) * 72.0 / 300.0
                    let tY = (selectedShape.location.y - CGFloat(selectedShape.size.height)/2.0) * 72.0 / 300.0
                    let tWidth = selectedShape.size.width * 72.0 / 300.0
                    let tHeight = selectedShape.size.height * 72.0 / 300.0
                    let tzIndex = selectedShape.zIndex
                    super.setupSelectedProperties(x:tX,y:tY,width:tWidth,height:tHeight,zIndex:tzIndex)

                }

            }
        }
    }
    
  

}


