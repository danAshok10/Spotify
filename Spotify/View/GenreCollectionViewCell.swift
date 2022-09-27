//
//  GenreCollectionViewCell.swift
//  Spotify
//
//  Created by user212878 on 8/12/22.
//

import UIKit

class GenreCollectionViewCell: UICollectionViewCell {
    
    static let identifier = "GenreCollectionViewCell"
    
    let imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        imageView.tintColor = .white
        imageView.image = UIImage(systemName: "music.quarternote.3", withConfiguration: UIImage.SymbolConfiguration(pointSize: 50, weight: .semibold))
        return imageView
    }()
    
    
    let label: UILabel = {
        let label = UILabel()
        label.textColor = .white
        label.font = .systemFont(ofSize: 22, weight: .semibold)
        return label
    }()
    
    let colors: [UIColor] = [
        .systemRed,
        .systemBlue,
        .systemPink,
        .systemTeal,
        .systemGray,
        .systemGreen,
        .systemYellow,
        .systemIndigo,
        .systemPurple
    ]
    override init(frame: CGRect) {
        super.init(frame: frame)
       // backgroundColor = .systemGreen
        contentView.layer.cornerRadius = 8
        contentView.layer.masksToBounds = true
        contentView.addSubview(imageView)
        contentView.addSubview(label)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        label.text = nil
    }
    override func layoutSubviews() {
        super.layoutSubviews()
        label.frame = CGRect(x: 10, y: contentView.height/2, width: contentView.width - 20, height: contentView.height/2)
        imageView.frame = CGRect(x: contentView.width/2, y: 10, width: contentView.width/2.5, height: contentView.width/2.5)
    }
    func config(with viewModel: BrowseCategoriesVM){
        label.text = viewModel.name
        imageView.loadFrom(URLAddress: viewModel.imageURL)
        contentView.backgroundColor = colors.randomElement()
    }
}
