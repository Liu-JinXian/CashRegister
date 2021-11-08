//
//  BentoModel.swift
//  cashRegister
//
//  Created by 劉晉賢 on 2021/11/7.
//
import ObjectMapper

class BentoModel: Mappable {
    
    var uuid: String?
    var name: String?
    var price: Int?
    var location: Int?
    
    required init?(map: Map) {
    }
    
    func mapping(map: Map) {
        uuid <- map["_id"]
        name <- map["name"]
        price <- map["price"]
        location <- map["location"]
    }
}
