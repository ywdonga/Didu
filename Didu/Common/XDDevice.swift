//
//  XDDevice.swift
//  Didu
//
//  Created by dyw on 2023/3/10.
//

import Foundation
import DeviceKit

struct XDDevice {
    private static let shared = XDDevice()
    private init() {}

    /// keyWindow
    public static var keyWindow: UIWindow? {
        let wds = (UIApplication.perform(NSSelectorFromString("sharedApplication"))?.takeUnretainedValue() as? UIApplication)?.windows
        return wds?.first(where: {$0.isKeyWindow}) ?? wds?.first
    }
    
    /// 获取屏幕尺寸
    public static var screenBounds: CGRect {
        return UIScreen.main.bounds
    }
    
    /// 获取屏幕宽度
    public static var screenWidth: CGFloat {
        return screenBounds.width
    }
    
    /// 获取屏幕高度
    public static var screenHeight: CGFloat {
        return screenBounds.height
    }
    
    /// 获取刘海屏顶部非安全区域高度
    public static var notchTop: CGFloat {
        return keyWindow?.safeAreaInsets.top ?? 0
    }
    
    /// 获取刘海屏底部非安全区域高度
    public static var notchBottom: CGFloat {
        return keyWindow?.safeAreaInsets.bottom ?? 0
    }
    
    /// 获取状态栏高度
    public static var statusHeight: CGFloat {
        return notchTop > 0 ? notchTop : 20
    }
    
    /// 获取导航栏高度
    public static var navHeight: CGFloat {
        return statusHeight + 44
    }
    
    /// 设备型号
    public static var deviceModel: String {
        return Device.current.safeDescription
    }
    
    /// 设备品牌
    public static var deviceBrand: String {
        return UIDevice.current.model
    }
    
    /// 系统版本
    public static var systemVersion: String {
        return UIDevice.current.systemVersion
    }
    
    /// app版本
    public static var appVersion: String {
        if let temp = Bundle.main.infoDictionary?["CFBundleShortVersionString"] as? String  {
            return temp
        }
        return ""
    }
    
    /// bundle Id
    public static var bundleId: String {
        if let temp = Bundle.main.infoDictionary?["CFBundleVersion"] as? String  {
            return temp
        }
        return ""
    }
}
