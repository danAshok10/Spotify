//
//  PlayListViewController.swift
//  Spotify
//
//  Created by user212878 on 6/19/22.
//

import UIKit

class PlayListViewController: UIViewController,PlayListHeaderCollectionReusableViewDelegate {
    
    

    let playList:Item
    
    private var viewModels = [RecomendationCellVM]()
    private var tracks = [AudioTracks]()
    
    public var isOwner = false
    
    private let collectionView: UICollectionView = UICollectionView(
        frame: .zero,
        collectionViewLayout: UICollectionViewCompositionalLayout(sectionProvider: { (_, _) -> NSCollectionLayoutSection? in
            return PlayListViewController.createSectionalLayout()
        }))
    init(with playList: Item) {
        self.playList = playList
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        
        title = playList.name
       // collectionView.backgroundColor = .red
        APICaller.shared.getPlayListDetails(with: playList) { [weak self] (response) in
            DispatchQueue.main.async {
                switch response{
                case .success(let model):

                    self?.tracks  = model.tracks.items.compactMap({  $0.track
                    })
                    self?.viewModels = model.tracks.items.compactMap({
                            RecomendationCellVM(
                                albumName: $0.track.album.name,
                                artistName: $0.track.album.artists.first?.name ?? "_",
                                albumImage: $0.track.album.images.first?.url ?? "",
                                totalTracks: $0.track.album.total_tracks)
                        })
                    self?.collectionView.reloadData()
                    print("Count: \(self?.viewModels.count)")
                case .failure(let error):
                    break
                }
            }
            
        }
        configCollectionview()
        navigationItem.rightBarButtonItem =  UIBarButtonItem(barButtonSystemItem: .reply, target: self, action: #selector(didTapShareBtn))
        if isOwner{
            removeTrackFromUserPlayList()
        }
        
    }
    
    
    //action func to share the playlist
    @objc private func didTapShareBtn(){
        print(playList.external_urls)
        
        guard let url = URL(string: playList.external_urls["spotify"] ?? "") else {
            return
        }
        let vc = UIActivityViewController(activityItems: ["Checkout this play list", url], applicationActivities: [])
        vc.popoverPresentationController?.barButtonItem = navigationItem.rightBarButtonItem
        present(vc, animated: true, completion: nil)
    }
    
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        collectionView.frame = view.bounds
    }
    private  func configCollectionview(){
        view.addSubview(collectionView)
        
        collectionView.register(
            RecomendedTrackCollectionViewCell.self,
            forCellWithReuseIdentifier: RecomendedTrackCollectionViewCell.identifier)
        
        collectionView.register(
            PlayListHeaderCollectionReusableView.self,
            forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader,
            withReuseIdentifier: PlayListHeaderCollectionReusableView.identifier)
        
        collectionView.backgroundColor = .systemBackground
        collectionView.dataSource = self
        collectionView.delegate = self
    }
    private func removeTrackFromUserPlayList(){
        let gesture = UILongPressGestureRecognizer(target: self, action: #selector(didTapLongPress(_:)))
        collectionView.isUserInteractionEnabled = true
        collectionView.addGestureRecognizer(gesture)
    }
    @objc func didTapLongPress(_ gesture: UILongPressGestureRecognizer){
        guard gesture.state == .began else{
            return
        }
        let touchPoint = gesture.location(in: collectionView)
        guard let indexPath = collectionView.indexPathForItem(at: touchPoint) else{
            return
        }
        let model = tracks[indexPath.row]
        let actionSheet = UIAlertController(title: model.album.name, message: "Do you want to remove this track", preferredStyle: .actionSheet)
        actionSheet.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
        actionSheet.addAction(UIAlertAction(title: "Remove Track", style: .default, handler: { (_) in
            APICaller.shared.removeTrackFtomPlayList(track: model, playList: self.playList) { sucess in
                print("Track is deleted from playList: \(sucess)")
            }
            print("Selected track is: \(model)")
        }))
        present(actionSheet, animated: true, completion: nil
        )
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
        section.boundarySupplementaryItems = [NSCollectionLayoutBoundarySupplementaryItem(
             layoutSize: NSCollectionLayoutSize(
                widthDimension: .fractionalWidth(1.0),
                heightDimension: .fractionalWidth(1.0)),
                elementKind: UICollectionView.elementKindSectionHeader,
                alignment: .top)]
       // section.orthogonalScrollingBehavior = .groupPaging
        return section
    }
    }

//MARK: - Collection View Data Source & Deleagtes

extension PlayListViewController: UICollectionViewDelegate, UICollectionViewDataSource{
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModels.count
        //return viewModels.count
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(
                withReuseIdentifier: RecomendedTrackCollectionViewCell.identifier,
                for: indexPath) as? RecomendedTrackCollectionViewCell else{
            return UICollectionViewCell()
        }
        let viewModel = viewModels[indexPath.row]
        cell.config(with: viewModel)
        
       // cell.backgroundColor = .green
        return cell
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        collectionView.deselectItem(at: indexPath, animated: true)
        let track = tracks[indexPath.row]
        PlayBackPresenter.shared.startPlayBack(from: self, track: track)
    }
    
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        guard  kind == UICollectionView.elementKindSectionHeader ,let     header = collectionView.dequeueReusableSupplementaryView(
                ofKind: kind,
                withReuseIdentifier: PlayListHeaderCollectionReusableView.identifier,
                for: indexPath) as? PlayListHeaderCollectionReusableView else{
            return UICollectionReusableView()
        }
        let headerVM = PlayListHeaderViewVM(
            name: playList.name,
            ownerName: playList.owner.display_name,
            description: playList.description,
            artworkURL: playList.images.first?.url)
        header.config(with: headerVM)
        header.delegate = self
        return header
    }
    
}

extension PlayListViewController{
    func PlayListHeaderCollectionReusableViewDidTapPlatAll(_ header: PlayListHeaderCollectionReusableView) {
        PlayBackPresenter.shared.startPlayBack(from: self, track: tracks)
        print("Play All")
    }
}

