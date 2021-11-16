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
    
    var name: String?
    var price: Int?
    var row: Int?
    var add: Bool?
    
    func setViewModel(bentoModel: BentoModel, add: Bool? = false) {
        self.name = bentoModel.name
    }
    
    func setViewModel(name: String, price: Int, row: Int? = nil, add: Bool? = false) {
        
        self.name = name
        self.row = row
        self.price = price
        self.add = add
    }
    
    func onTouchSave() {
        add == false ? updateBentoItem() : addBentoItem()
    }
}

extension SetUpItemViewModel {
    
    func addBentoItem() {
        
        let params: Parameters = ["name": name ?? "", "price": "\(price ?? 0)"]
        let url = URL(string: "http://35.234.3.50:3000/MenuInsert")!
        
        Alamofire.request(url, method: .post ,parameters: params).responseJSON { (response) in
            if response.result.isSuccess {
                print("Add success!")
            }else {
                print("error!")
            }
        }
    }
    
    func deleteBentoItem() {
        
        let params: Parameters = ["name": name ?? "", "price": "\(price ?? 0)"]
        let url = URL(string: "http://35.234.3.50:3000/MenuDelete")!
        
        Alamofire.request(url, method: .post ,parameters: params).responseJSON { (response) in
            if response.result.isSuccess {
                print("Delete successfully!")
            }else {
                print("error!")
            }
        }
    }
    
    func updateBentoItem() {
        
        let params: Parameters = ["location":"\(row ?? 0)", "name": name ?? "", "price": "\(price ?? 0)"]
        let url = URL(string: "http://35.234.3.50:3000/MenuUpdate")!
        
        Alamofire.request(url, method: .post ,parameters: params).responseJSON { (response) in
            if response.result.isSuccess {
                print("update successfully!")
            }else {
                print("error!")
            }
        }
    }
}
