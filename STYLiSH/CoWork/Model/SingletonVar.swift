//
//  SingletonVar.swift
//  STYLiSH
//
//  Created by TingFeng Shen on 2023/9/4.
//  Copyright © 2023 AppWorks School. All rights reserved.
//

import Foundation

class SigletonVar {
    static let uuid = UserDefaults.standard.string(forKey: "uuid")
    static let group = UserDefaults.standard.string(forKey: "userGroup")
}
