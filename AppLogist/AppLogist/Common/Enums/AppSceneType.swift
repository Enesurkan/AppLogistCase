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
    
    var description : String {
        switch self {
        case .ProductList: return "ProductListViewController"
        }
    }
}

enum AppStoryboardType : CustomStringConvertible {
    case ProductList
    
    var description : String {
        switch self {
        case .ProductList: return "ProductList"
        }
    }
}
