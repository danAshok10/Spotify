//
//  NewReleaseCollectionViewCell.swift
//  Spotify
//
//  Created by user212878 on 7/20/22.
//

import UIKit

class NewReleaseCollectionViewCell: UICollectionViewCell {
    static let identifier = "NewReleaseCollectionViewCell"
    private let albumCoverimageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(systemName: "photo")
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()
    private let albumNameLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.font = .systemFont(ofSize: 22, weight: .semibold)
        return label
    }()
    private let numberOfTracksLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.font = .systemFont(ofSize: 12, weight: .regular)
        return label
    }()
    private let artistNameLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.font = .systemFont(ofSize: 15, weight: .regular)
        return label
    }()
    override init(frame: CGRect) {
        super.init(frame: frame)
        contentView.backgroundColor = .secondarySystemBackground
        contentView.addSubview(albumCoverimageView)
        contentView.addSubview(albumNameLabel)
        contentView.addSubview(numberOfTracksLabel)
        contentView.addSubview(artistNameLabel)
        
    }
    required init?(coder: NSCoder) {
        fatalError()
    }
    override func layoutSubviews() {
        super.layoutSubviews()
        albumNameLabel.sizeToFit()
        numberOfTracksLabel.sizeToFit()
        artistNameLabel.sizeToFit()
        let imageSize: CGFloat  = contentView.height
        albumCoverimageView.frame = CGRect(
            x: 5,
            y: 5,
            width: imageSize - 10,
            height: imageSize - 10)
        
        albumNameLabel.frame = CGRect(
            x: albumCoverimageView.right + 10,
            y: albumCoverimageView.top + 15,
            width: contentView.width - 10 - imageSize,
            height: 15)
        
        artistNameLabel.frame = CGRect(
            x: albumCoverimageView.right + 10,
            y: albumCoverimageView.top + 40,
            width: contentView.width - 10 - imageSize,
            height: 15)
        
        numberOfTracksLabel.frame = CGRect(
            x: albumCoverimageView.right + 10,
            y: albumCoverimageView.bottom - 35,
            width: contentView.width - 10 - imageSize,
            height: 10)
    }
    override func prepareForReuse() {
        super.prepareForReuse()
        albumNameLabel.text = nil
        numberOfTracksLabel.text = nil
        artistNameLabel.text = nil
        albumCoverimageView.image = nil
    }
    func configure(with ViewModel:NewReleasesCellVM){
        albumNameLabel.text = ViewModel.name
        numberOfTracksLabel.text = "Tracks : \(ViewModel.numberOfTracks)"
        artistNameLabel.text = ViewModel.artistName
        albumCoverimageView.loadFrom(URLAddress:ViewModel.imageURL.absoluteString)
    }
}


