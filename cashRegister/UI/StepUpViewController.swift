//
//  StepUpViewController.swift
//  cashRegister
//
//  Created by 7690 劉晉賢 on 2021/3/15.
//

import UIKit

class StepUpViewController: BaseViewController {
    
    @IBOutlet weak var tableView: UITableView!
    var fooditem :[[String:Int]] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let repository = ItemsRepository()
        fooditem = repository.getItemList()
        
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(UINib(nibName: "SetUpItemTableViewCell", bundle: nil), forCellReuseIdentifier: "SetUpItemTableViewCell")
        
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

extension StepUpViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let vc = getVC(st: "StepUp", vc: "SetUpItemViewController") as! SetUpItemViewController
        vc.setView(row: indexPath.row)
        vc.modalPresentationStyle = .overCurrentContext
        let nav = UINavigationController(rootViewController: vc)
        nav.restorationIdentifier = "StepUpViewController"
        nav.modalPresentationStyle = .fullScreen
        self.present(nav, animated: true)
        
    }
}

extension StepUpViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return fooditem.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "SetUpItemTableViewCell", for: indexPath) as! SetUpItemTableViewCell
        cell.setCell(item: fooditem[indexPath.row])
        return cell
    }
}
