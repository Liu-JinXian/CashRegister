//
//  BuyDetailResponse.swift
//  cashRegister
//
//  Created by 劉晉賢 on 2021/11/20.
//
import ObjectMapper

class BuyDetailResponse: BaseModel {
    
    var detailsID: Int?
    var bentoName: String?
    var bentoPrice: Int?
    var amount: Int?
    
    override func mapping(map: Map) {
        detailsID <- map["details_id"]
        bentoName <- map["bentoName"]
        bentoPrice <- map["bentoPrice"]
        amount <- map["amount"]
    }
}
