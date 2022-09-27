//
//  ProfileViewController.swift
//  Spotify
//
//  Created by user212878 on 6/19/22.
//

import UIKit
class ProfileViewController: UIViewController {
    
    let tableView: UITableView = {
        let tableView = UITableView(frame: .zero, style: .grouped)
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        
        return tableView
    }()
    var models = [String]()
    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(tableView)
        view.backgroundColor = .systemBackground
        title = "Profile"
        navigationItem.largeTitleDisplayMode = .never
        tableView.delegate = self
        tableView.dataSource = self
        fetchProfile()
       // showErrorLabel()
        
    }
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        tableView.frame = view.bounds
    }
    func fetchProfile(){
        APICaller.shared.getCurrentUserProfile { (userDetails) in
            DispatchQueue.main.async {
                switch userDetails{
                
                case .success(let userDetails):
                    self.upadateUIWithData(with: userDetails)
                    break
                case .failure(_):
                    self.showErrorLabel()
                    break
                }
            }
        }
    }
    func upadateUIWithData(with model: UserProfile){
        models.append("Name : \(model.display_name)")
        models.append("Country : \(model.country)")
        models.append("User Id : \(model.id)")
        models.append("Product : \(model.product)")
        createTableHeader(with : model.images.first?.url ?? "")
        tableView.reloadData()
        
    }
    func createTableHeader(with string: String)
    {
        let headerView = UIView(frame: CGRect(x: 0, y: 80.0, width: view.width, height: view.height/4))
        //headerView.bottomAnchor.constraint(equalTo: tableView.topAnchor, constant: 10.0)
         let imageSize: CGFloat = headerView.height/2
       // let imageSize: CGFloat = 20.0
        let imageView = UIImageView(frame: CGRect(x: 0, y: 0, width: imageSize, height: imageSize))
        headerView.addSubview(imageView)
        imageView.center = headerView.center
        imageView.contentMode = .scaleAspectFit
        imageView.layer.masksToBounds = true
        imageView.layer.cornerRadius = imageSize / 2
        tableView.tableHeaderView = headerView
        imageView.loadFrom(URLAddress: string)
        view.addSubview(headerView)
       // imageView.sd_setImage(with: urlString, completed: nil)
    }
     func showErrorLabel(){
      /*  let alert = UIAlertController(title: "No Profile found", message: " ", preferredStyle: .alert)
        let action = UIAlertAction(title: "OK", style: .cancel)
        alert.addAction(action)
        self.present(alert, animated: true, completion: nil)*/
        let label = UILabel(frame: .zero)
        label.text = "No Profile Found"
        label.center = view.center
        label.sizeToFit()
        view.addSubview(label)
        
    }

}

//MARK: - Table View Delegates & Data Source
extension ProfileViewController: UITableViewDelegate, UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return models.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        cell.textLabel?.text =  models[indexPath.row]
        return cell
    }
    
    
}


