//
//  CashRegisterViewController.swift
//  cashRegister
//
//  Created by 劉晉賢 on 2021/2/27.
//

import UIKit

class CashRegisterViewController: UIViewController {
    
    @IBOutlet weak var money: UILabel!
    @IBOutlet weak var moneyView: UIView!
    @IBOutlet weak var foodItemCollectionView: UICollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        moneyView.layer.borderColor = UIColor.black.cgColor
        moneyView.layer.borderWidth = 1.0
        
    }
    
    @IBAction func onTouchBack(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
}

