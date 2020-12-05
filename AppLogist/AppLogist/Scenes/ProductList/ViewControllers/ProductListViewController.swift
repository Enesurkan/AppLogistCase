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
}

