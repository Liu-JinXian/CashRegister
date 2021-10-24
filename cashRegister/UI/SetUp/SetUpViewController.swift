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
        
        cell.updateDelegate = self
        
        cell.layer.masksToBounds = false
        cell.layer.shadowOffset = CGSize.init(width: 1, height: 1)
        cell.layer.shadowOpacity = 0.7
        cell.layer.shadowColor = UIColor.gray.cgColor
        cell.setCell(foodItem: (viewModel?.bento[indexPath.row])!, row: indexPath.row)
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, moveItemAt sourceIndexPath: IndexPath, to destinationIndexPath: IndexPath) {
        
        let temp = viewModel?.bento.remove(at: sourceIndexPath.item)
        update(location1: "\(destinationIndexPath.item)", location2: "\(sourceIndexPath.item)")
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

extension SetUpViewController: MenuUpdaterotocol {
    
    func onTouchUpdate(item: String, price: Int, location: Int) {
        let vc = getVC(st: "StepUp", vc: "SetUpItemViewController") as! SetUpItemViewController
        vc.setView(name: item, price: price, row: location)
        vc.modalPresentationStyle = .overCurrentContext
        let nav = UINavigationController(rootViewController: vc)
        nav.restorationIdentifier = "StepUpViewController"
        nav.modalPresentationStyle = .fullScreen
        self.present(nav, animated: true)
    }
}

extension SetUpViewController {
    
    func update(location1: String, location2: String ) {
        let url = URL(string: "http://35.234.3.50:3000/MenuUpdate")!
        
        var components = URLComponents(url: url, resolvingAgainstBaseURL: false)
        
        components?.queryItems = [
            URLQueryItem(name: "location1", value: location1),
            URLQueryItem(name: "location2", value: location2)
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
