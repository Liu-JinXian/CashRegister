//
//  DatePickViewController.swift
//  cashRegister
//
//  Created by 劉晉賢 on 2021/9/21.
//

import UIKit

extension DatePickViewController {
    func setView(viewModel: DatePickViewModel) {
        self.viewModel = viewModel
    }
}

class DatePickViewController: BaseViewController {
    
    @IBOutlet weak var datePicker: UIDatePicker!
    
    private var viewModel: DatePickViewModel?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let appearance = UINavigationBarAppearance()
        appearance.configureWithOpaqueBackground()
        self.navigationController?.navigationBar.standardAppearance = appearance;
        self.navigationController?.navigationBar.scrollEdgeAppearance = self.navigationController?.navigationBar.standardAppearance
        
        let calendar: NSCalendar = NSCalendar(calendarIdentifier: NSCalendar.Identifier.gregorian)!
        let currentDate = NSDate()
        let dateComponents = NSDateComponents()
        
        let maxDate = calendar.date(byAdding: dateComponents as DateComponents, to: currentDate as Date, options: NSCalendar.Options(rawValue: 0))
        datePicker.locale = Locale(identifier: "zh_TW")
        self.datePicker.maximumDate = maxDate
    }
    
    @IBAction func onTouchSet(_ sender: Any) {
        let datePickerDate = datePicker.date
        let date = self.convertDateToString(dateFormatTo: "yyyy/MM/dd", date: datePickerDate)
        viewModel?.onTouchDate?(date)
        
        self.dismiss(animated: true, completion: nil)
    }
    
    func convertDateToString(dateFormatTo: String, date: Date, amSymbolTo: String? = nil, pmSymbolTo: String? = nil) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.setToBasic(dateFormat: dateFormatTo, amSymbol: amSymbolTo, pmSymbol: pmSymbolTo)
        return dateFormatter.string(from: date)
    }
}
