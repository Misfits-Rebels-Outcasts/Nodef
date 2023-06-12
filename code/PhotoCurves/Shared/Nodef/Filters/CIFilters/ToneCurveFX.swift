//
//  Copyright © 2022 James Boo. All rights reserved.
//

import SwiftUI

class ToneCurveFX: FilterX {
           
    //Single, RGB, Red, Green, Blue, HSV
    //RGB All, RGB, RGB Red, RGB Green, RGB Blue, HSV
    @Published var channelMode:String = "RGB All"
    @Published var channel:String = "Red"
    
    var cp: CurvePoints = CurvePoints()
    var rcp: CurvePoints = CurvePoints()
    var gcp: CurvePoints = CurvePoints()
    var bcp: CurvePoints = CurvePoints()
    
    let description = "Adjusts tone response of the RGB or HSV channels of an image. This typically changes the brightness or contrast of an image. The input points are five x,y values that are interpolated using a spline curve. "

    override init()
    {
        let name = "CIToneCurve"
        super.init(name)
        desc=description
      
         
    }

    enum CodingKeys : String, CodingKey {
        case channelMode
        
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
        case cinitialPoint0
        case cinitialPoint1
        case cinitialPoint2
        case cinitialPoint3
        case cinitialPoint4
        case coffsetPoint0
        case coffsetPoint1
        case coffsetPoint2
        case coffsetPoint3
        case coffsetPoint4

        case rpointX0
        case rpointY0
        case rpointX1
        case rpointY1
        case rpointX2
        case rpointY2
        case rpointX3
        case rpointY3
        case rpointX4
        case rpointY4
        case rcinitialPoint0
        case rcinitialPoint1
        case rcinitialPoint2
        case rcinitialPoint3
        case rcinitialPoint4
        case rcoffsetPoint0
        case rcoffsetPoint1
        case rcoffsetPoint2
        case rcoffsetPoint3
        case rcoffsetPoint4
        
        case gpointX0
        case gpointY0
        case gpointX1
        case gpointY1
        case gpointX2
        case gpointY2
        case gpointX3
        case gpointY3
        case gpointX4
        case gpointY4
        case gcinitialPoint0
        case gcinitialPoint1
        case gcinitialPoint2
        case gcinitialPoint3
        case gcinitialPoint4
        case gcoffsetPoint0
        case gcoffsetPoint1
        case gcoffsetPoint2
        case gcoffsetPoint3
        case gcoffsetPoint4

        case bpointX0
        case bpointY0
        case bpointX1
        case bpointY1
        case bpointX2
        case bpointY2
        case bpointX3
        case bpointY3
        case bpointX4
        case bpointY4
        case bcinitialPoint0
        case bcinitialPoint1
        case bcinitialPoint2
        case bcinitialPoint3
        case bcinitialPoint4
        case bcoffsetPoint0
        case bcoffsetPoint1
        case bcoffsetPoint2
        case bcoffsetPoint3
        case bcoffsetPoint4

    }
    
    required init(from decoder: Decoder) throws {
        try super.init(from: decoder)
        let values = try decoder.container(keyedBy: CodingKeys.self)
        desc=description
        channelMode = try values.decodeIfPresent(String.self, forKey: .channelMode) ?? "RGB All"
      
        if channelMode == "RGB All" {
            cp.pointX0 = try values.decodeIfPresent(CGFloat.self, forKey: .pointX0) ?? 0.0
            cp.pointY0 = try values.decodeIfPresent(CGFloat.self, forKey: .pointY0) ?? 0.0
            
            cp.pointX1 = try values.decodeIfPresent(CGFloat.self, forKey: .pointX1) ?? 0.0
            cp.pointY1 = try values.decodeIfPresent(CGFloat.self, forKey: .pointY1) ?? 0.0
            
            cp.pointX2 = try values.decodeIfPresent(CGFloat.self, forKey: .pointX2) ?? 0.0
            cp.pointY2 = try values.decodeIfPresent(CGFloat.self, forKey: .pointY2) ?? 0.0
            
            cp.pointX3 = try values.decodeIfPresent(CGFloat.self, forKey: .pointX3) ?? 0.0
            cp.pointY3 = try values.decodeIfPresent(CGFloat.self, forKey: .pointY3) ?? 0.0
                    
            cp.pointX4 = try values.decodeIfPresent(CGFloat.self, forKey: .pointX4) ?? 0.0
            cp.pointY4 = try values.decodeIfPresent(CGFloat.self, forKey: .pointY4) ?? 0.0
            
            cp.cinitialPoint0 = try values.decodeIfPresent(CGSize.self, forKey: .cinitialPoint0) ??  CGSize(width: 0.0, height: 1.0)
            cp.cinitialPoint1 = try values.decodeIfPresent(CGSize.self, forKey: .cinitialPoint1) ??  CGSize(width: 0.25, height: 0.75)
            cp.cinitialPoint2 = try values.decodeIfPresent(CGSize.self, forKey: .cinitialPoint2) ??  CGSize(width: 0.5, height: 0.5)
            cp.cinitialPoint3 = try values.decodeIfPresent(CGSize.self, forKey: .cinitialPoint3) ??  CGSize(width: 0.75, height: 0.25)
            cp.cinitialPoint4 = try values.decodeIfPresent(CGSize.self, forKey: .cinitialPoint4) ??  CGSize(width: 1.0, height: 1.0)

            cp.coffsetPoint0 = try values.decodeIfPresent(CGSize.self, forKey: .coffsetPoint0) ??  CGSize(width: 0.0, height: 0.0)
            cp.coffsetPoint1 = try values.decodeIfPresent(CGSize.self, forKey: .coffsetPoint1) ??  CGSize(width: 0.0, height: 0.0)
            cp.coffsetPoint2 = try values.decodeIfPresent(CGSize.self, forKey: .coffsetPoint2) ??  CGSize(width: 0.0, height: 0.0)
            cp.coffsetPoint3 = try values.decodeIfPresent(CGSize.self, forKey: .coffsetPoint3) ??  CGSize(width: 0.0, height: 0.0)
            cp.coffsetPoint4 = try values.decodeIfPresent(CGSize.self, forKey: .coffsetPoint4) ??  CGSize(width: 0.0, height: 0.0)
        }
        if channelMode == "RGB"
            || channelMode == "RGB Red"
            || channelMode == "HSV"{
            rcp.pointX0 = try values.decodeIfPresent(CGFloat.self, forKey: .rpointX0) ?? 0.0
            rcp.pointY0 = try values.decodeIfPresent(CGFloat.self, forKey: .rpointY0) ?? 0.0
            
            rcp.pointX1 = try values.decodeIfPresent(CGFloat.self, forKey: .rpointX1) ?? 0.0
            rcp.pointY1 = try values.decodeIfPresent(CGFloat.self, forKey: .rpointY1) ?? 0.0
            
            rcp.pointX2 = try values.decodeIfPresent(CGFloat.self, forKey: .rpointX2) ?? 0.0
            rcp.pointY2 = try values.decodeIfPresent(CGFloat.self, forKey: .rpointY2) ?? 0.0
            
            rcp.pointX3 = try values.decodeIfPresent(CGFloat.self, forKey: .rpointX3) ?? 0.0
            rcp.pointY3 = try values.decodeIfPresent(CGFloat.self, forKey: .rpointY3) ?? 0.0
                    
            rcp.pointX4 = try values.decodeIfPresent(CGFloat.self, forKey: .rpointX4) ?? 0.0
            rcp.pointY4 = try values.decodeIfPresent(CGFloat.self, forKey: .rpointY4) ?? 0.0
            
            rcp.cinitialPoint0 = try values.decodeIfPresent(CGSize.self, forKey: .rcinitialPoint0) ??  CGSize(width: 0.0, height: 1.0)
            rcp.cinitialPoint1 = try values.decodeIfPresent(CGSize.self, forKey: .rcinitialPoint1) ??  CGSize(width: 0.25, height: 0.75)
            rcp.cinitialPoint2 = try values.decodeIfPresent(CGSize.self, forKey: .rcinitialPoint2) ??  CGSize(width: 0.5, height: 0.5)
            rcp.cinitialPoint3 = try values.decodeIfPresent(CGSize.self, forKey: .rcinitialPoint3) ??  CGSize(width: 0.75, height: 0.25)
            rcp.cinitialPoint4 = try values.decodeIfPresent(CGSize.self, forKey: .rcinitialPoint4) ??  CGSize(width: 1.0, height: 1.0)

            rcp.coffsetPoint0 = try values.decodeIfPresent(CGSize.self, forKey: .rcoffsetPoint0) ??  CGSize(width: 0.0, height: 0.0)
            rcp.coffsetPoint1 = try values.decodeIfPresent(CGSize.self, forKey: .rcoffsetPoint1) ??  CGSize(width: 0.0, height: 0.0)
            rcp.coffsetPoint2 = try values.decodeIfPresent(CGSize.self, forKey: .rcoffsetPoint2) ??  CGSize(width: 0.0, height: 0.0)
            rcp.coffsetPoint3 = try values.decodeIfPresent(CGSize.self, forKey: .rcoffsetPoint3) ??  CGSize(width: 0.0, height: 0.0)
            rcp.coffsetPoint4 = try values.decodeIfPresent(CGSize.self, forKey: .rcoffsetPoint4) ??  CGSize(width: 0.0, height: 0.0)
        }
        if channelMode == "RGB"
            || channelMode == "RGB Green"
            || channelMode == "HSV" {
            gcp.pointX0 = try values.decodeIfPresent(CGFloat.self, forKey: .gpointX0) ?? 0.0
            gcp.pointY0 = try values.decodeIfPresent(CGFloat.self, forKey: .gpointY0) ?? 0.0
            
            gcp.pointX1 = try values.decodeIfPresent(CGFloat.self, forKey: .gpointX1) ?? 0.0
            gcp.pointY1 = try values.decodeIfPresent(CGFloat.self, forKey: .gpointY1) ?? 0.0
            
            gcp.pointX2 = try values.decodeIfPresent(CGFloat.self, forKey: .gpointX2) ?? 0.0
            gcp.pointY2 = try values.decodeIfPresent(CGFloat.self, forKey: .gpointY2) ?? 0.0
            
            gcp.pointX3 = try values.decodeIfPresent(CGFloat.self, forKey: .gpointX3) ?? 0.0
            gcp.pointY3 = try values.decodeIfPresent(CGFloat.self, forKey: .gpointY3) ?? 0.0
                    
            gcp.pointX4 = try values.decodeIfPresent(CGFloat.self, forKey: .gpointX4) ?? 0.0
            gcp.pointY4 = try values.decodeIfPresent(CGFloat.self, forKey: .gpointY4) ?? 0.0
            
            gcp.cinitialPoint0 = try values.decodeIfPresent(CGSize.self, forKey: .gcinitialPoint0) ??  CGSize(width: 0.0, height: 1.0)
            gcp.cinitialPoint1 = try values.decodeIfPresent(CGSize.self, forKey: .gcinitialPoint1) ??  CGSize(width: 0.25, height: 0.75)
            gcp.cinitialPoint2 = try values.decodeIfPresent(CGSize.self, forKey: .gcinitialPoint2) ??  CGSize(width: 0.5, height: 0.5)
            gcp.cinitialPoint3 = try values.decodeIfPresent(CGSize.self, forKey: .gcinitialPoint3) ??  CGSize(width: 0.75, height: 0.25)
            gcp.cinitialPoint4 = try values.decodeIfPresent(CGSize.self, forKey: .gcinitialPoint4) ??  CGSize(width: 1.0, height: 1.0)

            gcp.coffsetPoint0 = try values.decodeIfPresent(CGSize.self, forKey: .gcoffsetPoint0) ??  CGSize(width: 0.0, height: 0.0)
            gcp.coffsetPoint1 = try values.decodeIfPresent(CGSize.self, forKey: .gcoffsetPoint1) ??  CGSize(width: 0.0, height: 0.0)
            gcp.coffsetPoint2 = try values.decodeIfPresent(CGSize.self, forKey: .gcoffsetPoint2) ??  CGSize(width: 0.0, height: 0.0)
            gcp.coffsetPoint3 = try values.decodeIfPresent(CGSize.self, forKey: .gcoffsetPoint3) ??  CGSize(width: 0.0, height: 0.0)
            gcp.coffsetPoint4 = try values.decodeIfPresent(CGSize.self, forKey: .gcoffsetPoint4) ??  CGSize(width: 0.0, height: 0.0)
        }
        if channelMode == "RGB"
            || channelMode == "RGB Blue"
            || channelMode == "HSV" {
            bcp.pointX0 = try values.decodeIfPresent(CGFloat.self, forKey: .bpointX0) ?? 0.0
            bcp.pointY0 = try values.decodeIfPresent(CGFloat.self, forKey: .bpointY0) ?? 0.0
            
            bcp.pointX1 = try values.decodeIfPresent(CGFloat.self, forKey: .bpointX1) ?? 0.0
            bcp.pointY1 = try values.decodeIfPresent(CGFloat.self, forKey: .bpointY1) ?? 0.0
            
            bcp.pointX2 = try values.decodeIfPresent(CGFloat.self, forKey: .bpointX2) ?? 0.0
            bcp.pointY2 = try values.decodeIfPresent(CGFloat.self, forKey: .bpointY2) ?? 0.0
            
            bcp.pointX3 = try values.decodeIfPresent(CGFloat.self, forKey: .bpointX3) ?? 0.0
            bcp.pointY3 = try values.decodeIfPresent(CGFloat.self, forKey: .bpointY3) ?? 0.0
                    
            bcp.pointX4 = try values.decodeIfPresent(CGFloat.self, forKey: .bpointX4) ?? 0.0
            bcp.pointY4 = try values.decodeIfPresent(CGFloat.self, forKey: .bpointY4) ?? 0.0
            
            bcp.cinitialPoint0 = try values.decodeIfPresent(CGSize.self, forKey: .bcinitialPoint0) ??  CGSize(width: 0.0, height: 1.0)
            bcp.cinitialPoint1 = try values.decodeIfPresent(CGSize.self, forKey: .bcinitialPoint1) ??  CGSize(width: 0.25, height: 0.75)
            bcp.cinitialPoint2 = try values.decodeIfPresent(CGSize.self, forKey: .bcinitialPoint2) ??  CGSize(width: 0.5, height: 0.5)
            bcp.cinitialPoint3 = try values.decodeIfPresent(CGSize.self, forKey: .bcinitialPoint3) ??  CGSize(width: 0.75, height: 0.25)
            bcp.cinitialPoint4 = try values.decodeIfPresent(CGSize.self, forKey: .bcinitialPoint4) ??  CGSize(width: 1.0, height: 1.0)

            bcp.coffsetPoint0 = try values.decodeIfPresent(CGSize.self, forKey: .bcoffsetPoint0) ??  CGSize(width: 0.0, height: 0.0)
            bcp.coffsetPoint1 = try values.decodeIfPresent(CGSize.self, forKey: .bcoffsetPoint1) ??  CGSize(width: 0.0, height: 0.0)
            bcp.coffsetPoint2 = try values.decodeIfPresent(CGSize.self, forKey: .bcoffsetPoint2) ??  CGSize(width: 0.0, height: 0.0)
            bcp.coffsetPoint3 = try values.decodeIfPresent(CGSize.self, forKey: .bcoffsetPoint3) ??  CGSize(width: 0.0, height: 0.0)
            bcp.coffsetPoint4 = try values.decodeIfPresent(CGSize.self, forKey: .bcoffsetPoint4) ??  CGSize(width: 0.0, height: 0.0)
        }

    }
    
    override func encode(to encoder: Encoder) throws {
        try super.encode(to: encoder)
        var container = encoder.container(keyedBy: CodingKeys.self)
        
        try container.encode(channelMode, forKey: .channelMode)
        
        if channelMode == "RGB All" {
            try container.encode(cp.pointX0, forKey: .pointX0)
            try container.encode(cp.pointY0, forKey: .pointY0)

            try container.encode(cp.pointX1, forKey: .pointX1)
            try container.encode(cp.pointY1, forKey: .pointY1)

            try container.encode(cp.pointX2, forKey: .pointX2)
            try container.encode(cp.pointY2, forKey: .pointY2)

            try container.encode(cp.pointX3, forKey: .pointX3)
            try container.encode(cp.pointY3, forKey: .pointY3)

            try container.encode(cp.pointX4, forKey: .pointX4)
            try container.encode(cp.pointY4, forKey: .pointY4)
            
            try container.encode(cp.cinitialPoint0, forKey: .cinitialPoint0)
            try container.encode(cp.cinitialPoint1, forKey: .cinitialPoint1)
            try container.encode(cp.cinitialPoint2, forKey: .cinitialPoint2)
            try container.encode(cp.cinitialPoint3, forKey: .cinitialPoint3)
            try container.encode(cp.cinitialPoint4, forKey: .cinitialPoint4)
            
            try container.encode(cp.coffsetPoint0, forKey: .coffsetPoint0)
            try container.encode(cp.coffsetPoint1, forKey: .coffsetPoint1)
            try container.encode(cp.coffsetPoint2, forKey: .coffsetPoint2)
            try container.encode(cp.coffsetPoint3, forKey: .coffsetPoint3)
            try container.encode(cp.coffsetPoint4, forKey: .coffsetPoint4)
        }
             
        if channelMode == "RGB" || channelMode == "RGB Red" || channelMode == "HSV" {
            try container.encode(rcp.pointX0, forKey: .rpointX0)
            try container.encode(rcp.pointY0, forKey: .rpointY0)

            try container.encode(rcp.pointX1, forKey: .rpointX1)
            try container.encode(rcp.pointY1, forKey: .rpointY1)

            try container.encode(rcp.pointX2, forKey: .rpointX2)
            try container.encode(rcp.pointY2, forKey: .rpointY2)

            try container.encode(rcp.pointX3, forKey: .rpointX3)
            try container.encode(rcp.pointY3, forKey: .rpointY3)

            try container.encode(rcp.pointX4, forKey: .rpointX4)
            try container.encode(rcp.pointY4, forKey: .rpointY4)
            
            try container.encode(rcp.cinitialPoint0, forKey: .rcinitialPoint0)
            try container.encode(rcp.cinitialPoint1, forKey: .rcinitialPoint1)
            try container.encode(rcp.cinitialPoint2, forKey: .rcinitialPoint2)
            try container.encode(rcp.cinitialPoint3, forKey: .rcinitialPoint3)
            try container.encode(rcp.cinitialPoint4, forKey: .rcinitialPoint4)
            
            try container.encode(rcp.coffsetPoint0, forKey: .rcoffsetPoint0)
            try container.encode(rcp.coffsetPoint1, forKey: .rcoffsetPoint1)
            try container.encode(rcp.coffsetPoint2, forKey: .rcoffsetPoint2)
            try container.encode(rcp.coffsetPoint3, forKey: .rcoffsetPoint3)
            try container.encode(rcp.coffsetPoint4, forKey: .rcoffsetPoint4)
        }
        if channelMode == "RGB" || channelMode == "RGB Green" || channelMode == "HSV" {
            try container.encode(gcp.pointX0, forKey: .gpointX0)
            try container.encode(gcp.pointY0, forKey: .gpointY0)

            try container.encode(gcp.pointX1, forKey: .gpointX1)
            try container.encode(gcp.pointY1, forKey: .gpointY1)

            try container.encode(gcp.pointX2, forKey: .gpointX2)
            try container.encode(gcp.pointY2, forKey: .gpointY2)

            try container.encode(gcp.pointX3, forKey: .gpointX3)
            try container.encode(gcp.pointY3, forKey: .gpointY3)

            try container.encode(gcp.pointX4, forKey: .gpointX4)
            try container.encode(gcp.pointY4, forKey: .gpointY4)
            
            try container.encode(gcp.cinitialPoint0, forKey: .gcinitialPoint0)
            try container.encode(gcp.cinitialPoint1, forKey: .gcinitialPoint1)
            try container.encode(gcp.cinitialPoint2, forKey: .gcinitialPoint2)
            try container.encode(gcp.cinitialPoint3, forKey: .gcinitialPoint3)
            try container.encode(gcp.cinitialPoint4, forKey: .gcinitialPoint4)
            
            try container.encode(gcp.coffsetPoint0, forKey: .gcoffsetPoint0)
            try container.encode(gcp.coffsetPoint1, forKey: .gcoffsetPoint1)
            try container.encode(gcp.coffsetPoint2, forKey: .gcoffsetPoint2)
            try container.encode(gcp.coffsetPoint3, forKey: .gcoffsetPoint3)
            try container.encode(gcp.coffsetPoint4, forKey: .gcoffsetPoint4)
        }
        if channelMode == "RGB" || channelMode == "RGB Blue" || channelMode == "HSV" {
            try container.encode(bcp.pointX0, forKey: .bpointX0)
            try container.encode(bcp.pointY0, forKey: .bpointY0)

            try container.encode(bcp.pointX1, forKey: .bpointX1)
            try container.encode(bcp.pointY1, forKey: .bpointY1)

            try container.encode(bcp.pointX2, forKey: .bpointX2)
            try container.encode(bcp.pointY2, forKey: .bpointY2)

            try container.encode(bcp.pointX3, forKey: .bpointX3)
            try container.encode(bcp.pointY3, forKey: .bpointY3)

            try container.encode(bcp.pointX4, forKey: .bpointX4)
            try container.encode(bcp.pointY4, forKey: .bpointY4)
            
            try container.encode(bcp.cinitialPoint0, forKey: .bcinitialPoint0)
            try container.encode(bcp.cinitialPoint1, forKey: .bcinitialPoint1)
            try container.encode(bcp.cinitialPoint2, forKey: .bcinitialPoint2)
            try container.encode(bcp.cinitialPoint3, forKey: .bcinitialPoint3)
            try container.encode(bcp.cinitialPoint4, forKey: .bcinitialPoint4)
            
            try container.encode(bcp.coffsetPoint0, forKey: .bcoffsetPoint0)
            try container.encode(bcp.coffsetPoint1, forKey: .bcoffsetPoint1)
            try container.encode(bcp.coffsetPoint2, forKey: .bcoffsetPoint2)
            try container.encode(bcp.coffsetPoint3, forKey: .bcoffsetPoint3)
            try container.encode(bcp.coffsetPoint4, forKey: .bcoffsetPoint4)
        }
    }
    
    var tonecurveRCIFilter:CIFilter?
    var tonecurveGCIFilter:CIFilter?
    var tonecurveBCIFilter:CIFilter?
    var currentCombineRGBCIFilter:CICombineRGBFilter?
    
    var tonecurveHCIFilter:CIFilter?
    var tonecurveSCIFilter:CIFilter?
    var tonecurveVCIFilter:CIFilter?
    var currentCombineHSVCIFilter:CICombineHSVFilter?
    var currentConvertRGBToHSVCIFilter:CIConvertRGBToHSVFilter?
    var currentConvertHSVToRGBCIFilter:CIConvertHSVToRGBFilter?

    override func getCIFilter(_ ciImage: CIImage)->CIFilter
    {
        if channelMode == "HSV" {
            
            if ciFilter != nil {
                currentConvertHSVToRGBCIFilter = ciFilter as! CIConvertHSVToRGBFilter
            } else {
                currentConvertRGBToHSVCIFilter = CIConvertRGBToHSVFilter()
                currentCombineHSVCIFilter = CICombineHSVFilter()
                currentConvertHSVToRGBCIFilter = CIConvertHSVToRGBFilter()
                ciFilter=currentConvertHSVToRGBCIFilter
            }
            
            
            currentConvertRGBToHSVCIFilter!.inputImage = ciImage
            let hsvImage = currentConvertRGBToHSVCIFilter?.outputImage
            
           
            let tonecurveH = tonecurveHCIFilter != nil ? tonecurveHCIFilter! : CIFilter(name: type)!
            tonecurveH.setValue(hsvImage, forKey: kCIInputImageKey)
           
            let tonecurveS = tonecurveSCIFilter != nil ? tonecurveSCIFilter! : CIFilter(name: type)!
            tonecurveS.setValue(hsvImage, forKey: kCIInputImageKey)

            let tonecurveV = tonecurveVCIFilter != nil ? tonecurveVCIFilter! : CIFilter(name: type)!
            tonecurveV.setValue(hsvImage, forKey: kCIInputImageKey)

            tonecurveH.setValue(CIVector(x:rcp.pointX0,y:rcp.pointY0), forKey: "inputPoint0")
            tonecurveH.setValue(CIVector(x:rcp.pointX1,y:rcp.pointY1), forKey: "inputPoint1")
            tonecurveH.setValue(CIVector(x:rcp.pointX2,y:rcp.pointY2), forKey: "inputPoint2")
            tonecurveH.setValue(CIVector(x:rcp.pointX3,y:rcp.pointY3), forKey: "inputPoint3")
            tonecurveH.setValue(CIVector(x:rcp.pointX4,y:rcp.pointY4), forKey: "inputPoint4")

            tonecurveS.setValue(CIVector(x:gcp.pointX0,y:gcp.pointY0), forKey: "inputPoint0")
            tonecurveS.setValue(CIVector(x:gcp.pointX1,y:gcp.pointY1), forKey: "inputPoint1")
            tonecurveS.setValue(CIVector(x:gcp.pointX2,y:gcp.pointY2), forKey: "inputPoint2")
            tonecurveS.setValue(CIVector(x:gcp.pointX3,y:gcp.pointY3), forKey: "inputPoint3")
            tonecurveS.setValue(CIVector(x:gcp.pointX4,y:gcp.pointY4), forKey: "inputPoint4")
            
            tonecurveV.setValue(CIVector(x:bcp.pointX0,y:bcp.pointY0), forKey: "inputPoint0")
            tonecurveV.setValue(CIVector(x:bcp.pointX1,y:bcp.pointY1), forKey: "inputPoint1")
            tonecurveV.setValue(CIVector(x:bcp.pointX2,y:bcp.pointY2), forKey: "inputPoint2")
            tonecurveV.setValue(CIVector(x:bcp.pointX3,y:bcp.pointY3), forKey: "inputPoint3")
            tonecurveV.setValue(CIVector(x:bcp.pointX4,y:bcp.pointY4), forKey: "inputPoint4")
            
            currentCombineHSVCIFilter!.inputImageR = tonecurveH.outputImage
            currentCombineHSVCIFilter!.inputImageG = tonecurveS.outputImage
            currentCombineHSVCIFilter!.inputImageB = tonecurveV.outputImage
            
            currentCombineHSVCIFilter!.inputTime = CGFloat(0.0)
            
           
            currentConvertHSVToRGBCIFilter!.inputImage = currentCombineHSVCIFilter!.outputImage
            return currentConvertHSVToRGBCIFilter!

        }
        else if channelMode == "RGB"
            || channelMode == "RGB Red"
            || channelMode == "RGB Green"
            || channelMode == "RGB Blue" {
            
            if ciFilter != nil {
                currentCombineRGBCIFilter = ciFilter as! CICombineRGBFilter
            } else {
                currentCombineRGBCIFilter = CICombineRGBFilter()
                ciFilter=currentCombineRGBCIFilter
            }
            
            
            let tonecurveR = tonecurveRCIFilter != nil ? tonecurveRCIFilter! : CIFilter(name: type)!
            tonecurveR.setValue(ciImage, forKey: kCIInputImageKey)
           
            let tonecurveG = tonecurveGCIFilter != nil ? tonecurveGCIFilter! : CIFilter(name: type)!
            tonecurveG.setValue(ciImage, forKey: kCIInputImageKey)

            let tonecurveB = tonecurveBCIFilter != nil ? tonecurveBCIFilter! : CIFilter(name: type)!
            tonecurveB.setValue(ciImage, forKey: kCIInputImageKey)

            tonecurveR.setValue(CIVector(x:rcp.pointX0,y:rcp.pointY0), forKey: "inputPoint0")
            tonecurveR.setValue(CIVector(x:rcp.pointX1,y:rcp.pointY1), forKey: "inputPoint1")
            tonecurveR.setValue(CIVector(x:rcp.pointX2,y:rcp.pointY2), forKey: "inputPoint2")
            tonecurveR.setValue(CIVector(x:rcp.pointX3,y:rcp.pointY3), forKey: "inputPoint3")
            tonecurveR.setValue(CIVector(x:rcp.pointX4,y:rcp.pointY4), forKey: "inputPoint4")

            tonecurveG.setValue(CIVector(x:gcp.pointX0,y:gcp.pointY0), forKey: "inputPoint0")
            tonecurveG.setValue(CIVector(x:gcp.pointX1,y:gcp.pointY1), forKey: "inputPoint1")
            tonecurveG.setValue(CIVector(x:gcp.pointX2,y:gcp.pointY2), forKey: "inputPoint2")
            tonecurveG.setValue(CIVector(x:gcp.pointX3,y:gcp.pointY3), forKey: "inputPoint3")
            tonecurveG.setValue(CIVector(x:gcp.pointX4,y:gcp.pointY4), forKey: "inputPoint4")
            
            tonecurveB.setValue(CIVector(x:bcp.pointX0,y:bcp.pointY0), forKey: "inputPoint0")
            tonecurveB.setValue(CIVector(x:bcp.pointX1,y:bcp.pointY1), forKey: "inputPoint1")
            tonecurveB.setValue(CIVector(x:bcp.pointX2,y:bcp.pointY2), forKey: "inputPoint2")
            tonecurveB.setValue(CIVector(x:bcp.pointX3,y:bcp.pointY3), forKey: "inputPoint3")
            tonecurveB.setValue(CIVector(x:bcp.pointX4,y:bcp.pointY4), forKey: "inputPoint4")
            
            currentCombineRGBCIFilter!.inputImageR = tonecurveR.outputImage
            currentCombineRGBCIFilter!.inputImageG = tonecurveG.outputImage
            currentCombineRGBCIFilter!.inputImageB = tonecurveB.outputImage
            currentCombineRGBCIFilter!.inputTime = CGFloat(0.0)
            if channelMode == "RGB" {
                currentCombineRGBCIFilter!.inputMode = CGFloat(0.0)
            }
            else if channelMode == "RGB Red" {
                currentCombineRGBCIFilter!.inputMode = CGFloat(1.0)
            }
            else if channelMode == "RGB Green" {
                currentCombineRGBCIFilter!.inputMode = CGFloat(2.0)
            }
            else if channelMode == "RGB Blue" {
                currentCombineRGBCIFilter!.inputMode = CGFloat(3.0)
            }

            return currentCombineRGBCIFilter!

        }
        else {
            var currentCIFilter: CIFilter
            if ciFilter != nil {
                currentCIFilter = ciFilter!
            } else {
                currentCIFilter = CIFilter(name: type)!
                ciFilter=currentCIFilter
            }
            
            currentCIFilter.setValue(ciImage, forKey: kCIInputImageKey)
            
            let point0=CIVector(x:cp.pointX0,y:cp.pointY0)
            currentCIFilter.setValue(point0, forKey: "inputPoint0")

            let point1=CIVector(x:cp.pointX1,y:cp.pointY1)
            currentCIFilter.setValue(point1, forKey: "inputPoint1")

            let point2=CIVector(x:cp.pointX2,y:cp.pointY2)
            currentCIFilter.setValue(point2, forKey: "inputPoint2")

            let point3=CIVector(x:cp.pointX3,y:cp.pointY3)
            currentCIFilter.setValue(point3, forKey: "inputPoint3")

            let point4=CIVector(x:cp.pointX4,y:cp.pointY4)
            currentCIFilter.setValue(point4, forKey: "inputPoint4")
            return currentCIFilter
        }

    }

}
