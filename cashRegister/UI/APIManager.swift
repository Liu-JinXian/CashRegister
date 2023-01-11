//
//  APIManager.swift
//  cashRegister
//
//  Created by 劉晉賢 on 2022/8/21.
//
import Alamofire

class APIManager {
    static let shared = APIManager()
    
    func checkLogin(uniform: String,account: String, password: String) {
        
        let encryptedPassword: String = password.aesEncrypt() ?? ""
        let params: Parameters = ["uniform": uniform,"account": account, "password": encryptedPassword]
        let url = URL(string: "http://localhost:3000/member/login")!
        
        Alamofire.request(url, method: .post ,parameters: params).responseJSON { (response) in
            //
            //            self.loginResponse = Mapper<LoginResponse>().map(JSONObject: response.result.value)
            //            UserDefaultUtil.shared.memberToken = self.loginResponse?.memberToken ?? ""
            //            UserDefaultUtil.shared.companyToken = self.loginResponse?.companyToken ?? ""
            //            UserDefaultUtil.shared.openForUse = self.loginResponse?.openForUse ?? false
            //
            //            let vc = self.getVC(st: "Main", vc: "MainViewController") as! MainViewController
            //            vc.modalPresentationStyle = .overCurrentContext
            //            self.navigationController?.pushViewController(vc, animated: true)
            //        }
        }
    }
}
