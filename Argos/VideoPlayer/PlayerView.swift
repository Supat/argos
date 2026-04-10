//
//  PlayerView.swift
//  Argos
//
//  Created by Supat Saetia on 15/7/20.
//  Copyright © 2020 Supat Saetia. All rights reserved.
//

import AVFoundation
import AVKit
import UIKit

/// `UIView` subclass that wraps an auto-looping, muted `AVQueuePlayer`.
/// It plays the supplied URL on repeat with `AVPlayerLooper` so the
/// SwiftUI demonstration panel can show a continuous clip.
final class PlayerView: UIView {

    private let playerLayer = AVPlayerLayer()
    private var queuePlayer: AVQueuePlayer?
    private var playerLooper: AVPlayerLooper?

    let previewLength: Double

    init(frame: CGRect, url: URL, previewLength: Double) {
        self.previewLength = previewLength
        super.init(frame: frame)
        configurePlayer(with: url)
    }

    required init?(coder: NSCoder) {
        self.previewLength = 15
        super.init(coder: coder)
    }

    override func layoutSubviews() {
        super.layoutSubviews()
        playerLayer.frame = bounds
    }

    private func configurePlayer(with url: URL) {
        let asset = AVURLAsset(url: url, options: [AVURLAssetAllowsCellularAccessKey: false])
        let item = AVPlayerItem(asset: asset)

        let player = AVQueuePlayer(playerItem: item)
        player.volume = 0
        playerLooper = AVPlayerLooper(player: player, templateItem: item)
        player.play()

        playerLayer.player = player
        playerLayer.videoGravity = .resizeAspectFill
        playerLayer.backgroundColor = UIColor.black.cgColor

        layer.addSublayer(playerLayer)
        queuePlayer = player
    }
}
