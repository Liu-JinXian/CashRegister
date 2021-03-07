//
//  MenuCollectionViewCell.swift
//  cashRegister
//
//  Created by 劉晉賢 on 2021/2/27.
//

import UIKit

class MenuCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var foodItem: UIButton!
    
    var item: String = ""
    var price: Int = 0
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    func setCell(foodItem: [String:Int]) {
        
        for (item, price) in foodItem {
            self.foodItem.setTitle(item, for: .normal)
            self.price = price
        }
    }
    @IBAction func onTouch(_ sender: Any) {
        print(price)
    }
}
