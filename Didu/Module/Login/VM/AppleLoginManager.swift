//
//  AppleLoginManager.swift
//  Didu
//
//  Created by DongYouWei on 2023/3/9.
//

import Foundation
import DeviceKit
import AuthenticationServices

class AppleLoginManager: NSObject {
    private static let shared = AppleLoginManager()
    private override init() {}
    private var backBlock: ((String, Bool)->())?
    
    /// 设置回调Block
    static func setLoginCallback(_ block: @escaping(String, Bool)->()) -> ASAuthorizationAppleIDButton {
        shared.backBlock = block
        return shared.loginBtn
    }
    
    /// 判断用户登录状态
    static func checkLoginState(_ block: @escaping(Bool)->()) {
        ASAuthorizationAppleIDProvider().getCredentialState(forUserID: KeychainItem.currentUserIdentifier) { (credentialState, error) in
            DispatchQueue.main.async {
                block(credentialState == .authorized)
            }
        }
    }
    
    private lazy var loginBtn: ASAuthorizationAppleIDButton = {
        let btn = ASAuthorizationAppleIDButton()
        btn.addTarget(self, action: #selector(handleSignInWithApple), for: .touchUpInside)
        return btn
    }()
}

extension AppleLoginManager {
    
    @objc func handleSignInWithApple() {
        let provider = ASAuthorizationAppleIDProvider()
        let request = provider.createRequest()
        request.requestedScopes = [.fullName, .email]
        
        let controller = ASAuthorizationController(authorizationRequests: [request])
        controller.delegate = self
        controller.presentationContextProvider = self
        controller.performRequests()
    }
    
}

extension AppleLoginManager: ASAuthorizationControllerDelegate {
    
    func authorizationController(controller: ASAuthorizationController, didCompleteWithAuthorization authorization: ASAuthorization) {
        // Handle authorization result
        switch authorization.credential {
        case let appleIDCredential as ASAuthorizationAppleIDCredential:
            let userIdentifier = appleIDCredential.user
            let fullName = appleIDCredential.fullName
            let email = appleIDCredential.email
            let identityToken = appleIDCredential.identityToken
            let authorizationCode = appleIDCredential.authorizationCode
            KeychainItem.saveUserInKeychain(userIdentifier)
            backBlock?("登录成功", true)
        default:
            backBlock?("登录失败", false)
            break
        }
    }
    
    func authorizationController(controller: ASAuthorizationController, didCompleteWithError error: Error) {
        // Handle error
        var msg: String
        if let error = error as? ASAuthorizationError {
            switch error.code {
            case .canceled: msg = "用户取消了授权"
            case .failed: msg = "授权失败"
            case .invalidResponse: msg = "无效的授权响应"
            case .notHandled: msg = "授权请求未被处理"
            case .notInteractive: msg = "用户未操作"
            case .unknown: msg = "未知错误"
            @unknown default: msg = "未知错误"
            }
        } else {
            msg = error.localizedDescription
        }
        backBlock?(msg, false)
    }
}

extension AppleLoginManager: ASAuthorizationControllerPresentationContextProviding {
    
    func presentationAnchor(for controller: ASAuthorizationController) -> ASPresentationAnchor {
        return XDDevice.keyWindow ?? UIWindow()
    }
    
}
