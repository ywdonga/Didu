//
//  AppleLoginManager.swift
//  Didu
//
//  Created by DongYouWei on 2023/3/9.
//

import Foundation
import KeychainAccess
import DeviceKit

struct AppleLoginManager {
    private static let shared = AppleLoginManager()
    private init() {}

    func appleLoginStateCheck() {
        ///1.钥匙串是否保存了apple login id
        guard let userIdentifier = KeychainExt.extKeyChainReadData(identifier: kAppBundleID+kAppleLogin888Identify) as? String else {
            DebugLog("没有读到apple login Identify")
            return
        }

        ///2.获取状态 回调是子线程
        let appleIDProvider = ASAuthorizationAppleIDProvider()
        appleIDProvider.getCredentialState(forUserID: userIdentifier) { (credentialState, error) in
            switch credentialState {
                
            /// The Apple ID credential is valid.
            case .authorized:
                break
                
            ///如果上次是apple登录 需要重新登录
            case .revoked, .notFound, .transferred:
                fallthrough
            default:
                break
            }
        }
    }
    
    lazy var keychain :Keychain = {
        let bid: String = (Bundle.main.infoDictionary?["CFBundleVersion"] as? String) ?? ""
        return Keychain(service: bid)
    }()
    
}
