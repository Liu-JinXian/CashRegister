//
//  SetUpItemTableViewCell.swift
//  cashRegister
//
//  Created by 7690 劉晉賢 on 2021/4/19.
//

import UIKit

class SetUpItemTableViewCell: UITableViewCell {
    
    @IBOutlet weak var item: UILabel!
    @IBOutlet weak var price: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    func setCell(item: [String:Int]) {
        for (item, price) in item {
            self.item.text = item
            self.price.text = "$\(price)"
        }
    }
}
