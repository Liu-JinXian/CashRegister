//
//  LoginViewController.swift
//  cashRegister
//
//  Created by 劉晉賢 on 2022/4/2.
//
import UIKit
import Alamofire
import ObjectMapper

class LoginViewController: BaseViewController {
    
    @IBOutlet weak var account: AccPwdTextField!
    @IBOutlet weak var password: AccPwdTextField!
    @IBOutlet weak var uniform: AccPwdTextField!
    
    private var loginResponse: LoginResponse?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.navigationBar.isHidden = true
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        self.navigationItem.title = "登入"
        let appearance = UINavigationBarAppearance()
        appearance.configureWithOpaqueBackground()
        appearance.backgroundColor = yellow
        self.navigationController?.navigationBar.standardAppearance = appearance;
        self.navigationController?.navigationBar.scrollEdgeAppearance = self.navigationController?.navigationBar.standardAppearance
    }
    
    @IBAction func onTouchLogin(_ sender: Any) {
        checkLogin(uniform: uniform.text ?? "", account: account.text ?? "", password: password.text ?? "")
    }
    
    @IBAction func onTouchRegister(_ sender: Any) {
        let vc = getVC(st: "Register", vc: "MemberRegisterViewController") as! MemberRegisterViewController
        vc.modalPresentationStyle = .overCurrentContext
        let nav = UINavigationController(rootViewController: vc)
        nav.restorationIdentifier = "MainViewController"
        nav.modalPresentationStyle = .fullScreen
        self.present(nav, animated: true)
    }
}

extension LoginViewController {
    
    func checkLogin(uniform: String,account: String, password: String) {
                
        let encryptedPassword: String = password.aesEncrypt() ?? ""
        let params: Parameters = ["uniform": uniform,"account": account, "password": encryptedPassword]
        let url = URL(string: "http://localhost:3000/member/login")!
        
        Alamofire.request(url, method: .post ,parameters: params).responseJSON { (response) in
            self.loginResponse = Mapper<LoginResponse>().map(JSONObject: response.result.value)
            UserDefaultUtil.shared.memberToken = self.loginResponse?.memberToken ?? ""
            UserDefaultUtil.shared.companyToken = self.loginResponse?.companyToken ?? ""
            UserDefaultUtil.shared.openForUse = self.loginResponse?.openForUse ?? false
            
            let vc = self.getVC(st: "Main", vc: "MainViewController") as! MainViewController
            vc.modalPresentationStyle = .overCurrentContext
            self.navigationController?.pushViewController(vc, animated: true)
        }
    }
}
