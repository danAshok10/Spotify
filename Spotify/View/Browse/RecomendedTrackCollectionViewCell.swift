//
//  RecomendedTrackCollectionViewCell.swift
//  Spotify
//
//  Created by user212878 on 7/20/22.
//

import UIKit

  

class RecomendedTrackCollectionViewCell: UICollectionViewCell {
    static let identifier = "RecomendedTrackCollectionViewCell"
    let albumNameLabel : UILabel = {
        let albumNameLabel = UILabel()
        albumNameLabel.font = .systemFont(ofSize: 22, weight: .semibold)
        albumNameLabel.numberOfLines = 0
        return albumNameLabel
    }()
    
    let artistName: UILabel = {
        let artistName = UILabel()
        artistName.font = .systemFont(ofSize: 12, weight: .medium)
        artistName.numberOfLines = 0
        return artistName
    }()
    
    let albumImage: UIImageView = {
        let albumImage = UIImageView()
        albumImage.contentMode = .scaleAspectFit
        albumImage.image = UIImage(named: "photo")
        return albumImage
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
        contentView.addSubview(albumImage)
        contentView.addSubview(totalTracks)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    override func layoutSubviews() {
        super.layoutSubviews()
        artistName.sizeToFit()
        albumNameLabel.sizeToFit()
        albumImage.sizeToFit()
        totalTracks.sizeToFit()
        configUI()
    }
    override func prepareForReuse() {
        super.prepareForReuse()
        albumNameLabel.text = nil
        artistName.text = nil
        albumImage.image = nil
        totalTracks.text = nil
    }
    func config(with viewModel: RecomendationCellVM) {
        albumNameLabel.text = viewModel.albumName
        artistName.text = viewModel.artistName
        albumImage.loadFrom(URLAddress: viewModel.albumImage)
        totalTracks.text = "Tracks: \(viewModel.totalTracks)"
    }
    func configUI(){
        let imageHeight = contentView.height
        let imageWidth = contentView.width
        
        albumImage.frame = CGRect(
            x: 0,
            y: 0,
            width: imageHeight,
            height: imageHeight)
        
        albumNameLabel.frame = CGRect(
            x: albumImage.right + 10,
            y: contentView.top + 15,
            width: contentView.width - albumImage.right - 10,
            height: 15)
        
        artistName.frame = CGRect(
            x: albumImage.right + 10,
            y: albumNameLabel.bottom + 15,
            width: contentView.width - albumImage.right - 10,
            height: 15)
        
        totalTracks.frame = CGRect(
            x: albumImage.right + 10,
            y: artistName.bottom + 15,
            width: contentView.width - albumImage.right - 10,
            height: 15)
    }
}
