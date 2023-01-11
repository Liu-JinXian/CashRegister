//
//  HistoryDataTableViewMdoel.swift
//  cashRegister
//
//  Created by 劉晉賢 on 2022/2/19.
//

class HistoryDataTableViewMdoel {
    
    var date: String?
    var isInside: Bool?
    var amount: Int = 0
    var price: Int = 0
    
    func setViewModel(buyDetailModel: BuyDetailModel) {
        self.date = buyDetailModel.time
        self.isInside = buyDetailModel.isInside
        
        buyDetailModel.buyDetails?.forEach{ (detail) in
            self.amount += detail.amount ?? 0
            self.price += detail.price ?? 0
        }
    }
}
