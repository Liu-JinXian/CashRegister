//
//  ItemTableViewCell.swift
//  cashRegister
//
//  Created by 劉晉賢 on 2021/3/8.
//

import UIKit

class ItemTableViewCell: UITableViewCell {
    
    @IBOutlet weak var item: UILabel!
    @IBOutlet weak var totalPrice: UILabel!
    @IBOutlet weak var amount: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    func setCell(Item: String,amount: Int, price: Int) {
        
        self.item.text = Item
        self.amount.text = "\(amount)個"
        self.totalPrice.text = "\(price)元"
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
}
