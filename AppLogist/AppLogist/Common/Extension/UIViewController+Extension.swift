//
//  UIViewController+Extension.swift
//  AppLogist
//
//  Created by Enes Urkan on 12/3/20.
//  Copyright © 2020 Enes Urkan. All rights reserved.
//

import Foundation
import UIKit

extension UIApplication {
    class func topViewController(controller: UIViewController? = UIApplication.shared.keyWindow?.rootViewController) -> UIViewController? {
        if let navigationController = controller as? UINavigationController {
            return topViewController(controller: navigationController.visibleViewController)
        }
        if let tabController = controller as? UITabBarController {
            if let selected = tabController.selectedViewController {
                return topViewController(controller: selected)
            }
        }
        if let presented = controller?.presentedViewController {
            return topViewController(controller: presented)
        }
        return controller
    }
}

extension UIViewController {
    func showAlertMessage(_ title : String, message : String, buttonTitle : String, cancelButtonText: String? = nil, success: (() -> Void)? = nil){
        let alert = UIAlertController(title: title, message: message, preferredStyle: UIAlertController.Style.alert)
        if let _cancelButtonText = cancelButtonText{
            alert.addAction(.init(title: _cancelButtonText, style: .cancel, handler: nil))
        }
        alert.addAction(.init(title: buttonTitle, style: .default, handler: { (action) in
            success?()
        }))
        self.present(alert, animated: true, completion: nil)
    }
}
