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

protocol MenuUpdaterotocol: NSObjectProtocol {
    func onTouchUpdate(item: String, price: Int, location: Int)
}

class MenuCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var foodItem: UIButton!
    @IBOutlet weak var item: UILabel!
    @IBOutlet weak var price: UILabel!
    
    weak var delegate: MenuCollectionViewCellProtocol?
    weak var updateDelegate: MenuUpdaterotocol?
    var items: String = ""
    var prices: Int = 0
    var location: Int?
    var update: Bool = false
    
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
    
    func setCell(foodItem: [String:Int], row: Int) {
        
        for (item, price) in foodItem {
            self.items = item
            self.item.text = item
            self.prices = price
            self.price.text = "$\(price)"
        }
        self.location = row
        self.update = true
    }
    
    @IBAction func onTouch(_ sender: Any) {
        
        if update == false {
            self.delegate?.onTouchItem(item: items, price: prices)
        } else{
            self.updateDelegate?.onTouchUpdate(item: items, price: prices, location: location ?? 0)
        }
    }
}
