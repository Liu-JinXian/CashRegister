//
//  ItemsReository.swift
//  cashRegister
//
//  Created by 7690 劉晉賢 on 2021/4/1.
//

import UIKit

class CashRegisterViewModel: NSObject {
    
    var bento: [[String: Int]] = []
    var reloadData: (() -> ())?
    
    func getItemList() {
        
        let address = "http://35.234.3.50:3000/Menu"
        if let url = URL(string: address) {
            // GET
            URLSession.shared.dataTask(with: url) { (data, response, error) in
                if let error = error {
                    print("Error: \(error.localizedDescription)")
                } else if let response = response as? HTTPURLResponse,let data = data {
                    print("Status code: \(response.statusCode)")
                    let decoder = JSONDecoder()
                    
                    if let bentoSetUp = try? decoder.decode([BentoSetUp].self, from: data) {
                        DispatchQueue.main.async{
                            for bento in bentoSetUp {
                                self.bento.append([bento.name: bento.price])
                            }
                            self.reloadData?()
                        }
                    }
                }
            }.resume()
        } else {
            print("Invalid URL.")
        }
    }
}
