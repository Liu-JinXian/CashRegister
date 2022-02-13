//
//  BuyDetailModel.swift
//  cashRegister
//
//  Created by 劉晉賢 on 2021/11/20.
//
import ObjectMapper

class BuyDetailModel: Mappable {
    
    var time: String?
    var isInside: String?
    var buyDetails: [BuyDetailResponse]?
    
    required init?(map: Map) {
    }
    
    func mapping(map: Map) {
        time <- map["time"]
        isInside <- map["isInside"]
        buyDetails <- map["buyDetails"]
    }
}
