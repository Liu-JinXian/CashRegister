//
//  MemberRegisterViewModel.swift
//  cashRegister
//
//  Created by 劉晉賢 on 2022/8/4.
//
import RxSwift
import RxCocoa
import ObjectMapper
import Alamofire

class MemberRegisterViewModel: BaseViewModel {
    
    func memberReigster(account: String,
                           password: String,
                           uniform: String,
                           name: String,
                           phone: String) {
        
        let params: Parameters = ["account": account,
                                  "password": password.aesEncrypt() ?? "",
                                  "uniform": uniform,
                                  "name": name,
                                  "phone": phone,
        ]
        let url = URL(string: "http://localhost:3000/staffInfos/addStaff")!
        
        Alamofire.request(url, method: .post ,parameters: params).responseJSON { (response) in
            if response.result.isSuccess {
                print("suessful")
            }else {
                print("error!")
            }
        }
    }
}

