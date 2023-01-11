//
//  CashRegisterItemCollectionViewModel.swift
//  cashRegister
//
//  Created by 劉晉賢 on 2021/11/20.
//
class CashRegisterItemCollectionViewModel {
    
    var onTouchItem: (() -> ())?
    var onTouchUpdate: (() -> ())?
    
    var item: String = ""
    var price: Int = 0
    var update: Bool = false
    var id: String = ""
    
    func setViewModel(foodItem: BentoModel, update: Bool? = false) {
        
        self.item = foodItem.bentoName ?? ""
        self.price = foodItem.bentoPrice ?? 0
        self.id = foodItem.bentoToken ?? ""
        self.update = update ?? false
    }
    
    func onTouch() {
        
        if update == false {
            self.onTouchItem?()
        } else{
            self.onTouchUpdate?()
        }
    }
}
