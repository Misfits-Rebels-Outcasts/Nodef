//
//  Copyright © 2022-2023 James Boo. All rights reserved.
//

import SwiftUI
import Combine
import RealityKit
import ARKit
class TerrianFX: BaseGeneratorEntityFX {
       
    @Published var timeElapsed:Float = 0.0
    @Published var numCellsWidth:Float = 32.0
    @Published var numCellsHeight:Float = 32.0
    @Published var cellSize:Float = 0.01
    @Published var height:Float = 0.0
    @Published var metallic:Float = 0.3
    @Published var roughness:Float = 0.3

    var worldOrigin: SIMD3<Float> =   [0.0, -0.15, 1.76]//[0.0, 0.0, 0.0]

    var sphere: MeshResource?
    
    let description = "Terrian for Augmented Reality"
    //private var displayEntity: ModelEntity!

    override init()
    {
        let name = "CITerrian"
        super.init(name)
        desc=description
        rotateX=0.0
        rotateY=45.0
        rotateZ=0.0
    }
    
    init(photoARView: PhotoARView)
    {
        let name = "CITerrian"
        super.init(name)
        desc=description
        self.photoARView=photoARView
        rotateX=0.0
        rotateY=45.0
        rotateZ=0.0
    }
    
    enum CodingKeys : String, CodingKey {
        case numCellsWidth
        case numCellsHeight
        case cellSize
        case height
        case metallic
        case roughness
    }

    required init(from decoder: Decoder) throws {
        try super.init(from: decoder)
        let values = try decoder.container(keyedBy: CodingKeys.self)
        desc=description
        numCellsWidth = try values.decodeIfPresent(Float.self, forKey: .numCellsWidth) ?? 8.0
        numCellsHeight = try values.decodeIfPresent(Float.self, forKey: .numCellsHeight) ?? 8.0
        cellSize = try values.decodeIfPresent(Float.self, forKey: .cellSize) ?? 0.01
        height = try values.decodeIfPresent(Float.self, forKey: .height) ?? 0.023

        metallic = try values.decodeIfPresent(Float.self, forKey: .metallic) ?? 0.5
        roughness = try values.decodeIfPresent(Float.self, forKey: .roughness) ?? 0.5
    }
    
    override func encode(to encoder: Encoder) throws {
        try super.encode(to: encoder)
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(numCellsWidth, forKey: .numCellsWidth)
        try container.encode(numCellsHeight, forKey: .numCellsHeight)
        try container.encode(cellSize, forKey: .cellSize)
        try container.encode(height, forKey: .height)
        try container.encode(metallic, forKey: .metallic)
        try container.encode(roughness, forKey: .roughness)
    }

    func getDocumentsDirectory() -> URL {
        let paths = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
        return paths[0]
    }
    
    //https://codingxr.com/articles/procedural-mesh-in-realitykit/
        func buildMesh(numCells: simd_int2, cellSize: Float, height : Float) -> MeshResource {
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
                    
                    positions.append([x, height, z])
                    positions.append([x + cellSize, height, z])
                    positions.append([x, height, z + cellSize])
                    positions.append([x + cellSize, height, z + cellSize])
                    
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

            let mesh = try! MeshResource.generate(from: [descriptor])
            
            return mesh
            
        }
        
    
    var constantColorCIFilter: CIFilter?
    override func getCIFilter(_ ciImage: CIImage)->CIFilter
    {

        if anchorEntity != nil {
            photoARView!.scene.removeAnchor(anchorEntity)
        }
        anchorEntity = AnchorEntity(world: worldOrigin)
        
        let ncw:Int32 = Int32(numCellsWidth)
        let nch:Int32 = Int32(numCellsHeight)
        let terrian = buildMesh(numCells: [ncw, nch], cellSize: cellSize, height : height)
        displayEntity = ModelEntity(mesh: terrian)
        /*
        displayEntity.transform.translation = [x,y,z]
        
        displayEntity.transform.rotation = simd_quatf(angle: rotateX * Float.pi / 180.0, axis: SIMD3<Float>(1,0,0)) * simd_quatf(angle: rotateY * Float.pi / 180.0, axis: SIMD3<Float>(0,1,0)) * simd_quatf(angle: rotateZ * Float.pi / 180.0, axis: SIMD3<Float>(0,0,1))

        displayEntity.transform.scale = [scale/100.0,scale/100.0,scale/100.0]
         */


        anchorEntity.addChild(displayEntity)

        var material = SimpleMaterial()
        material.color =  .init(tint: .blue.withAlphaComponent(0.05), texture: nil)
        let device = MTLCreateSystemDefaultDevice()!
        let library = device.makeDefaultLibrary()!
        let geometryWaterModifier = CustomMaterial.GeometryModifier(named: "geometryModifier", in: library)
        
        let surfaceWaterShader = CustomMaterial.SurfaceShader(named: "surfaceShader", in: library)
        let customWaterMaterials = try! CustomMaterial(from: material, surfaceShader : surfaceWaterShader, geometryModifier: geometryWaterModifier)
        
        displayEntity.model?.materials = [customWaterMaterials]
        
        let spotLight = SpotLight()
         spotLight.light.color = .white
        spotLight.light.intensity = 1000000
        spotLight.light.innerAngleInDegrees = 30
        spotLight.light.outerAngleInDegrees = 90
        spotLight.light.attenuationRadius = 12
        spotLight.shadow = SpotLightComponent.Shadow() //shadow
         spotLight.look(at:worldOrigin, from: [0, 1, 11.0], relativeTo: nil)
         anchorEntity.addChild(spotLight)
         
         let spotLight2 = SpotLight()
         spotLight2.light.color = .white
         spotLight2.light.intensity = 1000000
         spotLight2.light.innerAngleInDegrees = 30
         spotLight2.light.outerAngleInDegrees = 90
         spotLight2.light.attenuationRadius = 10
         //spotLight.shadow = SpotLightComponent.Shadow() //shadow
         spotLight2.look(at:worldOrigin + [1,1,1], from: [0, 1.5, -9.0], relativeTo: nil)
       
        anchorEntity.addChild(spotLight2)
        
        photoARView!.scene.addAnchor(anchorEntity)
        
        return super.getCIFilter(ciImage)
 
    }

}
