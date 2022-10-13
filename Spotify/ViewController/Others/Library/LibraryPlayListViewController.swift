//
//  LibraryPlayListViewController.swift
//  Spotify
//
//  Created by user212878 on 9/23/22.
//

import UIKit

class LibraryPlayListViewController: UIViewController {
    
    
    
    var noPlayListView = ActionLabelView()

    var items = [Item]()
    public var selectionHandler: ((Item) -> Void)?
    
    private let tableView : UITableView = {
        let tableView = UITableView(frame: .zero, style: .grouped)
        tableView.register(SearchResultTableViewCellTracknAlbum.self, forCellReuseIdentifier: SearchResultTableViewCellTracknAlbum.identifier)
        tableView.isHidden = true
        return tableView
    }()
    override func viewDidLoad() {
        super.viewDidLoad()
        //view.backgroundColor = .blue
        view.addSubview(noPlayListView)
        view.addSubview(tableView)
        
        noPlayListView.isHidden = true
        noPlayListView.configUIWithVM(with: ActionLabelViewModel(text: "No PlayList Added", actionTitle: "Add PlayList"))
        noPlayListView.delegate = self
        tableView.delegate = self
        tableView.dataSource = self
        
        //updateUI()
        fetchData()
        
        if selectionHandler != nil {
            navigationItem.leftBarButtonItem = UIBarButtonItem(barButtonSystemItem: .close, target: self, action: #selector(didTapCloseBtn))
        }
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        noPlayListView.frame = CGRect(x: 0, y: 0, width: 150, height: 175)
        noPlayListView.center = view.center
        tableView.frame = view.bounds
    }
    public func showAlertPlayListCreation(){
        let alert = UIAlertController(title: "New Playlist", message: "Add new Playlist", preferredStyle: .alert)
        alert.addTextField { (textField) in
            textField.placeholder = "Create new PlayList"
        }
        alert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
        alert.addAction(UIAlertAction(title: "Create", style: .default, handler: { (_) in
            guard let textfield = alert.textFields?.first , let text = textfield.text, !text.trimmingCharacters(in: .whitespaces).isEmpty else{
                return
            }
            APICaller.shared.createPlayList(with: text) {[weak self] (sucess) in
                if sucess{
                    self?.fetchData()
                    HapticsManager.shared.vibrate(for: .success)
                }else{
                    HapticsManager.shared.vibrate(for: .error)
                    print("Failed to create a play list")
                }
            }
        }))
        present(alert, animated: true, completion: nil)
    }
   
    private func fetchData(){
        let group = DispatchGroup()
        group.enter()
        DispatchQueue.main.async {
            APICaller.shared.getCurrentUserPlayList { (result) in
                
                defer{
                    group.leave()
                }
                switch result{
                
                case .success(let playList):
                    self.items = playList.items
                    self.updateUI()
                    print("Items inside API sucess caller count is \(self.items.count)")
                    break
                case .failure(let error):
                    break
                }
            }
        }
        group.notify(queue: .main){
            self.updateUI()
        }
    }
    private func updateUI(){
        print("Items.count in updateUI \(items.count)")
        if items.count == 0{
            DispatchQueue.main.async {
                self.noPlayListView.isHidden = false
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

extension LibraryPlayListViewController: actionLabelViewDelegate{
    func actionLabelViewDidTapButton(_ actionLabelView: ActionLabelView) {
        showAlertPlayListCreation()
    }
}

extension LibraryPlayListViewController: UITableViewDataSource, UITableViewDelegate{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return items.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: SearchResultTableViewCellTracknAlbum.identifier, for: indexPath) as? SearchResultTableViewCellTracknAlbum else {
            return UITableViewCell()
        }
        let item = items[indexPath.row]
        cell.config(with: SearchResultTableViewCellForTracknAlbumVM(title: item.name ,
                                                                    subTitle: item.owner.display_name,
                                                                    image: item.images.first?.url ?? ""))
        return cell
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 70
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        let item = items[indexPath.row]
        HapticsManager.shared.vibrateForSelection()
        
        guard selectionHandler == nil else{
            selectionHandler?(item)
            dismiss(animated: true, completion: nil)
            return
        }
            
        let vc = PlayListViewController(with: item)
        vc.isOwner = true
        navigationItem.largeTitleDisplayMode = .never
        navigationController?.pushViewController(vc, animated: true)
    }
}
