//
//  iTunesItemCell.swift
//  iTunesMusicMain
//
//  Created by Andy on 2022/3/15.
//

import UIKit
import Kingfisher

class iTunesItemCell: UICollectionViewCell {
    static let id = "iTunesItemCellID"
    static let height: CGFloat = 80
    
    @IBOutlet weak var icon: UIImageView!
    @IBOutlet weak var artistLabel: UILabel!
    @IBOutlet weak var collectionNameLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        collectionNameLabel.font = .regular(size: 20)
        artistLabel.font = .medium(size: 16)
        icon.makeRadius(radius: 8)
    }

    public func config(with item: iTunesItem) {
        artistLabel.text = "\(item.artistName) - \(item.collectionName)"
        collectionNameLabel.text = item.trackName
        guard let url = URL(string: item.artworkUrl100) else { return }
        icon.kf.setImage(with: url)
    }
}
