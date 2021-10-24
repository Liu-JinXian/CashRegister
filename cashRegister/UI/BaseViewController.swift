//
//  BaseViewController.swift
//  cashRegister
//
//  Created by 7690 劉晉賢 on 2021/3/17.
//

import UIKit

extension BaseViewController {
    
    func getVC(st: String, vc: String) -> UIViewController {
        let storyboard = UIStoryboard(name: st, bundle: Bundle.main)
        let viewController = storyboard.instantiateViewController(withIdentifier: vc)
        return viewController
    }
    
    func setNavTitle(title: String) {
        self.navTitle = title
        self.adjustNavTitle()
    }
}

class BaseViewController: UIViewController {
    
    private var navTitle: String = ""
    private var navAlpha: CGFloat = 1.0
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        adjustLeftBarButtonItem()
        adjustNavBackground()
        adjustNavColor()
    }
    
    @objc func onTouchNavClose() {
        self.dismiss(animated: true, completion: nil)
    }
}

extension BaseViewController {
    
    private func adjustLeftBarButtonItem() {
        
        let closeImage = #imageLiteral(resourceName: "back")
        self.navigationItem.leftBarButtonItem = UIBarButtonItem.init(image: closeImage, style: .plain, target: self, action: #selector(onTouchNavClose))
    }
    
    private func adjustNavTitle() {
        switch navAlpha {
        case 1.0:
            self.navigationItem.title = navTitle
        case 0.0:
            self.navigationItem.title = ""
        default: ()
        }
    }
    
    private func adjustNavColor() {
        self.navigationController?.navigationBar.setShadow(offset: CGSize(width: 0, height: 1), opacity: 0.2, shadowRadius: 2, color: .clear)
    }
    
    private func adjustNavBackground() {
        self.navigationController?.navigationBar.barTintColor = yellow
    }
}
