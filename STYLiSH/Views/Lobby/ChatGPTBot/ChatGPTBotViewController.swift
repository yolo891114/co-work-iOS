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
    
    @IBOutlet weak var chatTableView: UITableView!
    
    @IBOutlet weak var chatTextField: UITextField!
    
    @IBOutlet weak var sendButton: UIButton!

    @IBOutlet weak var cameraButton: UIButton!
    
    @IBAction func cameraButtonTapped(_ sender: UIButton) {
        
        let imagePickerController = UIImagePickerController()
        imagePickerController.sourceType = .photoLibrary
        imagePickerController.delegate = self
        present(imagePickerController, animated: true, completion: nil)
        
    }
    var selectPhoto = false // 判定是否有選擇照片
    
    var messages: [String] = []
    
    var postChatData: ChatRequest?
    
    override func viewDidLoad() {
        chatTableView.delegate = self
        chatTableView.dataSource = self
        
        navigationItem.title = "個人化推薦"
        navigationItem.titleView?.tintColor = .B1
        
        sendButton.addTarget(self, action: #selector(sendButtonTapped), for: .touchUpInside)
        
        chatTableView.estimatedRowHeight = 60
        chatTableView.rowHeight = UITableView.automaticDimension
    }
    
    @objc func sendButtonTapped() {
        
        if let text = chatTextField.text, !text.isEmpty {
            messages.append(text)
            
            postChatData = ChatRequest(tag: text)
            
            
            // 更新表格
            let indexPath = IndexPath(row: messages.count - 1, section: 0)
            chatTableView.insertRows(at: [indexPath], with: .automatic)
            
            postChatApi(indexPath: indexPath)
            //            // 滾動到新的訊息
            chatTableView.scrollToRow(at: indexPath, at: .bottom, animated: true)
            //
            // 清空輸入框
            chatTextField.text = ""
        }
    }
    
    
}

extension ChatGPTBotViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return messages.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let clientCell = chatTableView.dequeueReusableCell(withIdentifier: "ChatGPTBotClientCell", for: indexPath) as? ChatGPTBotClientCell else { return UITableViewCell() }
        guard let serverCell = chatTableView.dequeueReusableCell(withIdentifier: "ChatGPTBotServerCell", for: indexPath) as? ChatGPTBotServerCell else { return UITableViewCell() }
        
        if indexPath.row % 2 == 0 {
            clientCell.requestLabel.text = messages[indexPath.row]
            return clientCell
        } else {
            serverCell.responseLabel.text = messages[indexPath.row]
            return serverCell
        }
    }
    
    
}

extension ChatGPTBotViewController {
    
    func postChatApi(indexPath: IndexPath) {
        LKProgressHUD.show()
        sendButton.isEnabled = false
        if let url = URL(string: "http://54.66.20.75:8080/api/1.0/recommendation/chatbox") {
            var request = URLRequest(url: url)
            
            request.setValue("application/json", forHTTPHeaderField: "Content-Type")
            request.httpMethod = "POST"
            
            
            request.httpBody = try? JSONEncoder().encode(postChatData)
            
            URLSession.shared.dataTask(with: request) { data, response, error in
                LKProgressHUD.dismiss()
                
                if let data = data {
                    let content = String(data: data, encoding: .utf8)
                    print("Raw Data Received:")
                    print(content ?? "No data")
                    do {
                        let decoder = JSONDecoder()
                        let chatResponse = try decoder.decode(ChatResponse.self, from: data)
                        
                        
                        DispatchQueue.main.async {
                            self.sendButton.isEnabled = true
                            self.messages.append(chatResponse.chatResponse)
                            let newIndexPath = IndexPath(row: self.messages.count - 1, section: 0)
                            self.chatTableView.insertRows(at: [newIndexPath], with: .automatic) // 插入新的 cell
                        }
                        
                        print("Chat Response: \(chatResponse.chatResponse)")
                        print("Product ID: \(chatResponse.productId)")
                        
                    } catch let decodeError {
                        print("Decoding error: \(decodeError)")
                    }
                }
                if let httpResponse = response as? HTTPURLResponse {
                    print("HTTP Status Code: \(httpResponse.statusCode)")
                }
                if let error = error {
                    print("Error when post checkout API:\(error)")
                    
                }
            }.resume()
        }
    }
}


extension ChatGPTBotViewController: UIImagePickerControllerDelegate,UINavigationControllerDelegate{
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        
        selectPhoto = true
        if let image = info[.originalImage] as? UIImage {
            postImageApi(image: image)
        }
        
        
        
        dismiss(animated: true, completion: nil)
        
    }
    
    
    func postImageApi(image: UIImage) {
        LKProgressHUD.show()
        let url = URL(string: "http://54.66.20.75:8080/api/1.0/recommendation/smart_image")
        var request = URLRequest(url: url!)
        request.httpMethod = "POST"

        let boundary = "Boundary-\(UUID().uuidString)"
        request.setValue("multipart/form-data; boundary=\(boundary)", forHTTPHeaderField: "Content-Type")

        var body = Data()
        
        if let imageData = image.jpegData(compressionQuality: 1) {
            body.append("--\(boundary)\r\n")
            body.append("Content-Disposition: form-data; name=\"image\"; filename=\"image.jpg\"\r\n")
            body.append("Content-Type: image/jpeg\r\n\r\n")
            body.append(imageData)
            body.append("\r\n")
        }
        
        body.append("--\(boundary)--\r\n")

        request.httpBody = body

        URLSession.shared.dataTask(with: request) { (data, response, error) in
            LKProgressHUD.dismiss()
            if let data = data {
                let content = String(data: data, encoding: .utf8)
                print("圖片分析結果:")
                print(content ?? "No data")
                do {
                    let decoder = JSONDecoder()
                    let chatResponse = try decoder.decode(ChatResponse.self, from: data)
                    
                    print("Chat Response: \(chatResponse.chatResponse)")
                    print("Product ID: \(chatResponse.productId)")
                    
                } catch let decodeError {
                    print("Decoding error: \(decodeError)")
                }
            }
            
            if let httpResponse = response as? HTTPURLResponse {
                print("HTTP Status Code: \(httpResponse.statusCode)")
            }
            if let error = error {
                print("Error when post image API:\(error)")
                
            }
        }.resume()
    }

        
}
