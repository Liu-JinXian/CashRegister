//
//  StepUpViewController.swift
//  cashRegister
//
//  Created by 7690 劉晉賢 on 2021/3/15.
//

import UIKit

class SetUpViewController: BaseViewController {
    
    @IBOutlet weak var collectionView: UICollectionView!
    
    var viewModel: SetUpViewModel?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationItem.title = "設定"
        self.navigationController?.navigationBar.isTranslucent = false
        self.navigationController?.navigationBar.barTintColor = yellow
        self.collectionView.backgroundColor = yellow
        
        let longPressGesture = UILongPressGestureRecognizer(target: self, action: #selector(self.handleLongGesture(_:)))
        self.collectionView.addGestureRecognizer(longPressGesture)
        
        setCollectionView()
        bindViewModel()
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
        
        let vc = getVC(st: "StepUp", vc: "SetUpItemViewController") as! SetUpItemViewController
        vc.modalPresentationStyle = .overCurrentContext
        let nav = UINavigationController(rootViewController: vc)
        nav.restorationIdentifier = "StepUpViewController"
        nav.modalPresentationStyle = .fullScreen
        self.present(nav, animated: true)
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
        
        return viewModel?.bento.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "MenuCollectionViewCell", for: indexPath) as! MenuCollectionViewCell
        
        cell.delegate = self
        
        cell.layer.masksToBounds = false
        cell.layer.shadowOffset = CGSize.init(width: 1, height: 1)
        cell.layer.shadowOpacity = 0.7
        cell.layer.shadowColor = UIColor.gray.cgColor
        cell.setCell(foodItem: (viewModel?.bento[indexPath.row])!)
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, moveItemAt sourceIndexPath: IndexPath, to destinationIndexPath: IndexPath) {
        
        let temp = viewModel?.bento.remove(at: sourceIndexPath.item)
        viewModel?.bento.insert(temp ?? [:], at: destinationIndexPath.item)
    }
}

extension SetUpViewController {
    
    private func setCollectionView() {
        
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.register(UINib(nibName: "MenuCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "MenuCollectionViewCell")
        
        let layout: UICollectionViewFlowLayout = UICollectionViewFlowLayout()
        layout.minimumInteritemSpacing = 5
        layout.minimumLineSpacing = 5
        layout.sectionInset = UIEdgeInsets(top: 5, left: 5, bottom: 5, right: 5)
        collectionView.setCollectionViewLayout(layout, animated: false)
    }
    private func bindViewModel() {
        
        viewModel = SetUpViewModel()
        viewModel?.getBentoData()
        
        viewModel?.reloadData = { [weak self] in
            self?.collectionView.reloadData()
        }
    }
}

extension SetUpViewController: MenuCollectionViewCellProtocol {
    
    func onTouchItem(item: String, price: Int) {
        
        let vc = getVC(st: "StepUp", vc: "SetUpItemViewController") as! SetUpItemViewController
        vc.setView(name: item, price: price)
        vc.modalPresentationStyle = .overCurrentContext
        let nav = UINavigationController(rootViewController: vc)
        nav.restorationIdentifier = "StepUpViewController"
        nav.modalPresentationStyle = .fullScreen
        self.present(nav, animated: true)
        
    }
}
