//
//  AppSceneType.swift
//  AppLogist
//
//  Created by Enes Urkan on 12/3/20.
//  Copyright © 2020 Enes Urkan. All rights reserved.
//

import Foundation

enum AppSceneType : CustomStringConvertible {
    case ProductList
    case Basket
    
    var description : String {
        switch self {
        case .ProductList: return "ProductListViewController"
        case .Basket: return "BasketViewController"
        }
    }
}

enum AppStoryboardType : CustomStringConvertible {
    case ProductList
    case Basket
    
    var description : String {
        switch self {
        case .ProductList: return "ProductList"
        case .Basket: return "Basket"
        }
    }
}
