//
//  ViewController.swift
//  DeepX
//
//  Created by Marcus Vinicius Kuquert on 27/05/17.
//  Copyright © 2017 Marcus Vinicius Kuquert. All rights reserved.
//

import UIKit
import Alamofire
import RealmSwift

typealias CountTuple = (linesCount: Int, repos: [Repo])
typealias AgregatedLanguages = [String : CountTuple]

class ViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    
    private var activityIndicator: UIActivityIndicatorView!
    private var refreshControl: UIRefreshControl!
    private var titleField: UITextField!
    
    private var isReachable = false
    private let reachabilityManager = Alamofire.NetworkReachabilityManager(host: "https://api.github.com")
    
    fileprivate var user = "BearchInc"
    fileprivate var languages = AgregatedLanguages()
    
    fileprivate var keysList: [String] {
        get {
            let sorted = languages.sorted(by: { $0.1.linesCount > $1.1.linesCount })
            return sorted.map({ return $0.key })
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        listenForReachability()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        refreshControl = UIRefreshControl()
        titleField = UITextField(frame: CGRect(x: 0, y: 0, width: 200, height: 22))
        activityIndicator = UIActivityIndicatorView(frame: CGRect(x: 0, y: 0, width: 20, height: 20))
        
        titleField.delegate = self
        titleField.font = UIFont.boldSystemFont(ofSize: 19)
        titleField.textAlignment = .center
        titleField.clearButtonMode = .whileEditing
        titleField.text = user
        
        refreshControl.attributedTitle = NSAttributedString(string: "Pull to refresh")
        refreshControl.addTarget(self, action: #selector(tableViewRefresh), for: .valueChanged)
        
        let barButton = UIBarButtonItem(customView: activityIndicator)
        navigationItem.setRightBarButton(barButton, animated: true)
        navigationItem.titleView = titleField
        
        tableView?.delegate = self
        tableView?.dataSource = self
        tableView?.addSubview(refreshControl)
        tableView?.tableFooterView = UIView()
        
        activityIndicator.color = .red
        
        reloadData()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let viewController = segue.destination as? DetailViewController,
            let repos = sender as? ([Repo], String) {
            
            viewController.repos = repos.0
            viewController.title = repos.1
        }
    }
    
    private func loadOffline() {
        if let l = RealmUtil.fetchReposLocally(user: self.user) {
            self.activityIndicator.stopAnimating()
            self.refreshControl.endRefreshing()
            self.languages = l
            self.tableView.reloadData()
        } else {
            self.activityIndicator.stopAnimating()
            self.languages.removeAll()
            self.refreshControl.endRefreshing()
            self.tableView.reloadData()
        }
        
    }
    
    private func loadOnlineAndSave() {
        
        self.activityIndicator.startAnimating()
        
        RealmUtil.saveReposLocally(user: self.user) { resp in
            switch resp {
            case .success( _):
                self.loadOffline()
                break
            case .failure( _):
                //Show alert here
                self.loadOffline()
//                self.activityIndicator.stopAnimating()
//                self.languages.removeAll()
//                self.tableView.reloadData()
                break
            }
        }
    }
    
    private func listenForReachability() {
        self.reachabilityManager?.listener = { status in
            print("Network Status Changed: \(status)")
            switch status {
            case .notReachable:
                self.isReachable = false
                break
            case .reachable(_), .unknown:
                self.isReachable = true
                break
            }
        }
        
        self.reachabilityManager?.startListening()
    }
    
    fileprivate func reloadData() {
        isReachable ? loadOnlineAndSave() : loadOffline()
    }
    
    func tableViewRefresh(sender: UIRefreshControl?) {
        reloadData()
    }
    
}

//MARK: UITextFieldDelegate
extension ViewController: UITextFieldDelegate {
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        
        user = textField.text ?? ""
        reloadData()
        return false
    }
}

//MARK: UITableViewDelegate
extension ViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        let key = keysList[indexPath.row]
        
        if let repos = languages[key]?.repos {
            self.performSegue(withIdentifier: "showDetail", sender: (repos, key))
        }
    }
    
}

//MARK: UITableViewDataSource
extension ViewController: UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        if keysList.count > 1 {
            self.tableView.separatorStyle = .singleLine
            return 1
            
        } else {
            let messageLabel = UILabel(frame: self.view.frame)
            messageLabel.text = "Nenhuma linguagem encontrada para este usuário"
            messageLabel.textColor = UIColor.black
            messageLabel.numberOfLines = 0
            messageLabel.textAlignment = .center
            messageLabel.font = UIFont(name: "Helvetica-Bold", size: 36)
            messageLabel.sizeToFit()
            
            self.tableView.backgroundView = messageLabel
            self.tableView.separatorStyle = .none
        }
        return 0
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return keysList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell") as? LanguageTableViewCell
        
        let row = indexPath.row
        let key = keysList[row]
        let item = languages[key]
        let image = UIImage(named: key.lowercased() + ".pdf") ?? UIImage(named: "default.pdf")
        
        cell?.titleLabel?.text =  "\(key)"
        cell?.subtitleLabel?.text = "Repos: \((item?.repos.count) ?? -1)"
        cell?.descriptionLabel?.text = "Lines: \((item?.linesCount ?? -1).formattedWithSeparator)"
        cell?.iconImageView?.contentMode = .scaleAspectFit
        cell?.iconImageView?.image = image
        
        return cell ?? UITableViewCell()
    }
}
