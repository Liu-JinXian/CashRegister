//
//  ItemsReository.swift
//  cashRegister
//
//  Created by 7690 劉晉賢 on 2021/4/1.
//
import UIKit
import Alamofire
import ObjectMapper

class CashRegisterViewModel {
    
    var reloadData: (() -> ())?
    var setTotalItem: ((Int, Int) -> ())?
    var subViewModels: [CashRegisterItemCollectionViewModel] = []
    var cashRegisterDetailTableViewModels: [CashRegisterDetailTableViewModel] = []
    var bentoModel: [BentoModel]?
    var isInside: Bool? = true
    
    private var cashRegisterModels: [CashRegisterModel] = []
    private var isInModel: Bool?
    private var totalPrice: Int = 0
    private var totalAmount: Int = 0
    private var date: String?
    
    func getItemList() {
        let address = "http://192.168.0.102:3000/Menu"
        Alamofire.request(address).responseJSON { response in
            self.bentoModel = Mapper<BentoModel>().mapArray(JSONObject: response.result.value)
            self.setCellData()
            self.reloadData?()
        }
    }
    
    func onTouchEditing(row: Int) {
        
        cashRegisterModels.remove(at: row)
        setTotal()
    }
    
    func clearUserDeafaults() {
        cashRegisterDetailTableViewModels = []
        cashRegisterModels = []
        setTotal()
    }
    
    func onTouchCashRegister() {
        
        setBuyDetails()
        clearUserDeafaults()
    }
    
    func onTouchCancel() {
        clearUserDeafaults()
    }
}

extension CashRegisterViewModel {
    
    private func setCellData() {
        
        bentoModel?.forEach{ (item) in
            let viewModel = CashRegisterItemCollectionViewModel()
            viewModel.setViewModel(foodItem: item)
            viewModel.onTouchItem = { [weak self] in
                self?.onTouchItem(item: item)
            }
            subViewModels.append(viewModel)
        }
    }
    
    private func onTouchItem(item: BentoModel) {
        
        self.isInModel = false
        
        cashRegisterModels.forEach{ (model) in
            if model.bentoName == item.name {
                model.bentoAmount! += 1
                model.bentoTotalPrice! += model.bentoPrice!
                self.isInModel = true
            }
        }
        
        if isInModel == false {
            let cashRegisterModel = CashRegisterModel()
            cashRegisterModel.bentoName = item.name
            cashRegisterModel.bentoPrice = item.price
            cashRegisterModel.bentoAmount = 1
            cashRegisterModel.bentoTotalPrice = item.price
            cashRegisterModels.append(cashRegisterModel)
        }
        
        setTotal()
    }
    
    private func onTouchLess(item: String) {
        
        for (index, model) in cashRegisterModels.enumerated() {
            if model.bentoName == item {
                model.bentoAmount! -= 1
                model.bentoTotalPrice! -= model.bentoPrice!
                if model.bentoAmount == 0 {
                    cashRegisterModels.remove(at: index)
                }
            }
        }
        
        setTotal()
    }
    
    private func onTouchAdd(item: String) {
        
        cashRegisterModels.forEach{ (model) in
            if model.bentoName == item {
                model.bentoAmount! += 1
                model.bentoTotalPrice! += model.bentoPrice!
            }
        }
        setTotal()
    }
    
    private func setBuyDetails() {
        
        let url = URL(string: "http://192.168.0.102:3000/buyDeatailInsert")!
        if cashRegisterModels.isEmpty == true { return }
        let params = getDictionary()
        let headers: HTTPHeaders = [
            "Authorization": "Basic VXNlcm5hbWU6UGFzc3dvcmQ=",
            "Content-Type": "application/json"
        ]
        print(params)
        print("getPrettyParams: \(getPrettyParams(params)!)")
        
        Alamofire.request(url, method: .post ,parameters: params, encoding: JSONEncoding.default ,headers: headers).validate().responseJSON { (response) in
            if response.result.isSuccess {
                self.reloadData?()
                print("Add success!")
            }else {
                print("error!")
            }
        }
    }
    
    private func getDictionary() -> [String: Any] {
        
        let time = Date()
        let formatter = DateFormatter()
        formatter.locale = Locale.init(identifier: "zh_TW")
        formatter.dateFormat = "yyyy/MM/dd"
        self.date = formatter.string(from: time)
        
        var buyDetails: [[String: Any]] = []
        
        cashRegisterModels.forEach{ (model) in
            let buyDetail = [
                "name": model.bentoName ?? "",
                "price": model.bentoPrice ?? 0,
                "amount": model.bentoAmount ?? 0
            ] as [String : Any]
            
            buyDetails.append(buyDetail)
        }
        
        let params: Parameters = [
            "time": date ?? "",
            "isInSide": "\(isInside ?? false)" ,
            "buyDetails": buyDetails
        ] as [String: Any]
        return params
    }
    
    private func getPrettyParams(_ dict: [String: Any]) -> NSString? {
        let jsonData = try! JSONSerialization.data(withJSONObject: dict, options: .prettyPrinted)
        return NSString(data: jsonData, encoding: String.Encoding.utf8.rawValue)
    }
    
    private func setTotal() {
        
        totalAmount = 0
        totalPrice = 0
        cashRegisterDetailTableViewModels = []
        
        cashRegisterModels.forEach{ (model) in
            totalPrice += model.bentoTotalPrice ?? 0
            totalAmount += model.bentoAmount ?? 0
            
            let viewModel = CashRegisterDetailTableViewModel()
            viewModel.setViewModel(item: model.bentoName ?? "", amount: model.bentoAmount ?? 0, price: model.bentoPrice ?? 0)
            viewModel.onTouchLess = { [weak self] in
                self?.onTouchLess(item: model.bentoName ?? "")
            }
            viewModel.onTouchAdd = { [weak self] in
                self?.onTouchAdd(item: model.bentoName ?? "")
            }
            cashRegisterDetailTableViewModels.append(viewModel)
        }
        
        setTotalItem?(totalAmount, totalPrice)
    }
}
