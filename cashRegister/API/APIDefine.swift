//
//  APIDefine.swift
//  cashRegister
//
//  Created by 劉晉賢 on 2021/8/8.
//

import Foundation
import UIKit

let APITimeout: Double = 60.0

let BENTO = "locoalhost:3000"

enum APIUrl {
    case authApi(type: AuthApi)
    func getUrl() -> String {
        switch self {
        case .authApi(let type):
            return type.url()
        }
    }
    
    enum AuthApi: String {
        case apiToken = "api-token"
        
        
        static func urlWith(type: AuthApi, append:String) -> String {
            let base =  BENTO + "/bento"
            return "\(base)"
        }
        
        func url () -> String {
            return APIUrl.AuthApi.urlWith(type: self, append: "")
        }
        
        func url(append:String) -> String {
            return APIUrl.AuthApi.urlWith(type: self, append: append)
        }
    }
}
