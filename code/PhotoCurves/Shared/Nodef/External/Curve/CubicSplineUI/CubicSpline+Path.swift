//
//  Copyright © 2022 James Boo. All rights reserved.
//  Original code is under the Original MIT License
//
//  The modified derivation is available under GPL2.0
//
//
//  https://github.com/quantumOrange/CubicSpline
//  CunbicPath+Path.swift
//  
//
//  Created by David Crooks on 21/02/2023.
//

import Foundation
import SwiftUI
//import CubicSpline


@available(iOS 13.0, macOS 10.15, *)
extension CubicSpline {
    var path:Path {
        var path = Path()
        
        guard let start = cubicCurves.first?.start.cgPoint else { return path }
        
        path.move(to:start)
        
        for curve in cubicCurves {
            path.addCurve(to: curve.end.cgPoint, control1: curve.bezierControlPoint1.cgPoint, control2: curve.bezierControlPoint2.cgPoint)
        }

        return path
    }
}



