//
//  Constant.swift
//  cashRegister
//
//  Created by 劉晉賢 on 2022/8/6.
//

var isLogin: Bool {
    let memberToken = UserDefaultUtil.shared.memberToken
    let companyToken = UserDefaultUtil.shared.companyToken
    return memberToken == nil || memberToken == "" || companyToken == nil || companyToken == "" ? false : true
}

var openForUse: Bool {
    let openForUse = UserDefaultUtil.shared.openForUse
    return openForUse ?? false
}
