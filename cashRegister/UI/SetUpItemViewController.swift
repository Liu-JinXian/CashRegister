//
//  SetUpItemViewController.swift
//  cashRegister
//
//  Created by 7690 劉晉賢 on 2021/3/16.
//

import UIKit

extension SetUpItemViewController {
    func setView(row: Int) {
        
    }
}

class SetUpItemViewController: BaseViewController {
    
    @IBOutlet weak var enterItem: UITextField!
    @IBOutlet weak var enterPrice: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    @IBAction func onTouchSave(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction func onTouchCancel(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
}
