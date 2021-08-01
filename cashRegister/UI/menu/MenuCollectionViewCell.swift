//
//  MenuCollectionViewCell.swift
//  cashRegister
//
//  Created by 劉晉賢 on 2021/2/27.
//

import UIKit

protocol  MenuCollectionViewCellProtocol : NSObjectProtocol {
    func onTouchItem(item: String, price: Int)
}

class MenuCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var foodItem: UIButton!
    @IBOutlet weak var item: UILabel!
    @IBOutlet weak var price: UILabel!
    
    weak var delegate: MenuCollectionViewCellProtocol?
    var items: String = ""
    var prices: Int = 0
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.foodItem.layer.cornerRadius = 5
    }
    
    func setCell(foodItem: [String:Int]) {
        
        for (item, price) in foodItem {
            self.items = item
            self.item.text = item
            self.prices = price
            self.price.text = "$\(price)"
        }
    }
    @IBAction func onTouch(_ sender: Any) {
        
        self.delegate?.onTouchItem(item: items, price: prices)
    }
}
