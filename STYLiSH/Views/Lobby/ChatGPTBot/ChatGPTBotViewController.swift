//
//  ChatGPTBotViewController.swift
//  STYLiSH
//
//  Created by jeff on 2023/9/5.
//  Copyright © 2023 AppWorks School. All rights reserved.
//

import Foundation
import UIKit

class ChatGPTBotViewController: UIViewController {
    
    @IBOutlet weak var chatgptTableView: UITableView!
    
    override func viewDidLoad() {
        chatgptTableView.delegate = self
        chatgptTableView.dataSource = self
    }
    
    
}

extension ChatGPTBotViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let clientCell = chatgptTableView.dequeueReusableCell(withIdentifier: "ChatGPTBotClientCell", for: indexPath) as? ChatGPTBotClientCell else { return UITableViewCell() }
        guard let serverCell = chatgptTableView.dequeueReusableCell(withIdentifier: "ChatGPTBotServerCell", for: indexPath) as? ChatGPTBotServerCell else { return UITableViewCell() }
        
        if indexPath.row % 2 == 0 {
            return clientCell
        } else {
            return serverCell
        }
    }
    

}
