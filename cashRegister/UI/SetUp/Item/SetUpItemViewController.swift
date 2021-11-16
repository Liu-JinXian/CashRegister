//
//  SetUpItemViewController.swift
//  cashRegister
//
//  Created by 7690 劉晉賢 on 2021/3/16.
//
import UIKit

extension SetUpItemViewController {
    
    func setView(viewModel: SetUpItemViewModel) {
        self.viewModel = viewModel
    }
}

class SetUpItemViewController: BaseViewController {
    
    @IBOutlet weak var enterItem: UITextField!
    @IBOutlet weak var enterPrice: UITextField!
    
    private var viewModel: SetUpItemViewModel?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setView()
        bindViewModel()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }
    
    @IBAction func onTouchSave(_ sender: Any) {
        
        viewModel?.onTouchSave()
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction func onTouchCancel(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction func onTouchDelete(_ sender: Any) {
        viewModel?.deleteBentoItem()
        dismiss(animated: true, completion: nil)
    }
}

extension SetUpItemViewController {
    private func bindViewModel() {
        
    }
    
    private func setView() {
        if viewModel?.add == false {
            self.enterItem.text = viewModel?.name ?? ""
            self.enterPrice.text = "\(viewModel?.price ?? 0)"
        }
    }
}

