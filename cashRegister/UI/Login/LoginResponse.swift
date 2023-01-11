//
//  LoginResponse.swift
//  cashRegister
//
//  Created by 劉晉賢 on 2022/8/6.
//
import ObjectMapper

class LoginResponse: Mappable {
    
    var memberToken: String?
    var companyToken: String?
    var openForUse: Bool?
    var name: String?
    
    required init?(map: Map) {
    }
    
    func mapping(map: Map) {
        memberToken <- map["Member_Token"]
        companyToken <- map["Company_Token"]
        openForUse <- map["Member_OpenForUse"]
        name <- map["Member_Name"]
    }
}
