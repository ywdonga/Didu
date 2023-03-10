//
//  LoginVC.swift
//  Didu
//
//  Created by DongYouWei on 2023/3/9.
//

import UIKit
import SnapKit

class LoginVC: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        let loginBtn = AppleLoginManager.setLoginCallback { msg, resut in
            guard resut else {
                XDHud.toast(msg)
                return
            }
            AppDelegate.app?.setTabBarVC(true)
        }
        view.addSubview(loginBtn)
        loginBtn.snp.makeConstraints { make in
            make.center.equalToSuperview()
        }
    }   
}
