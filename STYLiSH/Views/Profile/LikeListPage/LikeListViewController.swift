//
//  LikeListViewController.swift
//  STYLiSH
//
//  Created by TingFeng Shen on 2023/9/2.
//  Copyright © 2023 AppWorks School. All rights reserved.
//

import UIKit

class LikeListViewController: UIViewController,UITableViewDataSource,UITableViewDelegate {


    
    @IBOutlet weak var likeListTableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        likeListTableView.dataSource = self
        likeListTableView.delegate = self
      

    }
 

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        //拿到本地的儲存資料顯示數量
        return 3
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = likeListTableView.dequeueReusableCell(withIdentifier: "LikeListTableViewCell", for: indexPath) as? LikeListTableViewCell else { return LikeListTableViewCell() }
        // 要拿到本地的儲存資料顯示
        cell.likeTitle.text = "123"
        cell.likePrice.text = "$ 9999"
        
        return cell
    }
    
}

