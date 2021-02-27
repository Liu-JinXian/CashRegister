//
//  ViewController.swift
//  cashRegister
//
//  Created by 劉晉賢 on 2021/2/27.
//

import UIKit

class MainViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    @IBAction func onTouchCashRegister(_ sender: Any) {
        let storyboard = UIStoryboard(name: "CashRegister", bundle: Bundle.main)
        let viewController: CashRegisterViewController = storyboard.instantiateViewController(withIdentifier: "CashRegisterViewController") as! CashRegisterViewController
//        viewController.getLocationList(locationResponse: locationResponse)
//        viewController.delegate = self
        
//        let navigationViewController = UINavigationController(rootViewController: viewController)
        viewController.modalPresentationStyle = .fullScreen
        self.present(viewController, animated: true, completion: nil)
    }
}

