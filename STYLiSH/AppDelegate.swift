//
//  AppDelegate.swift
//  STYLiSH
//
//  Created by WU CHIH WEI on 2019/2/11.
//  Copyright © 2019 AppWorks School. All rights reserved.
//

import UIKit
import AdSupport
import FBSDKCoreKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
    
    

    var uuid = ""
    var userGroup = ""
    
    // swiftlint:disable force_cast
    static let shared = UIApplication.shared.delegate as! AppDelegate
    // swiftlint:enable force_cast
    var window: UIWindow?

    func application(
        _ application: UIApplication,
        didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?
    ) -> Bool {
        TPDSetup.setWithAppId(
            Bundle.STValueForInt32(key: STConstant.tapPayAppID),
            withAppKey: Bundle.STValueForString(key: STConstant.tapPayAppKey),
            with: TPDServerType.sandBox
        )

        ApplicationDelegate.shared.application(application, didFinishLaunchingWithOptions: launchOptions)
        
        // post api
        if let uuid = UserDefaults.standard.string(forKey: "uuid") {

            self.uuid = uuid
        } else {
            self.uuid = UUID().uuidString
            UserDefaults.standard.setValue(self.uuid, forKey: "uuid")
        }
        
        print("---------\(UserDefaults.standard.string(forKey: "uuid"))")
        
        if let userGroup = UserDefaults.standard.string(forKey: "userGroup") {
            self.userGroup = userGroup
        } else {
            let group = ["A", "B"]
            let randomGroup = group.randomElement()
            
            UserDefaults.standard.setValue(randomGroup, forKey: "userGroup")
            userGroup = randomGroup!
        }


        postApi()

        
        return true
    }

    func application(
        _ app: UIApplication,
        open url: URL,
        options: [UIApplication.OpenURLOptionsKey: Any] = [:]
    ) -> Bool {
        return ApplicationDelegate.shared.application(app, open: url, options: options)
    }
    
    func postApi() {
        
        
        let userLogin = UserLogin(userID: uuid, eventType: "login", timestamp: SingletonVar.timeStamp, version: userGroup)
        
        if let url = URL(string: "http://54.66.20.75:8080/api/1.0/user/tracking"){
            var request = URLRequest(url: url)
            // httpMethod 設定
            request.setValue("application/json", forHTTPHeaderField: "Content-Type")
            request.httpMethod = "POST"
            // 將內容加入 httpBody
            request.httpBody = try? JSONEncoder().encode(userLogin)

            //  URLSession 本身還是必須執行，為主要上傳功能。
            URLSession.shared.dataTask(with: request) { data, response, error in

            }.resume()

        }
    }
}
