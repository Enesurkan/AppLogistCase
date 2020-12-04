//
//  GenericExtension.swift
//  AppLogist
//
//  Created by Enes Urkan on 12/4/20.
//  Copyright © 2020 Enes Urkan. All rights reserved.
//

import Foundation

extension Double {
    func rounded(toPlaces places:Int) -> Double {
        let divisor = pow(10.0, Double(places))
        return (self * divisor).rounded() / divisor
    }
}
