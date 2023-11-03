//
//  Copyright © 2022-2023 James Boo. All rights reserved.
//

import UIKit
import Combine
import RealityKit
import ARKit

class PhotoARView: ARView {
    
    private var seaEntity: Entity?
    private var accumulativeTime: Double = 0.0
    private var renderLoopSubscription: Cancellable?

    private let worldOriginDevice: SIMD3<Float> = [0.0, 0.0, -0.3]
    //private let worldOriginMac: SIMD3<Float> = [0.0, -0.15, 1.76]
    private let worldOriginMac: SIMD3<Float> = [0.0, -0.15, 0.0]
   
    private let entityRotationCycle = Float(120.0) // [sec]

    private var videoLooper: AVPlayerLooper!
    private var player: AVQueuePlayer!
    private var frameEntity: ModelEntity!
    private var displayEntity: ModelEntity!
    private var isActiveSub:Cancellable!
    
    func setupScene() {
     
        var anchorEntity: AnchorEntity!
        #if targetEnvironment(simulator)
            anchorEntity = AnchorEntity(world: worldOriginMac)
        #else
        if ProcessInfo.processInfo.isiOSAppOnMac {
            anchorEntity = AnchorEntity(world: worldOriginMac)
        } else {
            anchorEntity = AnchorEntity(world: worldOriginDevice)
        }
        #endif
        scene.addAnchor(anchorEntity)

        //let device = MTLCreateSystemDefaultDevice()!
        //let library = device.makeDefaultLibrary()!

        
        var simpleMaterial = SimpleMaterial()
        simpleMaterial.color =  .init(tint: .blue.withAlphaComponent(0.5), texture: nil)
        let sphere = MeshResource.generateSphere(radius: 0.5)
        let displayEntity = ModelEntity(mesh: sphere, materials : [simpleMaterial])

        anchorEntity.addChild(displayEntity)
        
        
        /*
        let spotLight = SpotLight()
        spotLight.light.color = .white
        spotLight.light.intensity = 1000000
        spotLight.light.innerAngleInDegrees = 30
        spotLight.light.outerAngleInDegrees = 90
        spotLight.light.attenuationRadius = 12
        spotLight.shadow = SpotLightComponent.Shadow() //shadow
        spotLight.look(at:worldOriginMac, from: [0, 0, 0.0], relativeTo: nil)
        anchorEntity.addChild(spotLight)
*/

      
        
        /*
        var material = SimpleMaterial()
        material.color = .init(tint: .white.withAlphaComponent(0.999),
                            texture: .init(try! .load(named: "VincentvanGoghSunflowers.jpg")))
        material.metallic = .float(1.0)
        material.roughness = .float(0.0)
                
        let displayEntity = ModelEntity(mesh: sphere, materials : [material])
        
        if let videoURL = Bundle.main.url(forResource: "photopaint", withExtension: "mp4") {
            let asset = AVURLAsset(url: videoURL)
            let playerItem = AVPlayerItem(asset: asset)
            player = AVQueuePlayer(playerItem: playerItem)
            videoLooper = AVPlayerLooper(player: player, templateItem: playerItem)
            let videoMaterial = VideoMaterial(avPlayer: player)
            displayEntity.model?.materials = [videoMaterial]
            player.play()
        }

        anchorEntity.addChild(displayEntity)
         */
             
    }

    
    func startPlaying() {
        //guard seaEntity != nil else { return }

        renderLoopSubscription = scene.subscribe(to: SceneEvents.Update.self) { event in
            DispatchQueue.main.async {
                self.update(deltaTime: event.deltaTime)
            }
        }
    }

    func stopPlaying() {
        renderLoopSubscription?.cancel()
    }

    private func update(deltaTime: Double) {
        guard let seaEntity = seaEntity else { return }

        accumulativeTime += deltaTime

        let angle = Float.pi * 2.0 * Float(accumulativeTime) / entityRotationCycle
        let orientation = simd_quatf(angle: angle, axis: [0.0, 1.0, 0.0])
        seaEntity.orientation = orientation

    }

    
   
}
