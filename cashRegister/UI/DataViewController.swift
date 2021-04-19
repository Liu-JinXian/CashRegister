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
        
        tableView.dataSource = self
        tableView.delegate = self
        tableView.register(UINib(nibName: "DataTableViewCell", bundle: nil), forCellReuseIdentifier: "DataTableViewCell")
    }
    
    
    @IBAction func onTouchSearchDateStart(_ sender: Any) {
    }
    
    @IBAction func onTouchSearchDateEnd(_ sender: Any) {
    }
    
    @objc private func datePickerChanged(picker: UIDatePicker) {
        
        let date = FormatUtil.convertDateToString(dateFormatTo: "yyyy/MM/dd", date: picker.date)
        dateStart.setTitle(date, for: .normal)
    }
    
//    @objc private func onTouchDatePickerDone() {
//        datePickerChanged(picker: datePicker)
//    }
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
