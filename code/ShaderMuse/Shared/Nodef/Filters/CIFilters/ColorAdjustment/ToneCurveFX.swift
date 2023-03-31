//
//  Copyright © 2022 James Boo. All rights reserved.
//

import SwiftUI

class ToneCurveFX: FilterX {
       
    //revisit No Curve UI. So to hide first
    //revisit reconcile cgfloat and float
    @Published var pointX0:CGFloat = 0
    @Published var pointY0:CGFloat = 0

    @Published var pointX1:CGFloat = 0.25
    @Published var pointY1:CGFloat = 0.25
    
    @Published var pointX2:CGFloat = 0.5
    @Published var pointY2:CGFloat = 0.5
    
    @Published var pointX3:CGFloat = 0.75
    @Published var pointY3:CGFloat = 0.75
    
    @Published var pointX4:CGFloat = 1
    @Published var pointY4:CGFloat = 1
    
    let description = "Adjusts tone response of the R, G, and B channels of an image. This typically changes the brightness in part of the spectrum. The input points are five x,y values that are interpolated using a spline curve. The user interface of the this filter node is still in Preview and will be updated in the upcoming version."

    override init()
    {
        let name = "CIToneCurve"
        super.init(name)
        desc=description
      
        print(CIFilter.localizedName(forFilterName: name))
        print(CIFilter.localizedDescription(forFilterName: name))
        print(CIFilter.localizedReferenceDocumentation(forFilterName: name))
         
    }

    enum CodingKeys : String, CodingKey {
        case pointX0
        case pointY0

        case pointX1
        case pointY1

        case pointX2
        case pointY2

        case pointX3
        case pointY3

        case pointX4
        case pointY4

    }

    required init(from decoder: Decoder) throws {
        try super.init(from: decoder)
        let values = try decoder.container(keyedBy: CodingKeys.self)
        desc=description
        pointX0 = try values.decodeIfPresent(CGFloat.self, forKey: .pointX0) ?? 0.0
        pointY0 = try values.decodeIfPresent(CGFloat.self, forKey: .pointY0) ?? 0.0
        
        pointX1 = try values.decodeIfPresent(CGFloat.self, forKey: .pointX1) ?? 0.0
        pointY1 = try values.decodeIfPresent(CGFloat.self, forKey: .pointY1) ?? 0.0
        
        pointX2 = try values.decodeIfPresent(CGFloat.self, forKey: .pointX2) ?? 0.0
        pointY2 = try values.decodeIfPresent(CGFloat.self, forKey: .pointY2) ?? 0.0
        
        pointX3 = try values.decodeIfPresent(CGFloat.self, forKey: .pointX3) ?? 0.0
        pointY3 = try values.decodeIfPresent(CGFloat.self, forKey: .pointY3) ?? 0.0
                
        pointX4 = try values.decodeIfPresent(CGFloat.self, forKey: .pointX4) ?? 0.0
        pointY4 = try values.decodeIfPresent(CGFloat.self, forKey: .pointY4) ?? 0.0
        
 
        
    }
    
    override func encode(to encoder: Encoder) throws {
        try super.encode(to: encoder)
        var container = encoder.container(keyedBy: CodingKeys.self)
        
        try container.encode(pointX0, forKey: .pointX0)
        try container.encode(pointY0, forKey: .pointY0)

        try container.encode(pointX1, forKey: .pointX1)
        try container.encode(pointY1, forKey: .pointY1)

        try container.encode(pointX2, forKey: .pointX2)
        try container.encode(pointY2, forKey: .pointY2)

        try container.encode(pointX3, forKey: .pointX3)
        try container.encode(pointY3, forKey: .pointY3)

        try container.encode(pointX4, forKey: .pointX4)
        try container.encode(pointY4, forKey: .pointY4)

    }
    
    override func getCIFilter(_ ciImage: CIImage)->CIFilter
    {
        var currentCIFilter: CIFilter
        if ciFilter != nil {
            currentCIFilter = ciFilter!
        } else {
            currentCIFilter = CIFilter(name: type)!
            ciFilter=currentCIFilter
        }
        currentCIFilter.setValue(ciImage, forKey: kCIInputImageKey)
        
        let point0=CIVector(x:pointX0,y:pointY0)
        currentCIFilter.setValue(point0, forKey: "inputPoint0")

        let point1=CIVector(x:pointX1,y:pointY1)
        currentCIFilter.setValue(point1, forKey: "inputPoint1")

        let point2=CIVector(x:pointX2,y:pointY2)
        currentCIFilter.setValue(point2, forKey: "inputPoint2")

        let point3=CIVector(x:pointX3,y:pointY3)
        currentCIFilter.setValue(point3, forKey: "inputPoint3")

        let point4=CIVector(x:pointX4,y:pointY4)
        currentCIFilter.setValue(point4, forKey: "inputPoint4")

        return currentCIFilter
    }

}
