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
        
        
        
        if let uuid = UserDefaults.standard.string(forKey: "uuid") {

            self.uuid = uuid
            print(uuid)
        } else {
            self.uuid = UUID().uuidString
            
            UserDefaults.standard.setValue(self.uuid, forKey: "uuid")
            print(self.uuid)
        }
        
        print("---------\(UserDefaults.standard.string(forKey: "uuid"))")
        
        if UserDefaults.standard.string(forKey: "userGroup") == "" {
            let group = ["A", "B"]
            let randomGroup = group.randomElement()
            
            UserDefaults.standard.setValue(randomGroup, forKey: "userGroup")
            
        }

        return true
    }

    func application(
        _ app: UIApplication,
        open url: URL,
        options: [UIApplication.OpenURLOptionsKey: Any] = [:]
    ) -> Bool {
        return ApplicationDelegate.shared.application(app, open: url, options: options)
    }
}
