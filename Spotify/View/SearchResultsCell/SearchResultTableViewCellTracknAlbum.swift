//
//  SearchResultTableViewCellTracknAlbum.swift
//  Spotify
//
//  Created by user212878 on 8/30/22.
//

import UIKit

struct SearchResultTableViewCellForTracknAlbumVM {
    let title: String
    let subTitle: String
    let image: String
}
class SearchResultTableViewCellTracknAlbum: UITableViewCell {

    static let identifier = "SearchResultTableViewCellTracknAlbum"
    private let label:UILabel = {
        let label = UILabel()
        label.numberOfLines = 1
        return label
    }()
    private let subTitle:UILabel = {
        let label = UILabel()
        label.numberOfLines = 1
        label.textColor = .secondaryLabel
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
        contentView.addSubview(subTitle)
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
        label.frame = CGRect(x: iconImageView.right + 10, y: 0, width: contentView.width - iconImageView.right - 15 , height: contentView.height/2)
        subTitle.frame = CGRect(x: iconImageView.right + 10, y: label.bottom + 3, width: contentView.width - iconImageView.right - 15, height: contentView.height/2 - 3)
    }
    override func prepareForReuse() {
        super.prepareForReuse()
        label.text = nil
        iconImageView.image = nil
        subTitle.text = nil
    }
    func config(with viewModel: SearchResultTableViewCellForTracknAlbumVM){
        label.text = viewModel.title
        subTitle.text = viewModel.subTitle
        print("Image inside config  \(viewModel.image)")
        iconImageView.loadFrom(URLAddress: viewModel.image)
    }
}

