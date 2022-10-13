//
//  AlbumViewController.swift
//  Spotify
//
//  Created by user212878 on 7/24/22.
//

import UIKit

class AlbumViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource,AlbumHeaderCollectionReusableViewDelegate {
    
    
  
    
    private var tracks : [AlbumTrack] = []
    
    private var album: Album
    
    private var viewModels = [RecomendationCellVM]()
    
    private let collectionView: UICollectionView = UICollectionView(
        frame: .zero,
        collectionViewLayout: UICollectionViewCompositionalLayout(sectionProvider: { (_, _) -> NSCollectionLayoutSection? in
            return AlbumViewController.createSectionalLayout()
        }))
    
    init(album: Album){
        
        self.album = album
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        title = album.name
        view.backgroundColor = .red
        configCollectionview()
        fetchData()
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .action, target: self, action: #selector(didTapAction))
        
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        collectionView.frame = view.bounds
    }
    
    private  func configCollectionview(){
        view.addSubview(collectionView)
        
        collectionView.register(
            AlbumTrackCollectionViewCell.self,
            forCellWithReuseIdentifier: AlbumTrackCollectionViewCell.identifier)
        
        collectionView.register(AlbumTrackHeaderCollectionReusableView.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: AlbumTrackHeaderCollectionReusableView.identifier)
        
        collectionView.backgroundColor = .systemBackground
        collectionView.dataSource = self
        collectionView.delegate = self
    }
    
    @objc func didTapAction(){
        let actionSheet = UIAlertController(title: album.name, message: "Save this Album to your Library", preferredStyle: .actionSheet)
        actionSheet.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
        actionSheet.addAction(UIAlertAction(title: "Save Album", style: .default, handler: { (_) in
            APICaller.shared.saveAlbumToLibraray(album: self.album) { (response) in
                if response{
                    HapticsManager.shared.vibrate(for: .success)
                    NotificationCenter.default.post(name: .albumSavedNotification, object: nil)
                }else{
                    HapticsManager.shared.vibrate(for: .error)
                }
            }
        }))
        present(actionSheet, animated: true, completion: nil)
    }
    
    private func fetchData(){
        APICaller.shared.albumDetail(with: album) { (data) in
            DispatchQueue.main.async {
                switch data{
                
                case .success(let model):
                    
                    self.viewModels = model.tracks.items.compactMap({
                        RecomendationCellVM(albumName: $0.name, artistName: $0.artists.first?.name ?? "_", albumImage: "", totalTracks: $0.track_number)
                    })
                    self.tracks
                        .append(contentsOf: model.tracks.items)
                case .failure(let error):
                    print(error.localizedDescription)
                }
            
                self.collectionView.reloadData()
            }
        }
    }
    
    private static func createSectionalLayout() -> NSCollectionLayoutSection{
        
        let item = NSCollectionLayoutItem(
            layoutSize: NSCollectionLayoutSize(
                widthDimension: .fractionalWidth(1.0),
                heightDimension: .fractionalHeight(1.0)) )
        item.contentInsets = NSDirectionalEdgeInsets(top: 2, leading: 2, bottom: 2, trailing: 2)
        
        let group = NSCollectionLayoutGroup.vertical(
            layoutSize: NSCollectionLayoutSize(
                widthDimension: .fractionalWidth(1.0),
                heightDimension: .absolute(110)),
                subitem: item,
                count: 1)
        
        
        let section = NSCollectionLayoutSection(group: group)
        
        section.boundarySupplementaryItems = [NSCollectionLayoutBoundarySupplementaryItem(layoutSize: NSCollectionLayoutSize(
                        widthDimension: .fractionalWidth(1.0),
                        heightDimension: .fractionalWidth(1.0)),
                        elementKind: UICollectionView.elementKindSectionHeader,
                        alignment: .top)]
        return section
    }
    
}


//MARK: - CollectionViewDelegates & Data Source
extension AlbumViewController{
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModels.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: AlbumTrackCollectionViewCell.identifier, for: indexPath) as? AlbumTrackCollectionViewCell else{
            return UICollectionViewCell()
        }
        cell.config(with: viewModels[indexPath.row])
        cell.backgroundColor = .secondarySystemBackground
        return cell
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        var track = tracks[indexPath.row]
        track.album = self.album
        PlayBackPresenter.shared.startPlayBack(from: self, track: [track])
        
    }
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        guard  kind == UICollectionView.elementKindSectionHeader , let header = collectionView.dequeueReusableSupplementaryView(
                ofKind: kind,
                withReuseIdentifier: AlbumTrackHeaderCollectionReusableView.identifier,
                for: indexPath) as? AlbumTrackHeaderCollectionReusableView else {
            return UICollectionReusableView()
        }
        header.delegate = self
        let headerModel = PlayListHeaderViewVM(name: album.name, ownerName: album.artists.first?.name, description: "Release Date: \(String.formattedDate(string: album.release_date))", artworkURL: album.images.first?.url)
        header.config(with: headerModel)
        return header
    }
}

extension AlbumViewController{
    func AlbumHeaderCollectionReusableViewDidTapPlatAll(_ header: AlbumTrackHeaderCollectionReusableView) {
        
        let trackWithAlbum : [AlbumTrack] = tracks.compactMap({
            var track = $0
            track.album = self.album
            return track
        })
        print("Album track \(trackWithAlbum)")
        PlayBackPresenter.shared.startPlayBack(from: self, track: trackWithAlbum)
    }
}


