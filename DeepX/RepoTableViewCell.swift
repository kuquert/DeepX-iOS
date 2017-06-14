//
//  RepoTableViewCell.swift
//  DeepX
//
//  Created by Marcus Vinicius Kuquert on 28/05/17.
//  Copyright © 2017 Marcus Vinicius Kuquert. All rights reserved.
//

import UIKit

class RepoTableViewCell: UITableViewCell {

    @IBOutlet weak var detailTitleLabel: UILabel!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var subtitleLabel: UILabel!
    @IBOutlet weak var detailLabel: UILabel!
    @IBOutlet weak var issuesImageView: UIImageView!
    
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
        
        self.titleLabel.text = "\(repo.name ?? "???")"
        self.detailTitleLabel.text = "\(repo.open_issues)"
        self.subtitleLabel.text = "Updated on \(formatter.string(from: repo.updated_at ?? Date()))"
        self.detailLabel.text = "Created on \(formatter.string(from: repo.created_at ?? Date()))"
        self.issuesImageView.image? = (self.issuesImageView.image?.withRenderingMode(.alwaysTemplate))!
        self.issuesImageView.tintColor = UIColor.red
        
    }

}
