//
//  BasketViewController+Data.swift
//  AppLogist
//
//  Created by Enes Urkan on 12/5/20.
//  Copyright © 2020 Enes Urkan. All rights reserved.
//

import Foundation

extension BasketViewController {
    
    internal func listDefineSections(_model: [Products]?) -> [ProductSectionModel]{
        guard let model = _model else {return []}
        return model.compactMap { (product) -> ProductSectionModel? in
            return .ProductSection(title: "Product Section", items: [.BasketProductSectionItem(basketProduct: product)])
        }
    }
    
    internal func runCheckItemProcess(basketData: [Product], serverData: [Products]) -> [Products]{
        if serverData.count == 0 {
            return []
        }
        
        if basketData.count == 0 {
            self.showAlertMessage("Uyarı", message: "Sepette ürün kalmadı. Sepet sayfasına girebilmek için ürün ekleyiniz.", buttonTitle: "Tamam", success: {
                self.dismiss(animated: true, completion: nil)
            })
            return []
        }
        
        return (basketData.map({ (product) -> Products? in
            var basketProductData = self.productListViewModel?.getServerData(id: product.id ?? "")
            basketProductData?.addedCount = product.amount ?? 0
            return basketProductData
        }) as! [Products])
    }
    
    
}
