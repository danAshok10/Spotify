//
//  CategoryViewController.swift
//  Spotify
//
//  Created by user212878 on 8/16/22.
//

import UIKit

class CategoryViewController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate {
    
    
    let category: SearchItem
    private let collectionView: UICollectionView = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewCompositionalLayout(sectionProvider: { (_, _) -> NSCollectionLayoutSection? in
        return CategoryViewController.createSectionalLayout()
    }))
    var playList = [CategoryItems]()
    
    init(category: SearchItem){
        self.category = category
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = category.name
        configCollectionView()
        view.backgroundColor = .systemBackground
        collectionView.backgroundColor = .secondarySystemBackground
        APICaller.shared.getCategoryPlayList(category: category) { (result) in
            switch result{
            
            case .success(let playList):
                DispatchQueue.main.async {
                    self.playList = playList.playlists.items
                    self.collectionView.reloadData()
                }
                
            case .failure(let error):
                print(error.localizedDescription)
                break
            }
        }
        
    }
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        collectionView.frame = view.bounds
    }
    
    private static func createSectionalLayout() -> NSCollectionLayoutSection{
        let item = NSCollectionLayoutItem(layoutSize: NSCollectionLayoutSize(
                        widthDimension: .fractionalWidth(1.0),
                        heightDimension: .fractionalHeight(1.0)))
        item.contentInsets = NSDirectionalEdgeInsets(top: 5, leading: 5, bottom: 5, trailing: 5)
        
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: NSCollectionLayoutSize(
                    widthDimension: .fractionalWidth(1.0),
                    heightDimension: .absolute(175)),
                    subitem: item,
                    count: 2)
        
        let section = NSCollectionLayoutSection(group: group)
        return section
    }
    
    private func configCollectionView(){
        view.addSubview(collectionView)
        collectionView.register(FeaturedPlayListCollectionViewCell.self, forCellWithReuseIdentifier: FeaturedPlayListCollectionViewCell.identifier)
       collectionView.dataSource = self
       collectionView.delegate = self
    }

}

extension CategoryViewController{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return playList.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: FeaturedPlayListCollectionViewCell.identifier, for: indexPath) as? FeaturedPlayListCollectionViewCell else {
            return UICollectionViewCell()
        }
        let playLists = playList[indexPath.row]
        cell.config(with: FeaturedPlayListCellVM(name: playLists.description, ownerName: playLists.name, numberOfTracks: playLists.tracks.total, image: playLists.images.first?.url ?? ""))
        
        return cell
    }
   /* func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let vc = PlayListViewController(with: playList[indexPath.row])
    }*/
}
