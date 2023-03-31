//
//  Copyright © 2022 James Boo. All rights reserved.
//


import SwiftUI

class TextX: ShapeX {
    
    //300.0 dpi fot init.
    @Published var textType:String = "Enter from Keyboard"
    @Published var fontSize:CGFloat = 16.0*300.0/72.0
    @Published var text:String = "Text"
    @Published var originalText:String = "Text"
    //var originalText:String = "Text"
    @Published var fontName:String = "Arial"
    @Published var textColor = Color.black
    @Published var horizontalTextAlignment:String = "Center"
    
    init(_ dpi:Double, _ location: CGPoint, _ size: CGSize, _ canvasSize: CGSize, _ isSelected: Bool) {
        
        super.init(dpi,"Text",location,size,canvasSize,isSelected)
        fontSize=16.0*dpi/72.0
        
    }

    enum CodingKeys : String, CodingKey {
        case fontSize
        case text
        case textType
        //case originalText
        case fontName
        case textColor
        case horizontalTextAlignment
    }

    required init(from decoder: Decoder) throws {
        try super.init(from: decoder)
        let values = try decoder.container(keyedBy: CodingKeys.self)
        //AA11 - need to revisit the 300 here
        fontSize = try values.decodeIfPresent(CGFloat.self, forKey: .fontSize) ?? 18.0*dpi/72.0
        text = try values.decodeIfPresent(String.self, forKey: .text) ?? "Text"
        //originalText = try values.decodeIfPresent(String.self, forKey: .originalText) ?? "Text"
        fontName = try values.decodeIfPresent(String.self, forKey: .fontName) ?? "Arial"
        textType = try values.decodeIfPresent(String.self, forKey: .textType) ?? "Enter from Keyboard"

        let textColorData = try values.decodeIfPresent(Data.self, forKey: .textColor) ?? nil
        if textColorData != nil
        {
            let color = try NSKeyedUnarchiver.unarchivedObject(ofClass: UIColor.self, from: textColorData!)
            textColor = Color(color!)
        }
        horizontalTextAlignment = try values.decodeIfPresent(String.self, forKey: .horizontalTextAlignment) ?? "Center"

    }
    
    override func encode(to encoder: Encoder) throws {
        try super.encode(to: encoder)
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(fontSize, forKey: .fontSize)
        try container.encode(text, forKey: .text)
        //try container.encode(originalText, forKey: .originalText)
        try container.encode(fontName, forKey: .fontName)
        try container.encode(textType, forKey: .textType)

        let convertedTextColor = UIColor(textColor)
        let textColorData = try NSKeyedArchiver.archivedData(withRootObject: convertedTextColor, requiringSecureCoding: false)
        try container.encode(textColorData, forKey: .textColor)
        try container.encode(horizontalTextAlignment, forKey: .horizontalTextAlignment)

    }
    
    override func view() -> AnyView {
        AnyView(
            HStack{
                if horizontalTextAlignment == "Right" { Spacer() }
                Text(self.text)
                    .lineLimit(1)
                    .font(.custom(self.fontName, size: self.fontSize))
                    .foregroundColor(self.textColor)
                    .fixedSize(horizontal: true, vertical: false)
                if horizontalTextAlignment == "Left" { Spacer() }
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
        
        //self.location.x=self.location.x - self.size.width/2.0 + tw/2.0
        */
    }
    
}
