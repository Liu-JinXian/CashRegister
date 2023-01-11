//
//  BuyDetailModel.swift
//  cashRegister
//
//  Created by 劉晉賢 on 2021/11/20.
//
import ObjectMapper

class BuyDetailModel: Mappable {
    
    var timeID: String?
    var time: String?
    var isInside: Bool?
    var buyDetails: [BuyDetailResponse]?
    
    required init?(map: Map) {
    }
    
    func mapping(map: Map) {
        timeID <- map["id"]
        time <- map["time"]
        isInside <- map["isInSide"]
        buyDetails <- map["buyDetails"]
    }
}
