//
//  SettingsViewController.swift
//  Spotify
//
//  Created by user212878 on 6/19/22.
//

import UIKit

class SettingsViewController: UIViewController, UITableViewDelegate, UITableViewDataSource{
  
    let arrSettingsItem = ["Settings1","Settings2","Settings3","Settings4","Settings5"]
    private var sections = [Section]()
    let tableView: UITableView = {
        let tableView = UITableView(frame: .zero, style: .grouped)
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        return tableView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
       
        title = "Settings"
        view.backgroundColor = .systemBackground
        view.addSubview(tableView)
        configureModel()
        tableView.delegate = self
        tableView.dataSource = self
        
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        tableView.frame = view.bounds
    }
    func configureModel(){
        sections.append(Section(title: "Profile", option: [Option(title: "View your profile", handler: {[weak self]  in
            let vc = ProfileViewController()
            vc.title = "Profile"
            self?.navigationController?.pushViewController(vc, animated: true)
        })]))
        sections.append(Section(title: "Account", option: [Option(title: "Sign Out", handler: {[weak self]  in
            self?.signOutTapped()
        })]))
    }
     func signOutTapped(){
        
        let alert = UIAlertController(title: "Sign Out!!!", message: "Do you want to signout?", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Ok", style: .default, handler: { (_) in
            AuthManger.shared.signOut { [weak self] (sucess) in
                if sucess{
                    DispatchQueue.main.async {
                        let navVC = UINavigationController(rootViewController: WelcomeViewController())
                        navVC.navigationBar.prefersLargeTitles = true
                        navVC.viewControllers.first?.navigationItem.largeTitleDisplayMode = .always
                        navVC.modalPresentationStyle = .fullScreen
                        self?.present(navVC, animated: true, completion: {
                            self?.navigationController?.popToRootViewController(animated: false)
                        })
                    }
                }
            }
        }))
        alert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
        present(alert, animated: true, completion: nil)
        
    }
    
}
extension SettingsViewController{
    func numberOfSections(in tableView: UITableView) -> Int {
        return sections.count
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return sections[section].option.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let model = sections[indexPath.section].option[indexPath.row]
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        cell.textLabel?.text  = model.title
        return cell
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let model = sections[indexPath.section]
        model.option[indexPath.row].handler()
    }
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        let model = sections[section]
        return model.title
    }
}

