//
//  AppDelegate.swift
//  Didu
//
//  Created by dyw on 2023/3/3.
//

import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {
    var window :UIWindow?
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        window = UIWindow(frame: CGRect(origin: UIScreen.main.bounds.origin, size: UIScreen.main.bounds.size))
        window?.backgroundColor = .white
        window?.rootViewController = LoginVC()
        window?.makeKeyAndVisible()
        
        return true
    }
    
}

