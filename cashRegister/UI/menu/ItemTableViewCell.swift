//
//  ItemTableViewCell.swift
//  cashRegister
//
//  Created by 劉晉賢 on 2021/3/8.
//

import UIKit
protocol  ItemTableViewCellllProtocol : NSObjectProtocol {
    func onTouchLess(item: String)
    func onTouchAdd(item: String)
}

class ItemTableViewCell: UITableViewCell {
    
    @IBOutlet weak var item: UILabel!
    @IBOutlet weak var totalPrice: UILabel!
    @IBOutlet weak var amount: UILabel!
    
    private var viewModel: ItemTableViewModel?
    
    weak var delegate: ItemTableViewCellllProtocol?
    
    func setCell(viewModel: ItemTableViewModel) {
        self.viewModel = viewModel
        
        self.item.text = viewModel.item ?? ""
        self.amount.text = "\(viewModel.amount ?? 0)個"
        self.totalPrice.text = "\(viewModel.totalPrice ?? 0)元"
    }
    
    func setCell(Item: String,amount: Int, price: Int) {
        
        self.item.text = Item
        self.amount.text = "\(amount)個"
        self.totalPrice.text = "\(price)元"
    }
    
    @IBAction func onTouchLess(_ sender: Any) {
        viewModel?.onTouchLess?()
        self.delegate?.onTouchLess(item: item.text ?? "")
    }
    
    @IBAction func onTouchAdd(_ sender: Any) {
        viewModel?.onTouchAdd?()
        self.delegate?.onTouchAdd(item: item.text ?? "")
    }
}
