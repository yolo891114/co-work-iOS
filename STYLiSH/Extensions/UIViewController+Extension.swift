//
//  UIViewController+Extension.swift
//  STYLiSH
//
//  Created by jeff on 2023/9/2.
//  Copyright © 2023 AppWorks School. All rights reserved.
//

import Foundation
import UIKit

extension UIViewController {
    func addBannerView() -> BannerView {
        let bannerView = BannerView()
        view.addSubview(bannerView)
        bannerView.translatesAutoresizingMaskIntoConstraints = false

        NSLayoutConstraint.activate([
            bannerView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            bannerView.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            bannerView.widthAnchor.constraint(equalToConstant: 40),
            bannerView.heightAnchor.constraint(equalToConstant: 250)
        ])

        bannerView.setupUI()
        return bannerView
    }
}

