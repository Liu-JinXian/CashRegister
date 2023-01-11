//
//  MemberRegisterViewController.swift
//  cashRegister
//
//  Created by 劉晉賢 on 2022/4/3.
//

import UIKit

class MemberRegisterViewController: BaseViewController {

    @IBOutlet weak var account: AccPwdTextField!
    @IBOutlet weak var password: AccPwdTextField!
    @IBOutlet weak var uniform: AccPwdTextField!
    @IBOutlet weak var phone: AccPwdTextField!
    @IBOutlet weak var name: AccPwdTextField!
    
    private var viewModel: MemberRegisterViewModel?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        bindViewModel()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        self.navigationItem.title = "員工註冊"
        let appearance = UINavigationBarAppearance()
        appearance.configureWithOpaqueBackground()
        appearance.backgroundColor = yellow
        self.navigationController?.navigationBar.standardAppearance = appearance;
        self.navigationController?.navigationBar.scrollEdgeAppearance = self.navigationController?.navigationBar.standardAppearance
    }
    
    @IBAction func onTouchRegister(_ sender: Any) {
        viewModel?.memberReigster(account: account.text ?? "",
                                  password: password.text ?? "",
                                  uniform: uniform.text ?? "",
                                  name: name.text ?? "",
                                  phone: phone.text ?? "")
    }
    
    private func bindViewModel() {
        viewModel = MemberRegisterViewModel()
    }
}
