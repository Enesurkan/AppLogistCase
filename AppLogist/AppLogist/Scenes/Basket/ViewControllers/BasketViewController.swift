//
//  BasketViewController.swift
//  AppLogist
//
//  Created by Enes Urkan on 12/5/20.
//  Copyright © 2020 Enes Urkan. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

class BasketViewController: BaseViewController {
    
    @IBOutlet weak var basketNavigatonView: UIView!
    @IBOutlet weak var bottomBasketView: UIView!
    @IBOutlet weak var tableView: UITableView!
    let basketNavigationView = BasketNavigationView.loadFromNib()
    let basketBottomView = BasketBottomView.loadFromNib()
    var section : BehaviorRelay<[ProductSectionModel]> = BehaviorRelay(value: [])
    var productListViewModel : ProductListViewModel?{
        didSet{
            bindTableViewToPage()
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }
    
    func setupUI(){
        setupNavigation(basketNavigatonView)
        setupBottomView(bottomBasketView)
        tableView.layer.cornerRadius = 5
        tableView.backgroundColor = .white
    }
    
    func setupNavigation(_ navigation: UIView, animation: Bool = true){
        self.navigationItem.titleView = nil
        basketNavigationView.deleteButton.rx.tap.bind{[weak self] _ in
            self?.removeAllBasket()
        }.disposed(by: disposeBag)
        navigation.addSubview(basketNavigationView)
        basketNavigationView.snp.makeConstraints { (make) in
            make.bottom.top.leading.trailing.equalToSuperview()
        }
    }
    
    func setupBottomView(_ navigation: UIView, animation: Bool = true){
        self.navigationItem.titleView = nil
        basketBottomView.acceptBasket.rx.tap.bind{[weak self] _ in
            self?.productListViewModel?.checkoutService()
        }.disposed(by: disposeBag)
        navigation.addSubview(basketBottomView)
        basketBottomView.snp.makeConstraints { (make) in
            make.bottom.top.leading.trailing.equalToSuperview()
        }
    }
    
    func removeAllBasket(){
        self.showAlertMessage("Uyarı", message: "Sepeti silmek istediğinize emin misiniz?", buttonTitle: "Sil", cancelButtonText: "Vazgeç") {
            self.productListViewModel?.removeAllBasket()
        }
    }

}
