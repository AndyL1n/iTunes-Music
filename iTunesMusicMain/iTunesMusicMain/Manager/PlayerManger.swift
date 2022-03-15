//
//  PlayerManger.swift
//  iTunesMusicMain
//
//  Created by Andy on 2022/3/15.
//

import Foundation
import AVFoundation
import MediaPlayer
import Kingfisher

public class PlayerManger {
    private struct Static {
        static var instance : PlayerManger!
    }
    
    public static var `default` : PlayerManger = {
        let queue = DispatchQueue(label: "once")
        queue.sync {
            Static.instance = PlayerManger()
        }
        return Static.instance
    }()
    
    private var player: AVPlayer?
    private var playerItem: AVPlayerItem?
    private var itunesItem: iTunesItem?
    
    public func play(with item: iTunesItem) {
        guard let playUrl = URL(string: item.previewUrl) else { return }
        self.itunesItem = item
        self.playerItem = AVPlayerItem(url: playUrl)
        self.player = AVPlayer(playerItem: self.playerItem)
        
        self.player?.volume = 1
        self.player?.play()
        setupNowPlaying()
        setupRemoteCommandCenter()
    }
    
    public func resume() {
        self.player?.play()
    }
    
    public func pause() {
        self.player?.pause()
    }
    
    public func stop() {
        self.player = nil
        self.playerItem = nil
        self.itunesItem = nil
    }
    
    func setupNowPlaying() {
        guard let playerItem = playerItem,
              let player = player,
              let itunesItem = itunesItem
        else { return }
        
        var playInfo = [String : Any]()
        playInfo[MPMediaItemPropertyTitle] = itunesItem.trackName
        playInfo[MPMediaItemPropertyArtist] = itunesItem.artistName
        playInfo[MPMediaItemPropertyPlaybackDuration] = playerItem.asset.duration.seconds
        playInfo[MPNowPlayingInfoPropertyElapsedPlaybackTime] = playerItem.currentTime().seconds
        playInfo[MPNowPlayingInfoPropertyPlaybackRate] = player.rate

        MPNowPlayingInfoCenter.default().nowPlayingInfo = playInfo
        MPNowPlayingInfoCenter.default().playbackState = .playing
    }

    func setupRemoteCommandCenter() {
        _ = MPRemoteCommandCenter.shared().then {
            $0.playCommand.isEnabled = true
            $0.pauseCommand.isEnabled = true
            $0.playCommand.addTarget { _ in
                self.player?.play()
                return .success
            }
            $0.pauseCommand.addTarget { _ in
                self.player?.pause()
                return .success
            }
        }
    }

}
