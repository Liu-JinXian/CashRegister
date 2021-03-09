//
//  UIViewExtension.swift
//  cashRegister
//
//  Created by 7690 劉晉賢 on 2021/3/9.
//

import UIKit

extension UIView {
    
    func setShadow(offset:CGSize,opacity:Float,shadowRadius:CGFloat, color: UIColor) {
        self.layer.masksToBounds = false
        self.layer.shadowOffset = offset
        self.layer.shadowOpacity = opacity
        self.layer.shadowRadius = shadowRadius
        self.layer.shadowColor = color.cgColor
        self.layer.shouldRasterize = true
        self.layer.rasterizationScale = UIScreen.main.scale
    }
}
