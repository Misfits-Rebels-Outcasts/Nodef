//
//  Copyright © 2022 James Boo. All rights reserved.
//  Original code is under the Original MIT License
//
//  The modified derivation is available under GPL2.0
//
//
//  https://github.com/quantumOrange/CubicSpline
//  SIMD2+CGPoint.swift
//  
//
//  Created by David Crooks on 25/02/2023.
//

import Foundation
import CoreGraphics


extension SIMD2 where Scalar==Double {
    var cgPoint:CGPoint {
        CGPoint(x: x, y: y)
    }
}

