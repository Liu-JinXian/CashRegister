//
//  StepUpViewController.swift
//  cashRegister
//
//  Created by 7690 劉晉賢 on 2021/3/15.
//

import UIKit

class StepUpViewController: BaseViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    @IBAction func onTouchSetUpItem(_ sender: Any) {
        
        let vc = getVC(st: "StepUp", vc: "SetUpItemViewController") as! SetUpItemViewController
        vc.modalPresentationStyle = .overCurrentContext
        let nav = UINavigationController(rootViewController: vc)
        nav.restorationIdentifier = "StepUpViewController"
        nav.modalPresentationStyle = .fullScreen
        self.present(nav, animated: true)
    }
}
