//
//  AppDelegate+.swift
//  Didu
//
//  Created by dyw on 2023/3/10.
//

import UIKit

extension AppDelegate {
    
    /// 获取屏幕尺寸
    public static var app: AppDelegate? {
        return UIApplication.shared.delegate as? AppDelegate
    }
    
}

extension AppDelegate {
 
    func makeWindow() {
        window = UIWindow(frame: CGRect(origin: UIScreen.main.bounds.origin, size: UIScreen.main.bounds.size))
        window?.backgroundColor = .white
        window?.rootViewController = LaunchVC()
        window?.makeKeyAndVisible()
    }
    
    /// 登录成功后，切换到tabbar
    func setTabBarVC(_ animate: Bool = true) {
        setRootViewController(rootVC: TabBarVC(), animate: animate, isRight: true)
    }
    
    /// 退出登录后，切换到登录页面
    func setLoginVC(_ animate: Bool = true) {
        setRootViewController(rootVC: LoginVC(), animate: animate, isRight: false)
    }
    
    /// 检查是否已登录
    func checkLoginState() {
        AppleLoginManager.checkLoginState { resut in
            if resut {// 已登录
                AppDelegate.app?.setTabBarVC(false)
            } else {//未登录
                AppDelegate.app?.setLoginVC(false)
            }
        }
    }
}

extension AppDelegate {
    
    /// 动画设置根视图控制器
    private func setRootViewController(rootVC: UIViewController, animate: Bool, isRight: Bool) {
        if animate {
            let animation = CATransition()
            animation.duration = 0.25
            animation.timingFunction = CAMediaTimingFunction(name: .linear)
            animation.type = .push
            animation.subtype = isRight ? .fromRight: .fromLeft
            window?.layer.add(animation, forKey: nil)
        }
        window?.rootViewController = rootVC
    }
    
}
