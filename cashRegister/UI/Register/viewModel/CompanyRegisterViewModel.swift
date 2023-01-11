//
//  CompanyRegisterViewModel.swift
//  cashRegister
//
//  Created by 劉晉賢 on 2022/8/1.
//
import RxSwift
import RxCocoa
import ObjectMapper
import Alamofire

class CompanyRegisterViewModel: BaseViewModel {
    
    func companyReigster(account: String,
                           password: String,
                           uniform: String,
                           storeName: String,
                           phone: String,
                           address: String) {
        
        let params: Parameters = ["account": account,
                                  "password": password.aesEncrypt() ?? "",
                                  "uniform": uniform,
                                  "storeName": storeName,
                                  "phone": phone,
                                  "address": address,
        ]
        let url = URL(string: "http://localhost:3000/compamyInfos/addCompanys")!
        
        Alamofire.request(url, method: .post ,parameters: params).responseJSON { (response) in
            
            switch response.response?.statusCode {
            case 200:
                print("【回應】requestURL: 200")
                print("----------------------------")
                return
            default:
                return
            }
        }
    }
}
