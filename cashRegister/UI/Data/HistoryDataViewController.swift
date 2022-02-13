//
//  DataViewController.swift
//  cashRegister
//
//  Created by 7690 劉晉賢 on 2021/3/12.
//
import UIKit
import Alamofire
import ObjectMapper

class HistoryDataViewController: BaseViewController {
    
    @IBOutlet weak var tableView: UITableView!
    
    var buyDetailModel: [BuyDetailModel] = []
    override func viewDidLoad() {
        super.viewDidLoad()
        
        getDataList()
        //        let date = self.convertDateToString(dateFormatTo: "yyyy/MM/dd", date: Date())
        //        dateStart.setTitle("\(date)", for: .normal)
        //        dateEnd.setTitle("\(date)", for: .normal)
        
        self.navigationItem.rightBarButtonItem =  UIBarButtonItem(image: UIImage(named: "setting"), style: .plain, target: self, action: #selector(onTouchSetting))
        
        tableView.dataSource = self
        tableView.delegate = self
        tableView.register(UINib(nibName: "DataTableViewCell", bundle: nil), forCellReuseIdentifier: "DataTableViewCell")
    }
    
    
    func convertDateToString(dateFormatTo: String, date: Date, amSymbolTo: String? = nil, pmSymbolTo: String? = nil) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.setToBasic(dateFormat: dateFormatTo, amSymbol: amSymbolTo, pmSymbol: pmSymbolTo)
        return dateFormatter.string(from: date)
    }
    
    //    @IBAction func onTouchSearchDateStart(_ sender: Any) {
    //
    //        let vc = getVC(st: "Data", vc: "DatePickViewController") as! DatePickViewController
    //        vc.modalPresentationStyle = .overCurrentContext
    //        vc.delegate = self
    //        self.present(vc, animated: true)
    //    }
    
    //    @IBAction func onTouchSearchDateEnd(_ sender: Any) {
    
    //        let vc = getVC(st: "Data", vc: "DatePickViewController") as! DatePickViewController
    //        vc.modalPresentationStyle = .overCurrentContext
    //        vc.delegate = self
    //        self.present(vc, animated: true)
    //    }
    
    @objc private func onTouchSetting() {
        
        let vc = getVC(st: "Data", vc: "DataSettingViewController") as! DataSettingViewController
        self.present(vc, animated: true)
    }
}

extension HistoryDataViewController: UITableViewDelegate {
    
}

extension HistoryDataViewController: UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "DataTableViewCell", for: indexPath) as! HistoryDataTableViewCell
        return cell
    }
}

extension HistoryDataViewController {
    
    func getDataList() {
        let address = "http://localhost:3000/buyDeatail"
        Alamofire.request(address).responseJSON { response in
            self.buyDetailModel = Mapper<BuyDetailModel>().mapArray(JSONObject: response.result.value) ?? []
            print(self.getPrettyPrint(response.result.value!))
        }
    }
    
    private func getPrettyPrint(_ responseValue: Any) -> String {
        var string: String = ""
        if let data = try? JSONSerialization.data(withJSONObject: responseValue, options: .prettyPrinted) {
            if let nstr = NSString(data: data, encoding: String.Encoding.utf8.rawValue) {
                string = nstr as String
            }
        }
        return string
    }
}

//extension DataViewController: DatePickProtocol {
//    func onTouchSetDate(datePickerDate: Date) {
//        let date = self.convertDateToString(dateFormatTo: "yyyy/MM/dd", date: datePickerDate)
//        dateStart.setTitle("\(date)", for: .normal)
//    }
//}
