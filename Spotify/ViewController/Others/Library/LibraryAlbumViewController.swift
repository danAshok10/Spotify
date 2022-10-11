//
//  LibraryAlbumViewController.swift
//  Spotify
//
//  Created by user212878 on 9/23/22.
//

import UIKit

class LibraryAlbumViewController: UIViewController {

   
    
    var noAlbumView = ActionLabelView()

    var album = [AlbumTrack]()
    
    private var observer: NSObjectProtocol?
   
    
    private let tableView : UITableView = {
        let tableView = UITableView(frame: .zero, style: .grouped)
        tableView.register(SearchResultTableViewCellTracknAlbum.self, forCellReuseIdentifier: SearchResultTableViewCellTracknAlbum.identifier)
        tableView.isHidden = true
        return tableView
    }()
    override func viewDidLoad() {
        super.viewDidLoad()
        //view.backgroundColor = .blue
        view.addSubview(noAlbumView)
        view.addSubview(tableView)
        
        noAlbumView.isHidden = true
        noAlbumView.configUIWithVM(with: ActionLabelViewModel(text: "No saved Album", actionTitle: "Browse"))
        noAlbumView.delegate = self
        tableView.delegate = self
        tableView.dataSource = self
        
        //updateUI()
        fetchData()
        observer = NotificationCenter.default.addObserver(forName: .albumSavedNotification, object: nil, queue: .main, using: {[weak self] (_) in
            self?.fetchData()
        })
        
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        noAlbumView.frame = CGRect(x: (view.width - 150)/2, y: (view.height - 170)/2, width: 150, height: 170)
        print("Width:\(view.width)")
        print("Width:\(view.height)")
        //noAlbumView.center = view.center
        tableView.frame = view.bounds
    }
    
   
   private func fetchData(){
    APICaller.shared.getCurrentUserAlbum { (result) in
        switch result{
        
        case .success(let album):
            self.album = album
            self.updateUI()
        case .failure(let error):
            break
        }
    }
    }
    private func updateUI(){
        print("Album.count in updateUI \(album.count)")
        if album.count == 0{
            DispatchQueue.main.async {
                self.noAlbumView.isHidden = false
            }
            
        }else{
            //display tableView
            DispatchQueue.main.async {
                self.tableView.isHidden = false
                self.tableView.reloadData()
            }
        }
    }
    
    @objc func didTapCloseBtn(){
        dismiss(animated: true, completion: nil)
    }

}
extension LibraryAlbumViewController: UITableViewDataSource, UITableViewDelegate{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return album.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: SearchResultTableViewCellTracknAlbum.identifier, for: indexPath) as? SearchResultTableViewCellTracknAlbum else {
            return UITableViewCell()
        }
        let item = album[indexPath.row]
        cell.config(with: SearchResultTableViewCellForTracknAlbumVM(title: item.name ,
                                                                    subTitle: item.artists.first?.name ?? "",
                                                                    image: item.album?.images.first?.url ?? ""))
        return cell
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 70
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        let item = album[indexPath.row]
      
        guard let album = item.album else{
            return
        }
        let vc = AlbumViewController(album: album)
       // vc.isOwner = true
        navigationItem.largeTitleDisplayMode = .never
        navigationController?.pushViewController(vc, animated: true)
    }
}
extension LibraryAlbumViewController: actionLabelViewDelegate{
    func actionLabelViewDidTapButton(_ actionLabelView: ActionLabelView) {
        tabBarController?.selectedIndex = 0
    }
}
