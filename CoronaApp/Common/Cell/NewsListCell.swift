//
//  NewsListCell.swift
//  CoronaApp
//
//  Created by andrew on 2020/02/27.
//  Copyright © 2020 Yunjjang. All rights reserved.
//

import UIKit

class NewsListCell: UITableViewCell {

    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var subscriptLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

    func display(with model: NewsPresentModel) {
        titleLabel.text = model.title
        subscriptLabel.text = model.description
    }
    
}
