//
//  LoginVC.swift
//  Didu
//
//  Created by DongYouWei on 2023/3/9.
//

import UIKit
import AuthenticationServices
import SnapKit

class LoginVC: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        view.addSubview(loginBtn)
        loginBtn.snp.makeConstraints { make in
            make.center.equalToSuperview()
        }
    }
    
    @objc func handleSignInWithApple() {
        let provider = ASAuthorizationAppleIDProvider()
        let request = provider.createRequest()
        request.requestedScopes = [.fullName, .email]
        
        let controller = ASAuthorizationController(authorizationRequests: [request])
        controller.delegate = self
        controller.presentationContextProvider = self
        controller.performRequests()
    }
    
    lazy var loginBtn: ASAuthorizationAppleIDButton = {
        let btn = ASAuthorizationAppleIDButton()
        btn.addTarget(self, action: #selector(handleSignInWithApple), for: .touchUpInside)
        return btn
    }()
}

extension LoginVC: ASAuthorizationControllerDelegate {
    
    func authorizationController(controller: ASAuthorizationController, didCompleteWithAuthorization authorization: ASAuthorization) {
        // Handle authorization result
        
    }
    
    func authorizationController(controller: ASAuthorizationController, didCompleteWithError error: Error) {
        // Handle error
        switch error.code {
            
        default:
            <#code#>
        }
        NSString *errorMsg;
        switch (error.code) {
            case ASAuthorizationErrorUnknown: {
                errorMsg = @"授权请求失败，未知原因";
                break;
            }
            case ASAuthorizationErrorCanceled: {
                errorMsg = @"用户取消了授权请求";
                break;
            }
            case ASAuthorizationErrorInvalidResponse: {
                errorMsg = @"授权请求响应无效";
                break;
            }
            case ASAuthorizationErrorNotHandled: {
                errorMsg = @"未能处理授权请求";
                break;
            }
            case ASAuthorizationErrorFailed: {
                errorMsg = @"获取授权失败";
                break;
            }
        }
        
        NSLog(@"error message:%@", errorMsg);

    }
}

extension LoginVC: ASAuthorizationControllerPresentationContextProviding {
    
    func presentationAnchor(for controller: ASAuthorizationController) -> ASPresentationAnchor {
        return view.window ?? UIWindow()
    }
}
