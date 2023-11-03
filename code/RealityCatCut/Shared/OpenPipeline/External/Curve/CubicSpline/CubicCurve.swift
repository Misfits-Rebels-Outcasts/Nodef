//
//  Copyright © 2022 James Boo. All rights reserved.
//  Original code is under the Original MIT License
//
//  The modified derivation is available under GPL2.0
//
//
//  https://github.com/quantumOrange/CubicSpline
//
//  CubicCurve.swift
//  
//
//  Created by David Crooks on 21/02/2023.
//

import Foundation

public struct CubicCurve {
    
    let a: SIMD2<Double>
    let b: SIMD2<Double>
    let c: SIMD2<Double>
    let d: SIMD2<Double>
    
    public var start: SIMD2<Double> {
        a
    }
    
    public var end: SIMD2<Double> {
        a + b + c + d
    }
    
    public var bezierControlPoint1:SIMD2<Double> {
        a + b / 3.0
    }

    public var bezierControlPoint2:SIMD2<Double> {
        a + 2 * b / 3.0 + c / 3.0
    }

    public func f(_ t:Double) -> SIMD2<Double> {
        let t_2:Double = t * t
        let t_3:Double = t_2  * t
        
        let r1:SIMD2<Double> = a + (b * t)
        let r2:SIMD2<Double> = (c * t_2)  + (d * t_3)
        
        return r1 + r2
    }
    
    public func df(_ t:Double) -> SIMD2<Double> {
        
        let t_2:Double = t * t
        let r1:SIMD2<Double> = b
        let r2:SIMD2<Double> = (2 * c * t)  + (3 * d * t_2)
        
        return r1 + r2
    }
    
    func ddf(_ t:Double) -> SIMD2<Double> {
        2 * c + 6 * d * t
    }
    
    init(start: SIMD2<Double>, end: SIMD2<Double>, derivativeStart c_start: SIMD2<Double>, derivativeEnd c_end: SIMD2<Double> ) {
        self.a = start
        self.b = c_start
        self.c = 3 * (end - start) - 2 * c_start - c_end
        self.d = 2 * (start - end) + c_start + c_end
    }
}


