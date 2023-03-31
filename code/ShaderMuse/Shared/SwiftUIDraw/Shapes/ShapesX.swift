//
//  Copyright © 2022 James Boo. All rights reserved.
//


import SwiftUI

class ShapesX: Codable, ObservableObject{
    @Published var shapeList = [ShapeX]()

    init() {
        
    }
    
    func deSelectAll() {
        shapeList.forEach
        {
            $0.isSelected = false
        }
    }
    
    func add(shape: ShapeX)
    {
        shapeList.append(shape)
    }
    
    enum CodingKeys: String, CodingKey {
      case shapelist
    }
    
    enum ShapeTypeKey: CodingKey {
       case type
    }

    enum ShapeTypes: String, Decodable {
            case rectangle = "Rectangle"
            case ellipse = "Ellipse"
            case text = "Text"
            case image = "Image"
            case barcode = "Barcode"
            case qrcode = "QRCode"
    }

    
    required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        var shapesArrayForType = try container.nestedUnkeyedContainer(forKey: CodingKeys.shapelist)
        var newShapeList = [ShapeX]()
        var shapesArray = shapesArrayForType //JSONUnkeyedDecodingContainer that contains a currentIndex. assignining it this way gives you another object which currentIndex is independent

        while(!shapesArrayForType.isAtEnd)
        {
            //isAtEnd and the nestedContainer will loop through
            //Get the shape which is a KeyedDecodingContainer
            let shape = try shapesArrayForType.nestedContainer(keyedBy: ShapeTypeKey.self) //causes the currentIndex to increase
            //print("s:",shape)
            //Get the Type of the Shape (KeyedDecodingContainer)
            //the decode part uses the type which is a key and ShapeTypes which is a enum containing all types
            let type = try shape.decode(ShapeTypes.self, forKey: ShapeTypeKey.type)
  
            switch type {
                case .rectangle:
                    print("found rectangle")
                    newShapeList.append(try shapesArray.decode(RectangleX.self)) //since currentIndex of shapesArray is still at previous location, decode the object
                case .ellipse:
                    print("found ellipse")
                    newShapeList.append(try shapesArray.decode(EllipseX.self))
                case .image:
                    print("found image")
                    newShapeList.append(try shapesArray.decode(ImageX.self))
                case .text:
                    print("found text")
                    newShapeList.append(try shapesArray.decode(TextX.self))
                case .barcode:
                    print("found barcode")
                    newShapeList.append(try shapesArray.decode(BarcodeX.self))
                case .qrcode:
                    print("found qr code")
                    newShapeList.append(try shapesArray.decode(QRCodeX.self))
            }
        }
        self.shapeList = newShapeList
    }

    func encode(to encoder: Encoder) throws {
      var container = encoder.container(keyedBy: CodingKeys.self)
      try container.encode(shapeList, forKey: .shapelist)
    }
    
    func duplicate(labelWidth:Double, labelHeight:Double, dpi:Double)
    {
        
        shapeList.forEach
        {
            if $0.isSelected == true {
                              
                var w=595.0, h=265.0
                w = w < labelWidth*dpi ? w : labelWidth*dpi - 50.0
                h = h < labelHeight*dpi ? h : labelHeight*dpi - 50.0
                w = w < 30 ? 30 : w
                h = h < 30 ? 30 : h
                
                if $0 is RectangleX
                {
                    deSelectAll();
                    
                    let shape = RectangleX(
                            dpi,
                            CGPoint(x:labelWidth*dpi/2,y:labelHeight*dpi/2),
                            CGSize(width: w, height: h),
                            CGSize(width: labelWidth*dpi, height: labelHeight*dpi),
                            true)
                    
                    let selectedShape = $0 as! RectangleX
                    shape.type = selectedShape.type
                    if selectedShape.location.x + 20 <= selectedShape.canvasSize.width
                    {
                        shape.location.x = selectedShape.location.x + 20
                    }
                    else
                    {
                        shape.location.x = selectedShape.location.x
                    }
                    if selectedShape.location.y + 20 <= selectedShape.canvasSize.height
                    {
                        shape.location.y = selectedShape.location.y + 20
                    }
                    else
                    {
                        shape.location.y = selectedShape.location.y
                    }
                    shape.size = selectedShape.size
                    shape.canvasSize = selectedShape.canvasSize
                    shape.isSelected = true
                    shape.zIndex = selectedShape.zIndex
                    
                    shape.strokeWidth = selectedShape.strokeWidth
                    shape.strokeColor = selectedShape.strokeColor
                    shape.fillColor = selectedShape.fillColor
                    selectedShape.isSelected = false

                    add(shape: shape)
                }
                else if $0 is EllipseX
                {
                    deSelectAll();
                    
                    let shape = EllipseX(
                            dpi,
                            CGPoint(x:labelWidth*dpi/2,y:labelHeight*dpi/2),
                            CGSize(width: w, height: h),
                            CGSize(width: labelWidth*dpi, height: labelHeight*dpi),
                            true)
                    
                    let selectedShape = $0 as! EllipseX
                    shape.type = selectedShape.type
                    if selectedShape.location.x + 20 <= selectedShape.canvasSize.width
                    {
                        shape.location.x = selectedShape.location.x + 20
                    }
                    else
                    {
                        shape.location.x = selectedShape.location.x
                    }
                    if selectedShape.location.y + 20 <= selectedShape.canvasSize.height
                    {
                        shape.location.y = selectedShape.location.y + 20
                    }
                    else
                    {
                        shape.location.y = selectedShape.location.y
                    }
                    shape.size = selectedShape.size
                    shape.canvasSize = selectedShape.canvasSize
                    shape.isSelected = true
                    shape.zIndex = selectedShape.zIndex
                    
                    shape.strokeWidth = selectedShape.strokeWidth
                    shape.strokeColor = selectedShape.strokeColor
                    shape.fillColor = selectedShape.fillColor
                    selectedShape.isSelected = false

                    add(shape: shape)
                }
                else if $0 is TextX
                {
                    
                    deSelectAll();
                    
                    let shape = TextX(
                            dpi,
                            CGPoint(x:labelWidth*dpi/2,y:labelHeight*dpi/2),
                            CGSize(width: w, height: h),
                            CGSize(width: labelWidth*dpi, height: labelHeight*dpi),
                            true)
                    
                    let selectedShape = $0 as! TextX
                    shape.type = selectedShape.type
                    if selectedShape.location.x + 20 <= selectedShape.canvasSize.width
                    {
                        shape.location.x = selectedShape.location.x + 20
                    }
                    else
                    {
                        shape.location.x = selectedShape.location.x
                    }
                    if selectedShape.location.y + 20 <= selectedShape.canvasSize.height
                    {
                        shape.location.y = selectedShape.location.y + 20
                    }
                    else
                    {
                        shape.location.y = selectedShape.location.y
                    }
                    shape.size = selectedShape.size
                    shape.canvasSize = selectedShape.canvasSize
                    shape.isSelected = true
                    shape.zIndex = selectedShape.zIndex

                    shape.textType = selectedShape.textType
                    shape.fontSize = selectedShape.fontSize
                    shape.text = selectedShape.text
                    shape.originalText = selectedShape.originalText
                    shape.fontName = selectedShape.fontName
                    shape.textColor = selectedShape.textColor
                    shape.horizontalTextAlignment = selectedShape.horizontalTextAlignment
                    selectedShape.isSelected = false

                    add(shape: shape)
                    
                 
                }
                else if $0 is BarcodeX
                {
                    deSelectAll();
                    let shape = BarcodeX(
                            dpi,
                            CGPoint(x:labelWidth*dpi/2,y:labelHeight*dpi/2),
                            CGSize(width: w, height: h),
                            CGSize(width: labelWidth*dpi, height: labelHeight*dpi),
                            true)
                    let selectedShape = $0 as! BarcodeX
                    shape.type = selectedShape.type
                    if selectedShape.location.x + 20 <= selectedShape.canvasSize.width
                    {
                        shape.location.x = selectedShape.location.x + 20
                    }
                    else
                    {
                        shape.location.x = selectedShape.location.x
                    }
                    if selectedShape.location.y + 20 <= selectedShape.canvasSize.height
                    {
                        shape.location.y = selectedShape.location.y + 20
                    }
                    else
                    {
                        shape.location.y = selectedShape.location.y
                    }
                    shape.size = selectedShape.size
                    shape.canvasSize = selectedShape.canvasSize
                    shape.isSelected = true
                    shape.zIndex = selectedShape.zIndex
                    shape.checkDigit = selectedShape.checkDigit
                    shape.symbology = selectedShape.symbology
                    shape.fontSize = selectedShape.fontSize
                    shape.input = selectedShape.input
                    shape.symbology = selectedShape.symbology
                    shape.checkDigit = selectedShape.checkDigit
                    shape.barcode = selectedShape.barcode
                    shape.humanReadableText = selectedShape.humanReadableText
                    shape.fontName = selectedShape.fontName
                    shape.textColor = selectedShape.textColor
                    shape.horizontalTextAlignment = selectedShape.horizontalTextAlignment
                    shape.hrFontName = selectedShape.hrFontName
                    shape.hrTextColor = selectedShape.hrTextColor
                    shape.hrFontSize = selectedShape.hrFontSize
                    shape.extendedStyle = selectedShape.extendedStyle
                    shape.bearersBar = selectedShape.bearersBar
                    selectedShape.isSelected = false
                    add(shape: shape)
                }
                else if $0 is QRCodeX
                {
                    deSelectAll();
                    let shape = QRCodeX(
                            dpi,
                            CGPoint(x:labelWidth*dpi/2,y:labelHeight*dpi/2),
                            CGSize(width: w, height: h),
                            CGSize(width: labelWidth*dpi, height: labelHeight*dpi),
                            true)
                    let selectedShape = $0 as! QRCodeX
                    shape.type = selectedShape.type
                    if selectedShape.location.x + 20 <= selectedShape.canvasSize.width
                    {
                        shape.location.x = selectedShape.location.x + 20
                    }
                    else
                    {
                        shape.location.x = selectedShape.location.x
                    }
                    if selectedShape.location.y + 20 <= selectedShape.canvasSize.height
                    {
                        shape.location.y = selectedShape.location.y + 20
                    }
                    else
                    {
                        shape.location.y = selectedShape.location.y
                    }
                    shape.size = selectedShape.size
                    shape.canvasSize = selectedShape.canvasSize
                    shape.isSelected = true
                    shape.zIndex = selectedShape.zIndex
                    shape.input = selectedShape.input
                    shape.errorLevel = selectedShape.errorLevel
                    
                    selectedShape.isSelected = false
                    add(shape: shape)
                }
                else if $0 is ImageX
                {
                    deSelectAll();
                    
                    let shape = ImageX(
                            dpi,
                            CGPoint(x:labelWidth*dpi/2,y:labelHeight*dpi/2),
                            CGSize(width: w, height: h),
                            CGSize(width: labelWidth*dpi, height: labelHeight*dpi),
                            true)
                    
                    let selectedShape = $0 as! ImageX
                    shape.type = selectedShape.type
                    if selectedShape.location.x + 20 <= selectedShape.canvasSize.width
                    {
                        shape.location.x = selectedShape.location.x + 20
                    }
                    else
                    {
                        shape.location.x = selectedShape.location.x
                    }
                    if selectedShape.location.y + 20 <= selectedShape.canvasSize.height
                    {
                        shape.location.y = selectedShape.location.y + 20
                    }
                    else
                    {
                        shape.location.y = selectedShape.location.y
                    }
                    shape.size = selectedShape.size
                    shape.canvasSize = selectedShape.canvasSize
                    shape.isSelected = true
                    shape.zIndex = selectedShape.zIndex
                    
        

                    shape.maintainAspectRatio = selectedShape.maintainAspectRatio
                    shape.scale = selectedShape.scale

                    // @Published var image: UIImage = UIImage(named: "LabelImage")!
                    /*
                    let newCgIm = selectedShape.image.cgImage!.copy()
                    let copy = UIImage(cgImage: newCgIm!, scale: selectedShape.image.scale, orientation: selectedShape.image.imageOrientation)
                    */
                    UIGraphicsBeginImageContext(selectedShape.image.size)
                    selectedShape.image.draw(in: CGRect(x: 0, y: 0, width: selectedShape.image.size.width, height: selectedShape.image.size.height))
                    let copy = UIGraphicsGetImageFromCurrentImageContext()
                    UIGraphicsEndImageContext()
                    
                    //let colorSpace = selectedShape.image.cgImage?.colorSpace
                    //let colorSpaceCopy = copy.cgImage?.colorSpace
          

                    //let contrastFilter  = CIFilter.colorControls()
                    //contrastFilter.inputImage = copy?.ciImage
                    //contrastFilter.brightness = Float(50.0 / 100.0)
                    //contrastFilter.saturation = Float(10.0 / 100.0)
                    //contrastFilter.contrast = Float(50.0 / 100.0)
                    //shape.image=UIImage(ciImage:contrastFilter.outputImage!)
                     
                    shape.image=copy!
                    
                    
                    let filters = FiltersX()

                    let encoder=JSONEncoder()
                    encoder.outputFormatting = .prettyPrinted
                    let filtersData = (try? encoder.encode(selectedShape.filters))!
                    let filtersDataStr = String(data: filtersData, encoding: .utf8)!
                    
                    print(filtersDataStr)
                    
                    let loadedFilters = (try? JSONDecoder().decode(FiltersX.self, from: filtersDataStr.data(using: .utf8)!))!
                    
                    shape.filters=loadedFilters
                    shape.filters.reassignIds()
                    shape.filters.initNodeIndex()
                    shape.filters.reassignAllBounds()
                    shape.filteredimage = shape.filters.applyFilters(image: shape.image)
                                                            
                    selectedShape.isSelected = false
                    add(shape: shape)
                    
                }
            }
            
        }
    }
}
