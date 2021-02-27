//
//  ViewController.swift
//  cashRegister
//
//  Created by 劉晉賢 on 2021/2/27.
//

import UIKit

class MainViewController: UIViewController {
    
    @IBOutlet weak var money: UILabel!
    @IBOutlet weak var moneyView: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        moneyView.layer.borderColor = UIColor.black.cgColor
        moneyView.layer.borderWidth = 1.0
        
    }
}

