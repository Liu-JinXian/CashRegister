//
//  SetUpViewModel.swift
//  cashRegister
//
//  Created by 劉晉賢 on 2021/8/15.
//
import RxSwift
import RxCocoa
import ObjectMapper
import Alamofire

class SetUpViewModel: BaseViewModel {
    
    var reloadData: (() -> ())?
    var presentToVC: ((UIViewController) -> ())?
    var bentoModel: [BentoModel]?
    var subViewModels: [CashRegisterItemCollectionViewModel] = []
    
    private var moveToken: String?
    
    func getBentoData() {
        let address = "http://localhost:3000/menuinfo"
        let params = ["companyToken": UserDefaultUtil.shared.companyToken ?? ""]
        Alamofire.request(address, method: .post, parameters: params).responseJSON { response in
            self.bentoModel = Mapper<BentoModel>().mapArray(JSONObject: response.result.value)
            self.setCellData()
            self.reloadData?()
        }
    }
    
    func cleanModel() {
        
        subViewModels = []
        bentoModel = []
    }
    
    func getUpdateLocation(locationTemp: Int, locationMove: Int) {
        
        bentoModel?.forEach{ (model) in
            if model.location == locationMove + 1 {
                moveToken = model.bentoToken ?? ""
            }
        }
        
        let params: Parameters = ["move": "\(locationMove + 1)", "temp": "\(locationTemp + 1)", "moveToken": moveToken ?? ""]
        let url = URL(string: "http://localhost:3000/menuinfo/updatelocation")!
        
        Alamofire.request(url, method: .post ,parameters: params).responseJSON { (response) in
            if response.result.isSuccess {
                self.bentoModel = Mapper<BentoModel>().mapArray(JSONObject: response.result.value)
                self.subViewModels = []
                self.setCellData()
                self.reloadData?()
            }else {
                print("error!")
            }
        }
    }
    
    func setNumberOfItemsInSection() -> Int {
        return bentoModel?.count ?? 0
    }
    
    func onTouchSetUpItem() {
        
        let vc = getVC(st: "StepUp", vc: "SetUpItemViewController") as! SetUpItemViewController
        let viewModel = SetUpItemViewModel()
        viewModel.setViewModel(add: true)
        vc.setView(viewModel: viewModel)
        viewModel.reloadData = { [weak self] in
            self?.reloadData?()
        }
        vc.modalPresentationStyle = .overCurrentContext
        let nav = UINavigationController(rootViewController: vc)
        nav.restorationIdentifier = "StepUpViewController"
        nav.modalPresentationStyle = .fullScreen
        self.presentToVC?(nav)
    }
}

extension SetUpViewModel {
    
    private func setCellData() {
        bentoModel?.forEach { (item) in
            let viewModel = CashRegisterItemCollectionViewModel()
            viewModel.setViewModel(foodItem: item, update: true)
            viewModel.onTouchUpdate = { [weak self] in
                let vc = self?.getVC(st: "StepUp", vc: "SetUpItemViewController") as! SetUpItemViewController
                let viewModel = SetUpItemViewModel()
                viewModel.setViewModel(bentoModel: item, add: false)
                viewModel.reloadData = { [weak self] in
                    self?.reloadData?()
                }
                vc.setView(viewModel: viewModel)
                vc.modalPresentationStyle = .overCurrentContext
                let nav = UINavigationController(rootViewController: vc)
                nav.restorationIdentifier = "StepUpViewController"
                nav.modalPresentationStyle = .fullScreen
                self?.presentToVC?(nav)
            }
            subViewModels.append(viewModel)
        }
    }
}

