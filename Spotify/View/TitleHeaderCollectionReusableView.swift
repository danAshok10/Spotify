//
//  TitleHeaderCollectionReusableView.swift
//  Spotify
//
//  Created by user212878 on 8/1/22.
//

import UIKit

class TitleHeaderCollectionReusableView: UICollectionReusableView {
    
    static let identifier = "TitleHeaderCollectionReusableView"
    
    private let titleLabel:UILabel = {
        let titleLable = UILabel()
        titleLable.numberOfLines = 0
        titleLable.backgroundColor = .systemBackground
        titleLable.font = .systemFont(ofSize: 35, weight: .bold)
        return titleLable
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .systemBackground
        addSubview(titleLabel)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        titleLabel.frame = CGRect(x: 5, y: 0, width: width, height: height)
    }
    
    func config(with titleHeader: String){
        titleLabel.text = titleHeader
    }
}

