//
//  ItemsReository.swift
//  cashRegister
//
//  Created by 7690 劉晉賢 on 2021/4/1.
//
import UIKit
import Alamofire
import ObjectMapper

class CashRegisterViewModel: NSObject {
    
    var bentoModel: [BentoModel]?
    var reloadData: (() -> ())?
    
    func getItemList() {
        let address = "http://35.234.3.50:3000/Menu"
        Alamofire.request(address).responseJSON { response in
            self.bentoModel = Mapper<BentoModel>().mapArray(JSONObject: response.result.value)
            self.reloadData?()
        }
    }
}
