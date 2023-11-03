//
//  Copyright © 2022-2023 James Boo. All rights reserved.
//

import SwiftUI
import ARKit
import RealityKit

struct Singleton{
    //static var photoARView: PhotoARView! = PhotoARView(frame: .zero, cameraMode: .nonAR, automaticallyConfigureSession: true)
    /*
    #if targetEnvironment(simulator)
        static var photoARView: PhotoARView! = PhotoARView(frame: .zero)
    #else
        static var photoARView: PhotoARView! = PhotoARView(frame: .zero, cameraMode: .nonAR, automaticallyConfigureSession: true)
    #endif
    */
    

    //ANCHISES
    static var avPlayer: AVPlayer!
    static func getAVPlayerView() -> AVPlayer {
        if avPlayer == nil {
            avPlayer = AVPlayer()
            //avPlayer.currentItem=
        }
                
        return avPlayer
    }
    
    static var photoARView: PhotoARView!
    static func getPhotoARView() -> PhotoARView {
        if photoARView == nil {
            #if targetEnvironment(simulator)
                photoARView = PhotoARView(frame: .zero)
            #else
                photoARView = PhotoARView(frame: .zero, cameraMode: .nonAR, automaticallyConfigureSession: true)
            #endif
        }
        
        let cameraEntity = PerspectiveCamera()
        cameraEntity.camera.fieldOfViewInDegrees = 60
        cameraAnchor.addChild(cameraEntity)
        photoARView.scene.addAnchor(cameraAnchor)
        
        return photoARView
    }
      
    static var library: MTLLibrary! = nil
    static func getARLibrary() -> MTLLibrary {
        if library == nil {
            library = MTLCreateSystemDefaultDevice()!.makeDefaultLibrary()!
        }
        return library
    }
    
    static func onPagePropertiesOff(_ pageSettings: PageSettings,_ optionSettings: OptionSettings,_ appSettings: AppSettings) {

        
        if optionSettings.showingAR {
            //optionSettings.showingAR = false
            //photoARView.cameraMode = .nonAR
            return
        }
        
        
        print("Page Properties Off - Singleton")
        pageSettings.resetViewer()
        optionSettings.showPropertiesView=0
        optionSettings.showPagePropertiesView=0
        optionSettings.pagePropertiesHeight=95
        appSettings.zoomFactor = appSettings.zoomFactor * 1.0/0.999
        
        
    }
    
    
    static var cameraAnchor = AnchorEntity(world: [0.0, 0.0, 2.1])

    static func onLiveCamOn(showLive: Bool, optionSettings: OptionSettings) {
        if showLive {
            /*
            let cameraEntity = PerspectiveCamera()
            cameraEntity.camera.fieldOfViewInDegrees = 60
            //var camOrigin: SIMD3<Float> = [0.0, 0.0, 1.95]
            //let cameraAnchor = AnchorEntity(world: camOrigin)//AnchorEntity(world: .zero)
            cameraAnchor.addChild(cameraEntity)
            photoARView!.scene.addAnchor(cameraAnchor)
            */
            /*
            photoARView!.scene.removeAnchor(cameraAnchor)
            //var camOrigin: SIMD3<Float> = [0.0, 0.0, 2.45]
            var camOrigin: SIMD3<Float> = [0.0, 0.0, 2.1]
            cameraAnchor = AnchorEntity(world: camOrigin)
            photoARView!.scene.addAnchor(cameraAnchor)
             */
            
            optionSettings.showingAR = true
            Singleton.getPhotoARView().cameraMode = .ar
        }
        else {
            /*
            photoARView!.scene.removeAnchor(cameraAnchor)
            //var camOrigin: SIMD3<Float> = [0.0, 0.0, 1.95]
            var camOrigin: SIMD3<Float> = [0.0, 0.0, 2.1]
            cameraAnchor = AnchorEntity(world: camOrigin)
            photoARView!.scene.addAnchor(cameraAnchor)
            */
            
            optionSettings.showingAR = false
            Singleton.getPhotoARView().cameraMode = .nonAR
        }
    }
    
}
