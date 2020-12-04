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
        guard var model = _model else {return []}
        
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
}
