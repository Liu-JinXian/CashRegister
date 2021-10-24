//
//  DataViewController.swift
//  cashRegister
//
//  Created by 7690 劉晉賢 on 2021/3/12.
//

import UIKit

class DataViewController: BaseViewController {
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var dateStart: UIButton!
    @IBOutlet weak var dateEnd: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let date = self.convertDateToString(dateFormatTo: "yyyy/MM/dd", date: Date())
        dateStart.setTitle("\(date)", for: .normal)
        dateEnd.setTitle("\(date)", for: .normal)
        
        tableView.dataSource = self
        tableView.delegate = self
        tableView.register(UINib(nibName: "DataTableViewCell", bundle: nil), forCellReuseIdentifier: "DataTableViewCell")
    }
    
    
    func convertDateToString(dateFormatTo: String, date: Date, amSymbolTo: String? = nil, pmSymbolTo: String? = nil) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.setToBasic(dateFormat: dateFormatTo, amSymbol: amSymbolTo, pmSymbol: pmSymbolTo)
        return dateFormatter.string(from: date)
    }
    
    @IBAction func onTouchSearchDateStart(_ sender: Any) {
        
        let vc = getVC(st: "Data", vc: "DatePickViewController") as! DatePickViewController
        vc.modalPresentationStyle = .overCurrentContext
        vc.delegate = self
        self.present(vc, animated: true)
    }
    
    @IBAction func onTouchSearchDateEnd(_ sender: Any) {
        
        let vc = getVC(st: "Data", vc: "DatePickViewController") as! DatePickViewController
        vc.modalPresentationStyle = .overCurrentContext
        vc.delegate = self
        self.present(vc, animated: true)
    }
}

extension DataViewController: UITableViewDelegate {
    
}

extension DataViewController: UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "DataTableViewCell", for: indexPath) as! DataTableViewCell
        return cell
    }
}

extension DataViewController: DatePickProtocol {
    func onTouchSetDate(datePickerDate: Date) {
        let date = self.convertDateToString(dateFormatTo: "yyyy/MM/dd", date: datePickerDate)
        dateStart.setTitle("\(date)", for: .normal)
    }
}
