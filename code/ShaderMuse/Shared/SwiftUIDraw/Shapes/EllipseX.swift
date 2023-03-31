//
//  Copyright © 2022 James Boo. All rights reserved.
//


import SwiftUI
class EllipseX: ShapeX {
    
    @Published var strokeWidth:Double = 0.25 * 300.0/72.0
    @Published var strokeColor = Color.black
    @Published var fillColor = Color.white
    
    init(_ dpi:Double, _ location: CGPoint, _ size: CGSize, _ canvasSize: CGSize, _ isSelected: Bool) {
        super.init(dpi,"Ellipse",location,size,canvasSize,isSelected)
        strokeWidth = 0.25 * dpi/72.0
    }

    enum CodingKeys : String, CodingKey {
        case strokeWidth
        case strokeColor
        case fillColor
    }

    required init(from decoder: Decoder) throws {
        try super.init(from: decoder)
        let values = try decoder.container(keyedBy: CodingKeys.self)
        strokeWidth = try values.decodeIfPresent(Double.self, forKey: .strokeWidth) ?? 0.25 * dpi/72.0
        
        let strokeColorData = try values.decodeIfPresent(Data.self, forKey: .strokeColor) ?? nil
        if strokeColorData != nil
        {
            let color = try NSKeyedUnarchiver.unarchivedObject(ofClass: UIColor.self, from: strokeColorData!)
            strokeColor = Color(color!)
        }
        
        let fillColorData = try values.decodeIfPresent(Data.self, forKey: .fillColor) ?? nil
        if fillColorData != nil
        {
            let color = try NSKeyedUnarchiver.unarchivedObject(ofClass: UIColor.self, from: fillColorData!)
            fillColor = Color(color!)
        }
    }
    
    override func encode(to encoder: Encoder) throws {
        try super.encode(to: encoder)
          var container = encoder.container(keyedBy: CodingKeys.self)
          try container.encode(strokeWidth, forKey: .strokeWidth)
        
        let convertedStrokeColor = UIColor(strokeColor)
        let strokeColorData = try NSKeyedArchiver.archivedData(withRootObject: convertedStrokeColor, requiringSecureCoding: false)
        try container.encode(strokeColorData, forKey: .strokeColor)
              
        let convertedFillColor = UIColor(fillColor)
        let fillColorData = try NSKeyedArchiver.archivedData(withRootObject: convertedFillColor, requiringSecureCoding: false)
        try container.encode(fillColorData, forKey: .fillColor)
    }

    
    override func view() -> AnyView {
        AnyView(
            Ellipse()
                .stroke(strokeColor, lineWidth: strokeWidth)
                .background(Ellipse().fill(fillColor))
                //.stroke(Color.black, lineWidth: 1)
                .frame(width: self.size.width, height: self.size.height)
                .position(self.location))
        }
}
