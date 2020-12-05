//
//  BasketNavigationView.swift
//  AppLogist
//
//  Created by Enes Urkan on 12/5/20.
//  Copyright © 2020 Enes Urkan. All rights reserved.
//

import UIKit
import Reusable
import RxCocoa
import RxSwift

class BasketNavigationView: UIView, NibReusable {

    @IBOutlet weak var closeButton: UIButton!
    @IBOutlet weak var deleteButton: UIButton!
    let disposeBag = DisposeBag()
    
    override func awakeFromNib() {
        super.awakeFromNib()
        subscribeButton()
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    func subscribeButton(){
        closeButton.rx.tap.bind{ _ in
            if let topVC = UIApplication.topViewController() {
                topVC.dismiss(animated: true, completion: nil)
            }
        }.disposed(by: disposeBag)
    }

}
