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
    
    private var viewModel: CashRegisterViewModel?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        bindViewModel()
        setView()
        setCollectionView()
        setTableView()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        self.navigationItem.title = "POS系統"
//        self.navigationController?.navigationBar.isTranslucent = false
        self.navigationController?.navigationBar.barTintColor = yellow
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        
        //離開頁面時清除UserDeafaults
        viewModel?.clearUserDeafaults()
    }
    
    @IBAction func onTouchCashRegister(_ sender: Any) {
        
        viewModel?.onTouchCashRegister()
    }
    
    @IBAction func onTouchCancel(_ sender: Any) {
        viewModel?.onTouchCancel()
    }
    
    @IBAction func onTouchInside(_ sender: Any) {
        
        insideOrOutside.text = "內用  >"
        viewModel?.isInside = true
        
        inside.backgroundColor = yellow
        inside.setShadow(offset: CGSize.init(width: 0, height: 0), opacity: 1, shadowRadius: 1, color: .black)
        //        inside.setShadow(offset: CGSize.init(width: -3, height: -3), opacity: 0.5, shadowRadius: 1, color: .black)
        inside.setTitleColor(.white, for: .normal)
        
        outside.backgroundColor = UIColor.white
        outside.layer.borderColor = UIColor.green.cgColor
        outside.setTitleColor(yellow, for: .normal)
        outside.layer.masksToBounds = true
        outside.layer.borderWidth = 2
        outside.layer.borderColor = UIColor.lightGray.cgColor
    }
    
    @IBAction func onTouchOutside(_ sender: Any) {
        
        insideOrOutside.text = "外帶  >"
        viewModel?.isInside = false
        inside.backgroundColor = UIColor.white
        inside.layer.borderColor = UIColor.green.cgColor
        inside.setTitleColor(yellow, for: .normal)
        inside.layer.masksToBounds = true
        inside.layer.borderWidth = 2
        inside.layer.borderColor = UIColor.lightGray.cgColor
        
        outside.backgroundColor = UIColor.lightGray
        outside.layer.borderColor = UIColor.black.cgColor
        outside.setTitleColor(.white, for: .normal)
        outside.layer.borderWidth = 0
        outside.setTitleColor(.white, for: .normal)
        outside.backgroundColor = yellow
        outside.setShadow(offset: CGSize.init(width: 0, height: 0), opacity: 1, shadowRadius: 1, color: .black)
    }
}


extension CashRegisterViewController: UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        return CGSize(width: (self.foodItemCollectionView.frame.width/4 - 10), height: (self.foodItemCollectionView.frame.height/6 - 10))
    }
}
extension CashRegisterViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        return viewModel?.bentoModel?.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "MenuCollectionViewCell", for: indexPath) as! MenuCollectionViewCell
        cell.layer.masksToBounds = false
        cell.layer.shadowOffset = CGSize.init(width: 1, height: 1)
        cell.layer.shadowOpacity = 0.7
        cell.layer.shadowColor = UIColor.gray.cgColor
        cell.setCell(viewModel: (viewModel?.subViewModels[indexPath.row])!)
        return cell
    }
}

extension CashRegisterViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return  viewModel?.cashRegisterModels.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        viewModel?.setItemTableViewModel(indexPath: indexPath)
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "ItemTableViewCell", for: indexPath) as! ItemTableViewCell
        cell.setCell(viewModel: (viewModel?.itemTableViewModel)!)
        return cell
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        
        viewModel?.onTouchEditing(indexPath: indexPath)
    }
}



extension CashRegisterViewController {
    
    private func bindViewModel() {
        
        viewModel = CashRegisterViewModel()
        viewModel?.getItemList()
        
        viewModel?.reloadData = { [weak self] in
            self?.foodItemCollectionView.reloadData()
        }
        
        viewModel?.setTotalItem = { [weak self] amout, price in
            self?.totalItem.text = "共\(amout)項"
            self?.totalPrice.text = "$\(price)元"
            self?.itemTableView.reloadData()
        }
    }
    
    private func setView() {
        
        detailsView.setShadow(offset: CGSize.init(width: 3, height: 3), opacity: 0.7, shadowRadius: 5, color: .black)
        
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
        
        itemTableView.dataSource = self
        itemTableView.register(UINib(nibName: "ItemTableViewCell", bundle: nil), forCellReuseIdentifier: "ItemTableViewCell")
    }
}
