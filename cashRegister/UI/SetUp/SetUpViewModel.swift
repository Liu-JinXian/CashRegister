//
//  SetUpViewModel.swift
//  cashRegister
//
//  Created by 劉晉賢 on 2021/8/15.
//
import RxSwift
import RxCocoa
import ObjectMapper
import Alamofire

class SetUpViewModel {
    
    var reloadData: (() -> ())?
    var bentoModel: [BentoModel]?
    
    func getBentoData() {
        let address = "http://35.234.3.50:3000/Menu"
        Alamofire.request(address).responseJSON { response in
            self.bentoModel = Mapper<BentoModel>().mapArray(JSONObject: response.result.value)
            self.reloadData?()
        }
    }
    
    func getUpdateLocation(locationTemp: String, locationMove: Int) {
        
        let params: Parameters = ["touch": "\(locationMove)", "temp": locationTemp, "uuid": bentoModel?[locationMove].uuid ?? ""]
        let url = URL(string: "http://35.234.3.50:3000/MenuUpdateLocation")!
        
        Alamofire.request(url, method: .post ,parameters: params).responseJSON { (response) in
            if response.result.isSuccess {
                self.bentoModel = Mapper<BentoModel>().mapArray(JSONObject: response.result.value)
                self.reloadData?()
            }else {
                print("error!")
            }
        }
    }
    
    func setNumberOfItemsInSection() -> Int {
        return bentoModel?.count ?? 0
    }
}
