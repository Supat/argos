//
//  PlayerView.swift
//  Argos
//
//  Created by Supat Saetia on 15/7/20.
//  Copyright © 2020 Supat Saetia. All rights reserved.
//

import UIKit
import AVFoundation
import AVKit

class PlayerView: UIView {
    
    private let playerLayer = AVPlayerLayer();
    private var previewTimer:Timer?
    var previewLength:Double
    var playerLooper: AVPlayerLooper!;
    var queuePlayer: AVQueuePlayer!;
    
    init(frame: CGRect, url: URL, previewLength:Double) {
        self.previewLength = previewLength;
        super.init(frame: frame);
        
        /*
        let player = AVPlayer(url: url);
        player.volume = 0;
        player.play();
         */
        
        let options = [AVURLAssetAllowsCellularAccessKey: false];
        let asset = AVURLAsset(url: url, options: options);
        let playerItem = AVPlayerItem(asset: asset);
        
        queuePlayer = AVQueuePlayer(playerItem: playerItem);
        playerLooper = AVPlayerLooper(player: queuePlayer, templateItem: playerItem);
        queuePlayer.volume = 0;
        queuePlayer.play();
        
        playerLayer.player = queuePlayer;
        playerLayer.videoGravity = .resizeAspectFill;
        playerLayer.backgroundColor = UIColor.black.cgColor;
        
        /*
        previewTimer = Timer.scheduledTimer(withTimeInterval: previewLength, repeats: true, block: { (timer) in
            player.seek(to: CMTime(seconds: 0, preferredTimescale: CMTimeScale(1)));
        })
         */
        
        layer.addSublayer(playerLayer);
    }
    
    required init?(coder: NSCoder) {
        self.previewLength = 15;
        super.init(coder: coder);
    }
    
    override func layoutSubviews() {
        super.layoutSubviews();
        playerLayer.frame = bounds;
    }
    
}
