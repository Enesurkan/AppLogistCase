//
//  BaseViewController.swift
//  AppLogist
//
//  Created by Enes Urkan on 12/3/20.
//  Copyright © 2020 Enes Urkan. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa
import Reusable
import SnapKit

class BaseViewController: UIViewController {
    
    let disposeBag = DisposeBag()

    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    func navigateVC(storyboard: AppStoryboardType, appScene: AppSceneType, animation: Bool = true){
        let vc = UIStoryboard.init(name: storyboard.description, bundle: nil).instantiateViewController(withIdentifier: appScene.description)
        self.navigationController?.pushViewController(vc, animated: animation)
    }
    
    func navigatePresentVC(storyboard: AppStoryboardType, appScene: AppSceneType, animation: Bool = true, style: UIModalPresentationStyle = .formSheet, success: (() -> Void)? = nil){
        let vc = UIStoryboard.init(name: storyboard.description, bundle: nil).instantiateViewController(withIdentifier: appScene.description)
        vc.modalPresentationStyle = style
        self.present(vc, animated: false) {
            success?()
        }
    }

}

