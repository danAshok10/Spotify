//
//  ActionLabelView.swift
//  Spotify
//
//  Created by user212878 on 9/25/22.
//

import UIKit
struct ActionLabelViewModel {
    let text: String
    let actionTitle: String
}

protocol actionLabelViewDelegate: AnyObject{
    func actionLabelViewDidTapButton(_ actionLabelView: ActionLabelView)
}

class ActionLabelView: UIView {
    
    weak var delegate: actionLabelViewDelegate?
    
    private let label: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.numberOfLines = 0
        return label
    }()
    private let button: UIButton = {
        let button = UIButton()
        //button.setTitleColor(.black, for: .normal)
        //let image = UIImage(systemName: "pause",withConfiguration: UIImage.SymbolConfiguration(pointSize: 60, weight: .regular))
        let image = UIImage(systemName: "plus.circle", withConfiguration: UIImage.SymbolConfiguration(pointSize: 100, weight: .medium))
        button.tintColor = .label
        button.setImage(image, for: .normal)
        return button
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)
        clipsToBounds = true
        isHidden = true
        
        addSubview(label)
        addSubview(button)
        button.addTarget(self, action: #selector(didTapButton), for: .touchUpInside)
    }
    @objc func didTapButton(){
        delegate?.actionLabelViewDidTapButton(self)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    override func layoutSubviews() {
        super.layoutSubviews()
        button.frame = CGRect(x: 0, y: 5, width: width - 20, height: width - 20)
        label.frame = CGRect(x: 0, y: height - 50, width: width, height: 15)
    }
    
    func configUIWithVM(with viewModel: ActionLabelViewModel){
        label.text = viewModel.text
        //button.titleLabel?.text = viewModel.actionTitle
    }
}
