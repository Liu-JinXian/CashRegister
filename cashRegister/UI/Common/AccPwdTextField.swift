//
//  AccPwdTextField.swift
//  cashRegister
//
//  Created by 劉晉賢 on 2022/4/2.
//

import UIKit

class AccPwdTextField: UITextField {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.setUp()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        self.setUp()
    }
    
    func setUp() {
        self.borderStyle = .none
        self.layer.backgroundColor = yellow.cgColor
        
        self.layer.masksToBounds = false
        self.layer.shadowColor = UIColor.brown.cgColor
        self.layer.shadowOffset = CGSize(width: 0.0, height: 1.0)
        self.layer.shadowOpacity = 1.0
        self.layer.shadowRadius = 0.0
        self.frame.size.width = 50
        
    }
}
