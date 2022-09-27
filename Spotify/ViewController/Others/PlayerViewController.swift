//
//  PlayerViewController.swift
//  Spotify
//
//  Created by user212878 on 6/19/22.
//

import UIKit

protocol PlayerViewControllerDelegate: AnyObject  {
    func didTapPlayPauseBtn()
    func didTapForwardBtn()
    func didTapBacwdBtn()
    func didSlideSlider(value: Float)
}
class PlayerViewController: UIViewController {
    
    weak var delegate: PlayerViewControllerDelegate?
    weak var dataSource: PLayerDataSource?
    weak var dataSourceForAlbum: PLayerDataSourceForAlbum?
    
    
    
    let imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        imageView.backgroundColor = .blue
        //imageView.image = UIImage(systemName: "photo")
        return imageView
    }()
     
    let controllerView = PlayerControllerView()
    override func viewDidLoad() {
        super.viewDidLoad()
        //view.backgroundColor = .red
        view.backgroundColor = .systemBackground
        view.addSubview(imageView)
        view.addSubview(controllerView)
        controllerView.backgroundColor = .systemBackground
        controllerView.delegate = self
        configBarBtn()
        configUIWithDataSource()
        configUIWithDataSourceForAlbum()
        
    }
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        imageView.frame = CGRect(x: 0, y: view.safeAreaInsets.top, width: view.width, height: view.width)
        controllerView.frame = CGRect(x: 10, y: imageView.bottom + 10, width: view.width - 20, height: view.height - view.safeAreaInsets.top - 25 - view.safeAreaInsets.bottom)
    }
    private func configUIWithDataSource(){
        if let imageURL = dataSource?.imageURL, let subTitle = dataSource?.subTitle,let title = dataSource?.songName {
            imageView.loadFrom(URLAddress: imageURL)
            print(title)
            controllerView.configUIWithVM(with: PlayerControllerViewVM(title: title, subTitle: subTitle))
        }
        
    }
    private func configUIWithDataSourceForAlbum(){
        if let imageURL = dataSourceForAlbum?.AlbumImageURL, let subTitle = dataSourceForAlbum?.AlbumSubTitle, let title = dataSourceForAlbum?.AlbumSubTitle {
            imageView.loadFrom(URLAddress: imageURL)
            controllerView.configUIWithVM(with: PlayerControllerViewVM(title: title, subTitle: subTitle))
            print("Title \(title)")
        }
    }
    private func configBarBtn(){
        navigationItem.leftBarButtonItem = UIBarButtonItem(barButtonSystemItem: .close, target: self, action: #selector(didTapCloseBtn))
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .action, target: self, action: #selector(didTapActionBtn))
    }

    @objc func didTapCloseBtn(){
        dismiss(animated: true, completion: nil)
    }
    @objc func didTapActionBtn(){
        //
    }
    
    func refreshUI(){
        configUIWithDataSource()
        configUIWithDataSourceForAlbum()
    }
    

}

extension PlayerViewController: PlayerControllerViewDelegate{
    func playerControllerView(_ viewController: PlayerControllerView, didSlider value: Float) {
        delegate?.didSlideSlider(value: value)
    }
    
    func PlayerControllerViewDidTapPlayPauseBtn(_ viewController: PlayerControllerView) {
        delegate?.didTapPlayPauseBtn()
    }
    
    func PlayerControllerViewDidTapForwardBtn(_ viewController: PlayerControllerView) {
        delegate?.didTapForwardBtn()
    }
    
    func PlayerControllerViewDidTapBackwardBtn(_ viewController: PlayerControllerView) {
        delegate?.didTapBacwdBtn()
    }
    

    
}
