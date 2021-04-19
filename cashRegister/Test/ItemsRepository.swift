//
//  ItemsReository.swift
//  cashRegister
//
//  Created by 7690 劉晉賢 on 2021/4/1.
//

import UIKit

class ItemsRepository: NSObject {
    func getItemList() -> [[String: Int]] {
 
        let foodItems = [["香腸":80],["Ｇ排":85],["招牌":95],["滷Ｇ":90],["鯖魚":90],["鯛魚":90],["秋刀魚":90],["燒肉":115],["烤雞":90],["滷排":110],["焢肉":110],["炸排":110],["養生":95],["鮭魚":110],["雞腿":120],["海南烤雞":110],["養生菜飯":80],["菜飯":70],["單腿":65],["單排":65],["單魚":50],["其他":45]]
        
        return foodItems
    }
}
