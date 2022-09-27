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
    override func viewDidLoad() {
        super.viewDidLoad()
        //view.backgroundColor = .blue
        view.addSubview(noPlayListView)
        
        noPlayListView.isHidden = true
        noPlayListView.configUIWithVM(with: ActionLabelViewModel(text: "No PlayList Added", actionTitle: "Add PlayList"))
        noPlayListView.delegate = self
        
        
        DispatchQueue.main.async {
            APICaller.shared.getCurrentUserPlayList { (result) in
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
        
        
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        noPlayListView.frame = CGRect(x: 0, y: 0, width: 150, height: 175)
        noPlayListView.center = view.center
    }
    
    private func updateUI(){
        if items.count == 0{
            noPlayListView.isHidden = false
        }else{
            
        }
    }
}

extension LibraryPlayListViewController: actionLabelViewDelegate{
    func actionLabelViewDidTapButton(_ actionLabelView: ActionLabelView) {
        let alert = UIAlertController(title: "New Playlist", message: "Add new Playlist", preferredStyle: .alert)
        alert.addTextField { (textField) in
            textField.placeholder = "Create new PlayList"
        }
        alert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
        alert.addAction(UIAlertAction(title: "Create", style: .default, handler: { (_) in
            guard let textfield = alert.textFields?.first , let text = textfield.text, !text.trimmingCharacters(in: .whitespaces).isEmpty else{
                return
            }
            APICaller.shared.createPlayList(with: text) { (sucess) in
                if sucess{
                   //refresh play list UI
                }else{
                    print("Failed to create a play list")
                }
            }
        }))
        present(alert, animated: true, completion: nil)
    }
}
