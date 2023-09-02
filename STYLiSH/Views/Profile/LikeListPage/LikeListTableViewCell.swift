//
//  LikeListTableViewCell.swift
//  STYLiSH
//
//  Created by TingFeng Shen on 2023/9/2.
//  Copyright © 2023 AppWorks School. All rights reserved.
//

import UIKit

class LikeListTableViewCell: UITableViewCell {

    @IBOutlet weak var likeImage: UIImageView!
    
    @IBOutlet weak var likeTitle: UILabel!
    
    @IBOutlet weak var likePrice: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

    }

}
