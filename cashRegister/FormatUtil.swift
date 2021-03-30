//
//  FormatUtil.swift
//  cashRegister
//
//  Created by 7690 劉晉賢 on 2021/3/23.
//

import UIKit

class FormatUtil: NSObject {
    
    static func convertDateToString(dateFormatTo: String, date: Date, amSymbolTo: String? = nil, pmSymbolTo: String? = nil) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.setToBasic(dateFormat: dateFormatTo, amSymbol: amSymbolTo, pmSymbol: pmSymbolTo)
        return dateFormatter.string(from: date)
    }
}
