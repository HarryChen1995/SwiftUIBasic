//
//  VideoControlView.swift
//  PlayVideo
//
//  Created by Hanlin Chen on 10/21/20.
//

import SwiftUI
import AVKit
struct VideoControlView: View {
    @State var isPlaying = false
    @Binding var pos:Double
    let player: AVPlayer
    var body: some View {
        HStack{
        Button(action: {
            self.isPlaying.toggle()
            if self.isPlaying {
                self.player.play()
            }else {
                self.player.pause()
            }
        }, label: {
            Image(systemName: self.isPlaying ? "pause" : "play").foregroundColor(.white)
        }).padding(.trailing, 20)
            Slider(value: $pos, in: 0...1, step: 0.01, onEditingChanged: {_ in
                
                guard let item = self.player.currentItem else {
                    return
                }
                let targetTime = item.duration.seconds * self.pos
                self.player.seek(to: CMTime(seconds:targetTime , preferredTimescale: 600))
            
            }).accentColor(.white).padding(.horizontal, 10)
      }
    }
}
