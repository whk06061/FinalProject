//
//  MovieTableViewCell.swift
//  Project2
//
//  Created by Mac SWU on 2020/07/04.
//  Copyright © 2020 Mac SWU. All rights reserved.
//

import UIKit

class MovieTableViewCell: UITableViewCell {
    
    @IBOutlet var labelTitle: UILabel!
    @IBOutlet var labelReviewTitle: UILabel!
    @IBOutlet var labelPlace: UILabel!
    @IBOutlet var labelDate: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
