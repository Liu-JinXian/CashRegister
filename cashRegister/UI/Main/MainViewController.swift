//
//  ViewController.swift
//  cashRegister
//
//  Created by 劉晉賢 on 2021/2/27.
//

import UIKit

class MainViewController: BaseViewController {
    
    @IBOutlet weak var cashRegister: UIButton!
    @IBOutlet weak var historyData: UIButton!
    @IBOutlet weak var setUp: UIButton!
    @IBOutlet weak var logout: UIButton!
    @IBOutlet weak var memberProfile: UIButton!
    @IBOutlet weak var errorText: UILabel!
    @IBOutlet weak var errorView: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if openForUse == false {
            self.historyData.isEnabled = false
        }
        
        errorView.isHidden = true
        
        cashRegister.layer.cornerRadius = 12
        logout.layer.cornerRadius = 12
        historyData.layer.cornerRadius = 12
        setUp.layer.cornerRadius = 12
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        self.navigationController?.navigationBar.isHidden = true
    }
    
    @IBAction func onTouchCashRegister(_ sender: Any) {
        
        let vc = getVC(st: "CashRegister", vc: "CashRegisterViewController") as! CashRegisterViewController
        vc.modalPresentationStyle = .overCurrentContext
        let nav = UINavigationController(rootViewController: vc)
        nav.restorationIdentifier = "MainViewController"
        nav.modalPresentationStyle = .fullScreen
        self.present(nav, animated: true)
    }
    
    @IBAction func onTouchData(_ sender: Any) {
        
        if historyData.isEnabled == false {
            self.errorText.text = "您沒有權限使用此功能"
            self.errorView.isHidden = true
            
            UIView.animate(withDuration: 0.5, animations: {
                self.errorView.alpha = 1
                
            }, completion: { after in
                if after {
                    UIView.animate(withDuration: 0.5, delay: 2, options: .allowUserInteraction, animations: {
                        self.errorView.alpha = 0
                    })
                }
            })
        
        }else {
            let vc = getVC(st: "Data", vc: "DataViewController") as! HistoryDataViewController
            vc.modalPresentationStyle = .overCurrentContext
            let nav = UINavigationController(rootViewController: vc)
            nav.restorationIdentifier = "MainViewController"
            nav.modalPresentationStyle = .fullScreen
            self.present(nav, animated: true)
        }
        

    }
    
    @IBAction func onTouchSetUp(_ sender: Any) {
            
        let vc = getVC(st: "StepUp", vc: "StepUpViewController") as! SetUpViewController
        vc.modalPresentationStyle = .overCurrentContext
        let nav = UINavigationController(rootViewController: vc)
        nav.restorationIdentifier = "MainViewController"
        nav.modalPresentationStyle = .fullScreen
        self.present(nav, animated: true)
    }
    
    @IBAction func onTouchLogout(_ sender: Any) {
        
        let vc = getVC(st: "Main", vc: "LoginViewController") as! LoginViewController
        vc.modalPresentationStyle = .overCurrentContext
        let nav = UINavigationController(rootViewController: vc)
        nav.restorationIdentifier = "MainViewController"
        nav.modalPresentationStyle = .fullScreen
        self.present(nav, animated: true)
    }
    
    @IBAction func onTouchMemberProfile(_ sender: Any) {
        let vc = getVC(st: "Register", vc: "CompanyRegisterViewController") as! CompanyRegisterViewController
        vc.modalPresentationStyle = .overCurrentContext
        let nav = UINavigationController(rootViewController: vc)
        nav.restorationIdentifier = "MainViewController"
        nav.modalPresentationStyle = .fullScreen
        self.present(nav, animated: true)
    }
}
