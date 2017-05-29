//
//  RepoTableViewCell.swift
//  DeepX
//
//  Created by Marcus Vinicius Kuquert on 28/05/17.
//  Copyright © 2017 Marcus Vinicius Kuquert. All rights reserved.
//

import UIKit

class RepoTableViewCell: UITableViewCell {

    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var issueLabel: UILabel!
    @IBOutlet weak var createdAtLabel: UILabel!
    @IBOutlet weak var updatedAtLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        // Configure the view for the selected state
    }
    
    func setRepo(_ repo: Repo) {
        
        let formatter = DateFormatter()
        formatter.dateStyle = .medium
        
        self.nameLabel.text = "\(repo.name ?? "???")"
        self.issueLabel.text = "\(repo.open_issues ?? -1)"
        self.updatedAtLabel.text = "Updated on \(formatter.string(from: repo.updated_at!))"
        self.createdAtLabel.text = "Created on \(formatter.string(from: repo.created_at!))"
    }

}
