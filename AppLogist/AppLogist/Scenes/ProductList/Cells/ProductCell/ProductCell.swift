//
//  ProductCell.swift
//  AppLogist
//
//  Created by Enes Urkan on 12/4/20.
//  Copyright © 2020 Enes Urkan. All rights reserved.
//

import UIKit
import Reusable
import PINRemoteImage
import RxSwift
import RxCocoa

class ProductCell: UICollectionViewCell, NibReusable {
    
    var data: Products?
    let disposeBag = DisposeBag()
    var viewModel: ProductListViewModel?
    @IBOutlet weak var removeLabel: UILabel!
    @IBOutlet weak var removeButton: UIButton!
    @IBOutlet weak var productCount: UILabel!
    @IBOutlet weak var addLabel: UILabel!
    @IBOutlet weak var addButton: UIButton!
    @IBOutlet weak var productImage: UIImageView!
    @IBOutlet weak var productPrice: UILabel!
    @IBOutlet weak var productName: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        subscribeButton()
    }
    
    func resetUI(isHidden: Bool){
        removeLabel.isHidden = isHidden
        productCount.isHidden = isHidden
        removeButton.isHidden = isHidden
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
    
    func setupUI(_ product: Products){
        data = product
        productName.text = data?.name ?? ""
        productPrice.text = "\(data?.currency ?? "")\(formatPrice(price: data?.price ?? 0))"
        productImage.pin_setImage(from: URL(string: data?.imageUrl ?? "")!)
        if product.isAddBasket ?? false {
            basketAddUI()
        }else{
            resetUI(isHidden: true)
        }
    }
    
    func basketAddUI(){
        resetUI(isHidden: false)
        productCount.text = "\(data?.addedCount ?? 0)"
    }
    
    func formatPrice(price : Double) -> String{
        let roundedValue = price.rounded(toPlaces: 2)
        let replaceString = "\(roundedValue)".replacingOccurrences(of: ".", with: ",")
        return replaceString
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        resetUI(isHidden: true)
    }

}
