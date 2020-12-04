//
//  BaseViewModel.swift
//  AppLogist
//
//  Created by Enes Urkan on 12/3/20.
//  Copyright © 2020 Enes Urkan. All rights reserved.
//

import Foundation
import RxSwift
import RxCocoa
import Lottie

public class BaseViewModel {
    
    public var disposeBag = DisposeBag()
    
    func showAlertMessage(_ title : String, message : String, buttonTitle : String){
        if let topVC = UIApplication.topViewController() {
            let alert = UIAlertController(title: title, message: message, preferredStyle: UIAlertController.Style.alert)
            alert.addAction(UIAlertAction(title: buttonTitle, style: UIAlertAction.Style.default, handler: nil))
            topVC.present(alert, animated: true, completion: nil)
        }
    }
    
}
