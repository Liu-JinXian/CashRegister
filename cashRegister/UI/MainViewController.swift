//
//  ViewController.swift
//  cashRegister
//
//  Created by 劉晉賢 on 2021/2/27.
//

import UIKit

class MainViewController: UIViewController {
        
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
    
    @IBAction func onTouchCashRegister(_ sender: Any) {
        let storyboard = UIStoryboard(name: "CashRegister", bundle: Bundle.main)
        let viewController: CashRegisterViewController = storyboard.instantiateViewController(withIdentifier: "CashRegisterViewController") as! CashRegisterViewController

        self.navigationController?.pushViewController(viewController, animated: true)
    }
}

