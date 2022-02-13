//
//  MenuCollectionViewCell.swift
//  cashRegister
//
//  Created by 劉晉賢 on 2021/2/27.
//

import UIKit


class MenuCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var foodItem: UIButton!
    @IBOutlet weak var item: UILabel!
    @IBOutlet weak var price: UILabel!
    
    private var viewModel: MenuCollectionCellViewModel?
    
    func setCell(viewModel: MenuCollectionCellViewModel) {
        self.viewModel = viewModel
        
        self.item.text = viewModel.item
        self.price.text = "$\(viewModel.price)"
    }
    
    @IBAction func onTouch(_ sender: Any) {
        
        viewModel?.onTouch()
    }
}
