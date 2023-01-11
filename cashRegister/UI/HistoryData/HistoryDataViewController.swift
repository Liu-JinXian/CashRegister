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
    
    enum Section : Int, CaseIterable {
        case BANNER = 0
        case DATA
    }
    
    var buyDetailModel: [BuyDetailModel] = []
    override func viewDidLoad() {
        super.viewDidLoad()
        
        getDataList()
        //        let date = self.convertDateToString(dateFormatTo: "yyyy/MM/dd", date: Date())
        //        dateStart.setTitle("\(date)", for: .normal)
        //        dateEnd.setTitle("\(date)", for: .normal)
        
        self.navigationItem.rightBarButtonItem =  UIBarButtonItem(image: UIImage(named: "setting"), style: .plain, target: self, action: #selector(onTouchSetting))
        
        self.navigationItem.title = "設定"
        
        let appearance = UINavigationBarAppearance()
        appearance.configureWithOpaqueBackground()
        appearance.backgroundColor = yellow
        self.navigationController?.navigationBar.standardAppearance = appearance;
        self.navigationController?.navigationBar.scrollEdgeAppearance = self.navigationController?.navigationBar.standardAppearance
        
        tableView.dataSource = self
        tableView.delegate = self
        tableView.register(UINib(nibName: "HistoryDataTableViewCell", bundle: nil), forCellReuseIdentifier: "HistoryDataTableViewCell")
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
        
        let vc = getVC(st: "Data", vc: "HistorySettingDataSettingViewController") as! HistorySettingDataSettingViewController
        let nav = UINavigationController(rootViewController: vc)
        nav.modalPresentationStyle = .fullScreen
        self.present(nav, animated: true)
    }
}

extension HistoryDataViewController: UITableViewDelegate {
    
}

extension HistoryDataViewController: UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return Section.allCases.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        let section = Section(rawValue: section)!
        switch section {
        case .BANNER:
            return 1
        case .DATA:
            return buyDetailModel.count
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let section = Section(rawValue: indexPath.section)!
        
        switch section {
        case .BANNER:
            let cell = tableView.dequeueReusableCell(withIdentifier: "HistoryDataTableViewCell", for: indexPath) as! HistoryDataTableViewCell
            cell.setBannerCell()
            return cell
            
        case .DATA:
            let cell = tableView.dequeueReusableCell(withIdentifier: "HistoryDataTableViewCell", for: indexPath) as! HistoryDataTableViewCell
            let viewModel = HistoryDataTableViewMdoel()
            viewModel.setViewModel(buyDetailModel: buyDetailModel[indexPath.row])
            cell.setCell(viewModel: viewModel)
            return cell
        }
    }
}

extension HistoryDataViewController {
    
    func getDataList() {
        let address = "http://localhost:3000/businessInfos"
        Alamofire.request(address).responseJSON { response in
            self.buyDetailModel = Mapper<BuyDetailModel>().mapArray(JSONObject: response.result.value) ?? []
            self.tableView.reloadData()
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
