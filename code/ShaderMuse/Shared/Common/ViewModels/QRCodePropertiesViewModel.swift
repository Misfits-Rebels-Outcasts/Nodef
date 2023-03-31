
import SwiftUI

class QRCodePropertiesViewModel: ObjectBaseViewModel {
    @Published var input: String = "12345678"
    @Published var errorLevel: String = "L"
    //@Published var qrColor = Color.black
    func setupSelectedProperties()
    {
        self.shapes.shapeList.forEach
        {
            if $0.isSelected == true {
                if $0 is QRCodeX
                {
                    let selectedShape = $0 as! QRCodeX
                    
                    self.errorLevel = selectedShape.errorLevel
                    print(selectedShape.input)
                    self.input = selectedShape.input
                    //self.qrColor = selectedShape.qrColor
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
