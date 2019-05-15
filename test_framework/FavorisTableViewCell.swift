//
//  FavorisTableViewCell.swift
//  test_framework
//
//  Created by Viviane on 15/05/2019.
//  Copyright © 2019 m2sar. All rights reserved.
//

import UIKit

class FavorisTableViewCell: UITableViewCell {

    @IBOutlet weak var img: UIImageView!
    @IBOutlet weak var ville: UILabel!
    @IBOutlet weak var temp: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
