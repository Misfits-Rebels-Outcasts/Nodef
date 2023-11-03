//
//  Copyright © 2022 James Boo. All rights reserved.
//

import SwiftUI
import Combine
import RealityKit
import ARKit
class PhotoFrameFX: BaseEntityFX {
       
    @Published var timeElapsed:Float = 0.0
    @Published var radius:Float = 0.5
    @Published var metallic:Float = 0.3
    @Published var roughness:Float = 0.3
    

    var worldOrigin: SIMD3<Float> =  [0.0, 0.0, 0.0]
    //var anchorEntity: AnchorEntity!
    var sphere: MeshResource?
    
    let description = "Photo Frame for Augmented Reality"
    //private var displayEntity: ModelEntity!
    override init()
    {
        let name = "CIPhotoFrameReality"
        super.init(name)
        desc=description
        scale=350.0
        rotateX=0.0
        rotateY=0.0
        rotateZ=0.0
        y=0-0.5
        //z=0-0.5
    }
    
    init(photoARView: PhotoARView)
    {
        let name = "CIPhotoFrameReality"
        super.init(name)
        desc=description
        self.photoARView=photoARView
        scale=350.0
        rotateX=0.0
        rotateY=0.0
        rotateZ=0.0
        y=0-0.5
        //z=0-0.5

    }
    
    enum CodingKeys : String, CodingKey {
        case radius
        case metallic
        case roughness
    }

    required init(from decoder: Decoder) throws {
        try super.init(from: decoder)
        let values = try decoder.container(keyedBy: CodingKeys.self)
        desc=description
        radius = try values.decodeIfPresent(Float.self, forKey: .radius) ?? 0.5
        metallic = try values.decodeIfPresent(Float.self, forKey: .metallic) ?? 0.5
        roughness = try values.decodeIfPresent(Float.self, forKey: .roughness) ?? 0.5
    }
    
    override func encode(to encoder: Encoder) throws {
        try super.encode(to: encoder)
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(radius, forKey: .radius)
        try container.encode(metallic, forKey: .metallic)
        try container.encode(roughness, forKey: .roughness)
    }

    func getDocumentsDirectory() -> URL {
        let paths = FileManager.default.urls(for: .cachesDirectory, in: .userDomainMask)
        return paths[0]
    }
    
    private let surfaceEntityName = "Mesh1"
    var constantColorCIFilter: CIFilter?
    var previousGenerateType=""

    override func getCIFilter(_ ciImage: CIImage)->CIFilter
    {

        //if parent?.videoGeneration == false {
            
        //}
        if parent!.generatedVideoURL != nil {
            print("###generateVideoPhotoFrame")
            generateVideoPhotoFrame(ciImage)
            previousGenerateType="Video"
        } else {
            print("generatePhotoFrame")
            generatePhotoFrame(ciImage)
            previousGenerateType="Photo"
        }
        return super.getCIFilter(ciImage)
 
    }
    
    private var videoLooper: AVPlayerLooper!
    private var player: AVQueuePlayer!
    private var frameEntity: ModelEntity!
    private var isActiveSub:Cancellable!
    
    func generateVideoPhotoFrame(_ ciImage: CIImage) {
        if parent!.generatedVideoURL != nil {
            cleanup()
            anchorEntity = AnchorEntity(world: worldOrigin)
            
            if displayEntity == nil || previousGenerateType=="Photo" {
                displayEntity = try? Entity.load(named: "photoframe")
            }
            
            displayEntity.transform.translation = [x,y,z]
            
            displayEntity.transform.rotation = simd_quatf(angle: rotateX * Float.pi / 180.0, axis: SIMD3<Float>(1,0,0)) * simd_quatf(angle: rotateY * Float.pi / 180.0, axis: SIMD3<Float>(0,1,0)) * simd_quatf(angle: rotateZ * Float.pi / 180.0, axis: SIMD3<Float>(0,0,1))

            displayEntity.transform.scale = [scale/100.0,scale/100.0,scale/100.0]
         
            anchorEntity.addChild(displayEntity)
            if let videoURL = parent!.generatedVideoURL {
                let asset = AVURLAsset(url: videoURL)
                let playerItem = AVPlayerItem(asset: asset)
                player = AVQueuePlayer(playerItem: playerItem)
                videoLooper = AVPlayerLooper(player: player, templateItem: playerItem)
                let videoMaterial = VideoMaterial(avPlayer: player)
                
                if let surfaceEntity = displayEntity.findEntity(named: surfaceEntityName),
                   let surfaceModelEntity = surfaceEntity as? ModelEntity {
                        surfaceModelEntity.model?.materials = [ videoMaterial ]
                }
               
                player.play()
            }
            
            photoARView!.scene.addAnchor(anchorEntity)
        }
    }
    
    func generatePhotoFrame(_ ciImage: CIImage) {
        cleanup()
        anchorEntity = AnchorEntity(world: worldOrigin)
        
        //blank out issue when switching from video material to image
        //reload entity fixes the issue
        if displayEntity == nil || previousGenerateType=="Video" {
            displayEntity = try? Entity.load(named: "photoframe")
        }
        
        displayEntity.transform.translation = [x,y,z]
        
        displayEntity.transform.rotation = simd_quatf(angle: rotateX * Float.pi / 180.0, axis: SIMD3<Float>(1,0,0)) * simd_quatf(angle: rotateY * Float.pi / 180.0, axis: SIMD3<Float>(0,1,0)) * simd_quatf(angle: rotateZ * Float.pi / 180.0, axis: SIMD3<Float>(0,0,1))

        displayEntity.transform.scale = [scale/100.0,scale/100.0,scale/100.0]
     
        anchorEntity.addChild(displayEntity)
        //ANCHISES
        let context = parent!.getContext()
        if let cgimg = context.createCGImage(ciImage , from: ciImage.extent) {
            let processedImage = UIImage(cgImage: cgimg)
            if let data = processedImage.pngData() {
                let filename = getDocumentsDirectory().appendingPathComponent("photoframex"+UUID().uuidString+".png")
                
                if FileManager.default.fileExists(atPath: filename.path) {
                    do {
                        try FileManager.default.removeItem(atPath: filename.path)
                    } catch {
                        print("Unable to delete file: \(error) : \(#function).")
                    }
                }

                try? data.write(to: filename)
                
                do {
          
                    let texture = try TextureResource.load(contentsOf: filename)

                    /*
                    var unlitMaterial = UnlitMaterial()
                    unlitMaterial.color.texture = PhysicallyBasedMaterial.Texture(texture)
                    if let surfaceEntity = displayEntity.findEntity(named: surfaceEntityName),
                       let surfaceModelEntity = surfaceEntity as? ModelEntity {
                            surfaceModelEntity.model?.materials = [ unlitMaterial ]
                    }
                     */
                    
                    var pbrMaterial = PhysicallyBasedMaterial()
                    pbrMaterial.baseColor = PhysicallyBasedMaterial.BaseColor(texture:MaterialParameters.Texture(texture))
                    pbrMaterial.metallic = PhysicallyBasedMaterial.Metallic(floatLiteral: metallic)
                    pbrMaterial.roughness = PhysicallyBasedMaterial.Roughness(floatLiteral: roughness)
                    
                    if let surfaceEntity = displayEntity.findEntity(named: surfaceEntityName),
                       let surfaceModelEntity = surfaceEntity as? ModelEntity {
                            surfaceModelEntity.model?.materials = [ pbrMaterial ]
                    }
                     
                } catch {
                          print(error.localizedDescription)
                      }
            }
        }
        photoARView!.scene.addAnchor(anchorEntity)
    }
    /*
    private var accumulativeTime: Double = 0.0
    private var renderLoopSubscription: Cancellable?
    private let entityRotationCycle = Float(120.0)
     */
}
