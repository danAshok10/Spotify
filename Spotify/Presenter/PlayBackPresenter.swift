//
//  PlayBackPresenter.swift
//  Spotify
//
//  Created by user212878 on 8/31/22.
//

import Foundation
import UIKit
import AVFoundation


protocol PLayerDataSource: AnyObject{
    var songName: String?{
        get
    }
    var subTitle: String?{
        get
    }
    var imageURL: String?{
        get
    }
}

protocol PLayerDataSourceForAlbum: AnyObject{
    var AlbumSongName: String?{
        get
    }
    var AlbumSubTitle: String?{
        get
    }
    var AlbumImageURL: String?{
        get
    }
}

class PlayBackPresenter{
    var index: Int = 0
    
    static let shared = PlayBackPresenter()
    
    var playerVC: PlayerViewController?
    
    private var track : AudioTracks?
    private var playList = [AudioTracks]()
    private var album = [AlbumTrack]()
    
    var player : AVPlayer?
    var playerQue: AVQueuePlayer?
    
    //this current track is for a song(track) & playList
    var currentTrack: AudioTracks? {
        if let track = track, playList.isEmpty {
            return track
        }
        else if let playerQue = self.playerQue, !playList.isEmpty{
           /* let item = playerQue.currentItem
            let items = playerQue.items()
            guard let index = items.firstIndex(where: { $0 == item}) else{
                return nil
            }
            return playList[index]*/
            
            return playList[index]
        }
        return nil
    }
    
    //this currentTrackForAlbum is for Album
    var currentTrackForAlbum: AlbumTrack? {
        if let playerQue = self.playerQue, !album.isEmpty{
           /* let item = playerQue.currentItem
            let items = playerQue.items()
            
            guard let index = items.firstIndex(where: { $0 == item}) else{
                return nil
            }
            print(album[index])*/
            return album[index]
        }
        
        return nil
    }
    
    //for track
     func startPlayBack(from viewController: UIViewController, track: AudioTracks){
       
        guard let url = URL(string: track.album.preview_url ?? "https://p.scdn.co/mp3-preview/2726a9595503bf33fdf44d0e85ae8abc7d876d44?cid=774b29d4f13844c495f206cafdad9c86") else{
            return
        }
        player = AVPlayer(url: url)
        player?.volume = 0.5
//        APICaller.shared.getAudioTrack { (result) in
//            //
//        }
        let vc =  PlayerViewController()
        vc.delegate = self
        vc.dataSource = self
        self.track = track
        self.playList = []
        vc.title = track.album.name
        viewController.present(UINavigationController(rootViewController: vc), animated: true, completion: {[weak self]  in
            self?.player?.play()
            
        })
        
        self.playerVC = vc
       
    }
    //for playList
     func startPlayBack(from viewController:UIViewController, track: [AudioTracks]){
       // viewController.navigationController?.pushViewController(PlayerViewController(), animated: true)
        let vc =  PlayerViewController()
        
        vc.dataSource = self
        vc.delegate = self
        
        let items: [AVPlayerItem] = track.compactMap({
            guard let url = URL(string: $0.album.preview_url ?? "https://p.scdn.co/mp3-preview/2726a9595503bf33fdf44d0e85ae8abc7d876d44?cid=774b29d4f13844c495f206cafdad9c86") else{
                return nil
            }
            return AVPlayerItem(url: url)
        })
    
        self.playerQue = AVQueuePlayer(items: items)
        self.playerQue?.volume = 0.5
        
        self.track = nil
        self.playList = track
        viewController.present(UINavigationController(rootViewController: vc), animated: true, completion:{ [weak self] in
            self?.playerQue?.play()
            
        }
        )
    }
    //for Album
     func startPlayBack(from viewController:UIViewController, track: [AlbumTrack]){
        //viewController.navigationController?.pushViewController(PlayerViewController(), animated: true)
        self.album = track
        let items:[AVPlayerItem] = track.compactMap({
            guard let url = URL(string: $0.album?.preview_url ?? "https://p.scdn.co/mp3-preview/2726a9595503bf33fdf44d0e85ae8abc7d876d44?cid=774b29d4f13844c495f206cafdad9c86") else{
                return nil
            }
            return AVPlayerItem(url: url)
        })
        
        self.playerQue = AVQueuePlayer(items: items)
        self.playerQue?.volume = 0.5
        
        let vc =  PlayerViewController()
        vc.dataSourceForAlbum = self
        viewController.present(UINavigationController(rootViewController: vc), animated: true, completion: nil)
    }
    

}

//MARK: - Data Source for track & playList
extension PlayBackPresenter: PLayerDataSource{
    var songName: String? {
        return currentTrack?.album.name
    }
    
    var subTitle: String? {
        return currentTrack?.album.artists.first?.name
    }
    
    var imageURL: String? {
        return currentTrack?.album.images.first?.url
    }
    
    
}

//MARK: - DataSource for Album
extension PlayBackPresenter: PLayerDataSourceForAlbum{
    var AlbumImageURL: String? {
        return currentTrackForAlbum?.album?.images.first?.url
    }
    
    var AlbumSongName: String? {
        return currentTrackForAlbum?.album?.name
    }
    
    var AlbumSubTitle: String? {
        return currentTrackForAlbum?.album?.artists.first?.name
    }
    
    
}
//MARK: - Delegate
extension PlayBackPresenter: PlayerViewControllerDelegate{
    func didSlideSlider(value: Float) {
        player?.volume = value
    }
    
    func didTapPlayPauseBtn() {
        if let player = player {
            if player.timeControlStatus == .playing{
                player.pause()
            }else if player.timeControlStatus == .paused{
                player.play()
            }
            
        }else if let playerQue = playerQue{
            if playerQue.timeControlStatus == .playing{
                playerQue.pause()
            }else if playerQue.timeControlStatus == .paused{
                playerQue.play()
            }
        }
    }
    
    func didTapForwardBtn() {
    
    if playList.isEmpty{
            player?.pause()
        }else if let firstItem = playerQue?.items().first{
            playerQue?.advanceToNextItem()
            index += 1
            print(index)
            playerVC?.refreshUI()
        }
      //  index ++
        
    }
    
    func didTapBacwdBtn() {
        if playList.isEmpty{
            player?.pause()
            player?.play()
        }else if let firstItem = playerQue?.items().first{
            playerQue?.pause()
            playerQue?.removeAllItems()
            playerQue = AVQueuePlayer(items: [firstItem])
            playerQue?.play()
            playerQue?.volume = 0.5
        }
    }
    
    
}
