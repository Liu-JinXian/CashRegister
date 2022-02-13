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
    
    var items: [String] = []
    var amounts: [Int] = []
    var itemTotalPrices: [Int] = []
    var itemPrices: [Int] = []
    
    var amount: Int = 0
    var price: Int = 0
    var totalprice: Int = 0
    var totalamount: Int = 0
    var date: String?
    var isInside: Bool? = true
    
    var itemTableViewModel: ItemTableViewModel?
    
    var buyDetails: [BuyDetailResponse] = []
    
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
        
        totalprice -= itemTotalPrices[indexPath.row]
        totalamount -= amounts[indexPath.row]
        
        items.remove(at: indexPath.row)
        amounts.remove(at: indexPath.row)
        itemTotalPrices.remove(at: indexPath.row)
        
        setTotalItem?(totalamount, totalprice)
    }
    
    func clearUserDeafaults() {
        itemPrices = []
        items = []
        amounts = []
        itemTotalPrices = []
        price = 0
        totalprice = 0
        totalamount = 0
    }
    
    func setItemTableViewModel(indexPath: IndexPath) {
        
        itemTableViewModel = ItemTableViewModel()
        itemTableViewModel?.setViewModel(item: items[indexPath.row] ,amount: amounts[indexPath.row] ,price: itemPrices[indexPath.row])
        itemTableViewModel?.onTouchLess = { [weak self] in
            self?.onTouchLess(item: self?.items[indexPath.row] ?? "")
        }
        itemTableViewModel?.onTouchAdd = { [weak self] in
            self?.onTouchAdd(item: self?.items[indexPath.row] ?? "")
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
        
        if items.contains(item.name ?? "") == false {
            items.append(item.name ?? "")
            amounts.append(1)
            itemPrices.append(item.price ?? 0)
            itemTotalPrices.append(item.price ?? 0)
        } else {
            amount = amounts[items.firstIndex(of: item.name ?? "") ?? 0]
            amount += 1
            amounts[items.firstIndex(of: item.name ?? "") ?? 0] = amount
            
            self.price = itemTotalPrices[items.firstIndex(of: item.name ?? "") ?? 0]
            self.price += item.price ?? 0
            itemTotalPrices[items.firstIndex(of: item.name ?? "") ?? 0] = self.price
        }
        
        totalprice += item.price ?? 0
        totalamount += 1
        amount = 0
        setTotalItem?(totalamount, totalprice)
    }
    
    private func onTouchLess(item: String) {
        
        amount = amounts[items.firstIndex(of: item) ?? 0]
        amount -= 1
        
        if amount == 0 {
            
            totalprice -= itemTotalPrices[items.firstIndex(of: item) ?? 0]
            totalamount -= amounts[items.firstIndex(of: item) ?? 0]
            
            let row = items.firstIndex(of: item)
            items.remove(at: row ?? 0)
            amounts.remove(at: row ?? 0)
            itemTotalPrices.remove(at: row ?? 0)
            setTotalItem?(totalamount, totalprice)
            
        } else {
            
            amount = amounts[items.firstIndex(of: item) ?? 0]
            self.price = itemTotalPrices[items.firstIndex(of: item) ?? 0]
            totalprice -= price
            self.price = self.price/amount
            amount -= 1
            amounts[items.firstIndex(of: item) ?? 0] = amount
            
            self.price = self.price * amount
            itemTotalPrices[items.firstIndex(of: item) ?? 0] = self.price
            totalprice += price
            totalamount -= 1
            amount = 0
            setTotalItem?(totalamount, totalprice)
        }
    }
    
    private func onTouchAdd(item: String) {
        
        amount = amounts[items.firstIndex(of: item) ?? 0]
        price = itemTotalPrices[items.firstIndex(of: item) ?? 0]
        totalprice -= price
        price = price/amount
        amount += 1
        amounts[items.firstIndex(of: item) ?? 0] = amount
        
        price = price * amount
        totalprice += price
        itemTotalPrices[items.firstIndex(of: item) ?? 0] = self.price
        
        totalamount += 1
        amount = 0
        setTotalItem?(totalamount, totalprice)
    }
    
    private func setAll() {
        buyDetails = []
        
        for (index, item) in items.enumerated() {
            let buyDetail = BuyDetailResponse()
            buyDetail.name = item
            buyDetail.amount = amounts[index]
            buyDetail.price = itemPrices[index]
            buyDetails.append(buyDetail)
        }
        
        let time = Date()
        let formatter = DateFormatter()
        formatter.locale = Locale.init(identifier: "zh_TW")
        formatter.dateFormat = "yyyy/MM/dd"
        self.date = formatter.string(from: time)
    }
    
    private func setBuyDetails() {
        
        let url = URL(string: "http://localhost:3000/buyDeatailInsert")!
        if buyDetails == [] { return }
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
        
        var a: [[String: Any]] = []
        
        buyDetails.forEach{ (item) in
            let abc = [
                "name": item.name ?? "",
                "price": item.price ?? 0,
                "amount": item.amount ?? 0
            ] as [String : Any]
            
            a.append(abc)
        }
        
        let params: Parameters = [
            "time": date ?? "",
            "isInSide": "\(isInside ?? false)" ,
            "buyDetails": buyDetails.toJSON()
        ] as [String: Any]
        return params
    }
    
    private func getPrettyParams(_ dict: [String: Any]) -> NSString? {
        let jsonData = try! JSONSerialization.data(withJSONObject: dict, options: .prettyPrinted)
        return NSString(data: jsonData, encoding: String.Encoding.utf8.rawValue)
    }
}
