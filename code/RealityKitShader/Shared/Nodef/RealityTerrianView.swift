//
//  Copyright © 2022-2023 James Boo. All rights reserved.
//

import UIKit
import Combine
import RealityKit
import ARKit

class RealityTerrianView: ARView {

    private var landEntity: Entity?
    private var accumulativeTime: Double = 0.0
    private var renderLoopSubscription: Cancellable?

    private let worldOriginMac: SIMD3<Float> = [0.0, -0.12, 1.72]
    private let entityRotationCycle = Float(120.0) // [sec]
    
    //https://codingxr.com/articles/procedural-mesh-in-realitykit/
    func buildMesh(numCells: simd_int2, cellSize: Float) -> MeshResource {
        var positions: [simd_float3] = []
        var textureCoordinates: [simd_float2] = []
        var triangleIndices: [UInt32] = []
        
        let size: simd_float2 = [Float(numCells.x) * cellSize, Float(numCells.y) * cellSize]
        // Offset is used to make the origin in the center
        let offset: simd_float2 = [size.x / 2, size.y / 2]
        var i: UInt32 = 0
        
        let xincr : Float = 1.0 / Float(numCells[0])
        let yincr  : Float = 1.0 / Float(numCells[1])
        var xstart : Float = 0.0
        var ystart : Float = 0.0
        for row in 0..<numCells.y {
            for col in 0..<numCells.x {
                let x = (Float(col) * cellSize) - offset.x
                let z = (Float(row) * cellSize) - offset.y
                
                positions.append([x, 0, z])
                positions.append([x + cellSize, 0, z])
                positions.append([x, 0, z + cellSize])
                positions.append([x + cellSize, 0, z + cellSize])
                
                xstart = Float(col) * xincr
                ystart = Float(row) * yincr
                let uvstart00 : simd_float2 = [xstart, ystart]
                let uvstart10 : simd_float2 = [xstart + Float(xincr), ystart]
                let uvstart01 : simd_float2 = [xstart , ystart + Float(yincr)]
                let uvstart11 : simd_float2 = [xstart + Float(xincr), ystart + Float(yincr)]
                
                textureCoordinates.append(uvstart00)
                textureCoordinates.append(uvstart10)
                textureCoordinates.append(uvstart01)
                textureCoordinates.append(uvstart11)
                
                //textureCoordinates.append([0.0, 0.0])
                //textureCoordinates.append([1.0, 0.0])
                //textureCoordinates.append([0.0, 1.0])
                //textureCoordinates.append([1.0, 1.0])
                
                // Triangle 1
                triangleIndices.append(i)
                triangleIndices.append(i + 2)
                triangleIndices.append(i + 1)
                
                // Triangle 2
                triangleIndices.append(i + 1)
                triangleIndices.append(i + 2)
                triangleIndices.append(i + 3)
                
                i += 4
               
               
            }
      
            
        }
        
        var descriptor = MeshDescriptor(name: "proceduralMesh")
        descriptor.positions = MeshBuffer(positions)
        descriptor.primitives = .triangles(triangleIndices)
        descriptor.textureCoordinates = MeshBuffer(textureCoordinates)
        /*
        var material = PhysicallyBasedMaterial()
        material.baseColor = .init(tint: .white, texture: .init(try! .load(named: "base_color")))
        material.normal = .init(texture: .init(try! .load(named: "normal")))
         */
        let mesh = try! MeshResource.generate(from: [descriptor])
        
        return mesh
        
        //return ModelEntity(mesh: mesh, materials: [material])
    }
    

    func setupScene() {
        
        var anchorEntity: AnchorEntity!

        anchorEntity = AnchorEntity(world: worldOriginMac)
        scene.addAnchor(anchorEntity)
        
         
        //ver 5.0 user defined mesh
        //Prepare materials mod
       
        let device = MTLCreateSystemDefaultDevice()!
        let library = device.makeDefaultLibrary()!
        let geometryModifier = CustomMaterial.GeometryModifier(named: "geometryModifier", in: library)
        
        let surfaceShader = CustomMaterial.SurfaceShader(named: "surfaceShader", in: library)
      
        var baseMaterial = PhysicallyBasedMaterial()
        baseMaterial.baseColor = PhysicallyBasedMaterial.BaseColor(tint: UIColor.green)

        let customMaterials = try! CustomMaterial(from: baseMaterial, surfaceShader : surfaceShader, geometryModifier: geometryModifier)

        let plane = buildMesh(numCells: [64, 64], cellSize: 0.01)
        
         //ver 5.0
         landEntity = ModelEntity(mesh: plane, materials : [customMaterials])
        //landEntity = ModelEntity(mesh: plane, materials : [baseMaterial])
       
        
        if let entity = landEntity {
            
            anchorEntity.addChild(entity)
            
             
            let spotLight = SpotLight()
            spotLight.light.color = .white
            spotLight.light.intensity = 1000000
            spotLight.light.innerAngleInDegrees = 30
            spotLight.light.outerAngleInDegrees = 90
            spotLight.light.attenuationRadius = 12
            spotLight.shadow = SpotLightComponent.Shadow() //shadow
            spotLight.look(at:worldOriginMac, from: [0, 1, 11.0], relativeTo: nil)
            anchorEntity.addChild(spotLight)
             
             let spotLight2 = SpotLight()
             spotLight2.light.color = .white
             spotLight2.light.intensity = 1000000
             spotLight2.light.innerAngleInDegrees = 30
             spotLight2.light.outerAngleInDegrees = 90
             spotLight2.light.attenuationRadius = 10
             spotLight2.look(at:worldOriginMac + [1,1,1], from: [0, 1.5, -9.0], relativeTo: nil)
           
             
            anchorEntity.addChild(spotLight2)
              
        }
     
    }

    /// Start the time-based animation.
    func startPlaying() {
        guard landEntity != nil else { return }

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
        guard let landEntity = landEntity else { return }

        accumulativeTime += deltaTime

        let angle = Float.pi * 2.0 * Float(accumulativeTime) / entityRotationCycle
        let orientation = simd_quatf(angle: angle, axis: [0.0, 1.0, 0.0])
        landEntity.orientation = orientation

       
    }

    
   
}
