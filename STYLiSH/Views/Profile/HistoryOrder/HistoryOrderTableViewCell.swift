//
//  HistoryOrderTableViewCell.swift
//  STYLiSH
//
//  Created by jeff on 2023/9/4.
//  Copyright © 2023 AppWorks School. All rights reserved.
//

import Foundation

class HistoryOrderTableViewCell: UITableViewCell {
    
    @IBOutlet weak var borderView: UIView! {
        didSet {
            borderView.backgroundColor = .clear
            borderView.lkBorderColor = .black
            borderView.lkBorderWidth = 1
            borderView.lkCornerRadius = 5
        }
    }
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var orderIDLabel: UILabel!
    @IBOutlet weak var orderSumLabel: UILabel!
 
    override class func awakeFromNib() {
        
    }
}
