//
//  ProductListRepository.swift
//  AppLogist
//
//  Created by Enes Urkan on 12/3/20.
//  Copyright © 2020 Enes Urkan. All rights reserved.
//

import Foundation
import RxSwift

protocol ProductListRepositoryProtocol  {
    
}

class ProductListRepository : ProductListRepositoryProtocol{
    
    func getProductList<T>(_ dump: T.Type) -> Observable<T> where T : Decodable, T : Encodable {
        return  provider.rx
            .request(.productList)
            .observeOn(MainScheduler.instance)
            .map(T.self)
            .asObservable()
    }
    
}
