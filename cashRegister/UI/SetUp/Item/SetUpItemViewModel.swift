//
//  SetUpItemViewModel.swift
//  cashRegister
//
//  Created by 劉晉賢 on 2021/11/16.
//
import RxSwift
import RxCocoa
import ObjectMapper
import Alamofire

class SetUpItemViewModel{
    
    var reloadData: (() -> ())?
    var bentoName: String?
    var bentoPrice: Int?
    var bentoToken: String?
    var add: Bool?
    
    func setViewModel(bentoModel: BentoModel? = nil, add: Bool? = false) {
        self.bentoName = bentoModel?.bentoName
        self.bentoPrice = bentoModel?.bentoPrice
        self.bentoToken = bentoModel?.bentoToken
        self.add = add
    }
    
    func onTouchSave(name: String, price: String) {
        add == false ? updateBentoItem(name: name, price: price) : addBentoItem(name: name, price: price)
    }
}

extension SetUpItemViewModel {
    
    func addBentoItem(name: String, price: String) {
        
        let params: Parameters = ["companyToken": UserDefaultUtil.shared.companyToken ?? "","bentoName": name, "bentoPrice": price]
        let url = URL(string: "http://localhost:3000/menuinfo/menuAdd")!
        
        Alamofire.request(url, method: .post ,parameters: params).response{ (res) in
            if res.response?.statusCode == 200 {
                self.reloadData?()
                print("成功")
            }else {
                print("失敗")
            }
        }
    }
    
    func deleteBentoItem() {
        
        let params: Parameters = ["companyToken": UserDefaultUtil.shared.companyToken ?? "", "bentoToken": bentoToken ?? ""]
        let url = URL(string: "http://localhost:3000/menuinfo/menuDelete")!
        
        Alamofire.request(url, method: .post ,parameters: params).response { (res) in
            if res.response?.statusCode == 200 {
                self.reloadData?()
                print("成功")
            }else {
                print("失敗")
            }
        }
    }
    
    func updateBentoItem(name: String, price: String) {
        
        let params: Parameters = ["companyToken": UserDefaultUtil.shared.companyToken ?? "", "bentoToken": bentoToken ?? "", "bentoName": name, "bentoPrice": price]
        let url = URL(string: "http://localhost:3000/menuinfo/menuUpdate")!
        
        Alamofire.request(url, method: .post ,parameters: params).response { (res) in
            if res.response?.statusCode == 200 {
                self.reloadData?()
                print("成功")
            }else {
                print("失敗")
            }
        }
    }
}
