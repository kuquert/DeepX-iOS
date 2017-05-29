//
//  ViewController.swift
//  DeepX
//
//  Created by Marcus Vinicius Kuquert on 27/05/17.
//  Copyright © 2017 Marcus Vinicius Kuquert. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    
    private static let user = "BearchInc"
    
    typealias CountTuple = (langCount: Int, repos: [Repo])
    
    fileprivate var languages = [String : CountTuple]()
    
    fileprivate var keyList: [String] {
        get { return [String](languages.keys) }
    }
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        tableView.delegate = self
        tableView.dataSource = self
        
        title = ViewController.user
        
        RestUtil.allReposForUser(user: ViewController.user){ repos in
            
            repos.forEach( {
                RestUtil.languagesForRepo(repo: $0, ofUser: ViewController.user, response: { (dict, repo) in
                    for (key, value) in dict {
                        
                        if let item = self.languages[key] {
                            
                            let lg = item.langCount + value
                            var repos = item.repos
                            repos.append(repo)
                            self.languages[key]! = (lg, repos)
                            
                        } else {
                            self.languages[key] = (value, [repo])
                        }
                        
                        self.tableView.reloadData()
                    }
                    print(self.languages)
                })
            })
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let viewController = segue.destination as? DetailViewController,
            let repos = sender as? ([Repo], String) {
            
            viewController.repos = repos.0
            viewController.title = repos.1
        }
    }
}

extension ViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let key = keyList[indexPath.row]
        
        if let repos = languages[key]?.repos {
            self.performSegue(withIdentifier: "showDetail", sender: (repos, key))
        }
        
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
}
extension ViewController: UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return keyList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell")
        let row = indexPath.row
        let key = keyList[row]
        cell?.textLabel?.text =  "\(key) with: \((languages[key]?.langCount)!) lines and \((languages[key]?.repos.count)!) repos"
        
        return cell ?? UITableViewCell()
    }
}
