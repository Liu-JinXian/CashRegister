//
//  CashRegisterViewController.swift
//  cashRegister
//
//  Created by 劉晉賢 on 2021/2/27.
//

import UIKit

class CashRegisterViewController: BaseViewController {
    
    @IBOutlet weak var inside: UIButton!
    @IBOutlet weak var outside: UIButton!
    @IBOutlet weak var detailsView: UIView!
    @IBOutlet weak var foodItemCollectionView: UICollectionView!
    @IBOutlet weak var insideOrOutside: UILabel!
    @IBOutlet weak var itemTableView: UITableView!
    @IBOutlet weak var totalItem: UILabel!
    @IBOutlet weak var totalPrice: UILabel!
    @IBOutlet weak var cancel: UIButton!
    @IBOutlet weak var cashRegister: UIButton!
    
    var fooditem :[[String:Int]] = []
    var items: [String] = []
    var amounts: [Int] = []
    var itemTotalPrice: [Int] = []
    
    var amount: Int = 0
    var price: Int = 0
    var totalprice: Int = 0
    var totalamount: Int = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let repository = ItemsRepository()
        fooditem = repository.getItemList()
        
        setView()
        setCollectionView()
        setTableView()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        self.navigationItem.title = "收銀系統"
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        
        //離開頁面時清除UserDeafaults
        clearUserDeafaults()
    }
    
    @IBAction func onTouchCashRegister(_ sender: Any) {
        
        clearUserDeafaults()
        totalprice = 0
        totalAndTableviewReload()
    }
    
    @IBAction func onTouchCancel(_ sender: Any) {
        
        clearUserDeafaults()
        totalprice = 0
        totalAndTableviewReload()
    }
    
    @IBAction func onTouchInside(_ sender: Any) {
        
        insideOrOutside.text = "內用  >"
        
        inside.backgroundColor = colorButtonYellow
        inside.setShadow(offset: CGSize.init(width: -3, height: -3), opacity: 0.5, shadowRadius: 1, color: .gray)
        inside.setTitleColor(.white, for: .normal)
        
        outside.backgroundColor = UIColor.white
        outside.layer.borderColor = UIColor.green.cgColor
        outside.setTitleColor(.black, for: .normal)
        outside.layer.masksToBounds = true
        outside.layer.borderWidth = 2
        outside.layer.borderColor = UIColor.lightGray.cgColor
    }
    
    @IBAction func onTouchOutside(_ sender: Any) {
        
        insideOrOutside.text = "外帶  >"
        
        inside.backgroundColor = UIColor.white
        inside.layer.borderColor = UIColor.green.cgColor
        inside.setTitleColor(.black, for: .normal)
        inside.layer.masksToBounds = true
        inside.layer.borderWidth = 2
        inside.layer.borderColor = UIColor.lightGray.cgColor
        
        outside.backgroundColor = UIColor.lightGray
        outside.layer.borderColor = UIColor.black.cgColor
        outside.setTitleColor(.white, for: .normal)
        outside.layer.borderWidth = 0
        outside.setTitleColor(.white, for: .normal)
        outside.backgroundColor = colorButtonYellow
        outside.setShadow(offset: CGSize.init(width: -3, height: -3), opacity: 0.5, shadowRadius: 1, color: .gray)
        
    }
}


extension CashRegisterViewController: UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        return CGSize(width: (self.foodItemCollectionView.frame.width/5 - 10), height: (self.foodItemCollectionView.frame.height/5 - 10))
    }
}
extension CashRegisterViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        return fooditem.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "MenuCollectionViewCell", for: indexPath) as! MenuCollectionViewCell
        
        cell.delegate = self
        
        cell.layer.masksToBounds = false
        cell.layer.shadowOffset = CGSize.init(width: 1, height: 1)
        cell.layer.shadowOpacity = 0.7
        cell.layer.shadowRadius = 5
        cell.layer.shadowColor = UIColor.gray.cgColor
        cell.setCell(foodItem: fooditem[indexPath.row])
        return cell
    }
}

extension CashRegisterViewController: UITableViewDelegate {
    
}

extension CashRegisterViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return  items.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ItemTableViewCell", for: indexPath) as! ItemTableViewCell
        cell.delegate = self
        cell.setCell(Item: items[indexPath.row] ,amount: amounts[indexPath.row] ,price: itemTotalPrice[indexPath.row])
        return cell
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        
        
        totalprice -= itemTotalPrice[indexPath.row]
        totalamount -= amounts[indexPath.row]
        
        items.remove(at: indexPath.row)
        amounts.remove(at: indexPath.row)
        itemTotalPrice.remove(at: indexPath.row)
        
        self.totalItem.text = "共\(totalamount)項"
        self.totalPrice.text = "$\(totalprice)元"
        self.itemTableView.reloadData()
    }
}

extension CashRegisterViewController: MenuCollectionViewCellProtocol {
    
    func onTouchItem(item: String, price: Int) {
        
        if items.contains(item) == false {
            items.append(item)
            amounts.append(1)
            itemTotalPrice.append(price)
        } else {
            amount = amounts[items.firstIndex(of: item) ?? 0]
            amount += 1
            amounts[items.firstIndex(of: item) ?? 0] = amount
            
            self.price = itemTotalPrice[items.firstIndex(of: item) ?? 0]
            self.price += price
            itemTotalPrice[items.firstIndex(of: item) ?? 0] = self.price
        }
        
        totalprice += price
        totalamount += 1
        amount = 0
        totalAndTableviewReload()
    }
}

extension CashRegisterViewController: ItemTableViewCellllProtocol {
    func onTouchLess(item: String) {
        
        amount = amounts[items.firstIndex(of: item) ?? 0]
        amount -= 1
        
        if amount == 0 {
            
            totalprice -= itemTotalPrice[items.firstIndex(of: item) ?? 0]
            totalamount -= amounts[items.firstIndex(of: item) ?? 0]
            
            let row = items.firstIndex(of: item)
            items.remove(at: row ?? 0)
            amounts.remove(at: row ?? 0)
            itemTotalPrice.remove(at: row ?? 0)
            
            self.totalItem.text = "共\(totalamount)項"
            self.totalPrice.text = "$\(totalprice)元"
            self.itemTableView.reloadData()
            
        } else {
            
            amount = amounts[items.firstIndex(of: item) ?? 0]
            self.price = itemTotalPrice[items.firstIndex(of: item) ?? 0]
            totalprice -= price
            self.price = self.price/amount
            amount -= 1
            amounts[items.firstIndex(of: item) ?? 0] = amount
            
            self.price = self.price * amount
            itemTotalPrice[items.firstIndex(of: item) ?? 0] = self.price
            totalprice += price
            totalamount -= 1
            amount = 0
            totalAndTableviewReload()
        }
    }
    
    func onTouchAdd(item: String) {
        
        amount = amounts[items.firstIndex(of: item) ?? 0]
        price = itemTotalPrice[items.firstIndex(of: item) ?? 0]
        totalprice -= price
        price = price/amount
        amount += 1
        amounts[items.firstIndex(of: item) ?? 0] = amount
        
        price = price * amount
        totalprice += price
        itemTotalPrice[items.firstIndex(of: item) ?? 0] = self.price
        
        totalamount += 1
        amount = 0
        totalAndTableviewReload()
    }
}

extension CashRegisterViewController {
    
    private func setView() {
        
        self.navigationController?.navigationItem.title = "收銀系統"
        
        detailsView.setShadow(offset: CGSize.init(width: 3, height: 3), opacity: 0.7, shadowRadius: 5, color: .black)
        
        cancel.layer.borderWidth = 1
        cancel.layer.borderColor = UIColor.black.cgColor
        
        cashRegister.setShadow(offset: CGSize.init(width: -3, height: -3), opacity: 0.5, shadowRadius: 1, color: .gray)
        
        outside.layer.borderWidth = 2
        outside.layer.borderColor = UIColor.lightGray.cgColor
        
        inside.setTitleColor(.white, for: .normal)
        inside.setShadow(offset: CGSize.init(width: -3, height: -3), opacity: 0.5, shadowRadius: 1, color: .gray)
    }
    
    private func setCollectionView() {
        
        foodItemCollectionView.dataSource = self
        foodItemCollectionView.delegate = self
        foodItemCollectionView.register(UINib(nibName: "MenuCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "MenuCollectionViewCell")
        
        let layout: UICollectionViewFlowLayout = UICollectionViewFlowLayout()
        layout.minimumInteritemSpacing = 5
        layout.minimumLineSpacing = 5
        layout.sectionInset = UIEdgeInsets(top: 5, left: 5, bottom: 5, right: 5)
        foodItemCollectionView.setCollectionViewLayout(layout, animated: false)
    }
    
    private func setTableView() {
        
        itemTableView.delegate = self
        itemTableView.dataSource = self
        itemTableView.register(UINib(nibName: "ItemTableViewCell", bundle: nil), forCellReuseIdentifier: "ItemTableViewCell")
    }
    
    private func clearUserDeafaults() {
        
        items = []
        amounts = []
        itemTotalPrice = []
        price = 0
        totalprice = 0
        totalamount = 0
    }
    
    private func totalAndTableviewReload() {
        self.totalPrice.text = "$\(totalprice)元"
        self.totalItem.text = "共\(totalamount)項"
        self.itemTableView.reloadData()
    }
}

