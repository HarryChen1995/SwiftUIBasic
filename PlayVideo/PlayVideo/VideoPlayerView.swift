//
//  VideoPlayerView.swift
//  PlayVideo
//
//  Created by Hanlin Chen on 10/21/20.
//

import SwiftUI
import AVKit

class UIVideoPlayerView: UIView {
    let activityIndicator : UIActivityIndicatorView = {
       let avi = UIActivityIndicatorView()
        avi.style = UIActivityIndicatorView.Style.large
        avi.color = .white
        avi.translatesAutoresizingMaskIntoConstraints = false
        avi.startAnimating()
    return avi
    }()
    
    private let  playerLayer = AVPlayerLayer()
    var player:AVPlayer
    @Binding var pos:Double
    @Binding var duration: Double
    
    init(player:AVPlayer, pos: Binding<Double>, duration: Binding<Double>){
        self._pos = pos
        self._duration = duration
        self.player = player
        super.init(frame: .zero)
        addSubview(activityIndicator)
        activityIndicator.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
        activityIndicator.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
        activityIndicator.widthAnchor.constraint(equalToConstant: 50).isActive = true
        activityIndicator.heightAnchor.constraint(equalToConstant: 50).isActive = true
        playerLayer.player = self.player
        player.addPeriodicTimeObserver(forInterval: CMTime(seconds: 0.5, preferredTimescale: 600), queue: nil, using: {
            time in
            guard let item = self.player.currentItem else {
                return
            }
            self.pos = time.seconds / item.duration.seconds
            
        })
        player.addObserver(self, forKeyPath: "currentItem.loadedTimeRanges", options: .new, context: nil)
        
        
        player.addObserver(self, forKeyPath: "timeControlStatus", options: [.old, .new], context: nil)
        
        layer.addSublayer(playerLayer)
    }
    
    override func observeValue(forKeyPath keyPath: String?, of object: Any?, change: [NSKeyValueChangeKey : Any]?, context: UnsafeMutableRawPointer?) {
        if keyPath == "currentItem.loadedTimeRanges" {
            if let duration = self.player.currentItem?.duration.seconds {
                self.duration = duration
            }
        }
        
        if keyPath == "timeControlStatus", let change = change, let newValue = change[NSKeyValueChangeKey.newKey] as? Int, let oldValue = change[NSKeyValueChangeKey.oldKey] as? Int {
            let oldStatus = AVPlayer.TimeControlStatus(rawValue: oldValue)
            let newStatus = AVPlayer.TimeControlStatus(rawValue: newValue)
            
            if newStatus != oldStatus {
                DispatchQueue.main.async {
                    if newStatus == .playing || newStatus == .paused {
                        self.activityIndicator.stopAnimating()
                    }else{
                        self.activityIndicator.startAnimating()
                    }
                }
            }
        
     }
    }
    
    required init?(coder: NSCoder) {
        fatalError("bad")
    }
    override func layoutSubviews() {
        super.layoutSubviews()
        playerLayer.frame = bounds
    }
}

struct VideoPlayerView: UIViewRepresentable {
    var player: AVPlayer
    @Binding var pos :Double
    @Binding var duration: Double
    func makeUIView(context: Context) -> UIVideoPlayerView {
        return UIVideoPlayerView(player: player, pos: $pos, duration: $duration)
    }
     func updateUIView(_ uiView: UIVideoPlayerView, context: Context) {
        
    }
}
