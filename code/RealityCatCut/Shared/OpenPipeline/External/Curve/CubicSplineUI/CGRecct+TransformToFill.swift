//
//  Copyright © 2022 James Boo. All rights reserved.
//  Original code is under the Original MIT License
//
//  The modified derivation is available under GPL2.0
//
//
//  https://github.com/quantumOrange/CubicSpline
//  CGRect+TransformToFill.swift
//  
//
//  Created by David Crooks on 25/02/2023.
//

import Foundation
import CoreGraphics


extension CGRect {
    func transformToFill(rect:CGRect) -> CGAffineTransform {
        let scaleX = rect.width / width
        let scaleY = rect.height / height
        
        let scale = CGAffineTransform(scaleX: scaleX, y: scaleY)
        
        let dx =  rect.origin.x - origin.x
        let dy =  rect.origin.y - origin.y
        
        let translation = CGAffineTransform(translationX: dx, y: dy)
        
        return translation.concatenating(scale)
    }
}

