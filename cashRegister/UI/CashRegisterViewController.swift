//
//  CashRegisterViewController.swift
//  cashRegister
//
//  Created by 劉晉賢 on 2021/2/27.
//

import UIKit

class CashRegisterViewController: UIViewController {
    
    @IBOutlet weak var detailsView: UIView!
    @IBOutlet weak var foodItemCollectionView: UICollectionView!
    @IBOutlet weak var itemTableView: UITableView!
    @IBOutlet weak var totalItem: UILabel!
    @IBOutlet weak var totalPrice: UILabel!
    @IBOutlet weak var cancel: UIButton!
    @IBOutlet weak var cashRegister: UIButton!
    
    let userDefault = UserDefaultUtil.shared
    
    var totalAmount: Int = 0
    var total: Int = 0
    var fooditem: [[String:Int]] = [["香腸":80],["Ｇ排":85],["招牌":95],["滷Ｇ":90],["鯖魚":90],["鯛魚":90],["秋刀魚":90],["燒肉":115],["烤雞":90],["滷排":110],["焢肉":110],["炸排":110],["養生":95],["鮭魚":110],["雞腿":120],["海南烤雞":110],["養生菜飯":80],["菜飯":70],["單腿":65],["單排":65],["單魚":50],["其他":45]]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationController?.navigationItem.title = "收銀系統"
        self.cancel.layer.cornerRadius = 30
        self.cashRegister.layer.cornerRadius = 30
        
        
        self.detailsView.layer.masksToBounds = false
        self.detailsView.clipsToBounds = false
        //        self.detailsView.layer.borderWidth = 0.5
        self.detailsView.layer.shadowOffset = CGSize.init(width: 3, height: 3)
        self.detailsView.layer.shadowOpacity = 0.7
        self.detailsView.layer.shadowRadius = 5
        self.detailsView.layer.shadowColor = UIColor.black.cgColor
        //        self.detailsView.layer.shouldRasterize = true
        //        self.detailsView.layer.rasterizationScale = UIScreen.main.scale
        
        setCollectionView()
        setTableView()
    }
    
    @IBAction func onTouchCashRegister(_ sender: Any) {
        
        let userDefaults = UserDefaults.standard
        let dics = userDefaults.dictionaryRepresentation()
        for key in dics { userDefaults.removeObject(forKey: key.key) }
        userDefaults.synchronize()
        
        total = 0
        self.totalPrice.text = "$\(total)元"
        self.itemTableView.reloadData()
    }
    
    @IBAction func onTouchCancel(_ sender: Any) {
        
        let userDefaults = UserDefaults.standard
        let dics = userDefaults.dictionaryRepresentation()
        for key in dics { userDefaults.removeObject(forKey: key.key) }
        userDefaults.synchronize()
        
        total = 0
        self.totalPrice.text = "$\(total)元"
        self.itemTableView.reloadData()
    }
}

extension CashRegisterViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        return fooditem.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "MenuCollectionViewCell", for: indexPath) as! MenuCollectionViewCell
        
        cell.delegate = self
        cell.clipsToBounds = true
        cell.layer.cornerRadius = 30
        cell.setCell(foodItem: fooditem[indexPath.row])
        return cell
    }
}

extension CashRegisterViewController: UITableViewDelegate {
    
}

extension CashRegisterViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        totalAmount = userDefault.item?.count ?? 0
        self.totalItem.text = "共\(totalAmount)項"
        return  userDefault.item?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ItemTableViewCell", for: indexPath) as! ItemTableViewCell
        
        cell.setCell(Item: userDefault.item?[indexPath.row] ?? "", price: userDefault.price?[indexPath.row] ?? 0)
        return cell
    }
}

extension CashRegisterViewController {
    
    private func setCollectionView() {
        
        foodItemCollectionView.dataSource = self
        foodItemCollectionView.register(UINib(nibName: "MenuCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "MenuCollectionViewCell")
        
        let layout: UICollectionViewFlowLayout = UICollectionViewFlowLayout()
        layout.itemSize = CGSize(width: 120, height: 120)
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
}

extension CashRegisterViewController: MenuCollectionViewCellProtocol {
    func onTouchItem(price: Int) {
        
        total += price
        self.totalPrice.text = "$\(total)元"
        self.itemTableView.reloadData()
    }
}
