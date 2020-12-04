//
//  ProductListViewController+CollectionView.swift
//  AppLogist
//
//  Created by Enes Urkan on 12/3/20.
//  Copyright © 2020 Enes Urkan. All rights reserved.
//

import UIKit
import RxDataSources
import RxCocoa
import RxSwift
import Differentiator
import Reusable

extension ProductListViewController {
    
    internal func bindCollectionViewToPage(){
        registerCollectionViewCells()
        subscribeService()
        initializeCollectionView()
        setCollectionLayout()
    }
    
    func setCollectionLayout() {
        let layout:UICollectionViewFlowLayout = UICollectionViewFlowLayout()
        layout.sectionInset = UIEdgeInsets(top:10,left:10,bottom:10,right:10)
        let screenWidth = UIScreen.main.bounds.size.width
        layout.itemSize = CGSize(width: (screenWidth - 30) / 3, height: ((screenWidth - 20) / 3) * 1.5)
        layout.minimumInteritemSpacing = 3
        layout.minimumLineSpacing = 3
        collectionView.collectionViewLayout = layout
    }
    
    private func subscribeService(){
        viewModel.getProductList()
        viewModel.productList.subscribe(onNext: {[weak self] (products) in
            guard
            let self = self,
            let _products = products
            else {return}
            self.setSection(_products)
        }).disposed(by: disposeBag)
        
        viewModel.basketProduct.subscribe(onNext: {[weak self] (basketProduct) in
            guard let self = self else {return}
            self.setNavigationViewProductCount(productCount: basketProduct.count)
            self.setSection(self.runCheckItemProcess(basketData: basketProduct,
                                                     serverData: self.viewModel.productList.value ?? []))
        }).disposed(by: disposeBag)
    }
    
    func setSection(_ products: [Products]){
        self.section.accept(self.listDefineSections(_model: products))
    }
    
    private func runCheckItemProcess(basketData: [Product], serverData: [Products]) -> [Products]{
        if serverData.count == 0 {
            return []
        }
        
        if basketData.count == 0 {
            return serverData
        }
        
        return (serverData.map({ (product) -> Products in
            var _tempProduct = product
            _ = basketData.map({ basketData in
                if product.id == basketData.id{
                    _tempProduct.addedCount = basketData.amount ?? 0
                    _tempProduct.isAddBasket = true
                }
            })
            return _tempProduct
        }))
    }
    
    private func initializeCollectionView() {
        setupCollectionViewDataBinding()
    }
    
    internal func registerCollectionViewCells(){
        collectionView.register(cellType: ProductCell.self)
    }
    
    internal func dataSource() -> RxCollectionViewSectionedReloadDataSource<ProductSectionModel> {
        return RxCollectionViewSectionedReloadDataSource<ProductSectionModel>(
            configureCell: { (dataSource, collection, indexPath, _) in
                switch dataSource[indexPath] {
                case .ProductSectionItem(let product):
                    let cell = collection.dequeueReusableCell(for: indexPath, cellType: ProductCell.self)
                    cell.viewModel = self.viewModel
                    cell.setupUI(product)
                    return cell
                }
        }
        )
    }
    
    private func setupCollectionViewDataBinding(){
        self.section.bind(to: collectionView.rx.items(dataSource: dataSource()))
            .disposed(by: disposeBag)
    }
    
}
