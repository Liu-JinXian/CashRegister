//
//  BentoMenuResponse.swift
//  cashRegister
//
//  Created by 劉晉賢 on 2021/10/24.
//
import ObjectMapper

class BentoMenuResponse: BaseModel {
    
    var name: String?
    var price: Int?
    var localtion: Int?
    
    override func mapping(map: Map) {
        name <- map["name"]
        price <- map["price"]
        localtion <- map["localtion"]
    }
}
