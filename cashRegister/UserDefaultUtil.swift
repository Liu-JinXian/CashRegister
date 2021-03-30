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
    
    var item: [String]? {
        get {
            return getObject(classType: [String](), key: .item) ?? []
        }
        set(value){
            let values = setOnlyThreeItem(array: value ?? [])
            update(object: values, key: .item)
        }
    }
    
    var price: [Int]? {
        get {
            return getObject(classType: [Int](), key: .price) ?? []
        }set(value){
            let values = setOnlyThreeItem(array: value ?? [])
            update(object: values, key: .price)
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
    
    private func setOnlyThreeItem(array:[Any]) -> [Any] {
        var howManyItem = array
        if howManyItem.count > 1000 {
            howManyItem.removeLast()
        }
        return howManyItem
    }
}

