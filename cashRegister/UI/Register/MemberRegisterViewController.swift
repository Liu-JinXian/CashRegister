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
    @IBOutlet weak var storeName: AccPwdTextField!
    @IBOutlet weak var position: AccPwdTextField!
    @IBOutlet weak var phone: AccPwdTextField!
    @IBOutlet weak var name: AccPwdTextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        self.navigationItem.title = "註冊"
        let appearance = UINavigationBarAppearance()
        appearance.configureWithOpaqueBackground()
        appearance.backgroundColor = yellow
        self.navigationController?.navigationBar.standardAppearance = appearance;
        self.navigationController?.navigationBar.scrollEdgeAppearance = self.navigationController?.navigationBar.standardAppearance
    }
}
