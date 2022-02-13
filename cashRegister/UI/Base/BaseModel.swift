//
//  BaseModel.swift
//  cashRegister
//
//  Created by 劉晉賢 on 2021/10/24.
//
import ObjectMapper

class BaseModel: NSObject, Mappable,Codable {
    
    var alertMsg: String?
    var errorMsg: String?
    
    override init() {
    }
    
    required init?(map: Map) {
        super.init()
        self.mapping(map: map)
    }
    
    func mapping(map: Map) {
        alertMsg <- map["AlertMsg"]
        errorMsg <- map["Error_Msg"]
    }
    
    func getValue<T>(Type: T.Type) -> T {
        return self as! T
    }
}
