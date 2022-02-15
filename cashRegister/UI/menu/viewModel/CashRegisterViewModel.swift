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
    
    var bentoModel: [BentoModel]?
    var subViewModels: [MenuCollectionCellViewModel] = []
    
    var cashRegisterModels: [CashRegisterModel] = []
    var isInModel: Bool?
    var totalprice: Int = 0
    var totalamount: Int = 0
    var date: String?
    var isInside: Bool? = true
    
    var itemTableViewModel: ItemTableViewModel?
    
    var reloadData: (() -> ())?
    var setTotalItem: ((Int, Int) -> ())?
    
    func getItemList() {
        let address = "http://localhost:3000/Menu"
        Alamofire.request(address).responseJSON { response in
            self.bentoModel = Mapper<BentoModel>().mapArray(JSONObject: response.result.value)
            self.setCellData()
            self.reloadData?()
        }
    }
    
    func onTouchEditing(indexPath: IndexPath) {
        
        cashRegisterModels.remove(at: indexPath.row)
        setTotal()
    }
    
    func clearUserDeafaults() {
        cashRegisterModels = []
        totalprice = 0
        totalamount = 0
    }
    
    func setItemTableViewModel(indexPath: IndexPath) {
        
        itemTableViewModel = ItemTableViewModel()
        itemTableViewModel?.setViewModel(item: cashRegisterModels[indexPath.row].bentoName ?? "",
                                         amount: cashRegisterModels[indexPath.row].bentoAmount ?? 0,
                                         price: cashRegisterModels[indexPath.row].bentoTotalPrice ?? 0)
        
        itemTableViewModel?.onTouchLess = { [weak self] in
            self?.onTouchLess(item: self?.cashRegisterModels[indexPath.row].bentoName ?? "")
        }
        itemTableViewModel?.onTouchAdd = { [weak self] in
            self?.onTouchAdd(item: self?.cashRegisterModels[indexPath.row].bentoName ?? "")
        }
    }
    
    func onTouchCashRegister() {
        
        setAll()
        setBuyDetails()
        clearUserDeafaults()
        totalprice = 0
        setTotalItem?(totalamount, totalprice)
    }
    
    func onTouchCancel() {
        clearUserDeafaults()
        cashRegisterModels = []
        totalprice = 0
        setTotalItem?(totalamount, totalprice)
    }
}

extension CashRegisterViewModel {
    
    private func setCellData() {
        bentoModel?.forEach{ (item) in
            let viewModel = MenuCollectionCellViewModel()
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
    
    private func setAll() {
        
        let time = Date()
        let formatter = DateFormatter()
        formatter.locale = Locale.init(identifier: "zh_TW")
        formatter.dateFormat = "yyyy/MM/dd"
        self.date = formatter.string(from: time)
    }
    
    private func setBuyDetails() {
        
        let url = URL(string: "http://localhost:3000/buyDeatailInsert")!
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
        totalamount = 0
        totalprice = 0
        
        cashRegisterModels.forEach{ (model) in
            totalprice += model.bentoTotalPrice ?? 0
            totalamount += model.bentoAmount ?? 0
        }
        setTotalItem?(totalamount, totalprice)
    }
}
