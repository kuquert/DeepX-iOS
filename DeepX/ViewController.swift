//
//  ViewController.swift
//  DeepX
//
//  Created by Marcus Vinicius Kuquert on 27/05/17.
//  Copyright © 2017 Marcus Vinicius Kuquert. All rights reserved.
//

import UIKit
import Alamofire

class ViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    
    private var user = "BearchInc"
    
    typealias CountTuple = (langCount: Int, repos: [Repo])
    
    fileprivate var languages = [String : CountTuple]()
    
    fileprivate var keyList: [String] {
        get { return [String](languages.keys) }
    }
    
    let titleField = UITextField(frame: CGRect(x: 0, y: 0, width: 200, height: 22))
    
    func reloadWithUser(user _user: String) {
        self.user = _user
        self.languages.removeAll()
        
        titleField.text = _user
        
        RestUtil.allReposForUser(user: _user){ repos in
//            repos?.forEach( {
                RestUtil.languagesForRepo(repo: (repos?[0])!, ofUser: _user, response: { (dict, repo) in
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
//            })
        }
    }
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        tableView.delegate = self
        tableView.dataSource = self
        
        titleField.delegate = self
        titleField.font = UIFont.boldSystemFont(ofSize: 19)
        titleField.textAlignment = .center
        titleField.clearButtonMode = .whileEditing
        navigationItem.titleView = titleField
        
        reloadWithUser(user: user)
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

extension ViewController: UITextFieldDelegate {
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        let user = textField.text ?? ""
        reloadWithUser(user: user)
        textField.resignFirstResponder()
        return false
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
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell") as? LanguageTableViewCell
        let row = indexPath.row
        let key = keyList[row]
        
        if let image = UIImage(named: key.lowercased() + ".pdf") {
            cell?.iconImageView?.image = image
        } else {
            cell?.iconImageView?.image = UIImage(named: "default.pdf")
        }
        
        cell?.iconImageView?.contentMode = .scaleAspectFit
        cell?.titleLabel?.text =  "\(key)"
        cell?.subtitleLabel?.text = " Lines: \((languages[key]?.langCount)!)"
        cell?.descriptionLabel?.text = "Repos: \((languages[key]?.repos.count)!)"
        
        return cell ?? UITableViewCell()
    }
}
