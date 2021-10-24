//
//  SetUpItemViewController.swift
//  cashRegister
//
//  Created by 7690 劉晉賢 on 2021/3/16.
//

import UIKit

extension SetUpItemViewController {
    
    func setView(name: String, price: Int, row: Int? = nil, add: Bool? = false) {
        
        self.name = name
        self.row = row
        self.price = price
        self.add = add
    }
}

class SetUpItemViewController: BaseViewController {
    
    @IBOutlet weak var enterItem: UITextField!
    @IBOutlet weak var enterPrice: UITextField!
    
    var name: String?
    var price: Int?
    var row: Int?
    var add: Bool?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if add == false {
            enterItem.text = name
            enterPrice.text = "\(price ?? 0)"
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }
    
    @IBAction func onTouchSave(_ sender: Any) {
        
        add == false ? updateItem() : addItem()
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction func onTouchCancel(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction func onTouchDelete(_ sender: Any) {
        deleteItem()
        dismiss(animated: true, completion: nil)
    }
    
    func addItem() {
        
        let url = URL(string: "http://35.234.3.50:3000/MenuInsert")!
        
        var components = URLComponents(url: url, resolvingAgainstBaseURL: false)
        
        components?.queryItems = [
            URLQueryItem(name: "name", value: enterItem.text ?? ""),
            URLQueryItem(name: "price", value: enterPrice.text ?? "0")
        ]
        
        let query = components?.url!.query
        
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.httpBody = Data(query!.utf8)
        
        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            guard let data = data, error == nil else {
                print(error?.localizedDescription ?? "No data")
                return
            }
            let responseJSON = try? JSONSerialization.jsonObject(with: data, options: [])
            if let responseJSON = responseJSON as? [String: Any] {
                print(responseJSON)
            }
        }
        task.resume()
    }
    
    func deleteItem() {
        let url = URL(string: "http://35.234.3.50:3000/MenuDelete")!
        
        var components = URLComponents(url: url, resolvingAgainstBaseURL: false)
        
        components?.queryItems = [
            URLQueryItem(name: "name", value: enterItem.text ?? ""),
            URLQueryItem(name: "price", value: enterPrice.text ?? "0")
        ]
        
        let query = components?.url!.query
        
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.httpBody = Data(query!.utf8)
        
        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            guard let data = data, error == nil else {
                print(error?.localizedDescription ?? "No data")
                return
            }
            let responseJSON = try? JSONSerialization.jsonObject(with: data, options: [])
            if let responseJSON = responseJSON as? [String: Any] {
                print(responseJSON)
            }
        }
        task.resume()
    }
    
    func updateItem() {
        
        let url = URL(string: "http://35.234.3.50:3000/MenuUpdate")!
        
        var components = URLComponents(url: url, resolvingAgainstBaseURL: false)
        
        components?.queryItems = [
            URLQueryItem(name: "location", value: "\(row ?? 0)"),
            URLQueryItem(name: "name", value: enterItem.text ?? ""),
            URLQueryItem(name: "price", value: enterPrice.text ?? "0")
        ]
        
        let query = components?.url!.query
        
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.httpBody = Data(query!.utf8)
        
        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            guard let data = data, error == nil else {
                print(error?.localizedDescription ?? "No data")
                return
            }
            let responseJSON = try? JSONSerialization.jsonObject(with: data, options: [])
            if let responseJSON = responseJSON as? [String: Any] {
                print(responseJSON)
            }
        }
        task.resume()
    }
}

