//
//  Copyright © 2022 James Boo. All rights reserved.
//

import SwiftUI

class TextPropertiesViewModel: ObjectBaseViewModel {

    @Published var textType: String = "Enter from Keyboard"
    @Published var text: String = "Text"
    @Published var fontName: String = "Arial"
    @Published var fontSize: Double = 18.0
    @Published var textColor = Color.black
    @Published var alignment: String = "Center"
    //@Published var zIndex: String = "0"

    
    func setupSelectedProperties()
    {
        self.shapes.shapeList.forEach
        {
            if $0.isSelected == true {
                let selectedText = $0 as! TextX
                
                self.textType = selectedText.textType
                self.text = selectedText.text
                self.textColor = selectedText.textColor
                self.fontName = selectedText.fontName
                self.fontSize = selectedText.fontSize
                self.alignment = selectedText.horizontalTextAlignment
                //self.zIndex = String(format: "%.0f", selectedText.zIndex)

               

                /*
                self.x = String(format: "%.0f", (selectedText.location.x - CGFloat(selectedText.size.width)/2.0) * 72.0 / 300.0)
                self.y = String(format: "%.0f", (selectedText.location.y - CGFloat(selectedText.size.height)/2.0) * 72.0 / 300.0)
                self.width = String(format: "%.0f", selectedText.size.width * 72.0 / 300.0)
                self.height = String(format: "%.0f", selectedText.size.height * 72.0 / 300.0)
                 */
                let tX = (selectedText.location.x - CGFloat(selectedText.size.width)/2.0) * 72.0 / 300.0
                let tY = (selectedText.location.y - CGFloat(selectedText.size.height)/2.0) * 72.0 / 300.0
                let tWidth = selectedText.size.width * 72.0 / 300.0
                let tHeight = selectedText.size.height * 72.0 / 300.0
                let tzIndex = selectedText.zIndex
                super.setupSelectedProperties(x:tX,y:tY,width:tWidth,height:tHeight,zIndex:tzIndex)
           
            }
        }
    }
    

}

