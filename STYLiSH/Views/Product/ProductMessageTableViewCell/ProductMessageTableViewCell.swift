//
//  ProductMessageTableViewCell.swift
//  STYLiSH
//
//  Created by TingFeng Shen on 2023/9/3.
//  Copyright © 2023 AppWorks School. All rights reserved.
//

import UIKit
// 繼承 ProductBasicCell 也是繼承 UITableViewCell ，裡面有一些 function，其他檔案多半是看到使用 layoutcell 這個 func 去做帶值去 UI 的動作。
// 但是這邊留言區不會用到 product 資訊，所以也有可能跟本不用繼承 ProductBasicCell。
class ProductMessageTableViewCell: ProductBasicCell {

    
    @IBOutlet weak var messgeLabel: UILabel!

    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
//        messgeLabel.layer.borderColor = .init(red: 0, green: 0, blue: 0, alpha: 1)
//        messgeLabel.layer.borderWidth = 1
//        messgeLabel.layer.cornerRadius = 10
//        messgeLabel.layer.masksToBounds = true
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
