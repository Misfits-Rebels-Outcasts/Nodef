//
//  Copyright © 2022 James Boo. All rights reserved.
//

import SwiftUI
import Combine
import RealityKit
import ARKit
class BoxFX: BaseEntityFX {
       
    @Published var timeElapsed:Float = 0.0
    @Published var cornerRadius:Float = 0.2
    @Published var width:Float = 0.7//1.0
    @Published var height:Float = 0.7//1.0
    @Published var depth:Float = 0.7//1.0
    @Published var splitFaces:Bool = false

    @Published var metallic:Float = 0.3
    @Published var roughness:Float = 0.3

    var worldOrigin: SIMD3<Float> =  [0.0, 0.0, 0.0]
    //var anchorEntity: AnchorEntity!
    var sphere: MeshResource?
    
    let description = "Box for Augmented Reality"
    //private var displayEntity: ModelEntity!
/*
    private var videoLooper: AVPlayerLooper!
    private var player: AVQueuePlayer!
    private var frameEntity: ModelEntity!
    private var isActiveSub:Cancellable!
*/
    override init()
    {
        let name = "CIBoxReality"
        super.init(name)
        desc=description
        rotateX=20.0
        rotateY=45.0
        rotateZ=0.0

    }
    
    init(photoARView: PhotoARView)
    {
        let name = "CIBoxReality"
        super.init(name)
        desc=description
        self.photoARView=photoARView
        rotateX=20.0
        rotateY=45.0
        rotateZ=0.0
    }
    
    enum CodingKeys : String, CodingKey {
        case width
        case height
        case depth
        case cornerRadius
        case splitFaces
        case metallic
        case roughness
    }

    required init(from decoder: Decoder) throws {
        try super.init(from: decoder)
        let values = try decoder.container(keyedBy: CodingKeys.self)
        desc=description
        width = try values.decodeIfPresent(Float.self, forKey: .width) ?? 1.0
        height = try values.decodeIfPresent(Float.self, forKey: .height) ?? 1.0
        depth = try values.decodeIfPresent(Float.self, forKey: .depth) ?? 0.15
        cornerRadius = try values.decodeIfPresent(Float.self, forKey: .cornerRadius) ?? 0.0
        splitFaces = try values.decodeIfPresent(Bool.self, forKey: .splitFaces) ?? true
        metallic = try values.decodeIfPresent(Float.self, forKey: .metallic) ?? 0.5
        roughness = try values.decodeIfPresent(Float.self, forKey: .roughness) ?? 0.5
    }
    
    override func encode(to encoder: Encoder) throws {
        try super.encode(to: encoder)
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(width, forKey: .width)
        try container.encode(height, forKey: .height)
        try container.encode(depth, forKey: .depth)
        try container.encode(cornerRadius, forKey: .cornerRadius)
        try container.encode(splitFaces, forKey: .splitFaces)
        try container.encode(metallic, forKey: .metallic)
        try container.encode(roughness, forKey: .roughness)
    }

    func getDocumentsDirectory() -> URL {
        let paths = FileManager.default.urls(for: .cachesDirectory, in: .userDomainMask)
        return paths[0]
    }
    
    func transform(displayModelEntity: ModelEntity) {
        
        displayModelEntity.transform.translation = [x,y,z]
        
        displayModelEntity.transform.rotation = simd_quatf(angle: rotateX * Float.pi / 180.0, axis: SIMD3<Float>(1,0,0)) * simd_quatf(angle: rotateY * Float.pi / 180.0, axis: SIMD3<Float>(0,1,0)) * simd_quatf(angle: rotateZ * Float.pi / 180.0, axis: SIMD3<Float>(0,0,1))

        displayModelEntity.transform.scale = [scale/100.0,scale/100.0,scale/100.0]
    }
    
    var previousGenerateType=""
    private var videoLooper: AVPlayerLooper!
    private var player: AVQueuePlayer!
    private var frameEntity: ModelEntity!
    private var isActiveSub:Cancellable!
    
    func generateObjectWithVideo(_ ciImage: CIImage) {
        cleanup()

        anchorEntity = AnchorEntity(world: worldOrigin)
        
        let displayModelEntity = ModelEntity(mesh: MeshResource.generateBox(width: width, height: height, depth: depth,cornerRadius: cornerRadius, splitFaces: splitFaces))

        transform(displayModelEntity: displayModelEntity)
        
        displayEntity=displayModelEntity
        anchorEntity.addChild(displayEntity)
        
        if let videoURL = parent!.generatedVideoURL {
            let asset = AVURLAsset(url: videoURL)
            let playerItem = AVPlayerItem(asset: asset)
            player = AVQueuePlayer(playerItem: playerItem)
            videoLooper = AVPlayerLooper(player: player, templateItem: playerItem)
            let videoMaterial = VideoMaterial(avPlayer: player)
            
            displayModelEntity.model?.materials = [videoMaterial]
            
            player.play()
        }
        
        
    }
    
    func generateObject(_ ciImage: CIImage) {
        cleanup()
        /*
        if anchorEntity != nil {
            photoARView!.scene.removeAnchor(anchorEntity)
        }
         */
        anchorEntity = AnchorEntity(world: worldOrigin)
        
        let displayModelEntity = ModelEntity(mesh: MeshResource.generateBox(width: width, height: height, depth: depth,cornerRadius: cornerRadius, splitFaces: splitFaces))
        
        transform(displayModelEntity: displayModelEntity)
        
        displayEntity=displayModelEntity
        anchorEntity.addChild(displayEntity)
        let context = parent!.getContext()
        
        if let cgimg = context.createCGImage(ciImage , from: ciImage.extent) {
            let processedImage = UIImage(cgImage: cgimg)
            if let data = processedImage.pngData() {
                let filename = getDocumentsDirectory().appendingPathComponent("box"+UUID().uuidString+".png")

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

                    var pbrMaterial = PhysicallyBasedMaterial()
                    pbrMaterial.baseColor = PhysicallyBasedMaterial.BaseColor(texture:MaterialParameters.Texture(texture))
                    pbrMaterial.metallic = PhysicallyBasedMaterial.Metallic(floatLiteral: metallic)
                    pbrMaterial.roughness = PhysicallyBasedMaterial.Roughness(floatLiteral: roughness)
                    /*
                    var material = SimpleMaterial()
                    material.baseColor = MaterialColorParameter.texture(texture)
                    material.metallic = .float(metallic)
                    material.roughness = .float(roughness)
                     */
                    /*
                    let device = MTLCreateSystemDefaultDevice()!
                    let library = device.makeDefaultLibrary()!
                    let geometryWaterModifier = CustomMaterial.GeometryModifier(named: "geometryWaterModifier", in: library)
                    
                    let surfaceWaterShader = CustomMaterial.SurfaceShader(named: "surfaceWaterShader1", in: library)
                    let customWaterMaterials = try! CustomMaterial(from: material, surfaceShader : surfaceWaterShader, geometryModifier: geometryWaterModifier)
                    */
                 
                    displayModelEntity.model?.materials = [pbrMaterial]
                } catch {
                          print(error.localizedDescription)
                      }
            }
        }
    }
    
    
    var constantColorCIFilter: CIFilter?
    override func getCIFilter(_ ciImage: CIImage)->CIFilter
    {

        if parent!.generatedVideoURL != nil {
            generateObjectWithVideo(ciImage)
            previousGenerateType="Video"
        } else {
            generateObject(ciImage)
            previousGenerateType="Photo"
        }
        
        photoARView!.scene.addAnchor(anchorEntity)
        
        return super.getCIFilter(ciImage)
 
    }
    /*
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
    
        accumulativeTime += deltaTime

        let angle = Float.pi * 2.0 * Float(accumulativeTime) / entityRotationCycle
        let orientation = simd_quatf(angle: angle, axis: [0.0, 1.0, 0.0])
        //displayEntity.orientation = orientation

       
    }
     */
}
