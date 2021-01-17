//
//  ContentView.swift
//  PlayVideo
//
//  Created by Hanlin Chen on 10/21/20.
//

import SwiftUI
import AVKit
struct ContentView: View {

    var body: some View {
        VideoPlayerContainerView()
        
    }
}


struct VideoPlayerContainerView:View{
    var player:AVPlayer = AVPlayer(url: URL(string: "http://localhost:4000/ocean.mp4")!)
    @State var isPlaying = false
    @State var pos: Double = 0.0
    @State var duration: Double = 0.0

    
    func formatter(duration:Double)->String{
        let seconds = Int(duration) % 60
        let minutesText = String(format: "%02d", Int(seconds) / 60 )
        let secondsText =  seconds < 10 ?  "0" + "\(seconds)" : "\(seconds)"
        return  minutesText + ":" +  secondsText
    }
    var body: some View {
        ZStack(alignment:.bottom){
            VideoPlayerView(player: player, pos:$pos, duration: $duration).frame(height:300).background(Color.black)
            HStack{
                if pos != 1 {
            Button(action: {
                self.isPlaying.toggle()
                if self.isPlaying {
                    self.player.play()
                }else {
                    self.player.pause()
                }
            }, label: {
                Image(systemName: self.isPlaying ? "pause" : "play").resizable().frame(width: 20, height: 20).foregroundColor(.white)
            }).padding(.trailing, 10)
            
            }
            else {
                Button(action: {
                    self.isPlaying = true
                    self.player.seek(to: .zero)
                    self.player.play()
                }, label: {
                    Image(systemName: "gobackward").resizable().frame(width: 20, height: 20).foregroundColor(.white)
                }).padding(.trailing, 20)
                
                }
        
            Text(formatter(duration: duration * pos)).foregroundColor(.white)
                Slider(value: $pos, in: 0...1, step: 0.01, onEditingChanged: {_ in
                    
                    guard let item = self.player.currentItem else {
                        return
                    }
                    let targetTime = item.duration.seconds * self.pos
                    self.player.seek(to: CMTime(seconds:targetTime , preferredTimescale: 600))
                
                }).accentColor(.white).padding(.horizontal, 10)
            
                Text(formatter(duration: duration)).foregroundColor(.white)
            
            }.padding()
        }
        
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
       ContentView()
    }
}
