//
//  SetUpViewModel.swift
//  cashRegister
//
//  Created by 劉晉賢 on 2021/8/15.
//

import Foundation
import RxSwift
import RxCocoa

struct BentoSetUp: Decodable {
    var name: String
    var price: Int
}

class SetUpViewModel {
    
    var bento: [[String: Int]] = []
    var reloadData: (() -> ())?
    
    func getBentoData() {
        let address = "http://localhost:3000/bento"
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
