//
//  GenericExtension.swift
//  AppLogist
//
//  Created by Enes Urkan on 12/4/20.
//  Copyright © 2020 Enes Urkan. All rights reserved.
//

import Foundation

extension Double {
    var twoDecimalString:String {
        let formatDouble = String(format: "%.2f", self)
        return formatDouble.replacingOccurrences(of: ".", with: ",")
    }
}
