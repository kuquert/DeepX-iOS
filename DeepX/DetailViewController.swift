//
//  DetailViewController.swift
//  DeepX
//
//  Created by Marcus Vinicius Kuquert on 28/05/17.
//  Copyright © 2017 Marcus Vinicius Kuquert. All rights reserved.
//

import UIKit
import SafariServices

class DetailViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    
    var repos = [Repo]()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        tableView.delegate = self
        tableView.dataSource = self
        //TODO verify forced unwrapping
        repos = repos.sorted(by: { return $0.0.open_issues! > $0.1.open_issues! })
        
        tableView.reloadData()
    }
}

extension DetailViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        //TODO verify forced unwrapping
        let repo = repos[indexPath.row]
        let svc = SFSafariViewController(url: URL(string: repo.html_url!)!)
        navigationController?.present(svc, animated: true, completion: nil)
    }
    
}

extension DetailViewController: UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return repos.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let repo = repos[indexPath.row]
        
        let cell = self.tableView.dequeueReusableCell(withIdentifier: "repoCell") as? RepoTableViewCell
        cell?.setRepo(repo)
        
        return cell ?? UITableViewCell()
    }
}
