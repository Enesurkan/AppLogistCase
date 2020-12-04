//
//  ProductListSectionModel.swift
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

enum ProductSectionModel{
    case ProductSection(title: String, items: [ProductSectionItem])
    
    var estimatedHeight: CGFloat {
        switch self {
        case .ProductSection: return 110
        }
    }
}

enum ProductSectionItem {
    case ProductSectionItem(product: Products)
}
