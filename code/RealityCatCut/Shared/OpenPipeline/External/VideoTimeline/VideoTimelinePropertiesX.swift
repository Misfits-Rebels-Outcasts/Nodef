

import Foundation
import SwiftUI
import AVKit

struct VideoTimelinePropertiesX: UIViewControllerRepresentable {
    
    //@EnvironmentObject var pageSettings: PageSettings
    @ObservedObject var node: FilterX
    var avPlayer: AVPlayer
    
    //var player: ViewController
    
    func makeUIViewController(context: Context) -> ViewController {
        //let view = ViewController(avPlayer: pageSettings.avPlayer!)
       
        let view = ViewController(node: node, avPlayer: avPlayer)
        
        return view
    }
    
    func updateUIViewController(_ uiViewController: ViewController, context: Context) {
        print("VideoTimelinePropertiesX updateUIViewController")
        
   
        if node is CutVideoFX {
            let cvfx = node as! CutVideoFX
            if cvfx.updateTimeline {
                uiViewController.updateTimeLine()
                cvfx.updateTimeline=false
            }
        }
        
        if node is ReadVideoFX {
            let rvfx = node as! ReadVideoFX
            if rvfx.updateTimeline {
                uiViewController.updateTimeLine()
                rvfx.updateTimeline=false
            }
        }
    
    }
}
