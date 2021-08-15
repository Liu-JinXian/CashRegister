//
//  APILoadingHandleType.swift
//  cashRegister
//
//  Created by 劉晉賢 on 2021/8/8.
//

import Foundation
import UIKit

public enum APILoadingHandleType {
    public typealias RawValue = APILoadingHandleType
    case coverPlate
    case notBlock
    case custom
    case coverPlateAlpha
    case clearBackgroundAndCantTouchView
    case ignore
}
