//
//  ViewController.swift
//  cashRegister
//
//  Created by 劉晉賢 on 2021/2/27.
//

import UIKit

class MainViewController: BaseViewController {
    
    @IBOutlet weak var cashRegister: UIButton!
    @IBOutlet weak var checkOut: UIButton!
    @IBOutlet weak var historyData: UIButton!
    @IBOutlet weak var setUp: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        cashRegister.layer.cornerRadius = 5
        checkOut.layer.cornerRadius = 5
        historyData.layer.cornerRadius = 5
        setUp.layer.cornerRadius = 5
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
        
        let vc = getVC(st: "Data", vc: "DataViewController") as! DataViewController
        vc.modalPresentationStyle = .overCurrentContext
        let nav = UINavigationController(rootViewController: vc)
        nav.restorationIdentifier = "MainViewController"
        nav.modalPresentationStyle = .fullScreen
        self.present(nav, animated: true)
    }
    
    @IBAction func onTouchSetUp(_ sender: Any) {
            
        let vc = getVC(st: "StepUp", vc: "StepUpViewController") as! StepUpViewController
        vc.modalPresentationStyle = .overCurrentContext
        let nav = UINavigationController(rootViewController: vc)
        nav.restorationIdentifier = "MainViewController"
        nav.modalPresentationStyle = .fullScreen
        self.present(nav, animated: true)
    }
}
