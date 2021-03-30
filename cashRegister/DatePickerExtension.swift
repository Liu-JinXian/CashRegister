//
//  DatePickerExtension.swift
//  cashRegister
//
//  Created by 7690 劉晉賢 on 2021/3/23.
//

import UIKit

extension UIDatePicker {
    func  setToBasic() {
        self.calendar = Calendar(identifier: .gregorian)
        self.timeZone = TimeZone(abbreviation: "UTC+8:00")
        self.locale = Locale(identifier: "zh_tw")
    }
}
