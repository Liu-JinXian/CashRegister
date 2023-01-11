//
//  BentoModel.swift
//  cashRegister
//
//  Created by 劉晉賢 on 2021/11/7.
//
import ObjectMapper

class BentoModel: Mappable {
    
    var bentoToken: String?
    var bentoName: String?
    var bentoPrice: Int?
    var location: Int?
    
    required init?(map: Map) {
    }
    
    func mapping(map: Map) {
        bentoToken <- map["bentoToken"]
        bentoName <- map["bentoName"]
        bentoPrice <- map["bentoPrice"]
        location <- map["location"]
    }
}
