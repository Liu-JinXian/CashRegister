//
//  SetUpItemViewController.swift
//  cashRegister
//
//  Created by 7690 劉晉賢 on 2021/3/16.
//

import UIKit

extension SetUpItemViewController {
    
    func setView(name: String, price: Int) {
        
        self.name = name
        self.price = price
    }
}

class SetUpItemViewController: BaseViewController {
    
    @IBOutlet weak var enterItem: UITextField!
    @IBOutlet weak var enterPrice: UITextField!
    
    var name: String?
    var price: Int?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        enterItem.text = name
        enterPrice.text = "\(price ?? 0)"
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }
    
    @IBAction func onTouchSave(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction func onTouchCancel(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
}
