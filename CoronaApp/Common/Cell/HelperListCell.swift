//
//  HelperCell.swift
//  CoronaApp
//
//  Created by andrew on 2020/02/28.
//  Copyright © 2020 Yunjjang. All rights reserved.
//

import UIKit

class HelperListCell: UITableViewCell {

    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var subscriptLabel: UILabel!
    @IBOutlet weak var nextImageview: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func display(with model: Helper) {
        titleLabel.text = model.reporter
        subscriptLabel.text = model.subscript_text
        
        
        guard let urlString = model.origin_link,
            let _ = URL(string: urlString) else {
                return
        }
        nextImageview.isHidden = false
    }

}
