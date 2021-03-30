//
//  DataViewController.swift
//  cashRegister
//
//  Created by 7690 劉晉賢 on 2021/3/12.
//

import UIKit

class DataViewController: BaseViewController {
    
//    private var datePickerTop: NSLayoutConstraint!
//    private var datePicker: UIDatePicker = {
//        let view = UIDatePicker()
//        view.translatesAutoresizingMaskIntoConstraints = false
//        view.setToBasic()
//        view.datePickerMode = .dateAndTime
//        view.addTarget(self, action: #selector(datePickerChanged(picker:)), for: .valueChanged)
//        return view
//    }()
//
//    private lazy var toolBarOnDatePicker : UIToolbar = {
//        let toolBar = UIToolbar()
//        toolBar.translatesAutoresizingMaskIntoConstraints = false
//        let doneBottom = UIBarButtonItem(title: "完成", style: .plain, target: self, action: #selector(self.onTouchDatePickerDone))
//        let lexibeSpace = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
//        toolBar.setItems([lexibeSpace, doneBottom], animated: true)
//        toolBar.isUserInteractionEnabled = true
//
//        return toolBar
//    }()
//
//    private func layoutDatePicker(){
//        view.addSubview(datePicker)
//        view.addSubview(toolBarOnDatePicker)
//
//        datePicker.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
//        datePicker.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
//
//        toolBarOnDatePicker.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
//        toolBarOnDatePicker.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
//
//        datePickerTop = toolBarOnDatePicker.topAnchor.constraint(equalTo: view.bottomAnchor)
//        datePickerTop.isActive = true
//
//        datePicker.topAnchor.constraint(equalTo: toolBarOnDatePicker.bottomAnchor, constant: 0).isActive = true
//    }
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var dateStart: UIButton!
    @IBOutlet weak var dateEnd: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
//        datePicker.backgroundColor = UIColor.white
//        if #available(iOS 14.0, *) {
//            datePicker.preferredDatePickerStyle = .wheels
//            datePicker.backgroundColor = UIColor.white
//            datePicker.sizeToFit()
//        }
//        layoutDatePicker()
        
        tableView.dataSource = self
        tableView.delegate = self
        tableView.register(UINib(nibName: "DataTableViewCell", bundle: nil), forCellReuseIdentifier: "DataTableViewCell")
    }
    
    
    @IBAction func onTouchSearchDateStart(_ sender: Any) {
        
//        datePicker.date = Date()
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
