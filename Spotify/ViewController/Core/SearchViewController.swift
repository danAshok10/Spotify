//
//  SearchViewController.swift
//  Spotify
//
//  Created by user212878 on 6/19/22.
//

import UIKit

class SearchViewController: UIViewController, UICollectionViewDelegate , UICollectionViewDataSource , UISearchBarDelegate {

    var viewModels = [BrowseCategoriesVM]()
    var searchItem: [SearchItem] = []
    let searchController: UISearchController = {
       // let results = UIViewController()
       // results.view.backgroundColor = .red
        let searchController = UISearchController(searchResultsController: SearchResultsViewController())
        searchController.searchBar.placeholder = "Artists,Tracks,Albums"
        searchController.searchBar.searchBarStyle = .minimal
        
        return searchController
    }()
    
    let collectionView : UICollectionView = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewCompositionalLayout(sectionProvider: { (_, _) -> NSCollectionLayoutSection? in
        return SearchViewController.createSectionalLayout()
    }))
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        navigationItem.searchController = searchController
      //  searchController.searchResultsUpdater = self
        searchController.searchBar.delegate = self
        configCollectionView()
        collectionView.delegate = self
        collectionView.dataSource = self
        
        APICaller.shared.getCategories { (result) in
            switch result{
            
            case .success(let model):
                DispatchQueue.main.async {
                    self.viewModels = model.categories.items.compactMap({
                        BrowseCategoriesVM(
                            name: $0.name,
                            imageURL: $0.icons.first?.url ?? "")
                    })
                    self.collectionView.reloadData()
                    self.searchItem.append(contentsOf: model.categories.items.compactMap({$0}))
                }
                
            case .failure(_):
                break
            }
        }
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        collectionView.frame = view.bounds
    }
    private func configCollectionView(){
        view.addSubview(collectionView)
        collectionView.register(GenreCollectionViewCell.self, forCellWithReuseIdentifier: GenreCollectionViewCell.identifier)
    }
    private static func createSectionalLayout() -> NSCollectionLayoutSection {
        
        let insets: CGFloat = 5.0
        let item = NSCollectionLayoutItem(
            layoutSize: NSCollectionLayoutSize(
                widthDimension: .fractionalWidth(0.5),
                heightDimension: .fractionalHeight(1.0)))
        item.contentInsets = NSDirectionalEdgeInsets(top: insets, leading: insets, bottom: insets, trailing: insets)
        
        
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .fractionalWidth(0.35)), subitem: item,count: 2)
        
        let section  = NSCollectionLayoutSection(group: group)
        
        return section
    }
    
    
}

//MARK: - UICollectionView Delegates & Data Source

extension SearchViewController{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModels.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: GenreCollectionViewCell.identifier, for: indexPath) as? GenreCollectionViewCell else {
            return UICollectionViewCell()
        }
       // cell.backgroundColor = cell.colors[(indexPath.row%cell.colors.count)]
        cell.config(with: viewModels[indexPath.row])
        return cell
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        collectionView.deselectItem(at: indexPath, animated: true)
        HapticsManager.shared.vibrateForSelection()
        let vc = CategoryViewController(category: searchItem[indexPath.row])
        print(searchItem[indexPath.row])
        vc.navigationItem.largeTitleDisplayMode = .never
        navigationController?.pushViewController(vc, animated: true)
        //self.present(vc, animated: true, completion: nil)
    }
    
    //search btn pressed delegate
    
   /* func updateSearchResults(for searchController: UISearchController) {
        

    }*/
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        //trimmingCharc are used to ensure that white spaces are not their in the search text
        guard let resultsController = searchController.searchResultsController as? SearchResultsViewController , let query = searchBar.text , !query.trimmingCharacters(in: .whitespaces).isEmpty else {
            return
        }
        resultsController.delegate = self
        print(query)
        APICaller.shared.getSearch(with: query) { (result) in
            switch result{
            
            case .success(let model):
                resultsController.update(with : model)
            case .failure(_):
                break
            }
        }
    }
}

extension SearchViewController: SearchResultsViewControllerDelegate{
    func showResults(_ controller: UIViewController) {
        controller.navigationItem.largeTitleDisplayMode = .never
        navigationController?.pushViewController(controller, animated: true)
    }
    
    
}


