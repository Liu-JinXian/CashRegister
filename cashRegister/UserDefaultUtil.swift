//
//  UserDefaultUtil.swift
//  cashRegister
//
//  Created by 劉晉賢 on 2021/3/6.
//

import Foundation

enum UserDefaultKey: String {
    case memberToken = "MemberToken"
    case companyToken = "CompanyToken"
    case openForUse = "OpenForUse"
}

class UserDefaultUtil: NSObject {
    
    static var shared = UserDefaultUtil()
    
    var memberToken: String? {
        get {
            return getObject(classType: String(), key: .memberToken) ?? ""
        }
        set(value) {
            update(object: value, key: .memberToken)
        }
    }
    
    var companyToken: String? {
        get {
            return getObject(classType: String(), key: .companyToken) ?? ""
        }
        set(value) {
            update(object: value, key: .companyToken)
        }
    }
    
    var openForUse: Bool? {
        get {
            return getObject(classType: Bool(), key: .openForUse) ?? false
        }
        set(value) {
            update(object: value, key: .openForUse)
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
    
    private func setOnlyThreeItem(array: [Any]) -> [Any] {
        var howManyItem = array
        if howManyItem.count > 1000 {
            howManyItem.removeLast()
        }
        return howManyItem
    }
}

