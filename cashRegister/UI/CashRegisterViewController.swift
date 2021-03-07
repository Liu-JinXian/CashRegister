//
//  CashRegisterViewController.swift
//  cashRegister
//
//  Created by 劉晉賢 on 2021/2/27.
//

import UIKit

class CashRegisterViewController: UIViewController {
    
    @IBOutlet weak var foodItemCollectionView: UICollectionView!
    
    @IBOutlet weak var collectionViewLayout: UICollectionViewFlowLayout!
    
    var fooditem: [[String:Int]] = [["香腸":80],["Ｇ排":85],["招牌":95],["滷Ｇ":90],["鯖魚":90],["鯛魚":90],["秋刀魚":90],["燒肉":115],["烤雞":90],["滷排":110],["焢肉":110],["炸排":110],["養生":95],["鮭魚":110],["雞腿":120],["海南烤雞":110],["養生菜飯":80],["菜飯":70],["單腿":65],["單排":65],["單魚":50],["其他":45]]
    
    override func viewDidLoad() {
        super.viewDidLoad()
    
        self.navigationController?.navigationItem.title = "收銀系統"
        foodItemCollectionView.delegate = self
        foodItemCollectionView.dataSource = self
        foodItemCollectionView.register(UINib(nibName: "MenuCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "MenuCollectionViewCell")
        
        let layout: UICollectionViewFlowLayout = UICollectionViewFlowLayout()
        layout.itemSize = CGSize(width: 120, height: 120)
//        layout.minimumInteritemSpacing = 5
//        layout.minimumLineSpacing = 15
        layout.sectionInset = UIEdgeInsets(top: 5, left: 5, bottom: 5, right: 5)
        foodItemCollectionView.setCollectionViewLayout(layout, animated: false)
    }
}

extension CashRegisterViewController: UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
}

extension CashRegisterViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return fooditem.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "MenuCollectionViewCell", for: indexPath) as! MenuCollectionViewCell
        
        cell.clipsToBounds = true
        cell.layer.cornerRadius = 30
        cell.setCell(foodItem: fooditem[indexPath.row])
        return cell
    }
    
}


