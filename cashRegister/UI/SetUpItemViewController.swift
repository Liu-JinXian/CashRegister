//
//  SetUpItemViewController.swift
//  cashRegister
//
//  Created by 7690 劉晉賢 on 2021/3/16.
//

import UIKit

class SetUpItemViewController: BaseViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let tapDismissKeyBoard = UITapGestureRecognizer(target: self, action: #selector(dismissKeyBoard))
        self.view.addGestureRecognizer(tapDismissKeyBoard)
    }
    
    @objc func dismissKeyBoard() {
        
        self.view.endEditing(true)
    }
    
    @IBAction func onTouchClose(_ sender: Any) {
        
        dismiss(animated: true, completion: nil)
    }
    
}
