//
//  ProductListViewController+SetupUI.swift
//  AppLogist
//
//  Created by Enes Urkan on 12/5/20.
//  Copyright © 2020 Enes Urkan. All rights reserved.
//

import Foundation
import UIKit

extension ProductListViewController {
    
    func setupUI(){
        setupNavigation(navigationView)
    }
    
    func setupNavigation(_ navigation: UIView, animation: Bool = true){
        self.navigationItem.titleView = nil
        navigationViews.basketButton.rx.tap.bind{[weak self] _ in
            guard let self = self else {return}
            self.basketButtonAction()
        }.disposed(by: disposeBag)
        navigation.addSubview(navigationViews)
        navigationViews.snp.makeConstraints { (make) in
            make.bottom.top.leading.trailing.equalToSuperview()
        }
    }
    
    func setNavigationViewProductCount(productCount : Int){
        navigationViews.basketProductCount.text = "\(productCount)"
    }
    
    func basketButtonAction(){
        if self.isHaveBasketInProduct() {
            self.navigatePresentVC(storyboard: .Basket, appScene: .Basket, success: {
                if let topVC = UIApplication.topViewController(), topVC.isKind(of: BasketViewController.self) {
                    (topVC as! BasketViewController).productListViewModel = self.viewModel
                }
            })
        }else{
            self.showAlertMessage("Dikkat", message: "Sepete girebilmek için ürün eklemeniz gerekmektedir.", buttonTitle: "Tamam")
        }
    }
    
    func isHaveBasketInProduct() -> Bool {
        return viewModel.basketProduct.value.count > 0
    }
}
