//
//  ViewController.swift
//  VideoTimelineView
//
//  Created by Tomohiro Yamashita on 2020/03/27.
//  Copyright © 2020 Tom. All rights reserved.
//

import UIKit
import AVFoundation

class ViewController: UIViewController, TimelinePlayStatusReceiver {

    var node: FilterX
    var avPlayer: AVPlayer
    var videoTimelineView:VideoTimelineView!
    let playerView = UIView()
    var playerLayer:AVPlayerLayer!
    let playButton = UIButton()

    /*
    init(avPlayer: AVPlayer) {
        self.avPlayer=avPlayer
        super.init(nibName: nil, bundle: nil)
    }
     */
    init(node: FilterX,avPlayer: AVPlayer) {
        self.node=node
        self.avPlayer=avPlayer
        super.init(nibName: nil, bundle: nil)
     
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
  
    func updateTimeLine() {
        if node.type=="CICutVideo" {
            videoTimelineView.hideTrimmer=false
       
            videoTimelineView.new(asset:AVURLAsset(url: node.assetURL2))

        } else {
            videoTimelineView.new(asset:AVURLAsset(url: node.assetURL1))

        }
    }
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        
        
        ///Prepare videoTimelineView
        //let asset = AVAsset(url: URL(fileURLWithPath: Bundle.main.path(forResource: "boowiek", ofType:"MOV")!))
        
        videoTimelineView = VideoTimelineView()
        //booboo
        videoTimelineView.player=avPlayer
        //videoTimelineView.audioPlayer=avPlayer
        //videoTimelineView.audioPlayer2=avPlayer
        videoTimelineView.frame = layout().timeline
        //videoTimelineView.new(asset:avPlayer.currentItem?.asset)
        
        if node.type=="CICutVideo" {
            videoTimelineView.hideTrimmer=false
            
            videoTimelineView.new(asset:AVURLAsset(url: node.assetURL2))
            videoTimelineView.setTrim(start:Float64(node.startTime), end:Float64(node.endTime), seek:nil, animate:false)

        } else {
            videoTimelineView.new(asset:AVURLAsset(url: node.assetURL1))

        }
          
        videoTimelineView.playStatusReceiver = self
        
        videoTimelineView.repeatOn = true
        videoTimelineView.setTrimIsEnabled(true)
        videoTimelineView.setTrimmerIsHidden(false)
        view.addSubview(videoTimelineView)
        
        videoTimelineView.moveTo(0, animate:false)
        //videoTimelineView.setTrim(start:0, end:5, seek:nil, animate:false)
        
        
        ///Prepare playerView
        //booboo
        /*
        let player = videoTimelineView.player!//You can also set another player like below
        //let player = AVPlayer(playerItem: AVPlayerItem(asset: asset))
        //videoTimelineView.player = player
        
        let playerFrame = layout().player
        playerLayer = AVPlayerLayer(player: player)
        playerLayer.frame.size = playerFrame.size
        playerLayer.videoGravity = AVLayerVideoGravity.resizeAspect
        player.actionAtItemEnd   = AVPlayer.ActionAtItemEnd.none
        
        playerView.frame = playerFrame
        playerView.layer.addSublayer(playerLayer)
        view.addSubview(playerView)
        */
        
        
        
        ///Prepare playButton
        /////ANCHISES
        /*
        playButton.frame = layout().button
        playButton.addTarget(self,action:#selector(self.playButtonAction), for:.touchUpInside)
        setPlayButtonImage()
        view.addSubview(playButton)
        */
    }
    
    override func viewDidLayoutSubviews() {
        videoTimelineView.frame = layout().timeline
        //booboo
        //playerView.frame = layout().player
       // playerLayer.frame.size = playerView.frame.size
        //playButton.frame = layout().button
        videoTimelineView.viewDidLayoutSubviews()
    }

    func layout() -> (timeline:CGRect, player:CGRect, button:CGRect) {
        //let timeline = CGRect(x: 0,y:40, width:view.frame.size.width, height:view.frame.size.height / 6)
        //var timeline = CGRect(x: 0,y:40, width:view.frame.size.width, height:view.frame.size.height)
        let timeline = CGRect(x: 0,y:0, width:view.frame.size.width, height:view.frame.size.height)
        //let screenRect = self.view.window?.frame.size
        //if screenRect != nil {
            //print(screenRect)
            //timeline = CGRect(x: 0,y:40, width:screenRect!.width, height:180)
        //}
        
        let player = CGRect(x:0, y:40, width:view.frame.size.width, height:view.frame.size.height * 0.4)
        let button = CGRect(x:(view.frame.size.width - 60) / 2, y:view.frame.size.height - 60, width:60, height:60)

        /*
        let timeline = CGRect(x: 0,y:view.frame.size.height * 0.6, width:view.frame.size.width, height:view.frame.size.height / 6)
        let player = CGRect(x:0, y:40, width:view.frame.size.width, height:view.frame.size.height * 0.4)
        let button = CGRect(x:(view.frame.size.width - 60) / 2, y:view.frame.size.height - 60, width:60, height:60)
         */
        return (timeline, player, button)
    }
    
    var playButtonStatus:Bool = false
    @objc func playButtonAction() {
        playButtonStatus = !playButtonStatus
        if playButtonStatus {
            videoTimelineView.play()
        } else {
            videoTimelineView.stop()
        }
        setPlayButtonImage()
    }
    
    func setPlayButtonImage() {
        if playButtonStatus {
            self.playButton.setImage(UIImage(systemName: "pause.fill", withConfiguration: UIImage.SymbolConfiguration(pointSize: 20, weight: .light, scale: .medium)), for: .normal)
        } else {
            self.playButton.setImage(UIImage(systemName: "play.fill", withConfiguration: UIImage.SymbolConfiguration(pointSize: 20, weight: .light, scale: .medium)), for: .normal)
        }
    }
    
    func videoTimelineStopped() {
        playButtonStatus = false
        setPlayButtonImage()
    }
    
    func videoTimelineMoved() {
        let time = videoTimelineView.currentTime
        print("time: \(time)")
    }
    
    func videoTimelineTrimChanged() {
        let trim = videoTimelineView.currentTrim()
        print("start time: \(trim.start)")
        print("end time: \(trim.end)")
        node.startTime=Float(trim.start)
        node.endTime=Float(trim.end)
        let xval=Int64(trim.end-trim.start)*Int64(node.timeScale)
        node.duration=CMTimeMake(value: xval, timescale: node.timeScale)
        node.videoStatus="Completed Trim"
        node.parent?.clearVideoStatus(x: node.nodeIndex+1)

    }

    
}

