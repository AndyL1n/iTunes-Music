//
//  PlaybackView.swift
//  iTunesMusicMain
//
//  Created by Andy on 2022/3/15.
//

import UIKit
import Kingfisher

class PlaybackView: UIView {
    public static var new: PlaybackView {
        let view = Bundle.main.loadNibNamed("PlaybackView", owner: self, options: nil)?.first as! PlaybackView
        return view
    }

    @IBOutlet weak var container: UIView!
    @IBOutlet weak var playButton: UIButton!
    @IBOutlet weak var closeButton: UIButton!
    
    @IBOutlet weak var artworkIcon: UIImageView!
    @IBOutlet weak var trackNameLabel: MarqueeLabel!
    @IBOutlet weak var artistNameLabel: MarqueeLabel!
    
    public var onClosePlayer: (() -> Void)?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        setupUI()
    }
    
    private func setupUI() {
        playButton.setImage(UIImage(named: "icon_pause"), for: .normal)
        playButton.addTarget(self, action: #selector(pressPlaying(_:)), for: .touchUpInside)
        closeButton.addTarget(self, action: #selector(stopPlaying), for: .touchUpInside)
        heightAnchor.constraint(equalToConstant: 60).isActive = true
        container.makeRadiusForEachCorner(radius: 8, corners: [.layerMaxXMinYCorner, .layerMinXMinYCorner])
        addShadow(color: .lightGray)
        trackNameLabel.font = .medium(size: 16)
        artistNameLabel.font = .regular(size: 14)
    }
    
    public func addPlayer(with item: iTunesItem) {
        trackNameLabel.text = "\(item.trackName)     "
        artistNameLabel.text = "\(item.artistName) - \(item.collectionName)     "
        if let artworkUrl = URL(string: item.artworkUrl100) {
            artworkIcon.kf.setImage(with: artworkUrl)
        }
        PlayerManger.default.play(with: item)
    }
    
    @objc func pressPlaying(_ sender: UIButton) {
        let isSelected = sender.isSelected
        sender.isSelected = !isSelected
        
        playButton.setImage(UIImage(named: isSelected ? "icon_pause" : "icon_play"), for: .normal)
        if isSelected {
            PlayerManger.default.resume()
        } else {
            PlayerManger.default.pause()
        }
    }
    
    @objc func stopPlaying() {
        PlayerManger.default.stop()
        onClosePlayer?()
    }
}
