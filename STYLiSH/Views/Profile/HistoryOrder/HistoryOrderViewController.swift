//
//  HistoryOrderViewController.swift
//  STYLiSH
//
//  Created by jeff on 2023/9/3.
//  Copyright © 2023 AppWorks School. All rights reserved.
//

import Foundation

class HistoryOrderViewController: UIViewController {
    
    @IBOutlet weak var historyTableView: UITableView!
    
    override func viewDidLoad() {
        
        historyTableView.delegate = self
        historyTableView.dataSource = self
        
        
    }
}

extension HistoryOrderViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = historyTableView.dequeueReusableCell(withIdentifier: "HistoryOrderTableViewCell", for: indexPath) as? HistoryOrderTableViewCell else { return UITableViewCell() }
        
//        cell.dateLabel.text
        
        return cell
        
    }
    
    
}
