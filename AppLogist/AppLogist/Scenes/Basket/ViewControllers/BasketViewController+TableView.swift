//
//  BasketViewController+TableView.swift
//  AppLogist
//
//  Created by Enes Urkan on 12/5/20.
//  Copyright © 2020 Enes Urkan. All rights reserved.
//

import UIKit
import RxDataSources
import RxCocoa
import RxSwift
import Differentiator
import Reusable

extension BasketViewController {
    
    internal func bindTableViewToPage() {
        registerTableViewCell()
        tableDataBinding()
        subscribeViewModelData()
        tableView.rx.setDelegate(self)
            .disposed(by: disposeBag)
    }
    
    private func tableDataBinding() {
        self.setupTableViewDataBinding()
    }
    
    private func subscribeViewModelData(){
        productListViewModel?.basketProduct.subscribe(onNext: {[weak self] (basketProduct) in
            guard let self = self else {return}
            self.basketBottomView.setTotalPrice(self.productListViewModel?.getBasketTotalPrice() ?? 0.0,
                                                currency: self.productListViewModel?.getProductsCurrency() ?? "")
            self.setSection(self.runCheckItemProcess(basketData: basketProduct,
                                                     serverData: self.productListViewModel?.productList.value ?? []))
        }).disposed(by: disposeBag)
        
        productListViewModel?.checkout.subscribe(onNext: {[weak self] (check) in
            guard let checkout = check else {return}
            if checkout.orderID != nil {
                self?.showAlertMessage("Harika!",
                                       message: checkout.message ?? "",
                                       buttonTitle: "Ana sayfaya Dön",
                                       cancelButtonText: nil,
                                       success: {
                    self?.dismiss(animated: true, completion: {
                        if let topVC = UIApplication.topViewController(), topVC.isKind(of: ProductListViewController.self) {
                            (topVC as! ProductListViewController).viewModel.removeAllBasket()
                            (topVC as! ProductListViewController).viewModel.checkout.accept(nil)
                        }
                    })
                })
            }else{
                self?.showAlertMessage("Üzgünüm",
                                       message: checkout.message ?? "Ödeme yapılırken bir hata ile karşılaşıldı.",
                                       buttonTitle: "Tamam")
            }
        }).disposed(by: disposeBag)
    }
    
    func setSection(_ products: [Products]){
        self.section.accept(self.listDefineSections(_model: products))
    }
    
    private func registerTableViewCell() {
        tableView.register(cellType: BasketProductCell.self)
    }

    private func dataSource() -> RxTableViewSectionedReloadDataSource<ProductSectionModel> {
        return RxTableViewSectionedReloadDataSource<ProductSectionModel>(
            configureCell: { (dataSource, tableView, indexPath, _) -> UITableViewCell in
            switch dataSource[indexPath] {
            case .BasketProductSectionItem(let basketData):
                let cell = tableView.dequeueReusableCell(for: indexPath, cellType: BasketProductCell.self)
                cell.viewModel = self.productListViewModel
                cell.setupUI(basketData)
                return cell
            case .ProductSectionItem(_):
                return UITableViewCell()
            }
        })
    }
    
    private func setupTableViewDataBinding() {
        self.section.bind(to: tableView.rx.items(dataSource: dataSource()))
        .disposed(by: disposeBag)
    }
}

extension BasketViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        let index = indexPath.section
        return self.section.value[index].estimatedHeight
    }
}
