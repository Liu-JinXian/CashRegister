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
    
    func setCell(name: String, price: Int) {
        self.item.text = name
        self.price.text = "$\(price)"
    }
}
