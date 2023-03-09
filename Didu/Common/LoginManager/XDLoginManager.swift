//
//  XDLoginManager.swift
//  Didu
//
//  Created by DongYouWei on 2023/3/9.
//

import Foundation

protocol XDLoginModel {
    func token() -> String
    func isLogin() -> Bool
}

struct XDLoginManager {
    private static let shared = XDLoginManager()
    private init() {}
    
    
    
}
