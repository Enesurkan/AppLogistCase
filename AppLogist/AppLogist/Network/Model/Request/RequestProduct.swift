//
//  RequestProduct.swift
//  AppLogist
//
//  Created by Enes Urkan on 12/4/20.
//  Copyright © 2020 Enes Urkan. All rights reserved.
//

import Foundation

public struct RequestProduct : Codable, RequestProtocol {
    public var products: [Product]?
    
    public init(_ products: [Product]){
        self.products = products
    }
}
