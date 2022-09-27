//
//  LibraryToggleView.swift
//  Spotify
//
//  Created by user212878 on 9/23/22.
//

import UIKit

protocol LibraryToggleViewDelegate: AnyObject {
    func LibraryToggleViewPlaylist(_ toggleView: LibraryToggleView)
    func LibraryToggleViewAlbum(_ toggleView: LibraryToggleView)
}

class LibraryToggleView: UIView {
    
    weak var delegate: LibraryToggleViewDelegate?
    
    enum State {
        case album
        case playList
    }
    var state: State = .playList
    
    let playListButton : UIButton = {
        let button = UIButton()
        button.setTitleColor(.label, for: .normal)
      /*  button.backgroundColor = .systemBackground
        button.layer.cornerRadius = 25
        button.layer.borderWidth = 2
        button.layer.borderColor = UIColor.secondarySystemBackground.cgColor
        */
        button.setTitle("PlayList", for: .normal)
        return button
    }()
    
    let albumListButton : UIButton = {
        let button = UIButton()
        button.setTitleColor(.label, for: .normal)
        button.setTitle("Album", for: .normal)
        
       /* button.backgroundColor = .systemBackground
        button.layer.cornerRadius = 25
        button.layer.borderWidth = 2
        button.layer.borderColor = UIColor.secondarySystemBackground.cgColor
        */

        return button
    }()
    
    let underLineView: UIView = {
        let view = UIView()
        view.backgroundColor = .systemGreen
        view.layer.cornerRadius = 2
        view.layer.masksToBounds = true
        return view
    }()
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.addSubview(playListButton)
        self.addSubview(underLineView)
        self.addSubview(albumListButton)
        playListButton.addTarget(self, action: #selector(didTapPlayListBtn), for: .touchUpInside)
        albumListButton.addTarget(self, action: #selector(didTapAlbumBtn), for: .touchUpInside)
       // self.backgroundColor = .darkGray
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        playListButton.frame = CGRect(x: 0, y: 0, width: 100, height: 50)
        albumListButton.frame = CGRect(x: playListButton.right + 10, y: 0, width: 100, height: 50)
        updateUnderLine()
        
    }
    
    @objc func didTapAlbumBtn(){
        self.delegate?.LibraryToggleViewAlbum(self)
        self.state = .album
        UIView.animate(withDuration: 0.3) {
            self.updateUnderLine()
        }
    }
    
    @objc func didTapPlayListBtn(){
        self.delegate?.LibraryToggleViewPlaylist(self)
        self.state = .playList
        UIView.animate(withDuration: 0.3) {
            self.updateUnderLine()
        }
    }
    
    func updateUnderLine(){
        switch state {
        case .album:
            underLineView.frame = CGRect(x: 100, y: albumListButton.bottom, width: 100, height: 3)
        case .playList:
            underLineView.frame = CGRect(x: 0, y: playListButton.bottom, width: 100, height: 3)
        }
    }
    func update(state: State){
        self.state = state
        UIView.animate(withDuration: 0.3) {
            self.updateUnderLine()
        }
    }
}
