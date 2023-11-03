//
//  Copyright © 2022 James Boo. All rights reserved.
//  Original code is under the Original MIT License
//
//  The modified derivation is available under GPL2.0
//
//
//  https://github.com/quantumOrange/CubicSpline
//
//  CubicSpline.swift
//
//
//  Created by David Crooks on 21/02/2023.
//

import Foundation
import simd

#if os(OSX) || os(iOS)
    import Accelerate
    typealias LAInt = __CLPK_integer
#elseif os(Linux)
    import CLapacke_Linux
    typealias LAInt = Int32
#endif

public struct CubicSpline {
    
    public var cubicCurves:[CubicCurve]
    
    public init() {
        self.cubicCurves = []
    }
    
    mutating func append(points:[SIMD2<Double>]) {
        guard cubicCurves.count > 1 else {
            let allPoints = cubicCurves.endPoints + points
            let newSpline = CubicSpline(points:allPoints )
            cubicCurves = newSpline.cubicCurves
            return
        }
        
        let two = cubicCurves.removeLast()
        let one = cubicCurves.last!
        
        let lastThreePoints = [one,two].endPoints
        
        let allPoints = lastThreePoints + points
        
        let newSpline = CubicSpline(points:allPoints )
        
        cubicCurves.append(contentsOf:newSpline.cubicCurves.dropFirst())
    }
    
    public init(points:[SIMD2<Double>]) {
        // The maths for the following calculation can be found here:
        // https://mathworld.wolfram.com/CubicSpline.html
        
        let n = points.count
        
        var vec:[SIMD2<Double>] = []
        
        guard (n >= 2) else {
            self.cubicCurves = []
            return
        }
        
        for i in 0..<n  {
            if i == 0 {
                vec.append( 3 * ( points[1] - points[0] ))
            }
            else if i == n - 1 {
                vec.append( 3 * ( points[n-1] - points[n-2] ))
            }
            else {
                vec.append( 3 * ( points[i + 1] - points[i-1] ))
            }
        }
        
        guard let derivatives = try? Self.solve(vec) else {
            self.cubicCurves = []
            return }
        
        
        let pointPairs =  points.adjacentPairs()
        let derivativePairs = derivatives.adjacentPairs()
      
        let zippedPairs = zip(pointPairs,derivativePairs)
        
        self.cubicCurves = zippedPairs.map { pointPairs, controlPairs in
            let (start, end) =  pointPairs
            let (c_start, c_end) = controlPairs
            return CubicCurve(start: start, end: end, derivativeStart: c_start, derivativeEnd: c_end)
        }
    }
    
    static func solve(_ v:[SIMD2<Double>]) throws -> [SIMD2<Double>] {
        // We need to solve the matrix equation M * d = v
        // where M is a tri-diagonal matrix:
        
        //  2   1   0   0   0 ...    0
        //  1   4   1   0   0 ...    0
        //  0   1   4   1   0 ...    0
        //  0   0   1   4   1 ...    0
        // ...
        //  0   0   0   0    1   4   1
        //  0   0   0   0    0   1   2
        
        // The lapack function dptsv will solve this efficiently:
        // http://www.netlib.org/lapack/explore-html/d9/dc4/group__double_p_tsolve_gaf1bd4c731915bd8755a4da8086fd79a8.html#gaf1bd4c731915bd8755a4da8086fd79a8
        
        var b = v.toDoubleArray()
        
        var diaganol = Array<Double>(repeating: 4, count: v.count)
        diaganol[0] = 2
        diaganol[v.count-1] = 2
        var subDiagonal = Array<Double>(repeating: 1, count: v.count - 1)
        var n:LAInt = Int32(v.count)
        var nrhs:LAInt = 2
        var info:LAInt = 0
        
        _ = withUnsafeMutablePointer(to: &n) { N in
            withUnsafeMutablePointer(to: &nrhs) { NRHS in
                withUnsafeMutablePointer(to: &info) { INFO in
                    dptsv_(N, NRHS, &diaganol, &subDiagonal, &b, N, INFO)
                }
            }
        }
        
        switch info {
            case 0:
                return b.toSIMD2Array()
            case let i where i > 0:
                throw LaPackError.leadingMinorNotPositiveDefinit(Int(i))
               // assertionFailure("Error: The leading minor of order \(i) is not positive definite, and the solution has not been computed.  The factorization has not been completed unless \(i) = N.")
            case let i where i < 0:
                throw LaPackError.illegalValue(Int(i))
            default:
                throw LaPackError.impossibleError
        }
        
    }
}

extension CubicSpline {
    public var endPoints:[SIMD2<Double>] {
        cubicCurves.endPoints
    }
}

enum LaPackError:Error {
    case leadingMinorNotPositiveDefinit(Int)
    case illegalValue(Int)
    case impossibleError
}

extension LaPackError: LocalizedError {
    public var errorDescription: String? {
        switch self {
        case .leadingMinorNotPositiveDefinit(let i):
            return NSLocalizedString("Error: The leading minor of order \(i) is not positive definite, and the solution has not been computed.  The factorization has not been completed unless \(i) = N.", comment: "LaPack Error")
        case .illegalValue(let i):
            return NSLocalizedString("Error: the \(i)-th argument had an illegal value.", comment: "LaPack Error")
        case .impossibleError:
            return NSLocalizedString("This error is impossible. If you are seeing this you do not exist.", comment: "Impossible error.")
        }
    }
}

