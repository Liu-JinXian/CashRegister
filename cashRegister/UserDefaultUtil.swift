//
//  UserDefaultUtil.swift
//  cashRegister
//
//  Created by 劉晉賢 on 2021/3/6.
//

import Foundation

enum UserDefaultKey: String {
    case item = "ITEM"
    case price = "PRICE"
}

class UserDefaultUtil: NSObject {
    
    static var shared = UserDefaultUtil()
    
    var uuid: String? {
        get {
            return getObject(classType: String(), key: .item)
        }
        set(uuid){
            update(object: uuid, key: .item)
        }
    }
    
    private func update(object: Any?, key: UserDefaultKey) {
        let userDefaults = UserDefaults.standard
        if let object = object {
            userDefaults.set(object, forKey: key.rawValue)
        } else {
            userDefaults.removeObject(forKey: key.rawValue)
        }
        userDefaults.synchronize()
    }
    
    private func getObject<T>(classType: T, key: UserDefaultKey) -> T? {
        let userDefaults = UserDefaults.standard
        return userDefaults.object(forKey: key.rawValue) as? T
    }
}

