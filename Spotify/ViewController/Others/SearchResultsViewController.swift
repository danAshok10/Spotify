//
//  SearchResultsViewController.swift
//  Spotify
//
//  Created by user212878 on 8/9/22.
//

import UIKit
import SafariServices
struct SearchSection{
    var title: String
    var results:[SearchResults]
}

protocol SearchResultsViewControllerDelegate {
    func showResults(_ controller: UIViewController)
}
class SearchResultsViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    
     var delegate: SearchResultsViewControllerDelegate?
    var sections:[SearchSection] = []
    
    private let tableView: UITableView = {
        let tableView = UITableView(frame: .zero, style: .insetGrouped)
        tableView.backgroundColor = .systemBackground
        return tableView
    }()
    override func viewDidLoad() {
        super.viewDidLoad()
       // tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        tableView.register(SearchResultTableViewCellTracknAlbum.self, forCellReuseIdentifier: SearchResultTableViewCellTracknAlbum.identifier)
        tableView.register(SearchResultTableViewCellForArtist.self, forCellReuseIdentifier: SearchResultTableViewCellForArtist.identifier)
       // tableView.isHidden = true
        view.addSubview(tableView)
        view.backgroundColor = .systemBackground
        tableView.delegate = self
        tableView.dataSource = self
    }
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        tableView.frame = view.bounds
    }
    func update(with results: [SearchResults]){
        let artist = results.filter({
            switch $0 {
            case .artist(model: let model):
                return true
            default: return false
            }
        })
        print(artist)
        let album = results.filter({
            switch $0{
            
            case .album(model: let model):
                return true
            default: return false
            }
        })
    
        let track = results.filter({
            switch $0{
           
            case .track(model: let model):
                return true
            default:
                return false
            }
        })
        self.sections = [
         SearchSection(title: "Artist", results: artist),
            SearchSection(title: "Album", results: album),
            SearchSection(title: "Songs", results: track)
        ]
        
        DispatchQueue.main.async {
            self.tableView.reloadData()
           // self.tableView.isHidden = self.results.isEmpty
        }
        
    }
}

extension SearchResultsViewController{
    func numberOfSections(in tableView: UITableView) -> Int {
        return sections.count
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return sections[section].results.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let result = sections[indexPath.section].results[indexPath.row]
        
       // let Acell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        
        
        switch result{
        
        
        case .artist(model: let model):
           //cell.textLabel?.text =  model.name
            guard let cell = tableView.dequeueReusableCell(withIdentifier: SearchResultTableViewCellForArtist.identifier, for: indexPath) as? SearchResultTableViewCellForArtist else{
                return UITableViewCell()
            }
            let vm = SearchResultTableViewCellForArtistVM(title: model.name, imageURL: model.images?.first?.url ?? "")
            print(model.images?.first?.url ?? "No image found")
            cell.config(with: vm)
            return cell
        case .album(model: let model):
            
            guard let cell = tableView.dequeueReusableCell(withIdentifier: SearchResultTableViewCellTracknAlbum.identifier, for: indexPath) as? SearchResultTableViewCellTracknAlbum else{
                return UITableViewCell()
            }
            let vm = SearchResultTableViewCellForTracknAlbumVM(title: model.name, subTitle: model.type, image: model.images.first?.url ?? "nil")
            cell.config(with: vm)
            return cell
        case .track(model: let model):
            guard let cell = tableView.dequeueReusableCell(withIdentifier: SearchResultTableViewCellTracknAlbum.identifier, for: indexPath) as? SearchResultTableViewCellTracknAlbum else{
                return UITableViewCell()
            }
            let vm =  SearchResultTableViewCellForTracknAlbumVM(title: model.album.name, subTitle: model.album.type, image: model.album.images.first?.url ?? "nil")
            cell.config(with: vm)
            return cell
        }
        //cell.textLabel?.text = "Dan"
        //return Acell
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return sections[section].title
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let result = sections[indexPath.section].results[indexPath.row]
        HapticsManager.shared.vibrateForSelection()
        switch result{
        
        case .artist(model: let model):
            
            print(model.external_urls.first)
            guard let url = URL(string: model.external_urls["spotify"] ?? "") else{
                return
            }
            let vc = SFSafariViewController(url: url)
            self.present(vc, animated: true, completion: nil)
        case .album(model: let model):
            let vc = AlbumViewController(album: model)
            //navigationItem.largeTitleDisplayMode = .never
            //navigationController?.pushViewController(vc, animated: true)
           // self.present(vc, animated: true, completion: nil)
            //self.navigationController?.pushViewController(vc, animated: true)
            delegate?.showResults(vc)
        case .track(model: let model):
            PlayBackPresenter.shared.startPlayBack(from: self, track: model)
            break
        }
    }
}
