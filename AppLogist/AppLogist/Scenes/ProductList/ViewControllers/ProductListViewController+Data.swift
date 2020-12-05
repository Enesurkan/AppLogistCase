//
//  ProductListViewController+Data.swift
//  AppLogist
//
//  Created by Enes Urkan on 12/3/20.
//  Copyright © 2020 Enes Urkan. All rights reserved.
//

import Foundation

extension ProductListViewController {
    
    internal func listDefineSections(_model: [Products]?) -> [ProductSectionModel]{
        guard let model = _model else {return []}
        
        var sec = [ProductSectionModel]()
        var subSec = [ProductSectionItem]()
        
        var index = 0;
        _ = model.map{ product in
            index = index + 1
            subSec.append(.ProductSectionItem(product: product))
            if index % 3 == 0 {
                sec.append(.ProductSection(title: "Product Section", items: subSec))
                subSec = []
            }
        }
        if subSec.count < 3 {
            sec.append(.ProductSection(title: "Product Section", items: subSec))
        }
        return sec
    }
    
    internal func runCheckItemProcess(basketData: [Product], serverData: [Products]) -> [Products]{
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
}
