//
//  MoyaProvider.swift
//  OddHunter
//
//  Created by Enes Urkan on 11/18/20.
//  Copyright © 2020 Enes Urkan. All rights reserved.
//

import Foundation
import Moya
import RxSwift
import Defaults

let provider: MoyaProvider<AppAPI> = {
    return MoyaProvider<AppAPI>.init(plugins: [NetworkLoggerPlugin.init(verbose: true,responseDataFormatter: JSONResponseDataFormatter),RequestInterceptor()])
}()

enum AppAPI {
    case productList
    case checkout(checkoutBody: RequestProduct)
    
}

extension AppAPI: TargetType, AccessTokenAuthorizable {
    var authorizationType: AuthorizationType {
        return .none
    }
    
    
    var baseURL: URL {
        return URL(string: "https://desolate-shelf-18786.herokuapp.com")!
    }
    
    var path: String {
        switch self {
        case .productList: return "/list"
        case .checkout: return "/checkout"
        }
    }
    
    var method: Moya.Method {
        switch self {
        case .productList: return .get
        case .checkout: return .post
        }
    }
    
    var parameters: [String: Any] {
        switch self {
        case .productList:
            return [:]
        case .checkout(let body):
            return body.asDictionary() ?? [:]
        }
    }
    
    var task: Task {
        switch self {
        case .productList:
            return .requestPlain
        case .checkout:
            return .requestParameters(parameters: parameters, encoding: JSONEncoding.default)
        }
    }
    
    var headers: [String : String]? {
        let header: [String : String] = [
            "Content-Type" : "application/json"
        ]
        return header
    }
    
    var sampleData: Data {
        return "".data(using: .utf8)!
    }
}


private func JSONResponseDataFormatter(_ data: Data) -> Data {
    do {
        let dataAsJSON = try JSONSerialization.jsonObject(with: data)
        let prettyData =  try JSONSerialization.data(withJSONObject: dataAsJSON, options: .prettyPrinted)
        return prettyData
    } catch {
        return data
    }
}
