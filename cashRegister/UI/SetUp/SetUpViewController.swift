//
//  StepUpViewController.swift
//  cashRegister
//
//  Created by 7690 劉晉賢 on 2021/3/15.
//
import UIKit

class SetUpViewController: BaseViewController {
    
    @IBOutlet weak var collectionView: UICollectionView!
    
    private var viewModel: SetUpViewModel?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setView()
        setCollectionView()
        bindViewModel()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        loadData()
    }
    
    override func loadData() {
        super.loadData()
        
        viewModel?.cleanModel()
        viewModel?.getBentoData()
    }
    
    @objc func handleLongGesture(_ gesture: UILongPressGestureRecognizer) {
        
        switch(gesture.state) {
            
        case UIGestureRecognizer.State.began:
            guard let selectedIndexPath = self.collectionView.indexPathForItem(at: gesture.location(in: self.collectionView)) else {
                break
            }
            collectionView.beginInteractiveMovementForItem(at: selectedIndexPath)
        case UIGestureRecognizer.State.changed:
            collectionView.updateInteractiveMovementTargetPosition(gesture.location(in: gesture.view!))
        case UIGestureRecognizer.State.ended:
            collectionView.endInteractiveMovement()
        default:
            collectionView.cancelInteractiveMovement()
        }
    }
    
    @IBAction func onTouchSetUpItem(_ sender: Any) {
        
        viewModel?.onTouchSetUpItem()
    }
}

extension SetUpViewController: UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        return CGSize(width: (self.collectionView.frame.width/4 - 10), height: (self.collectionView.frame.height/6 - 10))
    }
    
    func collectionView(_ collectionView: UICollectionView, canMoveItemAt indexPath: IndexPath) -> Bool {
        return true
    }
}

extension SetUpViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        return viewModel?.setNumberOfItemsInSection() ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CashRegisterItemCollectionViewCell", for: indexPath) as! CashRegisterItemCollectionViewCell
        cell.layer.masksToBounds = false
        cell.layer.shadowOffset = CGSize.init(width: 1, height: 1)
        cell.layer.shadowOpacity = 0.7
        cell.layer.shadowColor = UIColor.gray.cgColor
        cell.setCell(viewModel: (viewModel?.subViewModels[indexPath.row])!)
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, moveItemAt sourceIndexPath: IndexPath, to destinationIndexPath: IndexPath) {        
        viewModel?.getUpdateLocation(locationTemp: destinationIndexPath.item, locationMove: sourceIndexPath.item)
    }
}

extension SetUpViewController {
    
    private func bindViewModel() {
        
        viewModel = SetUpViewModel()
        
        viewModel?.reloadData = { [weak self] in
            self?.collectionView.reloadData()
        }
        
        viewModel?.presentToVC = { [weak self] vc in
            self?.present(vc, animated: true)
        }
    }
    
    private func setView() {
        self.navigationItem.title = "設定"
        
        let appearance = UINavigationBarAppearance()
        appearance.configureWithOpaqueBackground()
        appearance.backgroundColor = yellow
        self.navigationController?.navigationBar.standardAppearance = appearance;
        self.navigationController?.navigationBar.scrollEdgeAppearance = self.navigationController?.navigationBar.standardAppearance
        
        self.collectionView.backgroundColor = yellow
        
        let longPressGesture = UILongPressGestureRecognizer(target: self, action: #selector(self.handleLongGesture(_:)))
        self.collectionView.addGestureRecognizer(longPressGesture)
    }
    
    private func setCollectionView() {
        
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.register(UINib(nibName: "CashRegisterItemCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "CashRegisterItemCollectionViewCell")
        
        let layout: UICollectionViewFlowLayout = UICollectionViewFlowLayout()
        layout.minimumInteritemSpacing = 5
        layout.minimumLineSpacing = 5
        layout.sectionInset = UIEdgeInsets(top: 5, left: 5, bottom: 5, right: 5)
        collectionView.setCollectionViewLayout(layout, animated: false)
    }
}
