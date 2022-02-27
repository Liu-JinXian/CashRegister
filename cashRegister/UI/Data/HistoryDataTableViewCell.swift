//
//  HistoryDataTableViewCell.swift
//  cashRegister
//
//  Created by 7690 劉晉賢 on 2021/3/12.
//

import UIKit

extension HistoryDataTableViewCell {
    func setCell(viewModel: HistoryDataTableViewMdoel) {
        self.viewModel = viewModel
        
        self.dateLabel.text = viewModel.date ?? ""
        self.isInsideLabel.text = viewModel.isInside == false ? "外帶" : "內用"
        self.amoutLabel.text = "\(viewModel.amount)"
        self.priceLabel.text = "\(viewModel.price)"
    }
    
    func setBannerCell() {
        self.dateLabel.text = "日期"
        self.isInsideLabel.text = "內用/外帶"
        self.amoutLabel.text = "數量"
        self.priceLabel.text = "價格"
    }
}

class HistoryDataTableViewCell: UITableViewCell {
    
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var isInsideLabel: UILabel!
    @IBOutlet weak var amoutLabel: UILabel!
    @IBOutlet weak var priceLabel: UILabel!
    
    private var viewModel: HistoryDataTableViewMdoel?
}
