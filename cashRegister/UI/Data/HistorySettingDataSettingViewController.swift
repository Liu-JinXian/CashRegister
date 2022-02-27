//
//  HistorySettingDataSettingViewController.swift
//  cashRegister
//
//  Created by 劉晉賢 on 2021/10/30.
//
import UIKit

class HistorySettingDataSettingViewController: BaseViewController {
    
    @IBOutlet weak var cancel: UIButton!
    @IBOutlet weak var startDate: UIButton!
    @IBOutlet weak var endDate: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        cancel.layer.borderWidth = 1
        cancel.layer.borderColor = UIColor.black.cgColor
    }
    
    @IBAction func onTouchStartDate(_ sender: Any) {
        let vc = getVC(st: "Data", vc: "DatePickViewController") as! DatePickViewController
        let viewModel = DatePickViewModel()
        viewModel.onTouchDate = { [weak self] start in
            self?.startDate.setTitle(start, for: .normal)
        }
        vc.setView(viewModel: viewModel)
        let nav = UINavigationController(rootViewController: vc)
        nav.modalPresentationStyle = .fullScreen
        self.present(nav, animated: true)
    }
    
    @IBAction func onTouchEndDate(_ sender: Any) {
        let vc = getVC(st: "Data", vc: "DatePickViewController") as! DatePickViewController
        let viewModel = DatePickViewModel()
        viewModel.onTouchDate = { [weak self] end in
            self?.endDate.setTitle(end, for: .normal)
        }
        vc.setView(viewModel: viewModel)
        let nav = UINavigationController(rootViewController: vc)
        nav.modalPresentationStyle = .fullScreen
        self.present(nav, animated: true)
    }
}
