//
//  Copyright © 2022 James Boo. All rights reserved.
//

import SwiftUI

class BarcodePropertiesViewModel: ObjectBaseViewModel {

    @Published var inputType: String = "Enter from Keyboard"
    @Published var input: String = "1234"
    @Published var symbology: String = "Code 39"
    @Published var checkDigit: Bool = false
    @Published var extendedStyle: Bool = false
    
    @Published var bearersBar: String = "Top/Bottom" //Rectangle
    @Published var barcode: String = "*1234*"
    
    @Published var humanReadableText: String = "*1234*"
    
    @Published var fontName: String = "CCode39_S3"
    @Published var fontSize: Double = 18.0
    @Published var textColor = Color.black

    @Published var hrFontName: String = "Arial"
    @Published var hrFontSize: Double = 16.0
    @Published var hrTextColor = Color.black

    @Published var alignment: String = "Center"
    
    var skipOnChange = false
    var skipExtendedStyleOnChange = false

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
                let selectedText = $0 as! BarcodeX
   
                self.inputType = selectedText.inputType
                self.input = selectedText.input
                
                self.checkDigit = selectedText.checkDigit
           
                self.symbology = selectedText.symbology
                //bad fix
                if self.symbology == "Code 39"
                {
                    skipOnChange=false
                }
                else
                {
                    skipOnChange=true
                }

                if self.extendedStyle != selectedText.extendedStyle
                {
                    skipExtendedStyleOnChange = true
                }
                
                self.extendedStyle = selectedText.extendedStyle
                self.bearersBar = selectedText.bearersBar

                
                self.barcode = selectedText.barcode
                self.humanReadableText = selectedText.humanReadableText
                
                self.textColor = selectedText.textColor
                self.fontName = selectedText.fontName
                print(fontName)
                self.fontSize = selectedText.fontSize

                self.hrTextColor = selectedText.hrTextColor
                self.hrFontName = selectedText.hrFontName
                self.hrFontSize = selectedText.hrFontSize

                self.alignment = selectedText.horizontalTextAlignment
                //self.zIndex = String(format: "%.0f", selectedText.zIndex)
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

