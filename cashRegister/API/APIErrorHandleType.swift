//
//  APIErrorHandleType.swift
//  cashRegister
//
//  Created by 劉晉賢 on 2021/8/8.
//

import Foundation
public enum APIErrorHandleType {
    public typealias RawValue = APILoadingHandleType
    case coverPlate
    case alert
    case toast
    case custom
}
