//
//  BasketProductCell.swift
//  AppLogist
//
//  Created by Enes Urkan on 12/5/20.
//  Copyright © 2020 Enes Urkan. All rights reserved.
//

import UIKit
import Reusable
import RxSwift
import RxCocoa

class BasketProductCell: UITableViewCell, NibReusable {
    @IBOutlet weak var removeLabel: UILabel!
    @IBOutlet weak var removeButton: UIButton!
    @IBOutlet weak var productCount: UILabel!
    @IBOutlet weak var addLabel: UILabel!
    @IBOutlet weak var addButton: UIButton!
    @IBOutlet weak var productPrice: UILabel!
    @IBOutlet weak var productName: UILabel!
    @IBOutlet weak var productImage: UIImageView!
    let disposeBag = DisposeBag()
    var data: Products?
    var viewModel: ProductListViewModel?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        subscribeButton()
    }
    
    func setupUI(_ product: Products){
        data = product
        productName.text = data?.name ?? ""
        productPrice.text = "\(data?.currency ?? "")\((data?.price ?? 0).twoDecimalString)"
        productImage.pin_setImage(from: URL(string: data?.imageUrl ?? "")!)
        productCount.text = "\(product.addedCount ?? 0)"
    }
    
    func subscribeButton(){
        addButton.rx.tap.bind{[weak self] _ in
            guard let self = self else {return}
            let removeItem = Product(self.data?.id ?? "", amount: 1)
            self.viewModel?.upsertBasketData(productData: removeItem, isAdd: true)
        }.disposed(by: disposeBag)
        
        removeButton.rx.tap.bind{[weak self] _ in
            guard let self = self else {return}
            let removeItem = Product(self.data?.id ?? "", amount: 1)
            self.viewModel?.upsertBasketData(productData: removeItem, isAdd: false)
        }.disposed(by: disposeBag)
    }
    
}
