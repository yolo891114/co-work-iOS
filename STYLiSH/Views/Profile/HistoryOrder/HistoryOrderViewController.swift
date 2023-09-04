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
    
    var orderModel :[OrderModel]?
    
    override func viewDidLoad() {
        
        historyTableView.delegate = self
        historyTableView.dataSource = self
        
        getOrderApi()
        
        

    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        
        self.navigationController?.popToRootViewController(animated: false)
    }


}

extension HistoryOrderViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return orderModel?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = historyTableView.dequeueReusableCell(withIdentifier: "HistoryOrderTableViewCell", for: indexPath) as? HistoryOrderTableViewCell else { return UITableViewCell() }
        if let orderDate = orderModel?[indexPath.row].checkoutDate,
           let orderNumber = orderModel?[indexPath.row].orderNumber,
           let orderPrice = orderModel?[indexPath.row].totalPrice {
            cell.dateLabel.text = orderDate
            cell.orderIDLabel.text = "訂單編號：\(String(describing: orderNumber))"
            cell.orderSumLabel.text = "消費金額：\(String(describing: orderPrice))"
        }
        
        
        return cell
        
    }
    
    
}

extension HistoryOrderViewController {
    
    func getOrderApi() {
        
        if let url = URL(string: "http://54.66.20.75:8080/api/1.0/user/order?userID=\(SingletonVar.uuid!)") {
            var request = URLRequest(url: url)
            
            request.setValue("application/json", forHTTPHeaderField: "Content-Type")
            request.httpMethod = "GET"
            
            
            URLSession.shared.dataTask(with: request) { data, response, error in
                
                if let data = data {
                    do {
                        self.orderModel = try JSONDecoder().decode([OrderModel].self, from: data)
                        DispatchQueue.main.async {
                            self.historyTableView.reloadData()
                        }
                        print("Successfully decoded order: \(self.orderModel)")
                    } catch {
                        print("Failed to decode JSON: \(error)")
                    }
                }
                if let httpResponse = response as? HTTPURLResponse {
                    print("HTTP Status Code: \(httpResponse.statusCode)")
                }
                if let error = error {
                    print("Error when get order API:\(error)")
                    
                }
            }.resume()
        }
    }
}
