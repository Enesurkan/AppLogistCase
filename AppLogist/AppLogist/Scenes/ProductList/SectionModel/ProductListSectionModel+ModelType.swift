//
//  ProductListSectionModel+ModelType.swift
//  AppLogist
//
//  Created by Enes Urkan on 12/3/20.
//  Copyright © 2020 Enes Urkan. All rights reserved.
//

import Foundation
import RxDataSources
import RxCocoa
import RxSwift
import Differentiator

extension ProductSectionModel : SectionModelType {
    var items: [ProductSectionItem] {
        switch  self {
        case .ProductSection( _,let items):
            return items.map {$0}
        }
    }
    
    init(original: ProductSectionModel, items: [Item]) {
        switch original {
        case .ProductSection(let title, let items):
            self = .ProductSection(title: title, items: items)
        }
    }
    
    typealias Item = ProductSectionItem
}
