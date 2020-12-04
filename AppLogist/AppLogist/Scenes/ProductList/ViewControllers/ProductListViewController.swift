//
//  ViewController.swift
//  AppLogist
//
//  Created by Enes Urkan on 12/3/20.
//  Copyright © 2020 Enes Urkan. All rights reserved.
//

import UIKit
import RxCocoa
import RxSwift

class ProductListViewController: BaseViewController {
    
    
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var navigationView: UIView!
    var viewModel = ProductListViewModel()
    var navigationViews = NavigationView.loadFromNib()
    var section : BehaviorRelay<[ProductSectionModel]> = BehaviorRelay(value: [])
    
    override func viewDidLoad() {
        super.viewDidLoad()
        bindCollectionViewToPage()
        setupUI()
    }
    
    func setupUI(){
        setupNavigation(navigationView)
    }
    
    func setupNavigation(_ navigation: UIView, animation: Bool = true){
        self.navigationItem.titleView = nil
        navigationViews.basketButton.rx.tap.bind{[weak self] _ in
            //Route Basket Action
            //            self?.navigationController?.popViewController(animated: animation)
        }.disposed(by: disposeBag)
        navigation.addSubview(navigationViews)
        navigationViews.snp.makeConstraints { (make) in
            make.bottom.top.leading.trailing.equalToSuperview()
        }
    }
    
    func setNavigationViewProductCount(productCount : Int){
        navigationViews.basketProductCount.text = "\(productCount)"
    }
    
    
}

