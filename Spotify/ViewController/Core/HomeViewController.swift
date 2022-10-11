//
//  HomeViewController.swift
//  Spotify
//
//  Created by user212878 on 6/19/22.
//

import UIKit
enum BrowseSectionType{
    case newReleases(viewModels: [NewReleasesCellVM])
    case featuredPlayList(viewModels: [FeaturedPlayListCellVM])
    case recomendedTracks(viewModels: [RecomendationCellVM])
}

class HomeViewController: UIViewController {
    

    private var releases:[Album] = []
    private var playLists: [Item] = []
    private var track: [AudioTracks] = []
    
    private var sections = [BrowseSectionType]()
    private var collectionView: UICollectionView = UICollectionView(
        frame: .zero,
        collectionViewLayout: UICollectionViewCompositionalLayout { (sectionIndex, _) -> NSCollectionLayoutSection? in
            
            return HomeViewController.createSectionalLayout(section: sectionIndex)
    })
    //create a spinner in UI
    private let spinner : UIActivityIndicatorView = {
        let spinner  = UIActivityIndicatorView()
        spinner.tintColor = .label
        spinner.hidesWhenStopped = true
        return spinner
    }()
    
    
    var newReleases: NewReleasesResponse?
    var featuredPlayList: FeaturedPlayListResponse?
    var recomendationResponse: RecomendationResponse?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        navigationItem.rightBarButtonItem = UIBarButtonItem(image: UIImage(systemName: "gear"), style: .done, target: self, action:#selector(settingsBtnTapped))
        navigationController?.navigationItem.rightBarButtonItem?.tintColor = .systemGreen
//navigationController?.navigationBar.tintColor = .gray
        tabBarController?.tabBar.tintColor = .systemGreen
        configureCollectionView()
        view.addSubview(spinner)
        fetchData()
        collectionView.register(NewReleaseCollectionViewCell.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: "header")
        addToPlayListOnLongTapGesture()
        
    }
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        collectionView.frame = view.bounds
    }
    private func configureCollectionView(){
        view.addSubview(collectionView)
        collectionView.register(NewReleaseCollectionViewCell.self, forCellWithReuseIdentifier: NewReleaseCollectionViewCell.identifier)
        collectionView.register(FeaturedPlayListCollectionViewCell.self, forCellWithReuseIdentifier: FeaturedPlayListCollectionViewCell.identifier)
        collectionView.register(RecomendedTrackCollectionViewCell.self, forCellWithReuseIdentifier: RecomendedTrackCollectionViewCell.identifier)
        
        collectionView.register(TitleHeaderCollectionReusableView.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: TitleHeaderCollectionReusableView.identifier)
        
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.backgroundColor = .systemBackground
    }
    private func fetchData(){
        let group  = DispatchGroup()
        group.enter()
        group.enter()
        group.enter()
        //API call to get new releases
        APICaller.shared.getNewReleases { (result) in
            defer{
                group.leave()
            }
            switch result {
            
            case .success(let model):
                self.newReleases = model
            case .failure(let error):
                print("Error on getting new Releases\(error.localizedDescription)")
            }
        }
        //API call to get featured playlist
        APICaller.shared.getFeaturedPlayList { (result) in
            defer {
                group.leave()
            }
            switch result{
            
            case .success(let model):
                self.featuredPlayList = model
            case .failure(let error):
                print("Error in getting featured playlist \(error.localizedDescription)")
            }
        }
        //API call to get recomended tracks
        APICaller.shared.getGenereRecomendations { (result) in
            switch result{
            
            case .success(let model):
                let generes = model.genres
                var seeds = Set<String>()
                
                    while seeds.count < 5 {
                        if let random = generes.randomElement(){
                            seeds.insert(random)
                        }
                    }
                
                APICaller.shared.getRecomendations(generes: seeds) { (recomendationResponse) in
                    defer{
                        group.leave()
                    }
                    switch recomendationResponse{
                    
                    case .success(let model):
                        self.recomendationResponse = model
                    case .failure(let error):
                        print("Error in getting recomendations \(error.localizedDescription)")
                    }
                }
            case .failure(let error): break
                //
            }
        }
        
        group.notify(queue: .main) {
            guard let newReleases = self.newReleases?.albums.items, let featuredPlayList = self.featuredPlayList?.playlists.items, let recomendations = self.recomendationResponse?.tracks else {
                return
            }
            self.configModels(newReleases: newReleases, featuredPlayList: featuredPlayList, recomendations: recomendations)
            print("No of Sections \(self.sections.count)")
            print(" NO of New releases \(newReleases.count)")
            print(" NO of Featured Playlist \(featuredPlayList.count)")
            print(" NO of Recomendations \(recomendations.count)")
        }
        
        
    }
    private func addToPlayListOnLongTapGesture(){
        let gesture = UILongPressGestureRecognizer(target: self, action: #selector(didLongPress(_:)))
        collectionView.isUserInteractionEnabled = true
        collectionView.addGestureRecognizer(gesture)
    }
    @objc func didLongPress(_ gesture: UILongPressGestureRecognizer){
        guard gesture.state == .began else {
            return
        }
        let touchPoint = gesture.location(in: collectionView)
        guard let indexPath = collectionView.indexPathForItem(at: touchPoint), indexPath.section == 2 else{
            return
        }
        let model = track[indexPath.row]
        
        let actionSheet = UIAlertController(
            title: model.album.name,
            message: "Add this track to your playlist",
            preferredStyle: .actionSheet)
        actionSheet.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
        actionSheet.addAction(UIAlertAction(title: "Add to playlist", style: .default, handler: {[weak self] (_) in
            DispatchQueue.main.async {
                let vc = LibraryPlayListViewController()
                vc.selectionHandler = { playList in
                    APICaller.shared.addTrackToPlayList(track: model, playList: playList) { (sucess) in
                        print("Track is added to playlist \(sucess)")
                    }
                }
                
                self?.present(UINavigationController(rootViewController: vc), animated: true, completion: nil)
            }
            
        }))
        present(actionSheet, animated: true, completion: nil)
    }
    private func configModels(newReleases:[Album], featuredPlayList: [Item],recomendations: [AudioTracks]){
        self.releases = newReleases
        self.playLists = featuredPlayList
        self.track = recomendations
        sections.append(.newReleases(viewModels: newReleases.compactMap({
            return NewReleasesCellVM(
                name: $0.name,
                imageURL: URL(string: $0.images.first?.url ?? "")!,
                numberOfTracks: $0.total_tracks,
                artistName: $0.artists.first?.name ?? "")
        })  ))
        sections.append(.featuredPlayList(viewModels: featuredPlayList.compactMap({
            return FeaturedPlayListCellVM(
                name: $0.name,
                ownerName: $0.owner.display_name,
                numberOfTracks: $0.tracks.total,
                image: $0.images.first?.url ?? "")
        }) ))
        sections.append(.recomendedTracks(viewModels: recomendations.compactMap({
            return RecomendationCellVM(
                albumName: $0.album.name,
                artistName: $0.album.artists.first?.name ?? "-",
                albumImage: $0.album.images.first?.url ?? "",
                totalTracks: $0.album.total_tracks)
        }) ))
        DispatchQueue.main.async {
            self.collectionView.reloadData()
        }
        
    }
    @objc func settingsBtnTapped(){
        let vc = SettingsViewController()
        navigationController?.pushViewController(vc, animated: true)
    }

   

}
extension HomeViewController: UICollectionViewDelegate, UICollectionViewDataSource{
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return sections.count
    }
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        let type = sections[section]
        switch type{
        
        case .newReleases(viewModels: let viewModels):
            return viewModels.count
        case .featuredPlayList(viewModels: let viewModels):
            return viewModels.count
        case .recomendedTracks(viewModels: let viewModels):
            return viewModels.count
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let type = sections[indexPath.section]
        switch type{
        
        case .newReleases(let viewModels):
            guard let cell = collectionView.dequeueReusableCell(
                withReuseIdentifier: NewReleaseCollectionViewCell.identifier,
                    for: indexPath) as? NewReleaseCollectionViewCell
            else{
                return UICollectionViewCell()
            }
            let viewModel = viewModels[indexPath.row]
            cell.configure(with: viewModel)
            return cell
            
        case .featuredPlayList(let viewModels):
            guard let cell = collectionView.dequeueReusableCell(
                withReuseIdentifier: FeaturedPlayListCollectionViewCell.identifier,
                for: indexPath) as? FeaturedPlayListCollectionViewCell else {
                    return UICollectionViewCell()
                }
            cell.backgroundColor = .red
            let viewModel = viewModels[indexPath.row]
            cell.config(with: viewModel)
            return cell
            
        case .recomendedTracks(let viewModels):
            guard let cell = collectionView.dequeueReusableCell(
                    withReuseIdentifier: RecomendedTrackCollectionViewCell.identifier,
                    for: indexPath) as? RecomendedTrackCollectionViewCell else{
                return UICollectionViewCell()
            }
            let viewModel = viewModels[indexPath.row]
            cell.config(with: viewModel)
            //cell.backgroundColor = .green
            return cell
        }
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let section = sections[indexPath.section]
        switch section{
        
        case .newReleases:
            
            let album = releases[indexPath.row]
            let vc = AlbumViewController(album: album)
            vc.navigationItem.largeTitleDisplayMode = .never
            //vc.title = album.name
            navigationController?.pushViewController(vc, animated: true)
           
        case .featuredPlayList:
            
            let playList = playLists[indexPath.row]
            let vc = PlayListViewController(with: playList)
            navigationItem.largeTitleDisplayMode = .never
            navigationController?.pushViewController(vc, animated: true)
            
            
        case .recomendedTracks:
            let tracks = track[indexPath.row]
            
            PlayBackPresenter.shared.startPlayBack(from: self, track: tracks)
            
        }
    }
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        
        let section = sections[indexPath.section]
        
        guard kind == UICollectionView.elementKindSectionHeader, let header = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: TitleHeaderCollectionReusableView.identifier, for: indexPath) as? TitleHeaderCollectionReusableView else {
            return UICollectionReusableView()
        }
        switch section {
        
        case .newReleases(viewModels: let viewModels):
            header.config(with: "New Released Album")
        case .featuredPlayList(viewModels: let viewModels):
            header.config(with: "Featured Playlist")
        case .recomendedTracks(viewModels: let viewModels):
            
            header.config(with: "Made for you")
        }

        return header
    }
//    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
//        return CGSize(width: collectionView.frame.width, height: 40)
//    }
    
}
//MARK: - Creating Sections
extension HomeViewController{
    private static func createSectionalLayout(section: Int) -> NSCollectionLayoutSection{
        let sectionHeader = [NSCollectionLayoutBoundarySupplementaryItem(layoutSize: NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .absolute(80)), elementKind: UICollectionView.elementKindSectionHeader, alignment: .top)]
        switch section{
        case 0:
            //Item
            let item = NSCollectionLayoutItem(layoutSize:
                                           NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .fractionalHeight(1)))
            item.contentInsets = NSDirectionalEdgeInsets(top: 2, leading: 2, bottom: 2, trailing: 2)
            //Group
            //Vertical group inside horizontal group
            let verticalGroup = NSCollectionLayoutGroup.vertical(layoutSize: NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .absolute(360)), subitem: item, count: 3)
            let horizoantalGroup = NSCollectionLayoutGroup.horizontal(layoutSize: NSCollectionLayoutSize(widthDimension: .fractionalWidth(0.75), heightDimension: .absolute(360)), subitem: verticalGroup, count: 1)
            //Section
            let section = NSCollectionLayoutSection(group: horizoantalGroup)
            section.orthogonalScrollingBehavior = .groupPaging
            section.boundarySupplementaryItems = sectionHeader
            return section
            break
        case 1:
            //Item
            let item = NSCollectionLayoutItem(layoutSize:
                                           NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .fractionalHeight(1)))
            item.contentInsets = NSDirectionalEdgeInsets(top: 2, leading: 2, bottom: 2, trailing: 2)
            //Group
            let verticalGroup = NSCollectionLayoutGroup.vertical(layoutSize: NSCollectionLayoutSize(widthDimension: .absolute(300), heightDimension: .absolute(600)), subitem: item, count: 2)
            let horizontalGroup = NSCollectionLayoutGroup.horizontal(layoutSize: NSCollectionLayoutSize(widthDimension: .absolute(300), heightDimension: .absolute(600)), subitem: verticalGroup, count: 1)
            //Section
            let section = NSCollectionLayoutSection(group: horizontalGroup)
            section.orthogonalScrollingBehavior = .groupPaging
            section.boundarySupplementaryItems = sectionHeader
            return section
            break
        case 2:
            //Item
            let item = NSCollectionLayoutItem(layoutSize:
                                           NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .fractionalHeight(1)))
            item.contentInsets = NSDirectionalEdgeInsets(top: 2, leading: 2, bottom: 2, trailing: 2)
            //Group
            //Vertical group inside horizontal group
            let verticalGroup = NSCollectionLayoutGroup.vertical(layoutSize:NSCollectionLayoutSize(
                        widthDimension: .fractionalWidth(1),
                        heightDimension: .absolute(360)),
                        subitem: item,
                        count: 3)
            let horizoantalGroup = NSCollectionLayoutGroup.horizontal(layoutSize: NSCollectionLayoutSize(
                        widthDimension: .fractionalWidth(0.75),
                        heightDimension: .absolute(360)),
                        subitem: verticalGroup,
                        count: 1)
            //Section
            let section = NSCollectionLayoutSection(group: horizoantalGroup)
            section.orthogonalScrollingBehavior = .groupPaging
            section.boundarySupplementaryItems = sectionHeader
             return section
            break
        default:
            //Item
            let item = NSCollectionLayoutItem(layoutSize:
                                           NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .fractionalHeight(1)))
            item.contentInsets = NSDirectionalEdgeInsets(top: 2, leading: 2, bottom: 2, trailing: 2)
            //Group
            
            let group = NSCollectionLayoutGroup.vertical(layoutSize: NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .absolute(120)), subitem: item, count: 1)
            
            //Section
            let section = NSCollectionLayoutSection(group: group)
            section.orthogonalScrollingBehavior = .groupPaging
            return section
        }
        
    }
    
}
