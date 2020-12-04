//
//  Product.swift
//  AppLogist
//
//  Created by Enes Urkan on 12/4/20.
//  Copyright © 2020 Enes Urkan. All rights reserved.
//

import Foundation

public struct Product: Codable, RequestProtocol {
    public var id: String?
    public var amount: Int?
    
    public init(_ id:String, amount: Int){
        self.id = id
        self.amount = amount
    }
}
