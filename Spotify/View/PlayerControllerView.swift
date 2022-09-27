//
//  PlayerControllerView.swift
//  Spotify
//
//  Created by user212878 on 9/2/22.
//


//Bottom section of PlayerViewController
import Foundation
import UIKit

protocol PlayerControllerViewDelegate: AnyObject{
    func PlayerControllerViewDidTapPlayPauseBtn(_ viewController: PlayerControllerView)
    func PlayerControllerViewDidTapForwardBtn(_ viewController: PlayerControllerView)
    func PlayerControllerViewDidTapBackwardBtn(_ viewController: PlayerControllerView)
    func playerControllerView(_ viewController: PlayerControllerView, didSlider value: Float)
}

struct PlayerControllerViewVM{
    let title: String?
    let subTitle: String?
}
class PlayerControllerView: UIView{
    weak var delegate: PlayerControllerViewDelegate?
    
    var isPlaying: Bool = true
    
    private let slider: UISlider = {
        let slider = UISlider()
        slider.value = 0.25
        slider.tintColor = .green
        return slider
    }()
     let title: UILabel = {
            let title = UILabel()
            title.numberOfLines = 0
            title.font = .systemFont(ofSize: 22, weight: .semibold)
        title.text = "Title"
            return title
        }()
     let subTitle: UILabel = {
        let title = UILabel()
        title.numberOfLines = 0
        title.font = .systemFont(ofSize: 18, weight: .regular)
        title.text = "SubTitle"
        title.tintColor = .secondaryLabel
        return title
    }()
    private let backBtn:UIButton = {
        let button =  UIButton()
        button.tintColor = .green
        let image = UIImage(systemName: "backward.end",withConfiguration: UIImage.SymbolConfiguration(pointSize: 30, weight: .regular))
        button.setImage(image, for: .normal)
        return button
    }()
    private let playPauseBtn:UIButton = {
        let button =  UIButton()
        button.tintColor = .green
        let image = UIImage(systemName: "pause",withConfiguration: UIImage.SymbolConfiguration(pointSize: 60, weight: .regular))
        button.setImage(image, for: .normal)
        return button
    }()
    private let ForwardBtn:UIButton = {
        let button =  UIButton()
        button.tintColor = .green
        let image = UIImage(systemName: "forward.end",withConfiguration: UIImage.SymbolConfiguration(pointSize: 30, weight: .regular))
        button.setImage(image, for: .normal)
        return button
    }()
    override init(frame: CGRect) {
        super.init(frame: frame)
         
        addSubview(title)
        addSubview(subTitle)
        addSubview(slider)
        addSubview(playPauseBtn)
        addSubview(backBtn)
        addSubview(ForwardBtn)
        backgroundColor = .clear
        backBtn.addTarget(self, action: #selector(backBtnPressed), for: .touchUpInside)
        playPauseBtn.addTarget(self, action: #selector(playPauseBtnPressed), for: .touchUpInside)
        ForwardBtn.addTarget(self, action: #selector(forwardBtnPressed), for: .touchUpInside)
        slider.addTarget(self, action: #selector(didSlideSlider), for: .valueChanged)
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    @objc func backBtnPressed(){
        delegate?.PlayerControllerViewDidTapBackwardBtn(self)
    }
    
    @objc func playPauseBtnPressed(){
        delegate?.PlayerControllerViewDidTapPlayPauseBtn(self)
        self.isPlaying = !isPlaying
        
        //play & pause Btn
        let play = UIImage(systemName: "pause",withConfiguration: UIImage.SymbolConfiguration(pointSize: 60, weight: .regular))
        let pause = UIImage(systemName: "play.fill", withConfiguration: UIImage.SymbolConfiguration(pointSize: 60, weight: .regular))
        
        playPauseBtn.setImage(isPlaying ? pause:play, for: .normal)
    }
    
    @objc func forwardBtnPressed(){
        delegate?.PlayerControllerViewDidTapForwardBtn(self)
    }
    
    
    @objc func didSlideSlider(_ slider:UISlider){
        let value = slider.value
        delegate?.playerControllerView(self, didSlider: value)
    }
    override func layoutSubviews() {
        super.layoutSubviews()
        title.frame = CGRect(x: 10, y: 0, width: width, height: 50)
        subTitle.frame = CGRect(x: 10, y: title.bottom + 5, width: width, height: 50)
        slider.frame = CGRect(x: 10, y: subTitle.bottom + 15, width: width - 30, height: 20)
        backBtn.frame = CGRect(x: width / 2 - 75 - 90, y: slider.bottom + 30, width: 120, height: 120)
        playPauseBtn.frame = CGRect(x: width / 2 - 55, y: slider.bottom + 30, width: 120, height: 120)
        ForwardBtn.frame = CGRect(x: width - 75 - 65, y: slider.bottom + 30, width: 120, height: 120)
    }
    
    func configUIWithVM(with viewModel: PlayerControllerViewVM){
        title.text = viewModel.title
        subTitle.text = viewModel.subTitle
    }
}
