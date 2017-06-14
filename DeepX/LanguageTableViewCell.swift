//
//  LanguageTableViewCell.swift
//  DeepX
//
//  Created by Marcus Vinicius Kuquert on 10/06/17.
//  Copyright © 2017 Marcus Vinicius Kuquert. All rights reserved.
//

import UIKit

class LanguageTableViewCell: UITableViewCell {

    @IBOutlet weak var iconImageView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var subtitleLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
}
