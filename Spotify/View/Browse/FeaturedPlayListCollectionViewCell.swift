//
//  FeaturedPlayListCollectionViewCell.swift
//  Spotify
//
//  Created by user212878 on 7/20/22.
//
//let name: String
//let ownerName: String
//let numberOfTracks: Int
//let image: String

import UIKit

class FeaturedPlayListCollectionViewCell: UICollectionViewCell {
    static let identifier = "FeaturedPlayListCollectionViewCell"
    let playListName: UILabel = {
        let playListName = UILabel()
        playListName.numberOfLines = 0
        playListName.font = .systemFont(ofSize: 12, weight: .medium)
        return playListName
    }()
    let artistName: UILabel = {
        let artistName = UILabel()
        artistName.numberOfLines = 0
        artistName.font = .systemFont(ofSize: 20, weight: .semibold)
        return artistName
    }()
    let noOfTracksLabel: UILabel = {
        let noOfTracks = UILabel()
        noOfTracks.numberOfLines = 0
        noOfTracks.font = .systemFont(ofSize: 12, weight: .regular)
        return noOfTracks
    }()
    let playListImageView: UIImageView = {
        let playListImageView = UIImageView()
        playListImageView.image = UIImage(named: "photo")
        playListImageView.contentMode = .scaleAspectFit
        return playListImageView
    }()
    override init(frame: CGRect) {
        super.init(frame: frame)
        contentView.backgroundColor = .systemBackground
        contentView.addSubview(artistName)
        contentView.addSubview(noOfTracksLabel)
        contentView.addSubview(playListName)
        contentView.addSubview(playListImageView)
        //contentView.backgroundColor = .red
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    override func layoutSubviews() {
        super.layoutSubviews()
        artistName.sizeToFit()
        noOfTracksLabel.sizeToFit()
        playListName.sizeToFit()
        playListImageView.sizeToFit()
        configUI()
    }
    override func prepareForReuse() {
        super.prepareForReuse()
        artistName.text = nil
        playListName.text = nil
        noOfTracksLabel.text = nil
        playListImageView.image = nil
    }
    func configUI(){
        let imageHeight = contentView.height
        let imageWidth = contentView.width
        playListImageView.frame = CGRect(
            x: -40,
            y: 0,
            width: imageWidth,
            height: imageHeight - 80)
        artistName.frame = CGRect(
            x: 0,
            y: playListImageView.bottom + 5,
            width: contentView.width,
            height: 20)
        playListName.frame = CGRect(
            x: 0,
            y: artistName.bottom + 5,
            width: contentView.width,
            height: 20)
        noOfTracksLabel.frame = CGRect(
            x: 0,
            y: playListName.bottom + 5,
            width: contentView.width,
            height: 20)
    }
    func config(with viewModel: FeaturedPlayListCellVM){
        artistName.text = viewModel.ownerName
        playListName.text = viewModel.name
        noOfTracksLabel.text = "Tracks: \(viewModel.numberOfTracks)"
        playListImageView.loadFrom(URLAddress: viewModel.image)
    }
}
