//
//  BannerView.swift
//  STYLiSH
//
//  Created by jeff on 2023/9/1.
//  Copyright © 2023 AppWorks School. All rights reserved.
//

import Foundation
import UIKit

class BannerView: UIView {
    
    let bannerView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor.hexStringToUIColor(hex: "6B6B6B")
        view.alpha = 0.6
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    let bannerText: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.textColor = .white
        label.textAlignment = .center
        label.text = "全\n館\n滿\n4\n0\n0\n0\n免\n運\n ！"
        label.translatesAutoresizingMaskIntoConstraints = false
        
        return label
    }()
    
    func setupUI() {
        
        addSubview(bannerView)
        bannerView.addSubview(bannerText)
        
        NSLayoutConstraint.activate([
            bannerView.trailingAnchor.constraint(equalTo: trailingAnchor),
            bannerView.widthAnchor.constraint(equalToConstant: 40),
            bannerView.heightAnchor.constraint(equalToConstant: 250),
            
            bannerText.centerXAnchor.constraint(equalTo: bannerView.centerXAnchor),
            bannerText.centerYAnchor.constraint(equalTo: bannerView.centerYAnchor)
            
        ])
    }
    
    
}
