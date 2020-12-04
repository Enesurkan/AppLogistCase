//
//  Products.swift
//  AppLogist
//
//  Created by Enes Urkan on 12/3/20.
//  Copyright © 2020 Enes Urkan. All rights reserved.
//

import Foundation

public struct Products : Codable {
    public var id: String?
    public var name: String?
    public var price: Double?
    public var currency: String?
    public var imageUrl: String?
    public var stock: Int?
    public var isAddBasket: Bool?
    public var addedCount: Int?
    
    public init(){}
}
