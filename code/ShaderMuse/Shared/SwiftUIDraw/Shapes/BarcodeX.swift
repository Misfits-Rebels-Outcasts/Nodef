//
//  Copyright © 2022 James Boo. All rights reserved.
//


import SwiftUI

class BarcodeX: ShapeX {
    
    //@Published var fontSize:CGFloat = 30.0*300.0/72.0//AppSettings.dpiScale
    //AA11 - need to revisit the 300 here
    @Published var inputType:String = "Enter from Keyboard"

    @Published var fontSize:CGFloat = 99.0 //18.0*300.0/72.0
    @Published var input:String = "1234"
    @Published var symbology:String = "Code 39"
    @Published var checkDigit:Bool = false
    @Published var barcode:String = "*1234*"
    @Published var humanReadableText:String = "*1234*"
    //var originalText:String = "Text"
    @Published var fontName:String = "CCode39_S3"
    @Published var textColor = Color.black
    @Published var horizontalTextAlignment:String = "Center"

    @Published var hrFontName:String = "Arial"
    @Published var hrTextColor = Color.black
    @Published var hrFontSize:CGFloat = 16.0*300.0/72.0

    @Published var extendedStyle:Bool = false
    @Published var bearersBar:String = "Top/Bottom"

    
    init(_ dpi:Double, _ location: CGPoint, _ size: CGSize, _ canvasSize: CGSize, _ isSelected: Bool) {
        
        super.init(dpi,"Barcode",location,size,canvasSize,isSelected)
        fontSize = 23.76 * dpi / 72.0 //99.0 gives the same size as other platforms
        hrFontSize = 16.0*dpi/72.0
    }

    enum CodingKeys : String, CodingKey {
        case inputType
        case input
        case symbology
        case checkDigit
        case extendedStyle
        case bearersBar

        case barcode
        case humanReadableText

        case fontSize
        case fontName
        case textColor
        
        case hrFontSize
        case hrFontName
        case hrTextColor

        case horizontalTextAlignment
    }

    required init(from decoder: Decoder) throws {
        try super.init(from: decoder)
        let values = try decoder.container(keyedBy: CodingKeys.self)
        
        inputType = try values.decodeIfPresent(String.self, forKey: .inputType) ?? "Enter from Keyboard"

        input = try values.decodeIfPresent(String.self, forKey: .input) ?? "1234"
        symbology = try values.decodeIfPresent(String.self, forKey: .symbology) ?? "Code 39"
        checkDigit = try values.decodeIfPresent(Bool.self, forKey: .checkDigit) ?? false
        extendedStyle = try values.decodeIfPresent(Bool.self, forKey: .extendedStyle) ?? false
        bearersBar = try values.decodeIfPresent(String.self, forKey: .bearersBar) ?? "Top/Bottom"

        barcode = try values.decodeIfPresent(String.self, forKey: .barcode) ?? "1234"
        humanReadableText = try values.decodeIfPresent(String.self, forKey: .humanReadableText) ?? "1234"

        //AA11 - need to revisit the 300 here
        fontSize = try values.decodeIfPresent(CGFloat.self, forKey: .fontSize) ?? 18.0*dpi/72.0
        fontName = try values.decodeIfPresent(String.self, forKey: .fontName) ?? "CCode39_S3"
        let textColorData = try values.decodeIfPresent(Data.self, forKey: .textColor) ?? nil
        if textColorData != nil
        {
            let color = try NSKeyedUnarchiver.unarchivedObject(ofClass: UIColor.self, from: textColorData!)
            textColor = Color(color!)
        }
        
        hrFontSize = try values.decodeIfPresent(CGFloat.self, forKey: .hrFontSize) ?? 16.0*300.0/72.0
        hrFontName = try values.decodeIfPresent(String.self, forKey: .hrFontName) ?? "Arial"
        let hrTextColorData = try values.decodeIfPresent(Data.self, forKey: .hrTextColor) ?? nil
        if hrTextColorData != nil
        {
            let color = try NSKeyedUnarchiver.unarchivedObject(ofClass: UIColor.self, from: hrTextColorData!)
            hrTextColor = Color(color!)
        }
        
        horizontalTextAlignment = try values.decodeIfPresent(String.self, forKey: .horizontalTextAlignment) ?? "Center"

    }
    
    override func encode(to encoder: Encoder) throws {
        try super.encode(to: encoder)
        var container = encoder.container(keyedBy: CodingKeys.self)

        try container.encode(inputType, forKey: .inputType)
        try container.encode(input, forKey: .input)
        try container.encode(symbology, forKey: .symbology)
        try container.encode(checkDigit, forKey: .checkDigit)
        try container.encode(extendedStyle, forKey: .extendedStyle)
        try container.encode(bearersBar, forKey: .bearersBar)

        try container.encode(barcode, forKey: .barcode)
        try container.encode(humanReadableText, forKey: .humanReadableText)

        try container.encode(fontName, forKey: .fontName)
        try container.encode(fontSize, forKey: .fontSize)
        let convertedTextColor = UIColor(textColor)
        let textColorData = try NSKeyedArchiver.archivedData(withRootObject: convertedTextColor, requiringSecureCoding: false)
        try container.encode(textColorData, forKey: .textColor)
        
        try container.encode(hrFontName, forKey: .hrFontName)
        try container.encode(hrFontSize, forKey: .hrFontSize)
        let hrconvertedTextColor = UIColor(hrTextColor)
        let hrTextColorData = try NSKeyedArchiver.archivedData(withRootObject: hrconvertedTextColor, requiringSecureCoding: false)
        try container.encode(hrTextColorData, forKey: .hrTextColor)
        
        try container.encode(horizontalTextAlignment, forKey: .horizontalTextAlignment)

    }
    
    override func view() -> AnyView {
        AnyView(
            VStack
            {
                HStack{
                    if horizontalTextAlignment == "Right" { Spacer() }
                    Text(self.barcode)
                        .lineLimit(1)
                        .font(.custom(self.fontName, size: self.fontSize))
                        .foregroundColor(self.textColor)
                        .fixedSize(horizontal: true, vertical: false)
                    if horizontalTextAlignment == "Left" { Spacer() }
                }
                //revisit to fix the extended style problem
                //extended style will trigger encode barcode after reselect barcode and causes fonts to be reselected.
                
                //if symbology=="Code 39" ||
                if extendedStyle == false {
                    HStack{
                        if horizontalTextAlignment == "Right" { Spacer() }
                        Text(self.humanReadableText)
                            .lineLimit(1)
                            .font(.custom(self.hrFontName, size: self.hrFontSize))
                            //.font(.custom("CCodeIND2of5_S3", size: self.hrFontSize))
                            .foregroundColor(self.hrTextColor)
                            .fixedSize(horizontal: true, vertical: false)
                        if horizontalTextAlignment == "Left" { Spacer() }
                    }
                }
            }
                .frame(width: self.size.width, height: self.size.height)
                .clipShape(Rectangle())
                .position(self.location)
        )
    }
    
    override func useElipsisIfSizeTooSmall() {
        /*
        let text=self.originalText
        let textFont = UIFont(name: self.fontName, size: self.fontSize)!
        let tw=text.sizeNoConstraint(font:textFont).width
        let th=text.sizeNoConstraint(font:textFont).height
        print("textuw:",tw)
        print("textuh:",th)
        print("shapew:",self.size.width)
        print("shapeh:",self.size.height)
        if self.size.height<th ||
            self.size.width<tw
        {
            self.text="..."
        }
        else
        {
            self.text=self.originalText
        }
        */
        //self.location.x=self.location.x - self.size.width/2.0 + tw/2.0
        
    }
    
}


