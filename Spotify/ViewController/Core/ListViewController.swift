//
//  ListViewController.swift
//  Spotify
//
//  Created by user212878 on 6/19/22.
//

import UIKit

class LibraryViewController: UIViewController {

    let albumVC = LibraryAlbumViewController()
    let playListVC = LibraryPlayListViewController()
    
    let toggleView = LibraryToggleView()
    
    let scrollView : UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.isPagingEnabled = true
        return scrollView
    }()
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        view.addSubview(scrollView)
        view.addSubview(toggleView)
       // scrollView.backgroundColor = .red
        toggleView.delegate = self
        scrollView.delegate = self
        scrollView.contentSize = CGSize(width: view.width*2, height: view.height)
        addChildren()
        updateBarButton()
    }

    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        scrollView.frame = CGRect(
            x: 0,
            y: view.safeAreaInsets.top + 55,
            width: view.width,
            height: view.height - view.safeAreaInsets.bottom - view.safeAreaInsets.top - 55)
        toggleView.frame = CGRect(x: 10, y: view.safeAreaInsets.top , width: 200, height: 50)
    }
    private func updateBarButton(){
        switch toggleView.state{
        
        case .album:
            navigationItem.rightBarButtonItem = nil
           
        case .playList:
            navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self
                                                               , action: #selector(didTapAddBtn))
        }
    }
    private func addChildren(){
        addChild(playListVC)
        scrollView.addSubview(playListVC.view)
        playListVC.view.frame = CGRect(x: 0, y: 0 , width: scrollView.width/2, height: scrollView.height)
        playListVC.didMove(toParent: self)
        
        addChild(albumVC)
        scrollView.addSubview(albumVC.view)
        albumVC.view.frame = CGRect(x: view.width, y: 0, width: scrollView.width/2, height: scrollView.height)
    }
    @objc func didTapAddBtn(){
        playListVC.showAlertPlayListCreation()
    }
    
}

extension LibraryViewController: UIScrollViewDelegate{
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        if scrollView.contentOffset.x >= (view.width-200){
            toggleView.update(state: .album)
            updateBarButton()
        }
        else{
            toggleView.update(state: .playList)
            updateBarButton()
        }
    }
}

extension LibraryViewController: LibraryToggleViewDelegate{
    func LibraryToggleViewPlaylist(_ toggleView: LibraryToggleView) {
        scrollView.setContentOffset(.zero
                                    , animated: true)
        updateBarButton()
    }
    
    func LibraryToggleViewAlbum(_ toggleView: LibraryToggleView) {
        scrollView.setContentOffset(CGPoint(x: view.width, y: 0),
                                    animated: true)
        updateBarButton()
    }
    
   
    
}
 
