//
//  SearchResultTableViewCellForArtist.swift
//  Spotify
//
//  Created by user212878 on 8/26/22.
//

import UIKit

class SearchResultTableViewCellForArtist: UITableViewCell {

    static let identifier = "SearchResultTableViewCellForArtist"
    private let label:UILabel = {
        let label = UILabel()
        label.numberOfLines = 1
        return label
    }()
    private let iconImageView:UIImageView = {
        let iconImage = UIImageView()
        iconImage.image = UIImage(systemName: "photo")
        iconImage.contentMode = .scaleAspectFit
        return iconImage
    }()
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        contentView.addSubview(label)
        contentView.addSubview(iconImageView)
        contentView.clipsToBounds = true
        accessoryType = .disclosureIndicator
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    override func layoutSubviews() {
        super.layoutSubviews()
        let height = contentView.height - 10
        iconImageView.frame = CGRect(x: 10, y: 5, width: height , height: height)
        iconImageView.layer.cornerRadius = height / 2
        iconImageView.layer.masksToBounds = true
        label.frame = CGRect(x: iconImageView.right + 10, y: 0, width: contentView.width - iconImageView.right - 15 , height: contentView.height)
    }
    override func prepareForReuse() {
        super.prepareForReuse()
        label.text = nil
        iconImageView.image = nil
    }
    func config(with viewModel:SearchResultTableViewCellForArtistVM){
        label.text = viewModel.title
        print("Image inside config  \(viewModel.imageURL)")
        iconImageView.loadFrom(URLAddress: viewModel.imageURL)
    }
}
