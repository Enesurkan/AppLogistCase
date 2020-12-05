//
//  ProductListViewModel.swift
//  AppLogist
//
//  Created by Enes Urkan on 12/3/20.
//  Copyright © 2020 Enes Urkan. All rights reserved.
//

import Foundation
import RxSwift
import RxCocoa

protocol ProductListViewModelProtocol {
}

final class ProductListViewModel : BaseViewModel, ProductListViewModelProtocol {
    
    private var productListRepository = ProductListRepository()
    var productList : BehaviorRelay<[Products]?> = BehaviorRelay(value: nil)
    var basketProduct : BehaviorRelay<[Product]> = BehaviorRelay(value: [])
    var checkout : BehaviorRelay<Checkout?> = BehaviorRelay(value: nil)
    
    func getProductList(){
        productListRepository.getProductList([Products].self)
            .subscribe(onNext: {[weak self] (response) in
                guard let self = self else {return}
                if response.count > 0 {
                    self.productList.accept(response)
                }else{
                    self.showAlertMessage("Üzgünüm!", message: "Gösterilecek ürün bulunamadı.", buttonTitle: "Tamam")
                }
                }, onError: { (error) in
                    self.showAlertMessage("Üzgünüm!", message: error.localizedDescription, buttonTitle: "Tamam")
            }).disposed(by: disposeBag)
    }
    
    func checkoutService(){
        productListRepository.checkout(Checkout.self, checkoutRequestBody: RequestProduct(basketProduct.value))
            .subscribe(onNext: {[weak self] (checkout) in
                self?.checkout.accept(checkout)
            }, onError: { (error) in
                self.showAlertMessage("Üzgünüm!", message: error.localizedDescription, buttonTitle: "Tamam")
        }).disposed(by: disposeBag)
    }
    
    func addToBasket(productData: Product){
        var _tempBasket = basketProduct.value
        _tempBasket[getBasketProductIndex(id: productData.id ?? "")] = productData
        basketProduct.accept(_tempBasket)
    }
    
    func removeBasketInItem(id : String){
        var _tempBasket = basketProduct.value
        _tempBasket.remove(at: getBasketProductIndex(id: id))
        basketProduct.accept(_tempBasket)
    }
    
    func removeAllBasket(){
        basketProduct.accept([])
    }
    
    func getBasketProductIndex(id : String) -> Int{
        return basketProduct.value.firstIndex {$0.id == id} ?? 0
    }
    
    func isHaveBasketItem(id : String) -> Bool{
        return self.basketProduct.value.compactMap({$0}).filter{$0.id == id}.first != nil
    }
    
    func getServerData(id : String) -> Products {
        return self.productList.value?.compactMap({$0}).filter{$0.id == id}.first ?? Products()
    }
    
    func getMarketData(id : String) -> Product{
        return self.basketProduct.value.compactMap({$0}).filter{$0.id == id}.first ?? Product(id, amount: 1)
    }
    
    func upsertBasketData(productData: Product, isAdd: Bool){
        if isHaveBasketItem(id: productData.id ?? "") {
            var marketData = getMarketData(id: productData.id ?? "")
            let serverData = getServerData(id: productData.id ?? "")
            if isAdd {
                if marketData.amount == serverData.stock {
                    self.showAlertMessage("Üzgünüm!", message: "Stock sayısından fazla ekleyemezsiniz", buttonTitle: "Tamam")
                    return
                }else{
                    marketData.amount! += 1
                    addToBasket(productData: marketData)
                }
            }else{
                if marketData.amount == 1 {
                    removeBasketInItem(id: productData.id ?? "")
                }else{
                    marketData.amount! -= 1
                    addToBasket(productData: marketData)
                }
            }
        }else{
            var basketData = basketProduct.value
            basketData.append(productData)
            basketProduct.accept(basketData)
        }
    }
    
    func getBasketTotalPrice() -> Double{
        guard let _productList = productList.value else {return 0}
        if _productList.count == 0 {return 0}
        if basketProduct.value.count == 0 {return 0}
        var totalPrice : Double = 0.0
        _ = basketProduct.value.map {
            totalPrice = totalPrice + ((self.getServerData(id: $0.id ?? "").price ?? 0.0) * Double($0.amount ?? 0))
        }
        return totalPrice
    }
    
    func getProductsCurrency() -> String{
        guard let _productList = productList.value else {return ""}
        if _productList.count == 0 {return ""}
        return _productList.first?.currency ?? ""
    }
}
