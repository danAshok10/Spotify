//
//  PlayListHeaderCollectionReusableView.swift
//  Spotify
//
//  Created by user212878 on 7/30/22.
//

import UIKit

protocol PlayListHeaderCollectionReusableViewDelegate {
    func PlayListHeaderCollectionReusableViewDidTapPlatAll(_ header: PlayListHeaderCollectionReusableView)
}
class PlayListHeaderCollectionReusableView: UICollectionReusableView {
    static let identifier = "PlayListHeaderCollectionReusableView"
    
    var delegate: PlayListHeaderCollectionReusableViewDelegate?
    
    private let nameLabel : UILabel = {
        let nameLabel = UILabel()
        nameLabel.numberOfLines = 0
        nameLabel.font = .systemFont(ofSize: 22, weight: .semibold)
        return nameLabel
    }()
    private let descriptionLabel : UILabel = {
        let descriptionLabel = UILabel()
        descriptionLabel.numberOfLines = 0
        descriptionLabel.textColor = .secondaryLabel
        descriptionLabel.font = .systemFont(ofSize: 13, weight: .semibold)
        return descriptionLabel
    }()
    private let ownerLabel : UILabel = {
        let ownerLabel = UILabel()
        ownerLabel.textColor = .secondaryLabel
        ownerLabel.numberOfLines = 0
        ownerLabel.font = .systemFont(ofSize: 15, weight: .semibold)
        return ownerLabel
    }()
    private let image: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.image = UIImage(systemName: "photo")
        return imageView
    }()
    private let playAllButton: UIButton = {
        let button = UIButton()
        button.backgroundColor = .green
        let image = UIImage(systemName: "play.fill", withConfiguration: UIImage.SymbolConfiguration(pointSize: 30, weight: .regular))
        button.setImage(image, for: .normal)
        button.layer.cornerRadius = 30
        button.layer.masksToBounds = true
        return button
    }()
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .systemBackground
        addSubview(nameLabel)
        addSubview(descriptionLabel)
        addSubview(ownerLabel)
        addSubview(image)
        addSubview(playAllButton)
        playAllButton.addTarget(self, action: #selector(didTapPlayAllBtn), for: .touchUpInside)
    }
     
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        let imageSize = height / 1.5
        image.frame = CGRect(
            x: (width - imageSize)/2,
            y: 20,
            width: imageSize,
            height: imageSize)
        
        nameLabel.frame = CGRect(
            x: 10,
            y: image.bottom,
            width: width,
            height: 44)
        
        ownerLabel.frame = CGRect(
            x: 10,
            y: nameLabel.bottom,
            width: width - 100,
            height: 35)
        
        descriptionLabel.frame = CGRect(
            x: 10,
            y: ownerLabel.bottom,
            width: width - 100,
            height: 40)
        
        playAllButton.frame = CGRect(
            x: width - 100,
            y: height - 70,
            width: 60,
            height: 60)
        
    }
    @objc func didTapPlayAllBtn(){
        delegate?.PlayListHeaderCollectionReusableViewDidTapPlatAll(self)
    }
    func config(with ViewModel: PlayListHeaderViewVM){
        nameLabel.text = ViewModel.name
        ownerLabel.text = ViewModel.ownerName
        descriptionLabel.text = ViewModel.description
        guard let artworkURL = ViewModel.artworkURL else {
        return
        }
        image.loadFrom(URLAddress: artworkURL)
    }
}
