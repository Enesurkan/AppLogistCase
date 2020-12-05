//
//  BasketBottomView.swift
//  AppLogist
//
//  Created by Enes Urkan on 12/5/20.
//  Copyright © 2020 Enes Urkan. All rights reserved.
//

import UIKit
import Reusable

class BasketBottomView: UIView, NibLoadable {
    
    @IBOutlet weak var totalPrice: UILabel!
    @IBOutlet weak var acceptBasket: UIButton!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    func setTotalPrice(_ price : Double, currency: String){
        totalPrice.text = "Toplam: \(currency)\(price.twoDecimalString)"
    }
}
