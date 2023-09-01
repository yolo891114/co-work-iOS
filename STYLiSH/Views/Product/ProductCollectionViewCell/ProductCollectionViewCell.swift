//
//  ProductCollectionViewCell.swift
//  STYLiSH
//
//  Created by WU CHIH WEI on 2019/2/15.
//  Copyright © 2019 AppWorks School. All rights reserved.
//

import UIKit

class ProductCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var productImg: UIImageView!

    @IBOutlet weak var productTitleLbl: UILabel!

    @IBOutlet weak var productPriceLbl: UILabel!

//    @IBOutlet weak var likeButton: UIButton!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
    }
    
//    func setLikeButton() {
//        likeButton.setImage(UIImage(systemName: "heart"), for: .normal)
//        likeButton.setImage(UIImage(systemName: "heart.fill"), for: .selected)
//        likeButton.tintColor = .systemPink
//    }

    func layoutCell(image: String, title: String, price: Int) {
        productImg.loadImage(image, placeHolder: .asset(.Image_Placeholder))
        productTitleLbl.text = title
        productPriceLbl.text = String(price)
    }
    
    
    @IBAction func likeButtonAction(_ sender: Any) {
    }
}
