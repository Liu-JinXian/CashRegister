//
//  StepUpViewController.swift
//  cashRegister
//
//  Created by 7690 劉晉賢 on 2021/3/15.
//

import UIKit

class SetUpViewController: BaseViewController {
    
    @IBOutlet weak var tableView: UITableView!
    
    var viewModel: SetUpViewModel?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setTableView()
        bindViewModel()
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

extension SetUpViewController: UITableViewDelegate {
    
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

extension SetUpViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel?.bentoName.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "SetUpItemTableViewCell", for: indexPath) as! SetUpItemTableViewCell
        cell.setCell(name: viewModel?.bentoName[indexPath.row] ?? "", price: viewModel?.bentoPrice[indexPath.row] ?? 0)
        return cell
    }
}

extension SetUpViewController {
    
    private func setTableView() {
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(UINib(nibName: "SetUpItemTableViewCell", bundle: nil), forCellReuseIdentifier: "SetUpItemTableViewCell")
    }
    
    private func bindViewModel() {
        
        viewModel = SetUpViewModel()
        viewModel?.getBentoData()
        
        viewModel?.reloadData = { [weak self] in
            self?.tableView.reloadData()
        }
    }
}
