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
    var name: String?
    var price: Int?
    var id: String?
    var add: Bool?
    
    func setViewModel(bentoModel: BentoModel? = nil, add: Bool? = false) {
        self.name = bentoModel?.name
        self.price = bentoModel?.price
        self.id = bentoModel?.uuid
        self.add = add
    }
    
    func onTouchSave(name: String, price: String) {
        add == false ? updateBentoItem(name: name, price: price) : addBentoItem(name: name, price: price)
    }
}

extension SetUpItemViewModel {
    
    func addBentoItem(name: String, price: String) {
        
        let params: Parameters = ["name": name, "price": price]
        let url = URL(string: "http://192.168.0.102:3000/MenuInsert")!
        
        Alamofire.request(url, method: .post ,parameters: params).responseJSON { (response) in
            if response.result.isSuccess {
                self.reloadData?()
                print("Add success!")
            }else {
                print("error!")
            }
        }
    }
    
    func deleteBentoItem() {
        
        let params: Parameters = ["id": id ?? ""]
        let url = URL(string: "http://192.168.0.102:3000/MenuDelete")!
        
        Alamofire.request(url, method: .post ,parameters: params).responseJSON { (response) in
            switch response.result {
            case .success:
                self.reloadData?()
                print("Delete successfully!")
            case .failure:
                print("error")
            }
        }
    }
    
    func updateBentoItem(name: String, price: String) {
        
        let params: Parameters = ["id": id ?? "", "name": name, "price": price]
        let url = URL(string: "http://192.168.0.102:3000/MenuUpdate")!
        
        Alamofire.request(url, method: .post ,parameters: params).responseJSON { (response) in
            if response.result.isSuccess {
                self.reloadData?()
                print("update successfully!")
            }else {
                print("error!")
            }
        }
    }
}
