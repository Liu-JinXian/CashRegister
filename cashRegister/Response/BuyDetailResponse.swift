//
//  BuyDetailResponse.swift
//  cashRegister
//
//  Created by 劉晉賢 on 2021/11/20.
//
import ObjectMapper

class BuyDetailResponse: BaseModel {
    
    var name: String?
    var price: Int?
    var amount: Int?
    
    override func mapping(map: Map) {
        name <- map["name"]
        price <- map["price"]
        amount <- map["amount"]
    }
}
