//
//  BaseViewModel.swift
//  cashRegister
//
//  Created by 劉晉賢 on 2021/11/20.
//
import UIKit

class BaseViewModel {
    
    func getVC(st: String, vc: String) -> UIViewController {
        let storyboard = UIStoryboard(name: st, bundle: Bundle.main)
        let viewController = storyboard.instantiateViewController(withIdentifier: vc)
        return viewController
    }
}
