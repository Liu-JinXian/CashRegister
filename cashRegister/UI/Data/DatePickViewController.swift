//
//  DatePickViewController.swift
//  cashRegister
//
//  Created by 劉晉賢 on 2021/9/21.
//

import UIKit

protocol DatePickProtocol : NSObjectProtocol {
    func onTouchSetDate(datePickerDate: Date)
}

class DatePickViewController: BaseViewController {
    
    @IBOutlet weak var datePicker: UIDatePicker!
    
    var delegate: DatePickProtocol?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let calendar: NSCalendar = NSCalendar(calendarIdentifier: NSCalendar.Identifier.gregorian)!
        let currentDate = NSDate()
        let dateComponents = NSDateComponents()
        
        
        
        let maxDate = calendar.date(byAdding: dateComponents as DateComponents, to: currentDate as Date, options: NSCalendar.Options(rawValue: 0))
        datePicker.locale = Locale(identifier: "zh_TW")
        self.datePicker.maximumDate = maxDate
    }
    
    @IBAction func onTouchSet(_ sender: Any) {
        let datePickerDate = datePicker.date
        self.delegate?.onTouchSetDate(datePickerDate: datePickerDate)
        
        self.dismiss(animated: true, completion: nil)
    }
}
