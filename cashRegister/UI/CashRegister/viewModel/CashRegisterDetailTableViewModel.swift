//
//  CashRegisterDetailTableViewModel.swift
//  cashRegister
//
//  Created by 劉晉賢 on 2021/11/20.
//

class CashRegisterDetailTableViewModel {
    
    var onTouchLess: (() -> ())?
    var onTouchAdd: (() -> ())?
    
    var item: String?
    var amount: Int?
    var totalPrice: Int?
    
    func setViewModel(item: String, amount: Int, price: Int) {
        
        self.item = item
        self.amount = amount
        self.totalPrice = price
    }
}
