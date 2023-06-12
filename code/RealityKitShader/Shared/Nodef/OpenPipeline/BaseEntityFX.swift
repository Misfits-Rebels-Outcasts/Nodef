//
//  Copyright © 2022 James Boo. All rights reserved.
//

import SwiftUI
import Combine
import RealityKit
import ARKit
class BaseEntityFX: FilterX {
    @Published var x:Float = 0.0
    @Published var y:Float = 0.0
    @Published var z:Float = 0.0
    @Published var scale:Float = 100.0

    @Published var rotateX:Float = 40.0
    @Published var rotateY:Float = 45.0
    @Published var rotateZ:Float = 0.0
    var photoARView:PhotoARView?
    var anchorEntity: AnchorEntity!
    
    private var videoLooper: AVPlayerLooper!
    private var player: AVQueuePlayer!
    private var frameEntity: ModelEntity!
    var displayEntity: ModelEntity!
    private var isActiveSub:Cancellable!
    
    override init()
    {
        super.init()
    }
    
    override init(_ type:String) {
        super.init(type)
    }
    
    enum CodingKeys : String, CodingKey {
        case x
        case y
        case z
        case rotateX
        case rotateY
        case rotateZ
        case scale
    }

    required init(from decoder: Decoder) throws {
 
        try super.init(from: decoder)
        let values = try decoder.container(keyedBy: CodingKeys.self)
        x = try values.decodeIfPresent(Float.self, forKey: .x) ?? 0.0
        y = try values.decodeIfPresent(Float.self, forKey: .y) ?? 0.0
        z = try values.decodeIfPresent(Float.self, forKey: .z) ?? 0.0
        rotateX = try values.decodeIfPresent(Float.self, forKey: .rotateX) ?? 0.0
        rotateY = try values.decodeIfPresent(Float.self, forKey: .rotateY) ?? 0.0
        rotateZ = try values.decodeIfPresent(Float.self, forKey: .rotateZ) ?? 0.0
        scale = try values.decodeIfPresent(Float.self, forKey: .scale) ?? 100.0

    }
    
    override func encode(to encoder: Encoder) throws {
        try super.encode(to: encoder)
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(x, forKey: .x)
        try container.encode(y, forKey: .y)
        try container.encode(z, forKey: .z)
        try container.encode(rotateX, forKey: .rotateX)
        try container.encode(rotateY, forKey: .rotateY)
        try container.encode(rotateZ, forKey: .rotateZ)
        try container.encode(scale, forKey: .scale)

    }

    override func getCIFilter(_ ciImage: CIImage)->CIFilter
    {
        var currentCIFilter: CIFilter
        if ciFilter != nil {
            currentCIFilter = ciFilter!
        } else {
            let color:CIColor = .white
            var constantColorFilter: CIFilter

            constantColorFilter = CIFilter(name: "CIConstantColorGenerator")!
            constantColorFilter.setValue(color, forKey: kCIInputColorKey)
            var cropFilter: CIFilter
            cropFilter = CIFilter(name: "CICrop")!
            cropFilter.setValue(constantColorFilter.outputImage!, forKey: kCIInputImageKey)
            let rect = CIVector(cgRect: CGRect(x:0, y: 0, width: CGFloat(size.width), height: CGFloat(size.height)))
            cropFilter.setValue(rect, forKey: "inputRectangle")
            
            currentCIFilter=constantColorFilter
            ciFilter=currentCIFilter
        }
               
        
        return currentCIFilter
    }
    
    private var accumulativeTime: Double = 0.0
    private var renderLoopSubscription: Cancellable?
    private let entityRotationCycle = Float(120.0)
    func startPlaying() {

        renderLoopSubscription = photoARView!.scene.subscribe(to: SceneEvents.Update.self) { event in
            DispatchQueue.main.async {
                self.update(deltaTime: event.deltaTime)
            }
        }
    }

    /// Stop the time-based animation.
    func stopPlaying() {
        renderLoopSubscription?.cancel()
    }

    /// Update the time-based animation according to the delta-time.
    /// - Parameter deltaTime: delta-time [sec]
    private func update(deltaTime: Double) {
        guard let displayEntity = displayEntity else { return }
        accumulativeTime += deltaTime

        let angle = Float.pi * 2.0 * Float(accumulativeTime) / entityRotationCycle
        let orientation = simd_quatf(angle: angle, axis: [0.0, 1.0, 0.0])
        
        displayEntity.orientation = orientation

       
    }
}
