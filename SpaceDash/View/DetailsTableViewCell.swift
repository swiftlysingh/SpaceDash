//
//  DetailsTableViewCell.swift
//  SpaceDash
//
//  Created by Pushpinder Pal Singh on 03/08/20.
//  Copyright © 2020 Pushpinder Pal Singh. All rights reserved.
//

import UIKit

class DetailsTableViewCell: UITableViewCell {

    @IBOutlet weak var title: UILabel!
    @IBOutlet weak var subTitle: UILabel!
    @IBOutlet weak var details: UILabel!
    @IBOutlet weak var photo: UIImageView!
    @IBOutlet weak var isActive: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        isActive.layer.cornerRadius = 5
        isActive.layer.masksToBounds = true
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
