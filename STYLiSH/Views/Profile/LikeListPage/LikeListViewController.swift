//
//  LikeListViewController.swift
//  STYLiSH
//
//  Created by TingFeng Shen on 2023/9/2.
//  Copyright © 2023 AppWorks School. All rights reserved.
//

import UIKit
import Kingfisher

class LikeListViewController: UIViewController,UITableViewDataSource,UITableViewDelegate {


    
    @IBOutlet weak var likeListTableView: UITableView!
    
    var favoriteProducts: [[String: Any]] = []

    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        


        if let savedFavorites = UserDefaults.standard.array(forKey: "favoriteProducts") as? [[String: Any]] {
                favoriteProducts = savedFavorites
            }

        likeListTableView.dataSource = self
        likeListTableView.delegate = self
      

    }
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        
        self.navigationController?.popToRootViewController(animated: false)
        
    }
 

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        //拿到本地的儲存資料顯示數量
        return favoriteProducts.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = likeListTableView.dequeueReusableCell(withIdentifier: "LikeListTableViewCell", for: indexPath) as? LikeListTableViewCell else { return LikeListTableViewCell() }
        // 要拿到本地的儲存資料顯示
        
        let product = favoriteProducts[indexPath.row]

            if let title = product["title"] as? String {
                cell.likeTitle.text = title
            }

            if let price = product["price"] as? Double {
                cell.likePrice.text = "$\(price)"
            }

            if let imageURL = product["imageURL"] as? String {
                
                cell.likeImage.loadImage(imageURL)
            }

        
        return cell
    }
    
}

