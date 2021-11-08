//
//  DataSettingViewController.swift
//  cashRegister
//
//  Created by 劉晉賢 on 2021/10/30.
//
import UIKit

class DataSettingViewController: BaseViewController {

    @IBOutlet weak var cancel: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        cancel.layer.borderWidth = 1
        cancel.layer.borderColor = UIColor.black.cgColor
    }
}
