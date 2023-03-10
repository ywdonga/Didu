//
//  XDHud.swift
//  Didu
//
//  Created by dyw on 2023/3/10.
//

import Foundation
import Toast_Swift
import ProgressHUD

struct XDHud {
    private static let shared = XDHud()
    private init() {}

    static func toast(_ text: String) {
        XDDevice.keyWindow?.makeToast(text, point: CGPoint(x: XDDevice.screenWidth*0.5, y: XDDevice.screenHeight*0.5), title: nil, image: nil, completion: nil)
    }
}
