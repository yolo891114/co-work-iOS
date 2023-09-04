//
//  SingletonVar.swift
//  STYLiSH
//
//  Created by TingFeng Shen on 2023/9/4.
//  Copyright © 2023 AppWorks School. All rights reserved.
//

import Foundation

class SingletonVar {
    static let uuid = UserDefaults.standard.string(forKey: "uuid")
    static let group = UserDefaults.standard.string(forKey: "userGroup")
    static var timeStamp: String {
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
        return dateFormatter.string(from: Date())
        
    }
    
//    func postApi() {
//        if let url = URL(string: "http://54.66.20.75:8080/api/1.0/review/submit"){
//            var request = URLRequest(url: url)
//            // httpMethod 設定
//            request.setValue("application/json", forHTTPHeaderField: "Content-Type")
//            request.httpMethod = "POST"
//            // 將內容加入 httpBody
//            request.httpBody = try? JSONEncoder().encode(postData)
//
//            //  URLSession 本身還是必須執行，為主要上傳功能。
//            URLSession.shared.dataTask(with: request) { data, response, error in
//
//            }.resume()
//
//        }
//    }
}
