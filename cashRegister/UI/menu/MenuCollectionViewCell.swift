//
//  MenuCollectionViewCell.swift
//  cashRegister
//
//  Created by 劉晉賢 on 2021/2/27.
//

import UIKit

protocol  MenuCollectionViewCellProtocol : NSObjectProtocol {
    func onTouchItem(price: Int)
}

class MenuCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var foodItem: UIButton!
    
    let userDefault = UserDefaultUtil.shared
    weak var delegate: MenuCollectionViewCellProtocol?
    var item: String = ""
    var price: Int = 0
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        foodItem.layer.cornerRadius = 15
    }
    
    func setCell(foodItem: [String:Int]) {
        
        for (item, price) in foodItem {
            self.foodItem.setTitle(item, for: .normal)
            self.item = item
            self.price = price
        }
    }
    @IBAction func onTouch(_ sender: Any) {
        
        userDefault.item?.insert(self.item, at: 0)
        userDefault.price?.insert(self.price, at: 0)
        self.delegate?.onTouchItem(price: price)
    }
}
