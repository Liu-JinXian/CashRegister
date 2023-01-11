//
//  CompanyRegisterViewController.swift
//  cashRegister
//
//  Created by 劉晉賢 on 2022/7/31.
//

import UIKit

class CompanyRegisterViewController: BaseViewController {

    @IBOutlet weak var account: AccPwdTextField!
    @IBOutlet weak var password: AccPwdTextField!
    @IBOutlet weak var uniform: AccPwdTextField!
    @IBOutlet weak var storeName: AccPwdTextField!
    @IBOutlet weak var phone: AccPwdTextField!
    @IBOutlet weak var address: AccPwdTextField!
    
    private var viewModel: CompanyRegisterViewModel?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setView()
        bindViewModel()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        self.navigationItem.title = "公司註冊"
        let appearance = UINavigationBarAppearance()
        appearance.configureWithOpaqueBackground()
        appearance.backgroundColor = yellow
        self.navigationController?.navigationBar.standardAppearance = appearance;
        self.navigationController?.navigationBar.scrollEdgeAppearance = self.navigationController?.navigationBar.standardAppearance
    }
    
    @IBAction func onTouchRegister(_ sender: Any) {
        viewModel?.companyReigster(account: account.text ?? "",
                                   password: password.text ?? "",
                                   uniform: uniform.text ?? "",
                                   storeName: storeName.text ?? "",
                                   phone: phone.text ?? "",
                                   address: address.text ?? "")
    }
}

extension CompanyRegisterViewController {
    private func setView() {
        self.navigationItem.title = "公司註冊"
        
        let appearance = UINavigationBarAppearance()
        appearance.configureWithOpaqueBackground()
        appearance.backgroundColor = yellow
        self.navigationController?.navigationBar.standardAppearance = appearance;
        self.navigationController?.navigationBar.scrollEdgeAppearance = self.navigationController?.navigationBar.standardAppearance
    }
    
    private func bindViewModel() {
        viewModel = CompanyRegisterViewModel()
    }
}
