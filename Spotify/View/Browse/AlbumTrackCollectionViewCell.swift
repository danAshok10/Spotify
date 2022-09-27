//
//  AlbumTrackCollectionViewCell.swift
//  Spotify
//
//  Created by user212878 on 8/2/22.
//

import UIKit

class AlbumTrackCollectionViewCell: UICollectionViewCell {
    
    static let identifier = "AlbumTrackCollectionViewCell"
    let albumNameLabel : UILabel = {
        let albumNameLabel = UILabel()
        albumNameLabel.font = .systemFont(ofSize: 20, weight: .semibold)
        albumNameLabel.numberOfLines = 0
        return albumNameLabel
    }()
    
    let artistName: UILabel = {
        let artistName = UILabel()
        artistName.font = .systemFont(ofSize: 12, weight: .medium)
        artistName.numberOfLines = 0
        return artistName
    }()
    
    
    
    let totalTracks: UILabel = {
        let totalTracks = UILabel()
        totalTracks.numberOfLines = 0
        totalTracks.font = .systemFont(ofSize: 12, weight: .regular)
        return totalTracks
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        contentView.addSubview(albumNameLabel)
        contentView.addSubview(artistName)
        contentView.addSubview(totalTracks)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    override func layoutSubviews() {
        super.layoutSubviews()
        artistName.sizeToFit()
        albumNameLabel.sizeToFit()
        totalTracks.sizeToFit()
        configUI()
    }
    override func prepareForReuse() {
        super.prepareForReuse()
        albumNameLabel.text = nil
        artistName.text = nil
        totalTracks.text = nil
    }
    func config(with viewModel: RecomendationCellVM) {
        albumNameLabel.text = viewModel.albumName
        artistName.text = viewModel.artistName
        totalTracks.text = "Tracks: \(viewModel.totalTracks)"
    }
    func configUI(){
        let imageHeight = contentView.height
        let imageWidth = contentView.width
        
      
        
        albumNameLabel.frame = CGRect(
            x: 10,
            y: contentView.top + 15,
            width: contentView.width - 10,
            height: 19)
        
        artistName.frame = CGRect(
            x: 10,
            y: albumNameLabel.bottom + 15,
            width: contentView.width - 10,
            height: 15)
        
        totalTracks.frame = CGRect(
            x: 10,
            y: artistName.bottom + 15,
            width: contentView.width - 10,
            height: 15)
    }

}
